import json

# 读取源文件
with open('MonsterExcelConfigData.json', 'r', encoding='utf-8') as f:
    monsters = json.load(f)

# 转换为目标格式
mapping = []
for m in monsters:
    # 确保存在 id 和 monsterName
    if 'id' in m and 'monsterName' in m:
        entry = {
            "monsterId": m['id'],
            "monsterJson": f"{m['monsterName']}_{m['id']}"
        }
        mapping.append(entry)

# 写入目标文件
with open('MonsterMapping.json', 'w', encoding='utf-8') as f:
    json.dump(mapping, f, indent=2, ensure_ascii=False)

print(f"转换完成，共处理 {len(mapping)} 条记录。")