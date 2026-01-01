local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 39)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1.0, -140, -1.7, -220)

arr = {
{0, 0, 0, 0, 0},
{0, 0, 1, 0, 0},
{0, 1, 3, 1, 0},
{0, 0, 1, 0, 0},
{0, 0, 0, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
if getPlayerVocation(cid) == 37 or getPlayerVocation(cid) == 38 or getPlayerVocation(cid) == 39 or getPlayerVocation(cid) == 40 or getPlayerVocation(cid) == 64 or getPlayerVocation(cid) == 65 or getPlayerVocation(cid) == 66 or getPlayerVocation(cid) == 81 then
doCombat(cid, combat, var)
return true
end
end