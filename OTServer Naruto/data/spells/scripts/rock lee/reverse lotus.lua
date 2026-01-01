local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 34)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1500, -1.5, -2000)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 34)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1500, -1.5, -2000)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, 34)
setCombatFormula(combat3, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1500, -1.5, -2000)

local combat4 = createCombatObject()
setCombatParam(combat4, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat4, COMBAT_PARAM_EFFECT, 34)
setCombatFormula(combat4, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1500, -1.5, -2000)

local combat5 = createCombatObject()
setCombatParam(combat5, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat5, COMBAT_PARAM_EFFECT, 38)
setCombatFormula(combat5, COMBAT_FORMULA_LEVELMAGIC, -0.5, -100, -1.5, -300)

local combat6 = createCombatObject()
setCombatParam(combat6, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat6, COMBAT_PARAM_EFFECT, 62)
setCombatFormula(combat6, COMBAT_FORMULA_LEVELMAGIC, -0.0, -0, -0.0, -0)


local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 5000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -300)
setConditionFormula(condition, -1.5, 0, -0.5, 0)
setCombatCondition(combat5, condition)


arr1 = {
{0, 0, 0, 0, 0, 0, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 3, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 1, 1, 1, 1, 1, 0},
{0, 0, 0, 0, 0, 0, 0},
}

arr2 = {
{1, 1, 1, 1, 1, 1, 1},
{1, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 2, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 1},
{1, 1, 1, 1, 1, 1, 1},
}

arr3 = {
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
{1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
}

arr4 = {
{3},
}

arr5 = {
        {1, 1, 1, 1, 1},
        {1, 1, 3, 1, 1},
        {1, 1, 1, 1, 1}
}

arr6 = {
        {0, 0, 0, 0, 0},
        {1, 0, 0, 2, 0},
        {0, 0, 0, 0, 0}
}

local area1 = createCombatArea(arr1)
local area2 = createCombatArea(arr2)
local area3 = createCombatArea(arr3)
local area4 = createCombatArea(arr4)
local area5 = createCombatArea(arr5)
local area6 = createCombatArea(arr6)
setCombatArea(combat1, area1)
setCombatArea(combat2, area2)
setCombatArea(combat3, area3)
setCombatArea(combat4, area4)
setCombatArea(combat5, area5)
setCombatArea(combat6, area6)

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

function onCastSpell(cid, var)
local parameters = { cid = cid, var = var}

if exhaustion.check(cid, 20015) == false then
exhaustion.set(cid, 20015, 2)
addEvent(onCastSpell1, 200, parameters)
addEvent(onCastSpell2, 250, parameters)
addEvent(onCastSpell3, 300, parameters)
addEvent(onCastSpell4, 350, parameters)
addEvent(onCastSpell5, 400, parameters)
addEvent(onCastSpell6, 500, parameters)

return TRUE
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 20014).."]")
end
end