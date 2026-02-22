local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 2000) -- 2 segundos
setConditionParam(condition, CONDITION_PARAM_SPEED, -100) 

function onCastSpell(cid, var)
    if not exhaustion.check(cid, 23001) then
        local level = getPlayerLevel(cid)
        local fist = getPlayerSkillLevel(cid, SKILL_FIST) 
        local lookDir = getCreatureLookDirection(cid)
        
        local EFFECT_ID = 37 
        local min = (fist * 2.0) + (level * 0.5)
        local max = (fist * 3.0) + (level * 1.0)

        local pos = getThingPos(cid)
        local targetPos = {x = pos.x, y = pos.y, z = pos.z}

        if lookDir == 0 then targetPos.y = targetPos.y - 1 
        elseif lookDir == 1 then targetPos.x = targetPos.x + 1
        elseif lookDir == 2 then targetPos.y = targetPos.y + 1 
        elseif lookDir == 3 then targetPos.x = targetPos.x - 1 
        end

        local target = getTopCreature(targetPos).uid

        if isCreature(target) then
            doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -min, -max, CONST_ME_NONE)
            doAddCondition(target, condition)
            doSendMagicEffect(targetPos, EFFECT_ID)
        else
            doSendMagicEffect(targetPos, EFFECT_ID)
            doCreatureSay(cid, "Haa!", TALKTYPE_ORANGE_1)
        end
        exhaustion.set(cid, 23001, 2)
        return true
    else
        doPlayerSendCancel(cid, "Cooldown [" .. exhaustion.get(cid, 23001) .. "s]")
        return false
    end
end