local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 64)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -0.0, -0, -0.0, -0)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 22)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -1.5, -1750, -0.5, -2000)

arr1 = {
        {0, 0, 0, 0, 0},
        {0, 1, 0, 0, 0},
        {0, 0, 2, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0}
}




arr2 = {
        {0, 1, 1, 1, 0},
        {1, 1, 1, 1, 1},
        {1, 1, 3, 1, 1},
        {1, 1, 1, 1, 1},
        {0, 1, 1, 1, 0}
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

function onCastSpell(cid, var)

local parameters = { cid = cid, var = var}

if exhaustion.check(cid, 23013) == false then
addEvent(onCastSpell1, 100, parameters)
addEvent(onCastSpell2, 100, parameters)
exhaustion.set(cid, 23013, 2)
return true
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 23013).."]")
end
end