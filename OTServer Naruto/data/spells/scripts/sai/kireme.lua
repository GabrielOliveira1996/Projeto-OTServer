local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 44)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1.5, -400, -0.5, -550)

arr = {
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
{0, 0, 1, 0, 0},
{0, 0, 1, 0, 0},
{0, 0, 1, 0, 0},
{0, 0, 3, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)

if exhaustion.check(cid, 23010) == false then
exhaustion.set(cid, 23010, 2)
return doCombat(cid, combat, var)
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 23010).."]")
end
end

