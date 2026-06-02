-- 基础信息
local base_info = {
	group_id = 133611270
}

--================================================================
--
-- 配置 抓取仅位置
--
--================================================================

-- 怪物
monsters = {
	{ config_id = 270002 , monster_id = 21010401 , pos = { x = 5517.347, y = 186.992, z = 9864.824 } , rot = { x = 0, y = 137.904, z = 0 } , level = 93 , title_id = 3011, special_name_id = 2300101 },
	{ config_id = 270003 , monster_id = 21010401 , pos = { x = 5520.468, y = 187.479, z = 9864.844 } , rot = { x = 0, y = 141.073, z = 0 } , level = 93 , title_id = 3011, special_name_id = 2300101 },
	{ config_id = 270004 , monster_id = 21010401 , pos = { x = 5521.348, y = 188.916, z = 9867.41 } , rot = { x = 0, y = 151.786, z = 0 } , level = 93 , title_id = 3011, special_name_id = 2300101 },
	{ config_id = 270005 , monster_id = 21010601 , pos = { x = 5524.415, y = 185.376, z = 9859.351 } , rot = { x = 0, y = 133.71, z = 0 } , level = 93 , title_id = 3001, special_name_id = 2300101 },
	{ config_id = 270007 , monster_id = 21040201 , pos = { x = 5521.888, y = 183.675, z = 9852.746 } , rot = { x = 0, y = 162.364, z = 0 } , level = 93 , title_id = 3302, special_name_id = 2330101 },
	{ config_id = 270008 , monster_id = 21010501 , pos = { x = 5519.251, y = 183.958, z = 9854.643 } , rot = { x = 0, y = 179, z = 0 } , level = 93 , title_id = 3011, special_name_id = 2300101 },
	{ config_id = 270009 , monster_id = 21010501 , pos = { x = 5522.735, y = 184.096, z = 9855.22 } , rot = { x = 0, y = 177.539, z = 0 } , level = 93 , title_id = 3011, special_name_id = 2300101 },
	{ config_id = 270011 , monster_id = 22140101 , pos = { x = 5530.611, y = 183.475, z = 9848.951 } , rot = { x = 0, y = 238.311, z = 0 } , level = 93 , title_id = 4090, special_name_id = 2408901 },
	{ config_id = 270017 , monster_id = 22140101 , pos = { x = 5524.71, y = 183.901, z = 9854.366 } , rot = { x = 0, y = 211.681, z = 0 } , level = 93 , title_id = 4090, special_name_id = 2408901 }
}

-- NPC
npcs = {
}

-- 装置
gadgets = {
	{ config_id = 270015 , gadget_id = 70360001 , pos = { x = 5524.139, y = 185.406, z = 9859.488 } , rot = { x = 0, y = 0, z = 0 } , level = 93 },
	{ config_id = 270018 , gadget_id = 42215010 , pos = { x = 5521.535, y = 183.108, z = 9847.634 } , rot = { x = 0, y = 0, z = 0 } , level = 93 }
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
		monsters = { 270002,270003,270004,270005,270007,270008,270009,270011,270017 },
		gadgets = { 270015,270018 },
		regions = { },
		triggers = { },
		rand_weight = 100
	}
}
