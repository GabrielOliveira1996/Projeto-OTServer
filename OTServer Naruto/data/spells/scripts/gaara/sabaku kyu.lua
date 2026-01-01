local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 38)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -0.5, -600, -1.0, -800)
setCombatParam(combat1, COMBAT_PARAM_HITCOLOR, 205)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, 38)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 36)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -0.0, -0, -0.0, -0)
setCombatParam(combat2, COMBAT_PARAM_HITCOLOR, 205)

arr1 = {
        {0, 0, 0},
        {0, 3, 0},
        {0, 0, 0}
}




arr2 = {
        {0, 0, 0},
        {0, 3, 0},
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

function onCastSpell(cid, var)
local parameters = { cid = cid, var = var}
addEvent(onCastSpell1, 100, parameters)
addEvent(onCastSpell2, 100, parameters)

return TRUE

end