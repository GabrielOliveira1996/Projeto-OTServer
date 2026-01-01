local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 61)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.0, -0, -0.0, -0)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 2000)
--setConditionParam(condition, CONDITION_PARAM_SPEED, -500)
setConditionFormula(condition, -1.5, 0, -1.5, 0)
setCombatCondition(combat, condition)


arr = {
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
{0, 0, 3, 0, 0},
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end