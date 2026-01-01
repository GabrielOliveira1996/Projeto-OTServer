local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 14)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1.5, -1400, -0.5, -1650)

arr = {
{1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 3, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, 1, 1, 1, 1, 1, 1, 1, 1}
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
if exhaustion.check(cid, 23023) == false then
exhaustion.set(cid, 23023, 2)
return doCombat(cid, combat, var)
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 23023).."]")
end
end