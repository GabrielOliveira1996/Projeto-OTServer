local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -0.5, -4200, -1.0, -4600)
setCombatParam(combat1, COMBAT_PARAM_HITCOLOR, 16)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -0.0, -0, -0.0, -0)
setCombatParam(combat2, COMBAT_PARAM_HITCOLOR, 16)

arr1 = {
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 1, 1, 1, 0, 0},
{0, 0, 1, 3, 1, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
}

arr2 = {
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
{0, 0, 0, 0, 0, 0, 0},
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
[0] = {x=p.x+1, y=p.y-1, z=p.z},
[1] = {x=p.x+3, y=p.y, z=p.z},
[2] = {x=p.x+2, y=p.y+1, z=p.z},
[3] = {x=p.x, y=p.y, z=p.z}
}
local y = {
[0] = 84,
[1] = 84,
[2] = 84,
[3] = 84
}
pos = x[getCreatureLookDirection(cid)]
eff = y[getCreatureLookDirection(cid)]

if getPlayerVocation(cid) == 67 then
doPlayerSendCancel(cid,"Você não pode usar.")
return false
end

if exhaustion.check(cid, 23004) == false then
exhaustion.set(cid, 23004, 2)
doSendMagicEffect(pos, eff)
doCombat(cid, combat1, var)
doCombat(cid, combat2, var)
return true
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 23004).."]")
end
end