local condition = createConditionObject(CONDITION_POISON)
setConditionParam(condition, CONDITION_PARAM_DELAYED, 1) -- Começa a tirar dano após 1s
addDamageCondition(condition, 5, 2000, -15) -- 5 vezes, a cada 2 segundos, tira 15 de vida

function onCastSpell(cid, var)
    local target = getCreatureTarget(cid)
    if target > 0 then
        doTargetCombatCondition(cid, target, condition, 17) -- Efeito 17 (Corte) + Veneno
        return true
    end
    return false
end