local config = {
    slowCondition = createConditionObject(CONDITION_PARALYZE),
    damageType = COMBAT_PHYSICALDAMAGE,
    effTeleport = 10, -- Efeito na saí­da/chegada do Akamaru
    effBite = 17      -- Efeito da mordida no alvo
}

-- ConfiguraÃ§Ã£o do Paralyze (3 segundos)
setConditionParam(config.slowCondition, CONDITION_PARAM_TICKS, 3000)
setConditionFormula(config.slowCondition, -0.7, 0, -0.7, 0) -- Reduz 70% da velocidade

function onCastSpell(cid, var)
    -- 1. Verifica se o player tem um alvo selecionado
    local target = getCreatureTarget(cid)
    if target == 0 then
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUARENEEDTARGET)
        return false
    end

    -- 2. Verifica se o Akamaru estÃ¡ sumonado
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
        doPlayerSendCancel(cid, "Você precisa estar com o Akamaru sumonado para usar este jutsu.")
        return false
    end

    -- execução da lógica
    local targetPos = getCreaturePosition(target)
    local akamaruPos = getCreaturePosition(akamaru)

    -- efeito de saí­da onde o akamaru está agora
    doSendMagicEffect(akamaruPos, config.effTeleport)
    
    -- teleporta Akamaru para o alvo e manda efeito de chegada
    doTeleportThing(akamaru, targetPos, false)
    doSendMagicEffect(targetPos, config.effTeleport)

    -- cálculo de Dano
    local level = getPlayerLevel(cid)
    local fist = getPlayerSkillLevel(cid, SKILL_FIST)
    local min = -((fist * 1.5) + (level * 1.0))
    local max = -((fist * 2.5) + (level * 2.0))

    -- delay para a mordida
    addEvent(function()
        if isCreature(target) and isCreature(akamaru) then
            -- Aplica Dano com o efeito 17
            doTargetCombatHealth(akamaru, target, config.damageType, min, max, config.effBite)
            -- Aplica Slow
            doAddCondition(target, config.slowCondition)
            
            -- 5. Akamaru volta para o lado do Kiba apÃ³s 0.4 segundos
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