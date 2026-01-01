local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 38)
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_MANADRAIN)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -0.5, -700, -1.5, -850)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 58)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -0.0, -0, -0.0, -0)
setCombatParam(combat2, COMBAT_PARAM_HITCOLOR, 16)



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

function onCastSpell(cid, var)
local parameters = { cid = cid, var = var}

local target = getCreatureTarget(cid)

if exhaustion.check(cid, 20003) == false then
doCreatureSay(cid, "hakke hasangeki", TALKTYPE_SAY)
doCreatureAddMana(cid, -900)
doCreatureSetNoMove(target, true)
addEvent(doCreatureSetNoMove, 3 * 1000, target, false)
addEvent(onCastSpell1, 100, parameters) -- tira chakra
addEvent(onCastSpell2, 200, parameters)
addEvent(onCastSpell3, 600, parameters)
addEvent(onCastSpell4, 1000, parameters)
addEvent(onCastSpell5, 1400, parameters)
addEvent(onCastSpell6, 1800, parameters)
addEvent(onCastSpell7, 500, parameters) -- tira chakra
addEvent(onCastSpell8, 1000, parameters) -- tira chakra
addEvent(onCastSpell9, 1500, parameters) -- tira chakra
addEvent(onCastSpell10, 2000, parameters) -- tira chakra
exhaustion.set(cid, 20003, 3)
return
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 20003).."]")
end
end
