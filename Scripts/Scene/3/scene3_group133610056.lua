-- 基础信息
local base_info = {
	group_id = 133610056
}

--================================================================
--
-- 配置 抓取仅位置
--
--================================================================

-- 怪物
monsters = {
	{ config_id = 56002 , monster_id = 33070101 , pos = { x = 6369.704, y = 249.28, z = 10125.63 } , rot = { x = 0, y = 0, z = 0 } , level = 93 , title_id = 7411, special_name_id = 2741101 },
	{ config_id = 56003 , monster_id = 35550311 , pos = { x = 6366.19, y = 249.822, z = 10129.13 } , rot = { x = 0, y = 0, z = 0 } , level = 93 , title_id = 7359, special_name_id = 2900101 },
	{ config_id = 56004 , monster_id = 35550210 , pos = { x = 6371.877, y = 250.395, z = 10128.64 } , rot = { x = 0, y = 0, z = 0 } , level = 93 , title_id = 7359, special_name_id = 2900101 },
	{ config_id = 56016 , monster_id = 25550303 , pos = { x = 6363.5693, y = 250.66083, z = 10132.002 } , rot = { x = 0, y = 3.5914834, z = 0 } , level = 93 , title_id = 7359, special_name_id = 2900101 },
	{ config_id = 56017 , monster_id = 25550206 , pos = { x = 6360.7563, y = 251.55219, z = 10135.651 } , rot = { x = 0, y = 28.47212, z = 0 } , level = 93 , title_id = 7359, special_name_id = 2900101 }
}

-- NPC
npcs = {
}

-- 装置
gadgets = {
	{ config_id = 56015 , gadget_id = 70290196 , pos = { x = 6370.217, y = 250.265, z = 10129.07 } , rot = { x = 0, y = 0, z = 0 } , level = 93 },
	{ config_id = 56019 , gadget_id = 73070089 , pos = { x = 6370.456, y = 248.768, z = 10122.44 } , rot = { x = 0, y = 0, z = 0 } , level = 93 },
	{ config_id = 56037 , gadget_id = 73070149 , pos = { x = 6364.38, y = 242.643, z = 10131.71 } , rot = { x = 0, y = 0, z = 0 } , level = 93 },
	{ config_id = 56038 , gadget_id = 73070149 , pos = { x = 6368.42, y = 242.297, z = 10129.79 } , rot = { x = 0, y = 0, z = 0 } , level = 93 },
	{ config_id = 56039 , gadget_id = 73070149 , pos = { x = 6366.475, y = 242.83, z = 10131.99 } , rot = { x = 0, y = 0, z = 0 } , level = 93 }
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
		monsters = { 56002,56003,56004,56016,56017 },
		gadgets = { 56015,56019,56037,56038,56039 },
		regions = { },
		triggers = { },
		rand_weight = 100
	}
}
