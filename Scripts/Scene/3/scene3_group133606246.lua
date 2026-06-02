-- 基础信息
local base_info = {
	group_id = 133606246
}

--================================================================
--
-- 配置 抓取仅位置
--
--================================================================

-- 怪物
monsters = {
	{ config_id = 246001 , monster_id = 20011101 , pos = { x = 2271.189, y = 200, z = 8660.738 } , rot = { x = 0, y = 0, z = 0 } , level = 88 , title_id = 1051, special_name_id = 2100101 },
	{ config_id = 246002 , monster_id = 20011001 , pos = { x = 2263.472, y = 200, z = 8661.8 } , rot = { x = 0, y = 0, z = 0 } , level = 88 , title_id = 1005, special_name_id = 2100101 },
	{ config_id = 246003 , monster_id = 20011001 , pos = { x = 2262.685, y = 200, z = 8654.916 } , rot = { x = 0, y = 0, z = 0 } , level = 88 , title_id = 1005, special_name_id = 2100101 },
	{ config_id = 246004 , monster_id = 20011001 , pos = { x = 2284.363, y = 200, z = 8664.423 } , rot = { x = 0, y = 0, z = 0 } , level = 88 , title_id = 1005, special_name_id = 2100101 },
	{ config_id = 246005 , monster_id = 20011001 , pos = { x = 2273.927, y = 200.256, z = 8665.019 } , rot = { x = 0, y = 0, z = 0 } , level = 88 , title_id = 1005, special_name_id = 2100101 }
}

-- NPC
npcs = {
}

-- 装置
gadgets = {

}

-- 区域
regions = {
}

-- 触发器
triggers = {
}

-- 变量
variables = {
}

--================================================================
--
-- 初始化配置
--
--================================================================

-- 初始化时创建
init_config = {
	suite = 1,
	end_suite = 0,
	rand_suite = false
}

--================================================================
--
-- 小组配置
--
--================================================================

suites = {
	{
		-- suite_id = 1,
		-- description = ,
		monsters = { 246001,246002,246003,246004,246005 },
		gadgets = {  },
		regions = { },
		triggers = { },
		rand_weight = 100
	}
}
