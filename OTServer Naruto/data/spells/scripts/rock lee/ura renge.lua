local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 38)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -0.5, -1800, -1.5, -2000)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 62)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -0.0, -0, -0.0, -0)

local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 5000)
setConditionParam(condition, CONDITION_PARAM_SPEED, -300)
setConditionFormula(condition, -1.5, 0, -0.5, 0)
setCombatCondition(combat1, condition)

arr1 = {
        {1, 1, 1, 1, 1},
        {1, 1, 3, 1, 1},
        {1, 1, 1, 1, 1}
}




arr2 = {
        {0, 0, 0, 0, 0},
        {1, 0, 0, 2, 0},
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

function onCastSpell(cid, var)

local parameters = { cid = cid, var = var}


if exhaustion.check(cid, 20014) == false then
exhaustion.set(cid, 20014, 2)
addEvent(onCastSpell1, 100, parameters)
addEvent(onCastSpell2, 100, parameters)

return TRUE
else
doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 20014).."]")
end
end