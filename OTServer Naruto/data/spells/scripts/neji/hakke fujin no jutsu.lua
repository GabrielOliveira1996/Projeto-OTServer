local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_MANADRAIN)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 20)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.5, -700, -1.5, -850)

local arr = {
{0, 0, 0},
{0, 3, 0},
{0, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)

if exhaustion.check(cid, 20006) == false then
exhaustion.set(cid, 20006, 2)
return
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 20006).."]")
end
end