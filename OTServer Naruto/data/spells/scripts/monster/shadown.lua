local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 8)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1.0, -200, -0.7, -280)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 2000)
--setConditionParam(condition, CONDITION_PARAM_SPEED, -0)
setConditionFormula(condition, -0.0, 0, -0.0, 0)
setCombatCondition(combat, condition)


arr = {
{3},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end