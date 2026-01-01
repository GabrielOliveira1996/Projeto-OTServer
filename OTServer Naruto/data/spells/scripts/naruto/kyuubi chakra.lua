local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -0.0, -0, -0.0, -0)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1400, -1.0, -2100)

arr1 = {
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 1, 3, 1, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
}

arr2 = {
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 1, 3, 1, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
}

local area1 = createCombatArea(arr1)
setCombatArea(combat1, area1)

local area2 = createCombatArea(arr2)
setCombatArea(combat2, area2)

function onCastSpell(cid, var)
local p = getCreaturePosition(cid)
local x = {
[0] = {x=p.x, y=p.y-1, z=p.z},
[1] = {x=p.x+5, y=p.y, z=p.z},
[2] = {x=p.x, y=p.y+5, z=p.z},
[3] = {x=p.x-1, y=p.y, z=p.z}
}
local y = {
[0] = 86,   ---- cima
[1] = 87,   ---- >>>>
[2] = 88,   ---- baixo
[3] = 85    ---- <<<<
}
pos = x[getCreatureLookDirection(cid)]
eff = y[getCreatureLookDirection(cid)]

if exhaustion.check(cid, 23007) == false then
doCreatureAddMana(cid, -1300)
exhaustion.set(cid, 23007, 2)
doSendMagicEffect(pos, eff)
doCombat(cid, combat1, var)
doCombat(cid, combat2, var)
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 23007).."]")
end
end