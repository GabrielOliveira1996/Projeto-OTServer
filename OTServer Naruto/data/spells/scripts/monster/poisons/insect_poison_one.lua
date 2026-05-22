local condition = createConditionObject(CONDITION_POISON)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1) 
addDamageCondition(condition, 50, 2000, -60)

function onCastSpell(cid, var)
    local target = getCreatureTarget(cid)
    if target > 0 then
        doTargetCombatCondition(cid, target, condition, 17) 
        return true
    end
    return false
end