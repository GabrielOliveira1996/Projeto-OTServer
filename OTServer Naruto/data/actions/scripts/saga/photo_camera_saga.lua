function onUse(cid, item, fromPosition, itemEx, toPosition)

    -- [ CONFIGURAÇÕES ]
    local expPrimeiraFoto = 1000
    local efeitoFlash = 3 
    local efeitoHokage = 1  
    local hokageName = "Hiruzen Sarutobi [Hokage]" 
    local checkRadius = 7 

    local status = getPlayerStorageValue(cid, SAGA_STORAGE)

    -- 1. Verifica se o jogador já completou o registro com o Hokage (Etapa 7 em diante)
    if status >= SAGA_STAGE_HOKAGE_GRANDSON then
        doPlayerSendTextMessage(cid, 22, "Voce ja tirou sua foto de registro ninja.")
        return true
    end

    -- 2. PRIMEIRA FOTO (Transição da Etapa 5 para a 6)
    -- O Naruto tira a foto pintada que irrita o Terceiro Hokage
    if status == SAGA_STAGE_REGISTRATION_PHOTO then
        doSendMagicEffect(getThingPos(item.uid), efeitoFlash)
        doSendMagicEffect(getThingPos(cid), efeitoFlash)

        -- Busca o NPC Hokage na sala para a reação inicial de fúria
        local entities = getSpectators(getThingPos(cid), checkRadius, checkRadius, false)
        if entities then
            for _, entity in ipairs(entities) do
                if isNpc(entity) and getCreatureName(entity) == hokageName then
                    -- O Hokage grita indignado com a pintura facial
                    doCreatureSay(entity, "O que voce pensa que esta fazendo? Eu nao vou aceitar isso!", TALKTYPE_SAY)
                    doSendMagicEffect(getThingPos(entity), efeitoHokage)
                    break
                end
            end
        end

        -- Avança para a fase do confronto no gabinete
        setPlayerStorageValue(cid, SAGA_STORAGE, SAGA_STAGE_HOKAGE_CONFRONTATION)
        doPlayerAddExp(cid, expPrimeiraFoto)
        doPlayerSendTextMessage(cid, 22, "XIS! Voce tirou uma foto... pintada? O Terceiro Hokage parece furioso!")
        return true

    -- 3. REFAZENDO A FOTO (Opção "Certinha" na Etapa 6)
    -- Se o jogador decidir não usar o Jutsu Sexy, ele clica aqui para limpar o rosto
    elseif status == SAGA_STAGE_HOKAGE_CONFRONTATION then
        doSendMagicEffect(getThingPos(item.uid), efeitoFlash)
        doSendMagicEffect(getThingPos(cid), efeitoFlash)
        
        -- Ativa a storage auxiliar definida na LIB para validar com o NPC
        setPlayerStorageValue(cid, SAGA_AUX_CLEAN_FACE, 1) 
        doPlayerSendTextMessage(cid, 19, "Voce limpou as pinturas e tirou uma foto formal. O Hokage deve aceitar agora.")
        return true

    else
        -- 4. Caso tente clicar na camera sem ter a permissão do Iruka (Etapa < 5)
        doPlayerSendTextMessage(cid, 22, "Voce precisa da autorizacao do Iruka para tirar a foto de registro.")
        return false
    end
end