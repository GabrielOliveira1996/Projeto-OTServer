local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_LIFEDRAIN)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 14)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 4000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -200)
setConditionFormula(condition, -0.9, 0, -0.9, 0) 

function onCastSpell(cid, var)
    local target = getCreatureTarget(cid)
    local cooldownStorage = 23001
    local cooldownTime = 2

    if os.time() < getPlayerStorageValue(cid, cooldownStorage) then
        doPlayerSendCancel(cid, "Your Mushi Dama is on cooldown.")
        return false
    end

    if not isCreature(target) then
        doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTARGET)
        return false
    end

    local summons = getCreatureSummons(cid)
    local insectNearby = false
    
    if summons and #summons > 0 then
        for i = 1, #summons do
            if getDistanceBetween(getThingPos(summons[i]), getThingPos(target)) <= 1 then
                insectNearby = true
                break
            end
        end
    end

    if not insectNearby then
        doPlayerSendCancel(cid, "Your Kikaichu must be touching the target to use Mushi Dama.")
        return false
    end

    local level = getPlayerLevel(cid)
    local magicLevel = getPlayerMagLevel(cid)
    local min = (level * 2) + (magicLevel * 3)
    local max = (level * 3) + (magicLevel * 5)
    doTargetCombatHealth(cid, target, COMBAT_EARTHDAMAGE, -min, -max, 14)
    doAddCondition(target, condition)
    doSendAnimatedText(getThingPos(target), "TRAPPED!", 30)
    setPlayerStorageValue(cid, cooldownStorage, os.time() + cooldownTime)
    return true
end