#!/usr/bin/env python3
import os
import json
import re
import sys
import fnmatch
import tempfile
import copy
import zipfile
import string
import hashlib
from pathlib import Path
from argparse import ArgumentParser

def load_mappings(mapping_file):
    mappings = {}
    with open(mapping_file, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            if '->' in line:
                old, new = map(str.strip, line.split('->', 1))
            else:
                parts = line.split()
                if len(parts) >= 2:
                    old, new = parts[0], parts[-1]
                else:
                    continue
            if old:
                if old in mappings and mappings[old] != new:
                    raise ValueError(f"映射定义冲突: {old}")
                mappings[old] = new
    return mappings

def build_regex(mappings):
    keys = sorted(mappings.keys(), key=len, reverse=True)
    # A leading lookbehind prevents Python's regex engine from skipping long
    # runs of unrelated text. Check the preceding character only at a match.
    return re.compile(r'(?:' + '|'.join(re.escape(k) for k in keys) + r')(?![A-Za-z0-9_])')

WORD_CHARS = frozenset(string.ascii_letters + string.digits + '_')

def has_mapping(value, regex, mappings):
    # Most large TextMap/resource files contain none of the source names. Fast
    # native substring searches avoid a regex scan of every character there.
    return any(key in value for key in mappings) and any(
        match.start() == 0 or value[match.start() - 1] not in WORD_CHARS for match in regex.finditer(value))

def replace_str(s, regex, mappings):
    if not s:
        return s, False
    modified = False
    def repl(m):
        nonlocal modified
        if m.start() > 0 and s[m.start() - 1] in WORD_CHARS:
            return m.group(0)
        modified = True
        return mappings[m.group(0)]
    return regex.sub(repl, s), modified

def load_rules(path):
    if not os.path.isfile(path):
        return []
    with open(path, encoding='utf-8-sig') as source:
        return json.load(source)

def process_value(v, regex, mappings, rules=(), filename=''):
    if isinstance(v, dict):
        new_dict = {}
        changed = False
        scoped = {}
        additions = {}
        for rule in rules:
            if (fnmatch.fnmatchcase(Path(filename).name, rule['file'])
                    and all(key in v for key in rule.get('when_keys', []))
                    and all(v.get(key) == value for key, value in rule.get('when_values', {}).items())):
                scoped.update(rule.get('keys', {}))
                additions.update(rule.get('set', {}))
        for k, val in v.items():
            nk, kc = (scoped[k], scoped[k] != k) if k in scoped else replace_str(k, regex, mappings) if isinstance(k, str) else (k, False)
            nv, vc = process_value(val, regex, mappings, rules, filename)
            if nk in new_dict:
                raise ValueError(f"映射后键名冲突: {nk}")
            new_dict[nk] = nv
            if kc or vc:
                changed = True
        for key, value in additions.items():
            if key in new_dict:
                if new_dict[key] != value:
                    raise ValueError(f'资源类型元数据冲突: {key}')
            else:
                new_dict[key] = value
                changed = True
        return (new_dict, True) if changed else (v, False)
    elif isinstance(v, list):
        new_list = []
        changed = False
        for item in v:
            ni, ic = process_value(item, regex, mappings, rules, filename)
            new_list.append(ni)
            if ic:
                changed = True
        return (new_list, True) if changed else (v, False)
    elif isinstance(v, str):
        return replace_str(v, regex, mappings)
    else:
        return v, False

def is_resource_json(name):
    parts = name.replace('\\', '/').split('/')
    return name.lower().endswith('.json') and not any(part.lower() in ('.git', 'tool') for part in parts[:-1])

def transform_json(data, name, regex, mappings, rules):
    source = data.decode('utf-8-sig')
    # Avoid parsing and reformatting unrelated large resource files.
    if not has_mapping(source, regex, mappings) and not any(fnmatch.fnmatchcase(Path(name).name, rule['file'])
            and all('"' + key + '"' in source for key in rule.get('when_keys', [])) for rule in rules):
        return data
    try:
        value = json.loads(source)
    except ValueError as error:
        raise ValueError(f'{name}: {error}') from error
    result, changed = process_value(value, regex, mappings, rules, name)
    return (json.dumps(result, ensure_ascii=False, indent=2) + '\n').encode('utf-8') if changed else data

def transform_zip(path, regex, mappings, rules, check=False, bundle=None, expected_changes=None, json_filter=None):
    path = Path(path).resolve()
    stamp = (path.stat().st_size, path.stat().st_mtime_ns)
    changed = []
    descriptor, temporary = tempfile.mkstemp(prefix=path.name + '.', suffix='.tmp', dir=path.parent)
    os.close(descriptor)
    try:
        with zipfile.ZipFile(path) as source, zipfile.ZipFile(temporary, 'w') as target:
            entries = sorted(source.infolist(), key=lambda entry: entry.header_offset)
            if len({entry.filename for entry in entries}) != len(entries):
                raise ValueError('ZIP 中包含重复路径')
            target.comment = source.comment
            prefix = ''
            for entry in entries:
                parts = entry.filename.split('/')
                if 'BinOutput' in parts:
                    parents = parts[:parts.index('BinOutput')]
                    prefix = '/'.join(parents) + '/' if parents else ''
                    break
            tools = {prefix + 'Tool/' + name: data for name, data in (bundle or {}).items()}
            for index, entry in enumerate(entries):
                replacement = tools.pop(entry.filename, None)
                if is_resource_json(entry.filename) and (json_filter is None or json_filter(entry.filename)):
                    original = source.read(entry)
                    converted = transform_json(original, entry.filename, regex, mappings, rules)
                    if converted != original:
                        replacement = converted
                if replacement is not None and replacement != source.read(entry):
                    if expected_changes is not None and entry.filename not in expected_changes:
                        raise ValueError('出现预检清单以外的修改: ' + entry.filename)
                    changed.append(entry.filename)
                    if not check:
                        target.writestr(copy.copy(entry), replacement)
                        continue
                if check:
                    continue
                end = entries[index + 1].header_offset if index + 1 < len(entries) else source.start_dir
                clone = copy.copy(entry)
                clone.header_offset = target.fp.tell()
                source.fp.seek(entry.header_offset)
                remaining = end - entry.header_offset
                while remaining:
                    block = source.fp.read(min(1048576, remaining))
                    if not block:
                        raise EOFError(entry.filename)
                    target.fp.write(block)
                    remaining -= len(block)
                target.filelist.append(clone)
                target.NameToInfo[clone.filename] = clone
                target.start_dir = target.fp.tell()
                target._didModify = True
            for name, data in tools.items():
                if expected_changes is not None and name not in expected_changes:
                    raise ValueError('出现预检清单以外的新增文件: ' + name)
                changed.append(name)
                if not check:
                    target.writestr(name, data, compress_type=zipfile.ZIP_DEFLATED)
        if not check and changed:
            with zipfile.ZipFile(temporary) as verified:
                bad = verified.testzip()
                if bad:
                    raise ValueError('ZIP CRC 校验失败: ' + bad)
            if (path.stat().st_size, path.stat().st_mtime_ns) != stamp:
                raise RuntimeError('原 ZIP 已被其他进程修改，未覆盖')
            os.replace(temporary, path)
        return changed
    finally:
        if os.path.exists(temporary):
            os.unlink(temporary)

def transform_directory(root, regex, mappings, rules, check=False, expected_changes=None, expected_hashes=None):
    root = Path(root).resolve()
    files = []
    # Validate the whole batch before changing any resource file.
    for dirpath, dirs, names in os.walk(root):
        dirs[:] = [name for name in dirs if name.lower() not in ('.git', 'tool')]
        for name in names:
            path = Path(dirpath, name)
            if not is_resource_json(path.relative_to(root).as_posix()):
                continue
            original = path.read_bytes()
            relative = path.relative_to(root).as_posix()
            if expected_hashes is not None and relative in expected_hashes and hashlib.sha256(original).hexdigest() != expected_hashes[relative]:
                raise RuntimeError('资源在备份后已被修改，未覆盖: ' + relative)
            converted = transform_json(original, name, regex, mappings, rules)
            if converted != original:
                if expected_changes is not None and relative not in expected_changes:
                    raise RuntimeError('出现预检清单以外的修改: ' + relative)
                files.append((path, path.stat().st_size, path.stat().st_mtime_ns))
    if not check:
        for path, size, timestamp in files:
            if (path.stat().st_size, path.stat().st_mtime_ns) != (size, timestamp):
                raise RuntimeError('资源已被其他进程修改，未覆盖: ' + str(path))
            converted = transform_json(path.read_bytes(), path.name, regex, mappings, rules)
            descriptor, temporary = tempfile.mkstemp(prefix=path.name + '.', suffix='.tmp', dir=path.parent)
            try:
                with os.fdopen(descriptor, 'wb') as target:
                    target.write(converted)
                os.replace(temporary, path)
            finally:
                if os.path.exists(temporary):
                    os.unlink(temporary)
    return [str(path.relative_to(root)) for path, _, _ in files]

def main():
    parser = ArgumentParser(description='将资源字段规范化；支持目录和 ZIP，保留未修改 ZIP 条目的压缩数据')
    parser.add_argument('dir', nargs='?', default='.')
    parser.add_argument('-m', '--mapping', default=os.path.join(os.path.dirname(os.path.abspath(__file__)), 'deobf.txt'))
    parser.add_argument('--rules', default=os.path.join(os.path.dirname(os.path.abspath(__file__)), 'deobf.rules.json'))
    parser.add_argument('--check', action='store_true', help='仅检查并列出待修改文件')
    parser.add_argument('--report', help='将完整修改清单写入 JSON')
    args = parser.parse_args()

    if not os.path.isdir(args.dir) and not zipfile.is_zipfile(args.dir):
        parser.error('请输入资源目录或 ZIP 文件')

    if not os.path.isfile(args.mapping):
        print(f"映射文件不存在: {args.mapping}", file=sys.stderr)
        sys.exit(1)

    mappings = load_mappings(args.mapping)
    if not mappings:
        print("没有有效映射，退出")
        sys.exit(0)

    regex = build_regex(mappings)
    rules = load_rules(args.rules)
    if os.path.isdir(args.dir):
        changed = transform_directory(args.dir, regex, mappings, rules, args.check)
    else:
        bundle = {'deobf.py': Path(__file__).read_bytes(), 'deobf.txt': Path(args.mapping).read_bytes()}
        if os.path.isfile(args.rules):
            bundle['deobf.rules.json'] = Path(args.rules).read_bytes()
        changed = transform_zip(args.dir, regex, mappings, rules, args.check, bundle)
    report = {'check_only': args.check, 'changed_count': len(changed), 'changed_files': changed}
    if args.report:
        Path(args.report).write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding='utf-8')
    print(json.dumps({'check_only': args.check, 'changed_count': len(changed)}, ensure_ascii=False))

if __name__ == '__main__':
    main()
