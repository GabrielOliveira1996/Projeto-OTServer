local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 30)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -0.5, -300, -1.5, -450)

arr = {
{0, 0, 0, 0, 0},
{0, 1, 1, 1, 0},
{0, 1, 3, 1, 0},
{0, 1, 1, 1, 0},
{0, 0, 0, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)


function onCastSpell(cid, var)

if exhaustion.check(cid, 20010) == false then
exhaustion.set(cid, 20010, 2)
return doCombat(cid, combat, var)
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 20010).."]")
end
end

