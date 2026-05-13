local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FUUTON_DAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 57)

function onCastSpell(cid, var)
    return doCombat(cid, combat, var)
end