local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_KATON_DAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, 15)

-- configuracoes de queimadura
local condition = createConditionObject(CONDITION_FIRE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 5000) -- 5 segundos de duracao
setConditionParam(condition, CONDITION_PARAM_DRANKTIK, 1000) -- dano a cada 1 seg
setConditionParam(condition, CONDITION_PARAM_OFFICKEFFECT, 15) -- efeito de fogo no corpo
setConditionParam(condition, CONDITION_PARAM_MINVALUE, -100) -- dano min por tick
setConditionParam(condition, CONDITION_PARAM_MAXVALUE, -200) -- dano max por tick
setCombatCondition(combat, condition)

local area = createCombatArea({{1}})
setCombatArea(combat, area)

function onGetFormulaValues(cid, level, maglevel)
    local min = (level * 1.5) + (maglevel * 3.5) + 250
    local max = (level * 2.0) + (maglevel * 5.5) + 300
    return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
    local pos = getCreaturePosition(cid)
    local look = getCreatureLookDirection(cid)
    local range = 5
    local effect_missile = 15
    
    -- controle para nao atravessar parede
    local info = {stopped = false}

    for i = 1, range do
        addEvent(function()
            if not isCreature(cid) or info.stopped then return end
            
            local nextPos = {x = pos.x, y = pos.y, z = pos.z}
            if look == 0 then nextPos.y = pos.y - i
            elseif look == 1 then nextPos.x = pos.x + i
            elseif look == 2 then nextPos.y = pos.y + i
            elseif look == 3 then nextPos.x = pos.x - i
            end

            if doTileQueryAdd(cid, nextPos) ~= RETURNVALUE_NOERROR then
                local check = getTopCreature(nextPos).uid
                if not isCreature(check) then 
                    info.stopped = true
                    return 
                end
            end

            doSendMagicEffect(nextPos, effect_missile)
            doCombat(cid, combat, positionToVariant(nextPos))
            
        end, i * 80)
    end
    
    return true
end