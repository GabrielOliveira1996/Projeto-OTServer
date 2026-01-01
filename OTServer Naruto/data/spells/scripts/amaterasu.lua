local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 42)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -0.5, -600, -1.0, -900)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 42)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -0.5, -600, -1.0, -900)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, 42)
setCombatFormula(combat3, COMBAT_FORMULA_LEVELMAGIC, -0.5, -600, -1.0, -900)

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat4, COMBAT_PARAM_EFFECT, 42)
setCombatFormula(combat4, COMBAT_FORMULA_LEVELMAGIC, -0.5, -600, -1.0, -900)

local combat5 = createCombatObject()
setCombatParam(combat5, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat5, COMBAT_PARAM_EFFECT, 42)
setCombatFormula(combat5, COMBAT_FORMULA_LEVELMAGIC, -0.5, -600, -1.0, -900)

local combat6 = createCombatObject()
setCombatParam(combat6, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat6, COMBAT_PARAM_EFFECT, 42)
setCombatFormula(combat6, COMBAT_FORMULA_LEVELMAGIC, -0.5, -600, -1.0, -900)

local combat7 = createCombatObject()
setCombatParam(combat7, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat7, COMBAT_PARAM_EFFECT, 42)
setCombatFormula(combat7, COMBAT_FORMULA_LEVELMAGIC, -0.5, -600, -1.0, -900)

local combat8 = createCombatObject()
setCombatParam(combat8, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat8, COMBAT_PARAM_EFFECT, 42)
setCombatFormula(combat8, COMBAT_FORMULA_LEVELMAGIC, -0.5, -600, -1.0, -900)

local combat9 = createCombatObject()
setCombatParam(combat9, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat9, COMBAT_PARAM_EFFECT, 42)
setCombatFormula(combat9, COMBAT_FORMULA_LEVELMAGIC, -0.5, -600, -1.0, -900)

local combat10 = createCombatObject()
setCombatParam(combat10, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat10, COMBAT_PARAM_EFFECT, 42)
setCombatFormula(combat10, COMBAT_FORMULA_LEVELMAGIC, -0.5, -600, -1.0, -900)

arr1 = {

{3},

}

arr2 = {

{3},

}

arr3 = {
{3},
}

arr4 = {

{3},
}

arr5 = {
{3},
}

arr6 = {
{3},
}

arr7 = {
{3},
}

arr8 = {
{3},
}

arr9 = {
{3},
}

arr10 = {
{3},
}

local area1 = createCombatArea(arr1)
local area2 = createCombatArea(arr2)
local area3 = createCombatArea(arr3)
local area4 = createCombatArea(arr4)
local area5 = createCombatArea(arr5)
local area6 = createCombatArea(arr6)
local area7 = createCombatArea(arr7)
local area8 = createCombatArea(arr8)
local area9 = createCombatArea(arr9)
local area10 = createCombatArea(arr10)
setCombatArea(combat1, area1)
setCombatArea(combat2, area2)
setCombatArea(combat3, area3)
setCombatArea(combat4, area4)
setCombatArea(combat5, area5)
setCombatArea(combat6, area6)
setCombatArea(combat7, area7)
setCombatArea(combat8, area8)
setCombatArea(combat9, area9)
setCombatArea(combat10, area10)

local function onCastSpell1(parameters)
doCombat(parameters.cid, combat1, parameters.var)
end

local function onCastSpell2(parameters)
doCombat(parameters.cid, combat2, parameters.var)
end

local function onCastSpell3(parameters)
doCombat(parameters.cid, combat3, parameters.var)
end

local function onCastSpell4(parameters)
doCombat(parameters.cid, combat4, parameters.var)
end

local function onCastSpell5(parameters)
doCombat(parameters.cid, combat5, parameters.var)
end

local function onCastSpell6(parameters)
doCombat(parameters.cid, combat6, parameters.var)
end

local function onCastSpell7(parameters)
doCombat(parameters.cid, combat7, parameters.var)
end

local function onCastSpell8(parameters)
doCombat(parameters.cid, combat8, parameters.var)
end

local function onCastSpell9(parameters)
doCombat(parameters.cid, combat9, parameters.var)
end

local function onCastSpell10(parameters)
doCombat(parameters.cid, combat10, parameters.var)
end

function onCastSpell(cid, var)
if getPlayerStorageValue(cid, 301) > 1 then
local parameters = { cid = cid, var = var}
addEvent(onCastSpell1, 500, parameters)
addEvent(onCastSpell2, 100, parameters)
addEvent(onCastSpell3, 1500, parameters)
addEvent(onCastSpell4, 2000, parameters)
addEvent(onCastSpell5, 2500, parameters)
addEvent(onCastSpell6, 3000, parameters)
addEvent(onCastSpell7, 3500, parameters)
addEvent(onCastSpell8, 4000, parameters)
addEvent(onCastSpell9, 4500, parameters)
addEvent(onCastSpell10, 5000, parameters)

return TRUE

end