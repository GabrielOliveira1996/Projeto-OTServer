local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 2000) -- 2 segundos
setConditionParam(condition, CONDITION_PARAM_SPEED, -100) 

-- Função auxiliar para aplicar o dano com atraso
local function doWaveDmg(cid, targetPos, min, max, effect, condition)
    if not isCreature(cid) then return end
    
    -- Efeito visual no SQM
    doSendMagicEffect(targetPos, effect)
    
    -- Busca criatura e aplica dano/paralisia
    local target = getTopCreature(targetPos).uid
    if isCreature(target) then
        doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -min, -max, CONST_ME_NONE)
        doAddCondition(target, condition)
    end
end

function onCastSpell(cid, var)
    local level = getPlayerLevel(cid)
    local fist = getPlayerSkillLevel(cid, 0) 
    local lookDir = getCreatureLookDirection(cid)
    local EFFECT_ID = 37 
    
    local min = (fist * 3.0) + (level * 2.0)
    local max = (fist * 5.0) + (level * 3.0)
    local pos = getThingPos(cid)
    
    local delay = 150 -- Velocidade da onda (150ms entre cada SQM)

    for i = 1, 3 do
        local targetPos = {x = pos.x, y = pos.y, z = pos.z}

        if lookDir == 0 then targetPos.y = targetPos.y - i      -- Norte
        elseif lookDir == 1 then targetPos.x = targetPos.x + i -- Leste
        elseif lookDir == 2 then targetPos.y = targetPos.y + i -- Sul
        elseif lookDir == 3 then targetPos.x = targetPos.x - i -- Oeste
        end

        -- Agendamos o dano para acontecer um após o outro
        addEvent(doWaveDmg, (i - 1) * delay, cid, targetPos, min, max, EFFECT_ID, condition)
    end

    return true
end