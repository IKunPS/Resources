#!/usr/bin/env python3
import os
import json
import sys
import shutil
from argparse import ArgumentParser
from typing import Dict, Any, Tuple

def load_mappings(mapping_file: str) -> Dict[str, str]:
    """从映射文件读取替换规则，支持 old -> new 或 old new 格式，忽略 # 注释"""
    mappings = {}
    with open(mapping_file, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            if '->' in line:
                left, right = line.split('->', 1)
                old, new = left.strip(), right.strip()
            else:
                parts = line.split()
                if len(parts) >= 2:
                    old, new = parts[0], parts[-1]
                else:
                    continue
            if old and new:
                mappings[old] = new
    return mappings

def replace_str(s: str, mappings: Dict[str, str]) -> Tuple[str, bool]:
    """
    替换字符串中所有匹配的键，返回 (新字符串, 是否发生替换)
    按旧字符串长度降序替换，避免重叠问题
    """
    if not s:
        return s, False
    modified = False
    for old, new in sorted(mappings.items(), key=lambda x: len(x[0]), reverse=True):
        if old in s:
            s = s.replace(old, new)
            modified = True
    return s, modified

def process_value(value: Any, mappings: Dict[str, str]) -> Tuple[Any, bool]:
    """
    递归处理 JSON 数据，返回 (新数据, 是否发生替换)
    替换所有字符串（键名和字符串值）
    """
    if isinstance(value, dict):
        new_dict = {}
        any_modified = False
        for k, v in value.items():
            # 处理键名
            new_key, key_modified = replace_str(k, mappings) if isinstance(k, str) else (k, False)
            # 处理值
            new_val, val_modified = process_value(v, mappings)
            new_dict[new_key] = new_val
            if key_modified or val_modified:
                any_modified = True
        return new_dict, any_modified
    elif isinstance(value, list):
        new_list = []
        any_modified = False
        for item in value:
            new_item, item_modified = process_value(item, mappings)
            new_list.append(new_item)
            if item_modified:
                any_modified = True
        return new_list, any_modified
    elif isinstance(value, str):
        return replace_str(value, mappings)
    else:
        return value, False

def process_json_file(file_path: str, mappings: Dict[str, str], backup: bool = True):
    """处理单个 JSON 文件，仅当发生替换时才备份和写入"""
    if not os.path.isfile(file_path):
        print(f"⚠️ 跳过 {file_path} （文件不存在）")
        return

    # 读取 JSON
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except (json.JSONDecodeError, UnicodeDecodeError) as e:
        print(f"⚠️ 跳过 {file_path} （JSON 解析失败）: {e}")
        return
    except Exception as e:
        print(f"⚠️ 跳过 {file_path} （读取错误）: {e}")
        return

    # 递归替换，并获取是否发生了修改
    new_data, modified = process_value(data, mappings)

    if not modified:
        # 没有任何替换发生，跳过该文件
        return

    # 有替换发生，先备份（如果开启）
    if backup:
        backup_path = file_path + '.bak'
        if not os.path.exists(backup_path):
            try:
                shutil.copy2(file_path, backup_path)
            except FileNotFoundError as e:
                print(f"❌ 备份失败，跳过 {file_path} （源文件丢失）: {e}")
                return
            except Exception as e:
                print(f"❌ 备份失败，跳过 {file_path} : {e}")
                return

    # 写回原文件
    try:
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(new_data, f, ensure_ascii=False, indent=2)
    except Exception as e:
        print(f"❌ 写入失败 {file_path} : {e}")
        return

    print(f"✅ 已处理 {file_path} （发生了替换）")

def main():
    parser = ArgumentParser(description='递归替换 JSON 中的混淆字符串（仅修改包含匹配项的文件）')
    parser.add_argument('dir', nargs='?', default='.',
                        help='要处理的根目录（默认当前目录）')
    parser.add_argument('-m', '--mapping', default='deobf.txt',
                        help='映射文件路径（默认 deobf.txt）')
    parser.add_argument('--no-backup', action='store_true',
                        help='不备份原文件（默认备份为 .bak）')
    args = parser.parse_args()

    if not os.path.isfile(args.mapping):
        print(f"❌ 映射文件 {args.mapping} 不存在", file=sys.stderr)
        sys.exit(1)

    mappings = load_mappings(args.mapping)
    if not mappings:
        print("⚠️ 未读取到任何有效映射，退出。")
        sys.exit(0)
    print(f"📋 加载了 {len(mappings)} 条映射规则")

    root_dir = os.path.abspath(args.dir)
    if not os.path.isdir(root_dir):
        print(f"❌ 目录 {root_dir} 不存在", file=sys.stderr)
        sys.exit(1)

    # 遍历所有 JSON 文件
    for root, dirs, files in os.walk(root_dir):
        for file in files:
            if file.lower().endswith('.json'):
                file_path = os.path.join(root, file)
                process_json_file(file_path, mappings, backup=not args.no_backup)

if __name__ == '__main__':
    main()
