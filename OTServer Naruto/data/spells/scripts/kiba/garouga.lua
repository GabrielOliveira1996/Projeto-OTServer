local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 27)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1500, -1.5, -1700)

arr = {
{0, 0, 1, 0, 0},
{0, 1, 1, 1, 0},
{0, 1, 1, 1, 0},
{0, 1, 1, 1, 0},
{0, 1, 3, 1, 0},
{0, 1, 0, 1, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end