local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 205) 

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 3000) 
setConditionFormula(condition, -0.6, 0, -0.6, 0) 

function onCastSpell(cid, var)
    local target = getCreatureTarget(cid)
    if isCreature(target) then
        doAddCondition(target, condition)
        return doTargetCombatHealth(cid, target, COMBAT_DEATHDAMAGE, -140, -190, 36)
    end
    return false
end