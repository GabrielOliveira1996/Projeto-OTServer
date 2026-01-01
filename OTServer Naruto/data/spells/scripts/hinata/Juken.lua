local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 29)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1050, -1.5, -1200)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 5)

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
