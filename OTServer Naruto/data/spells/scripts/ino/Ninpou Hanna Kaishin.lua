local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 35)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1.0, -430, -1.7, -530)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 5)

arr = {
{3},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end