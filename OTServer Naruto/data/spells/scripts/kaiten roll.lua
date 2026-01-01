local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1140, -1.0, -1420)
setCombatParam(combat1, COMBAT_PARAM_HITCOLOR, 16)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, 38)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 54)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -0.0, -0, -0.0, -0)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatFormula(combat3, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1140, -1.0, -1420)
setCombatParam(combat3, COMBAT_PARAM_HITCOLOR, 16)

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat4, COMBAT_PARAM_EFFECT, 54)
setCombatFormula(combat4, COMBAT_FORMULA_LEVELMAGIC, -0.0, -0, -0.0, -0)

local combat5 = createCombatObject()
setCombatParam(combat5, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatFormula(combat5, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1140, -1.0, -1420)
setCombatParam(combat5, COMBAT_PARAM_HITCOLOR, 16)

local combat6 = createCombatObject()
setCombatParam(combat6, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat6, COMBAT_PARAM_EFFECT, 54)
setCombatFormula(combat6, COMBAT_FORMULA_LEVELMAGIC, -0.0, -0, -0.0, -0)

local combat7 = createCombatObject()
setCombatParam(combat7, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatFormula(combat7, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1140, -1.0, -1420)
setCombatParam(combat7, COMBAT_PARAM_HITCOLOR, 16)

local combat8 = createCombatObject()
setCombatParam(combat8, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat8, COMBAT_PARAM_EFFECT, 54)
setCombatFormula(combat8, COMBAT_FORMULA_LEVELMAGIC, -0.0, -0, -0.0, -0)


arr1 = {
        {1, 1, 1},
        {1, 2, 1},
        {1, 1, 1}
}

arr2 = {
        {1, 0, 0},
        {0, 2, 0},
        {0, 0, 0}
}

arr3 = {
        {1, 1, 1},
        {1, 2, 1},
        {1, 1, 1}
}

arr4 = {
        {1, 0, 0},
        {0, 2, 0},
        {0, 0, 0}
}

arr5 = {
        {1, 1, 1},
        {1, 2, 1},
        {1, 1, 1}
}

arr6 = {
        {1, 0, 0},
        {0, 2, 0},
        {0, 0, 0}
}

arr7 = {
        {1, 1, 1},
        {1, 2, 1},
        {1, 1, 1}
}

arr8 = {
        {1, 0, 0},
        {0, 2, 0},
        {0, 0, 0}
}

local area1 = createCombatArea(arr1)
local area2 = createCombatArea(arr2)
local area3 = createCombatArea(arr3)
local area4 = createCombatArea(arr4)
local area5 = createCombatArea(arr5)
local area6 = createCombatArea(arr6)
local area7 = createCombatArea(arr7)
local area8 = createCombatArea(arr8)
setCombatArea(combat1, area1)
setCombatArea(combat2, area2)
setCombatArea(combat3, area3)
setCombatArea(combat4, area4)
setCombatArea(combat5, area5)
setCombatArea(combat6, area6)
setCombatArea(combat7, area7)
setCombatArea(combat8, area8)

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

function onCastSpell(cid, var)
local parameters = { cid = cid, var = var}
addEvent(onCastSpell1, 200, parameters)
addEvent(onCastSpell2, 400, parameters)
addEvent(onCastSpell3, 600, parameters)
addEvent(onCastSpell4, 800, parameters)
addEvent(onCastSpell5, 1000, parameters)
addEvent(onCastSpell6, 1200, parameters)
addEvent(onCastSpell7, 1400, parameters)
addEvent(onCastSpell8, 1600, parameters)

return TRUE

end