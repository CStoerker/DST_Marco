
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
	Asset( "ANIM", "anim/egg_marco.zip" ),
	Asset( "ANIM", "anim/egg_marco_1.zip" ),
	Asset( "ANIM", "anim/egg_marco_2.zip" ),
	Asset( "ANIM", "anim/egg_marco_3.zip" ),
 
}
local prefabs = {}

-- Custom starting items
local start_inv = {
}
-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when reviving from ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "marco_speed_mod", 1)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "marco_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local relative_temperature_thresholds = { 8, 16, 24 }

local function GetRangeForTemperature(temp, ambient)
    local range = 0
	for i,v in ipairs(relative_temperature_thresholds) do
        if temp > ambient + v then
            range = range + 1
        end
    end
    return range

end

local function rebirth(inst)
	inst:DoTaskInTime(10, function()
		inst.AnimState:SetBuild("marco")
			local x, y, z = inst.Transform:GetWorldPosition()
			local fx = SpawnPrefab("firesplash_fx")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/firehound_explo")
			fx.Transform:SetPosition(x, y, z)
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED)
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED)
		inst.components.health.absorb = 0
		inst.components.health:StopRegen()
		inst.components.temperature.current = TheWorld.state.temperature
		inst.components.combat.damagemultiplier = 1.3
		local SavedRange = 0
		return SavedRange
	end)
end

local SavedRange = 0
local function UpdateBuild(inst, data)
    local ambient_temp = TheWorld.state.temperature
    local cur_temp = inst.components.temperature:GetCurrent()
    local range = GetRangeForTemperature(cur_temp, ambient_temp)
	local PreviousRange = SavedRange
	if PreviousRange == range then end
	if PreviousRange ~= range then
		SavedRange = range
		if range == 0 then 
			inst.AnimState:SetBuild("marco")
			local x, y, z = inst.Transform:GetWorldPosition()
			local fx = SpawnPrefab("firesplash_fx")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/firehound_explo")
			fx.Transform:SetPosition(x, y, z)
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED) * 1.3
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED) * 1.3
			inst.components.health.absorb = 0
			inst.components.health:StopRegen()
			inst.components.combat.damagemultiplier = 1.3
		else
			inst.AnimState:SetBuild("egg_marco_"..tostring(range))
			local x, y, z = inst.Transform:GetWorldPosition()
			local fx = SpawnPrefab("firesplash_fx")
			inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/firehound_explo")
			fx.Transform:SetPosition(x, y, z)
			inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED) / 2
			inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED) / 2
			inst.components.health:StartRegen(5,2)
			inst.components.health.absorb = 0.99
			inst.components.combat.damagemultiplier = 0.01
		end
		if SavedRange == 3 then
		rebirth(inst)
	end
	end
	return SavedRange

end

local function onbecameegg(inst)
inst.AnimState:SetBuild("egg_marco")
	local x, y, z = inst.Transform:GetWorldPosition()
	local fx = SpawnPrefab("firesplash_fx")
	inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/firehound_explo")
	fx.Transform:SetPosition(x, y, z)
	inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED) / 2
	inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED) / 2
	inst.components.health.absorb = 0.99
	inst.components.temperature.current = TheWorld.state.temperature
	
	inst:DoTaskInTime(150, function() -- you can change the time (now 300 seconds)
		inst.AnimState:SetBuild("marco")
		local x, y, z = inst.Transform:GetWorldPosition()
		local fx = SpawnPrefab("firesplash_fx")
		inst.SoundEmitter:PlaySound("dontstarve/creatures/hound/firehound_explo")
		fx.Transform:SetPosition(x, y, z)
		inst.components.locomotor.walkspeed = (TUNING.WILSON_WALK_SPEED)
		inst.components.locomotor.runspeed = (TUNING.WILSON_RUN_SPEED)
		inst.components.health.absorb = 0
		inst.components.health:StopRegen()
		inst.components.temperature.current = TheWorld.state.temperature
		inst.components.combat.damagemultiplier = 0.01
		end)
end

local function onloadegg(inst, data)
    local hp = data.newpercent
    if 0.111 >= hp then
		onbecameegg(inst)
	end
    if 0.222 > hp then
    	inst.components.health:StartRegen(1,3)
    	end
    if 0.222 <= hp then
	inst.components.health:StopRegen()
		
	end
end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "marco.tex" )
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "wilson"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(225)
	inst.components.hunger:SetMax(125)
	inst.components.sanity:SetMax(200)
	inst.components.temperature.mintemp = 0
	inst.components.temperature.inherentinsulation = TUNING.INSULATION_MED
	inst.components.temperature.inherentsummerinsulation = TUNING.INSULATION_MED
	inst.components.temperature.overheattemp = 500
	-- Damage multiplier (optional)
    	inst.components.combat.damagemultiplier = 1.3
    	inst.components.health.fire_damage_scale = 0
	
	-- a light that surrounds marco
	inst.entity:AddLight()
    inst.Light:Enable(true)
    inst.Light:SetRadius(2.0)
    inst.Light:SetFalloff(.3)
    inst.Light:SetIntensity(0.9)
    inst.Light:SetColour(10/255,110/255,255/255)
	
	inst:ListenForEvent("healthdelta", onloadegg)
	inst:ListenForEvent("temperaturedelta", UpdateBuild)
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload

end

return MakePlayerCharacter("marco", prefabs, assets, common_postinit, master_postinit, start_inv)
