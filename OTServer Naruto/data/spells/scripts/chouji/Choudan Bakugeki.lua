local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 34)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.5, -800, -1.5, -950)

arr = {
{0, 0, 0, 0, 0},
{0, 0, 3, 0, 0},
{0, 0, 0, 0, 0},

}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end
