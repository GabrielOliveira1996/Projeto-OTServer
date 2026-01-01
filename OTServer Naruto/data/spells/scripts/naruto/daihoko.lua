local combat1 = createCombatObject()
setCombatParam(combat1, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat1, COMBAT_PARAM_EFFECT, 24)
setCombatFormula(combat1, COMBAT_FORMULA_LEVELMAGIC, -0.5, -700, -1.0, -900)
setCombatParam(combat1, COMBAT_PARAM_HITCOLOR, 205)

local combat2 = createCombatObject()
setCombatParam(combat2, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat2, COMBAT_PARAM_EFFECT, 24)
setCombatFormula(combat2, COMBAT_FORMULA_LEVELMAGIC, -0.5, -700, -1.0, -900)
setCombatParam(combat2, COMBAT_PARAM_HITCOLOR, 205)

local combat3 = createCombatObject()
setCombatParam(combat3, COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
setCombatParam(combat3, COMBAT_PARAM_EFFECT, 24)
setCombatFormula(combat3, COMBAT_FORMULA_LEVELMAGIC, -0.5, -700, -1.0, -900)
setCombatParam(combat3, COMBAT_PARAM_HITCOLOR, 205)

arr1 = {
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 1, 0, 0, 0, 0},
        {0, 0, 0, 0, 3, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0}
}

arr2 = {
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 1, 0, 1, 0, 0, 0},
        {0, 0, 0, 1, 0, 1, 0, 0, 0},
        {0, 0, 0, 0, 2, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0}
}

arr3 = {
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 1, 1, 1, 1, 1, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, 2, 0, 0, 0, 0},
        {0, 0, 0, 0, 0, 0, 0, 0, 0}
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
    if exhaustion.check(cid, 23005) == false then
        exhaustion.set(cid, 23005, 2)
        doCreatureAddMana(cid, -840)
        local parameters = { cid = cid, var = var}
        addEvent(onCastSpell1, 0, parameters)
        addEvent(onCastSpell2, 300, parameters)
        addEvent(onCastSpell3, 600, parameters)
    else
        doPlayerSendCancel(cid, "Cooldown[" ..exhaustion.get(cid, 23005).."]")
    end
end