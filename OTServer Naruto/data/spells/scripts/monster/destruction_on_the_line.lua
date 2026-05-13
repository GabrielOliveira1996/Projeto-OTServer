local condition = createConditionObject(CONDITION_PARALYZE)
setConditionParam(condition, CONDITION_PARAM_TICKS, 2000) -- 2 segundos
setConditionParam(condition, CONDITION_PARAM_SPEED, -100) 

function onCastSpell(cid, var)
    -- Configurações para Monstro
    local EFFECT_ID = 37 
    local lookDir = getCreatureLookDirection(cid)
    local pos = getThingPos(cid)
    
    -- Defina o dano fixo aqui, já que monstro não tem Level/Skill
    local minDmg = 100
    local maxDmg = 200

    -- Loop para percorrer 3 SQMs à frente
    for i = 1, 3 do
        local targetPos = {x = pos.x, y = pos.y, z = pos.z}

        -- Calcula a posição baseada na direção que o monstro está olhando
        if lookDir == 0 then targetPos.y = targetPos.y - i      -- Norte
        elseif lookDir == 1 then targetPos.x = targetPos.x + i -- Leste
        elseif lookDir == 2 then targetPos.y = targetPos.y + i -- Sul
        elseif lookDir == 3 then targetPos.x = targetPos.x - i -- Oeste
        end

        -- Efeito visual em cada sqm da linha
        doSendMagicEffect(targetPos, EFFECT_ID)

        -- Busca criaturas na posição
        local target = getTopCreature(targetPos).uid
        if isCreature(target) then
            -- Aplica dano e paralisia
            doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -minDmg, -maxDmg, CONST_ME_NONE)
            doAddCondition(target, condition)
        end
    end

    return true
end