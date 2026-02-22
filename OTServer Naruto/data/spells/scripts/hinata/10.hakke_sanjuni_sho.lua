local BYA_STORAGE = 45001
local EFFECT_TRIGRAMA = 58 
local cooldownStorage = 23010
local cooldownTime = 4

local t_slow = createConditionObject(CONDITION_PARALYZE)
setConditionParam(t_slow, CONDITION_PARAM_TICKS, 3000)
setConditionFormula(t_slow, -0.7, 0, -0.7, 0)

function onCastSpell(cid, var)
    local target = getCreatureTarget(cid)
    if not target or not isCreature(target) then return false end

    if getDistanceBetween(getThingPos(cid), getThingPos(target)) > 3 then
        doPlayerSendCancel(cid, "The target is too far away.")
        return false
    end

    if os.time() < getPlayerStorageValue(cid, cooldownStorage) then
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end

    local skill = getPlayerSkillLevel(cid, 6)
    local level = getPlayerLevel(cid)
    local isByakugan = getPlayerStorageValue(cid, BYA_STORAGE) > 0
    
    doCreatureSetNoMove(cid, true)
    doCreatureSetNoMove(target, true)

    local total_hits = 32
    local interval = 125 

    local damage_min = (skill * 2.5) + (level * 2.0)
    local damage_max = (skill * 3.5) + (level * 2.5)
    if isByakugan then damage_min, damage_max = damage_min * 1.4, damage_max * 1.4 end
dddddddddddddddddddddddddwwwwwwwwwwwwwwdw
    local hit_min = math.max(1, math.floor(damage_min / total_hits))
    local hit_max = math.max(1, math.floor(damage_max / total_hits))

    for i = 1, total_hits do
        addEvent(function()
            if not isCreature(cid) then return end
            if not isCreature(target) then
                doCreatureSetNoMove(cid, false) 
                return 
            end

            local playerPos = getThingPos(cid)
            local centerPos = {x = playerPos.x + 1, y = playerPos.y + 1, z = playerPos.z}

            if i % 4 == 1 then 
                doSendMagicEffect(centerPos, EFFECT_TRIGRAMA)
            end

            doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -hit_min, -hit_max, 31)
            
            if i == 2 then doSendAnimatedText(getThingPos(cid), "2 PALMS", 215)
            elseif i == 4 then doSendAnimatedText(getThingPos(cid), "4 PALMS", 215)
            elseif i == 8 then doSendAnimatedText(getThingPos(cid), "8 PALMS", 215)
            elseif i == 16 then doSendAnimatedText(getThingPos(cid), "16 PALMS", 215)
            elseif i == 32 then 
                doSendAnimatedText(getThingPos(cid), "32 PALMS!", 180)
                
                doCreatureSetNoMove(cid, false)
                doCreatureSetNoMove(target, false)
                doAddCondition(target, t_slow)
            end
        end, i * interval)
    end

    setPlayerStorageValue(cid, cooldownStorage, os.time() + cooldownTime)
    return true
end