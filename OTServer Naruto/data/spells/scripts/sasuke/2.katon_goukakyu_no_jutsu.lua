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

-- logica da formula aplicada
function onGetFormulaValues(cid, level, maglevel)
    local min = (level * 1.5) + (maglevel * 3.5) + 200
    local max = (level * 2.0) + (maglevel * 5.5) + 250
    return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local arr = {
    {0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0},
    {0, 1, 1, 1, 0},
    {0, 1, 1, 1, 0},
    {0, 0, 1, 0, 0},
    {0, 0, 3, 0, 0},
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

function onCastSpell(cid, var)
    -- verifica exaustao
    if exhaustion.check(cid, 20011) == false then
        exhaustion.set(cid, 20011, 2)
        
        -- executa o combate duas vezes
        doCombat(cid, combat, var)
        return true
    else
        doPlayerSendCancel(cid, "Cooldown[" .. exhaustion.get(cid, 20011) .. "]")
        return false
    end
end