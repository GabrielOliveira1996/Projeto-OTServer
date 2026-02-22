local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_RAITON_DAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 11)

-- funcao da formula personalizada
function onGetFormulaValues(cid, level, maglevel)
    local min = (level * 1.5) + (maglevel * 3.5) + 250
    local max = (level * 2.0) + (maglevel * 5.5) + 300
    return -min, -max
end

-- define que o combate usara a funcao acima para calcular o dano
setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local arr = {
    {3},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
    if exhaustion.check(cid, 20012) == false then
        exhaustion.set(cid, 20012, 2)
        doCombat(cid, combat, var)
        doCombat(cid, combat, var)
        return true
    else
        doPlayerSendCancel(cid, "Cooldown[" .. exhaustion.get(cid, 20012) .. "]")
    end
end