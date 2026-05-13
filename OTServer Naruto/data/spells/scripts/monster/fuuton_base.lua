local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FUUTON_DAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 18)
setCombatFormula(combat, COMBAT_FORMULA_LEVELMAGIC, -1.5, -10, -0.5, -50)
setCombatParam(combat, COMBAT_PARAM_HITCOLOR, 215)

function onCastSpell(cid, var)
    return doCombat(cid, combat, var)
end