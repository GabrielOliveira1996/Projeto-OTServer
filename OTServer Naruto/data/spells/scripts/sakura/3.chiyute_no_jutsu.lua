local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_HEALING)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 12)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

function onGetFormulaValues(cid, level, maglevel)
    local min = (level * 1.5) + (maglevel * 3)
    local max = (level * 2.0) + (maglevel * 5)
    return min, max
end

-- usa formula definida acima.
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
    return doCombat(cid, combat, var)
end