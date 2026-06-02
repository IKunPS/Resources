-- 基础信息
local base_info = {
	group_id = 133611407
}

--================================================================
--
-- 配置 抓取仅位置
--
--================================================================

-- 怪物
monsters = {
	{ config_id = 407003 , monster_id = 22040101 , pos = { x = 6222.432, y = 295.338, z = 9763.464 } , rot = { x = 0, y = 0, z = 0 } , level = 93 , title_id = 4031, special_name_id = 2403101 },
	{ config_id = 407004 , monster_id = 22040101 , pos = { x = 6220.48, y = 295.384, z = 9761.678 } , rot = { x = 0, y = 0, z = 0 } , level = 93 , title_id = 4031, special_name_id = 2403101 },
	{ config_id = 407005 , monster_id = 22040101 , pos = { x = 6220.469, y = 295.6, z = 9757.738 } , rot = { x = 0, y = 0, z = 0 } , level = 93 , title_id = 4031, special_name_id = 2403101 },
	{ config_id = 407006 , monster_id = 22040101 , pos = { x = 6225.833, y = 295.678, z = 9759.084 } , rot = { x = 0, y = 0, z = 0 } , level = 93 , title_id = 4031, special_name_id = 2403101 },
	{ config_id = 407007 , monster_id = 22050101 , pos = { x = 6224.39, y = 295.66, z = 9758.025 } , rot = { x = 0, y = 0, z = 0 } , level = 93 , title_id = 4032, special_name_id = 2403101 },
	{ config_id = 407008 , monster_id = 22050101 , pos = { x = 6221.653, y = 295.589, z = 9758.279 } , rot = { x = 0, y = 234.374, z = 0 } , level = 93 , title_id = 4032, special_name_id = 2403101 },
	{ config_id = 407021 , monster_id = 22050101 , pos = { x = 6222.972, y = 295.409, z = 9758.529 } , rot = { x = 0, y = 0, z = 0 } , level = 93 , title_id = 4032, special_name_id = 2403101 },
	{ config_id = 407024 , monster_id = 22040101 , pos = { x = 6218.993, y = 295.645, z = 9756.964 } , rot = { x = 0, y = 0, z = 0 } , level = 93 , title_id = 4031, special_name_id = 2403101 },
	{ config_id = 407025 , monster_id = 22040101 , pos = { x = 6226.941, y = 295.678, z = 9760.191 } , rot = { x = 0, y = 0, z = 0 } , level = 93 , title_id = 4031, special_name_id = 2403101 },
	{ config_id = 407026 , monster_id = 22040101 , pos = { x = 6226.628, y = 295.997, z = 9753.07 } , rot = { x = 0, y = 329.894, z = 0 } , level = 93 , title_id = 4031, special_name_id = 2403101 },
	{ config_id = 407027 , monster_id = 38023003 , pos = { x = 6216.922, y = 295.472, z = 9760 } , rot = { x = 0, y = 0, z = 0 } , level = 93 },
	{ config_id = 407028 , monster_id = 38023003 , pos = { x = 6221.068, y = 295.148, z = 9766.219 } , rot = { x = 0, y = 143.633, z = 0 } , level = 93 },
	{ config_id = 407029 , monster_id = 38023004 , pos = { x = 6218.584, y = 295.291, z = 9762.777 } , rot = { x = 0, y = 137.958, z = 0 } , level = 93 }
}

-- NPC
npcs = {
}

-- 装置
gadgets = {
	{ config_id = 407001 , gadget_id = 73074051 , pos = { x = 6220.784, y = 295.409, z = 9761.308 } , rot = { x = 0, y = 0, z = 0 } , level = 93 },
	{ config_id = 407012 , gadget_id = 73074075 , pos = { x = 6221.918, y = 310.409, z = 9758.989 } , rot = { x = 0, y = 17.538, z = 0 } , level = 93 },
	{ config_id = 407014 , gadget_id = 73074077 , pos = { x = 6221.918, y = 296.409, z = 9758.989 } , rot = { x = 0, y = 0, z = 0 } , level = 93 },
	{ config_id = 407017 , gadget_id = 73074076 , pos = { x = 6221.918, y = 295.409, z = 9758.989 } , rot = { x = 0, y = 0, z = 0 } , level = 93 },
	{ config_id = 407022 , gadget_id = 70211001 , pos = { x = 6242.722, y = 297.449, z = 9772.457 } , rot = { x = 12.958, y = 217.436, z = 349.092 } , level = 88 },
	{ config_id = 407023 , gadget_id = 70211012 , pos = { x = 6243.777, y = 297.557, z = 9769.008 } , rot = { x = 10.428, y = 300.39, z = 10.06 } , level = 88 },
	{ config_id = 407031 , gadget_id = 73070005 , pos = { x = 6244.354, y = 309.01, z = 9755.735 } , rot = { x = 0, y = 107.253, z = 0 } , level = 93 }
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
		monsters = { 407003,407004,407005,407006,407007,407008,407021,407024,407025,407026,407027,407028,407029 },
		gadgets = { 407001,407012,407014,407017,407022,407023,407031 },
		regions = { },
		triggers = { },
		rand_weight = 100
	}
}
