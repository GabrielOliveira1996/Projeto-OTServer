function onStepIn(cid, item, position, fromPosition)
    
    local exp_ganha = 40000
    local nome_summon = "tazuna"

    if not isPlayer(cid) then return true end

    -- Se o jogador já passou dessa fase, não faz nada
    if getPlayerStorageValue(cid, SAGA_STORAGE) >= SAGA_STAGE_FINALLY_A_BREAK then
        return true
    end

    -- Verifica se o jogador está no estágio de ter derrotado o Zabuza (11)
    if getPlayerStorageValue(cid, SAGA_STORAGE) == SAGA_STAGE_WAVES_MIST then
        
        local summons = getCreatureSummons(cid)
        local tazuna_id = nil

        -- Busca pelo Tazuna entre os summons
        if summons and #summons > 0 then
            for _, summon in ipairs(summons) do
                if getCreatureName(summon):lower() == nome_summon:lower() then
                    tazuna_id = summon
                    break
                end
            end
        end

        if tazuna_id then
            -- 1. Remove o Tazuna
            doRemoveCreature(tazuna_id)

            -- 2. Avança a Saga para o estágio 12 (Acesso Liberado)
            setPlayerStorageValue(cid, SAGA_STORAGE, SAGA_STAGE_FINALLY_A_BREAK)

            -- 3. Entrega a Experiência
            doPlayerAddExperience(cid, exp_ganha)
            
            -- 4. Efeitos e Mensagens
            doSendMagicEffect(getThingPos(cid), 2) -- Fumaça
            doPlayerSendTextMessage(cid, 22, "Voce entregou Tazuna no cais! Missao cumprida. Agora voce pode viajar com o barqueiro.")
            
            -- Efeito visual de XP (Se o seu servidor suportar)
            if doSendAnimatedText then
                doSendAnimatedText(getThingPos(cid), exp_ganha .. " EXP", 215)
            end
        else
            -- Se não estiver com o Tazuna
            doPlayerSendTextMessage(cid, 22, "Onde esta o Tazuna? Voce precisa traze-lo ate aqui.")
            doSendMagicEffect(getThingPos(cid), 2)
        end
        
    elseif getPlayerStorageValue(cid, SAGA_STORAGE) < SAGA_STAGE_WAVES_MIST then
        doPlayerSendTextMessage(cid, 22, "O caminho para o cais esta bloqueado pelo Zabuza. Derrote-o primeiro!")
    end

    return true
end