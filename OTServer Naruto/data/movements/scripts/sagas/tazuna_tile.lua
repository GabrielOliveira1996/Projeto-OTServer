function onStepIn(cid, item, position, fromPosition)

    -- configuracoes
    local storage_antiga = 90908
    local storage_nova = 11121
    local exp_ganha = 12000
    local nome_summon = "tazuna"

    -- Verifica se é um jogador
    if not isPlayer(cid) then
        return true
    end

    -- Se o jogador já completou (já tem a storage nova), não faz nada
    if getPlayerStorageValue(cid, storage_nova) >= 1 then
        return true
    end

    -- Verifica se o jogador está na parte da missão de escolta
    if getPlayerStorageValue(cid, storage_antiga) >= 1 then
        
        local summons = getCreatureSummons(cid)
        local tazuna_encontrado = false
        local tazuna_id = 0

        -- Busca pelo Tazuna entre os summons
        if summons and #summons > 0 then
            for i = 1, #summons do
                local summon = summons[i]
                if getCreatureName(summon):lower() == nome_summon:lower() then
                    tazuna_encontrado = true
                    tazuna_id = summon
                    break
                end
            end
        end

        -- LOGICA DE VERIFICAÇÃO
        if tazuna_encontrado then
            -- 1. Remove o Tazuna
            doRemoveCreature(tazuna_id)

            -- 2. Troca as Storages
            setPlayerStorageValue(cid, storage_antiga, -1) 
            setPlayerStorageValue(cid, storage_nova, 1)    

            -- 3. Entrega a Experiência
            doPlayerAddExperience(cid, exp_ganha)

            -- 4. Efeitos e Mensagens de Sucesso
            doSendMagicEffect(getThingPos(cid), 2) -- Fumaca
            doPlayerSendTextMessage(cid, 22, "Voce escoltou Tazuna com seguranca e recebeu " .. exp_ganha .. " de experiencia!")
            
            -- Opcional: Efeito visual de Experiencia subindo (animado)
            doSendAnimatedText(getThingPos(cid), "12000 EXP", 215)
        else
            -- CASO NÃO TENHA O TAZUNA
            doPlayerSendTextMessage(cid, 22, "Voce precisa escoltar o Tazuna com vida ate este local para completar a missao.")
            doSendMagicEffect(getThingPos(cid), 2) -- Pequeno efeito de falha
        end
    end

    return true
end