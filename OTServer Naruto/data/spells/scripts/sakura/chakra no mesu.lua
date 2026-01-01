local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 60)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.5, -300, -1.0, -500)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 16)

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
if exhaustion.check(cid, 22001) == false then
exhaustion.set(cid, 22001, 2)
return doCombat(cid, combat, var)
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 22001).."]")
end
end