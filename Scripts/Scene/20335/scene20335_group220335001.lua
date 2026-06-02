-- 基础信息
local base_info = {
	group_id = 220335001
}

-- Trigger变量
local defs = {
}

--================================================================
--
-- 配置
--
--================================================================

-- 怪物
monsters = {
	{ config_id = 1001, monster_id = 29130202, pos = { x = 800.0, y = 1200.167, z = 800.0 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1, title_id = 217, special_name_id = 2022201 },
	{ config_id = 1014, monster_id = 29130302, pos = { x = -513.0, y = 1200.0, z = 791.336 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1, title_id = 215, special_name_id = 2022101 },
	{ config_id = 1016, monster_id = 29130302, pos = { x = -488.0, y = 1200.0, z = 790.737 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1, title_id = 215, special_name_id = 2022101 },
	{ config_id = 1015, monster_id = 29130302, pos = { x = -500.0, y = 1200.0, z = 811.63 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1, title_id = 215, special_name_id = 2022101 },
}

-- NPC
npcs = {
}

-- 装置
gadgets = {
	-- 第一阶段区域装置 (x ≈ -500)
	{ config_id = 1002, gadget_id = 70331528, pos = { x = -500.0, y = 1200.0, z = 800.0 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },
	{ config_id = 1029, gadget_id = 73119006, pos = { x = -500.0, y = 1199.85, z = 800.0 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },
	{ config_id = 1024, gadget_id = 42913019, pos = { x = -500.375, y = 1200.0, z = 831.291 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },
	{ config_id = 1003, gadget_id = 42913020, pos = { x = -499.891, y = 1200.0, z = 800.114 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },
	{ config_id = 1026, gadget_id = 73119004, pos = { x = 668.0, y = 1761.0, z = -953.0 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 }, -- 可能为复活点/传送点，两阶段均可保留

	-- 第二阶段区域装置 (x ≈ 800)
	{ config_id = 1025, gadget_id = 73119006, pos = { x = 800.062, y = 1200.017, z = 800.14 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },
	{ config_id = 1010, gadget_id = 70360001, pos = { x = 800.131, y = 1200.171, z = 797.079 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },
	{ config_id = 1020, gadget_id = 42913016, pos = { x = 787.57, y = 1200.1, z = 791.336 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },
	{ config_id = 1021, gadget_id = 42913016, pos = { x = 799.856, y = 1200.1, z = 814.721 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },
	{ config_id = 1022, gadget_id = 42913016, pos = { x = 812.345, y = 1200.1, z = 790.737 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },
	{ config_id = 1018, gadget_id = 73119001, pos = { x = 812.345, y = 1200.3, z = 790.737 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },
	{ config_id = 1012, gadget_id = 73119001, pos = { x = 787.57, y = 1200.3, z = 791.336 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },
	{ config_id = 1013, gadget_id = 73119001, pos = { x = 799.856, y = 1200.3, z = 814.721 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },
	{ config_id = 1011, gadget_id = 70331528, pos = { x = 800.131, y = 1200.171, z = 797.079 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },

	-- 宝箱（仅定义，由触发器动态生成）
	{ config_id = 1009, gadget_id = 70210106, pos = { x = 800.131, y = 1200.171, z = 797.079 }, rot = { x = 0.000, y = 0.000, z = 0.000 }, level = 1 },
}

-- 区域
regions = {
}

-- 触发器
triggers = {
	{ config_id = 1335001, name = "ANY_MONSTER_DIE_1014", event = EventType.EVENT_ANY_MONSTER_DIE, source = "", condition = "condition_ANY_MONSTER_DIE_1014", action = "action_ANY_MONSTER_DIE_1014" },
	{ config_id = 1335002, name = "ANY_MONSTER_DIE_1001", event = EventType.EVENT_ANY_MONSTER_DIE, source = "", condition = "condition_ANY_MONSTER_DIE_1001", action = "action_ANY_MONSTER_DIE_1001" },
	{ config_id = 1335003, name = "GADGET_STATE_CHANGE_1010", event = EventType.EVENT_GADGET_STATE_CHANGE, source = "", condition = "condition_GADGET_STATE_CHANGE_1010", action = "action_GADGET_STATE_CHANGE_1010" },
}

-- 点位
points = {
}

-- 变量
variables = {
}

-- 废弃数据
garbages = {
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
		-- description = 第一阶段：区域1战斗，
		monsters = { 1001 },
		gadgets = { 1002, 1029, 1024, 1003, 1026 }, -- 区域1装置 + 通用传送点
		regions = { },
		triggers = { "ANY_MONSTER_DIE_1014", "ANY_MONSTER_DIE_1001", "GADGET_STATE_CHANGE_1010" },
		rand_weight = 100
	},
	{
		-- suite_id = 2,
		-- description = 第二阶段：Boss战，
		monsters = { 1014, 1016, 1015 },
		gadgets = { 1025, 1010, 1020, 1021, 1022, 1018, 1012, 1013, 1011 }, -- 区域2装置（不含宝箱）
		regions = { },
		triggers = { },
		rand_weight = 100
	}
}

--================================================================
--
-- 触发器
--
--================================================================

-- 第一阶段怪物全灭检测（关联 1014，但实际检查 1014/1015/1016）
function condition_ANY_MONSTER_DIE_1014(context, evt)
	local deadMonster = evt.param1
	if deadMonster ~= 1014 and deadMonster ~= 1015 and deadMonster ~= 1016 then
		return false
	end

	local remain1014 = ScriptLib.GetGroupMonsterCountByConfigId(context, 220335001, 1014)
	local remain1015 = ScriptLib.GetGroupMonsterCountByConfigId(context, 220335001, 1015)
	local remain1016 = ScriptLib.GetGroupMonsterCountByConfigId(context, 220335001, 1016)

	if remain1014 > 0 or remain1015 > 0 or remain1016 > 0 then
		return false
	end
	return true
end

function action_ANY_MONSTER_DIE_1014(context, evt)
	local phase1_gadgets = {1002, 1029, 1024, 1003, 1026}
	for _, config_id in ipairs(phase1_gadgets) do
		ScriptLib.RemoveEntityByConfigId(context, 220335001, EntityType.GADGET, config_id)
	end

	ScriptLib.TransPlayerToPos(context, {
		uid_list = {},
		pos = { x = 800.131, y = 1200.171, z = 797.079 },
		radius = 2,
		rot = { x = 0, y = 0, z = 0 }
	})

	ScriptLib.AddExtraGroupSuite(context, 220335001, 2)
	return 0
end

-- Boss 死亡检测
function condition_ANY_MONSTER_DIE_1001(context, evt)
	if evt.param1 ~= 1001 then
		return false
	end
	return true
end

function action_ANY_MONSTER_DIE_1001(context, evt)
	if 0 ~= ScriptLib.SetGadgetStateByConfigId(context, 1010, GadgetState.Action01) then
		ScriptLib.PrintContextLog(context, "@@ LUA_WARNING : set_gadget_state_by_configId")
		return -1
	end
	return 0
end

-- 机关 1010 状态变化后生成宝箱
function condition_GADGET_STATE_CHANGE_1010(context, evt)
	if evt.param2 ~= 1010 or evt.param1 ~= GadgetState.Action01 then
		return false
	end
	return true
end

function action_GADGET_STATE_CHANGE_1010(context, evt)
	ScriptLib.CreateGadget(context, { config_id = 1009 })
	return 0
end
