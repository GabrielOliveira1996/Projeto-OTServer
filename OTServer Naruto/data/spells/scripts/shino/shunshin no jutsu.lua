local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 14)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1.5, -300, -0.5, -450)

arr = {
{3}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
if exhaustion.check(cid, 23020) == false then
exhaustion.set(cid, 23020, 2)
return doCombat(cid, combat, var)
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 23020).."]")
end
end