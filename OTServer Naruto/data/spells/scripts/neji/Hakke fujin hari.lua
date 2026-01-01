local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1740, -1.5, -1950)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 51)
setCombatParam(combat1, COMBAT_PARAM_HITCOLOR, 16)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1740, -1.5, -1950)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 51)
setCombatParam(combat2, COMBAT_PARAM_HITCOLOR, 16)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatFormula(combat3, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1740, -1.5, -1950)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, 51)
setCombatParam(combat3, COMBAT_PARAM_HITCOLOR, 16)

arr1 = {
{1, 1, 1, 1, 1, 1, 1},
{1, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 2, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 1},
{1, 1, 1, 1, 1, 1, 1},
}

arr2 = {
{1, 1, 1, 1, 1},
{1, 0, 0, 0, 1},
{1, 0, 2, 0, 1},
{1, 0, 0, 0, 1},
{1, 1, 1, 1, 1},
}

arr3 = {
{0, 0, 0, 0, 0},
{0, 1, 1, 1, 0},
{0, 1, 3, 1, 0},
{0, 1, 1, 1, 0},
{0, 0, 0, 0, 0},
}

local area1 = createCombatArea(arr1)
local area2 = createCombatArea(arr2)
local area3 = createCombatArea(arr3)
setCombatArea(combat1, area1)
setCombatArea(combat2, area2)
setCombatArea(combat3, area3)

local function onCastSpell1(parameters)
doCombat(parameters.cid, combat1, parameters.var)
end

local function onCastSpell2(parameters)
doCombat(parameters.cid, combat2, parameters.var)
end

local function onCastSpell3(parameters)
doCombat(parameters.cid, combat3, parameters.var)
end

function onCastSpell(cid, var)

local parameters = { cid = cid, var = var}

if exhaustion.check(cid, 20004) == false then
addEvent(onCastSpell1, 100, parameters)
addEvent(onCastSpell2, 150, parameters)
addEvent(onCastSpell3, 200, parameters)
exhaustion.set(cid, 20004, 2)
return true
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 20004).."]")
end
end
