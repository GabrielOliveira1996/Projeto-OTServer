local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 34)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -2.3, -1220, -2.8, -1520)

arr = {
{1, 3, 1}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
return doCombat(cid, combat, var)
end

