local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_KATON_DAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 15)

local condition = createConditionObject(CONDITION_FIRE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 5000) -- 5 segundos de duracao
setConditionParam(condition, CONDITION_PARAM_DRANKTIK, 1000) -- dano a cada 1 seg
setConditionParam(condition, CONDITION_PARAM_OFFICKEFFECT, 15) -- efeito de fogo no corpo
setConditionParam(condition, CONDITION_PARAM_MINVALUE, -100) -- dano min por tick
setConditionParam(condition, CONDITION_PARAM_MAXVALUE, -200) -- dano max por tick
setCombatCondition(combat, condition)

local area = createCombatArea({
    {0, 1, 0},
    {1, 3, 1},
    {0, 1, 0},
})
setCombatArea(combat, area)

function onGetFormulaValues(cid, level, maglevel)
    local min = (level * 1.5) + (maglevel * 3.5) + 100
    local max = (level * 2.0) + (maglevel * 5.5) + 150
    return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
    if not exhaustion.check(cid, 23001) then
        exhaustion.set(cid, 23001, 2)
        return doCombat(cid, combat, var)
    else
        doPlayerSendCancel(cid, "Cooldown [" .. exhaustion.get(cid, 23001) .. "s]")
        return false
    end
end