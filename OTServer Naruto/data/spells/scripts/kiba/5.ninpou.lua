local config = {
    slowCondition = createConditionObject(CONDITION_PARALYZE),
    damageType = COMBAT_PHYSICALDAMAGE,
    effTeleport = 10, -- Efeito na sa��da/chegada do Akamaru
    effBite = 17      -- Efeito da mordida no alvo
}

-- Configuração do Paralyze (3 segundos)
setConditionParam(config.slowCondition, CONDITION_PARAM_TICKS, 3000)
setConditionFormula(config.slowCondition, -0.7, 0, -0.7, 0) -- Reduz 70% da velocidade

function onCastSpell(cid, var)
    -- 1. Verifica se o player tem um alvo selecionado
    local target = getCreatureTarget(cid)
    if target == 0 then
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUARENEEDTARGET)
        return false
    end

    -- 2. Verifica se o Akamaru está sumonado
    local summons = getCreatureSummons(cid)
    local akamaru = nil
    local playerName = getPlayerName(cid):lower()

    for _, summon in ipairs(summons) do
        local sName = getCreatureName(summon):lower()
        -- Aceita se o nome for Akamaru ou se for o Clone (nome igual do player)
        if sName == "akamaru" or sName == playerName then
            akamaru = summon
            break
        end
    end

    if not akamaru then
        doPlayerSendCancel(cid, "Voce precisa estar com o Akamaru sumonado para usar este jutsu.")
        return false
    end

    -- 4. Execução da Lógica
    local targetPos = getCreaturePosition(target)
    local akamaruPos = getCreaturePosition(akamaru)

    -- Efeito de saída onde o Akamaru está agora
    doSendMagicEffect(akamaruPos, config.effTeleport)
    
    -- Teleporta Akamaru para o alvo e manda efeito de chegada
    doTeleportThing(akamaru, targetPos, false)
    doSendMagicEffect(targetPos, config.effTeleport)

    -- Cálculo de Dano
    local level = getPlayerLevel(cid)
    local fist = getPlayerSkillLevel(cid, SKILL_FIST)
    local min = -((fist * 1.2) + (level * 0.8))
    local max = -((fist * 1.8) + (level * 1.2))

    -- Delay minúsculo para a mordida (sensação de impacto)
    addEvent(function()
        if isCreature(target) and isCreature(akamaru) then
            -- Aplica Dano com o efeito 17
            doTargetCombatHealth(akamaru, target, config.damageType, min, max, config.effBite)
            -- Aplica Slow
            doAddCondition(target, config.slowCondition)
            
            -- 5. Akamaru volta para o lado do Kiba após 0.4 segundos
            addEvent(function()
                if isCreature(akamaru) and isCreature(cid) then
                    local masterPos = getCreaturePosition(cid)
                    -- Efeito saindo do inimigo
                    doSendMagicEffect(getCreaturePosition(akamaru), config.effTeleport)
                    -- Volta pro mestre
                    doTeleportThing(akamaru, masterPos, false)
                    -- Efeito chegando no mestre
                    doSendMagicEffect(masterPos, config.effTeleport)
                end
            end, 400)
        end
    end, 100)

    return true
end