local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 38)
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_MANADRAIN)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -0.5, -600, -1.5, -750)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 98)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -0.0, -0, -0.0, -0)





arr1 = {
{1, 1, 1, 1, 1},
{1, 1, 1, 1, 1},
{1, 1, 2, 1, 1},
{1, 1, 1, 1, 1},
{1, 1, 1, 1, 1}
}




arr2 = {
{1, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
{0, 0, 0, 0, 0},
{0, 0, 0, 2, 0},
{0, 0, 0, 0, 0}
}



local area1 = createCombatArea(arr1)
local area2 = createCombatArea(arr2)
setCombatArea(combat1, area1)
setCombatArea(combat2, area2)

local function onCastSpell1(parameters)
doCombat(parameters.cid, combat1, parameters.var)
end

local function onCastSpell2(parameters)
doCombat(parameters.cid, combat2, parameters.var)
end

local function onCastSpell3(parameters)
doCombat(parameters.cid, combat2, parameters.var)
end

local function onCastSpell4(parameters)
doCombat(parameters.cid, combat2, parameters.var)
end

local function onCastSpell5(parameters)
doCombat(parameters.cid, combat2, parameters.var)
end

local function onCastSpell6(parameters)
doCombat(parameters.cid, combat2, parameters.var)
end

local function onCastSpell7(parameters)
doCombat(parameters.cid, combat1, parameters.var)
end

local function onCastSpell8(parameters)
doCombat(parameters.cid, combat1, parameters.var)
end

local function onCastSpell9(parameters)
doCombat(parameters.cid, combat1, parameters.var)
end

local function onCastSpell10(parameters)
doCombat(parameters.cid, combat1, parameters.var)
end

local function onCastSpell11(parameters)
doCombat(parameters.cid, combat1, parameters.var)
end

local function onCastSpell12(parameters)
doCombat(parameters.cid, combat1, parameters.var)
end

local function onCastSpell13(parameters)
doCombat(parameters.cid, combat1, parameters.var)
end

local function onCastSpell14(parameters)
doCombat(parameters.cid, combat1, parameters.var)
end

local function onCastSpell15(parameters)
doCombat(parameters.cid, combat2, parameters.var)
end

local function onCastSpell16(parameters)
doCombat(parameters.cid, combat2, parameters.var)
end

local function onCastSpell17(parameters)
doCombat(parameters.cid, combat2, parameters.var)
end

local function onCastSpell18(parameters)
doCombat(parameters.cid, combat2, parameters.var)
end

function onCastSpell(cid, var)
local parameters = { cid = cid, var = var}

local target = getCreatureTarget(cid)

if(target) < 1 then
doPlayerSendCancel(cid,"Você tem que estar atacando o oponente para usar esse jutsu.")
return false
end

if exhaustion.check(cid, 20003) == false then
doCreatureSetNoMove(target, true)
doCreatureSetNoMove(cid, true)
addEvent(doCreatureSetNoMove, 3 * 1000, target, false)
addEvent(doCreatureSetNoMove, 3 * 1000, cid, false)
addEvent(onCastSpell1, 100, parameters) -- tira chakra
addEvent(onCastSpell2, 100, parameters)
addEvent(onCastSpell3, 300, parameters)
addEvent(onCastSpell4, 600, parameters)
addEvent(onCastSpell5, 900, parameters)
addEvent(onCastSpell6, 1200, parameters)
addEvent(onCastSpell7, 300, parameters) -- tira chakra
addEvent(onCastSpell8, 600, parameters) -- tira chakra
addEvent(onCastSpell9, 900, parameters) -- tira chakra
addEvent(onCastSpell10, 1200, parameters) -- tira chakra
addEvent(onCastSpell11, 1500, parameters) -- tira chakra
addEvent(onCastSpell12, 1800, parameters) -- tira chakra
addEvent(onCastSpell13, 2100, parameters) -- tira chakra
addEvent(onCastSpell14, 2400, parameters) -- tira chakra
addEvent(onCastSpell15, 1500, parameters) 
addEvent(onCastSpell16, 1800, parameters) 
addEvent(onCastSpell17, 2100, parameters) 
addEvent(onCastSpell18, 2400, parameters)
exhaustion.set(cid, 20003, 3)
return true
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 20003).."]")
end
end
