local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, 111) 
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 4000) 
setConditionParam(condition, CONDITION_PARAM_SPEEDVAR, -600) 
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
    return doCombat(cid, combat, var)
end