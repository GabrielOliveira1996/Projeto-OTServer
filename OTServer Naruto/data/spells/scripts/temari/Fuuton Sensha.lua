local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 56)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1.5, -1600, -0.5, -1850)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 215)

arr = {
{1, 1, 1, 1, 1},
{1, 1, 1, 1, 1},
{1, 1, 3, 1, 1},
{1, 1, 1, 1, 1},
{1, 1, 1, 1, 1},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end