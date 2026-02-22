local config = {
    storage_saga = 11124,     -- só é possível realizar a prova se tiver essa storage.
    storage_next_saga = 11125, -- storage que ganha ao ter sucesso na prova.
    storage_counter = 453517,  -- contador de acertos.
    storage_errors = 453515,   -- contador de erros.
    storage_danger = 120923,   -- storage que determina se o examinador está olhando.
    storage_is_cheating = 453516, 
    pos_kick = {x=3060, y=3017, z=5}, -- posição de teleporta para fora da sala.
    min_acertos = 6,
    experience = 50000 -- ganho de experiência ao concluir prova.
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
    local status_missao = getPlayerStorageValue(cid, config.storage_saga)
    local acertos = getPlayerStorageValue(cid, config.storage_counter)
    local erros = getPlayerStorageValue(cid, config.storage_errors)
    local pos = getThingPos(cid)

    -- bloqueio: só faz a prova se tiver a storage 11124 com valor 1.
    if status_missao ~= 1 then
        doPlayerSendTextMessage(cid, 22, "Voce nao tem permissao para fazer este exame agora.")
        return true
    end

    -- inicia a prova.
    if acertos == -1 then
        setPlayerStorageValue(cid, config.storage_counter, 0)
        setPlayerStorageValue(cid, config.storage_errors, 0)
        doSendAnimatedText(pos, "START!", 30) -- verde
        doPlayerSendTextMessage(cid, 22, "Voce iniciou a prova! Clique no papel para colar quando o examinador estiver distraido.")
        return true
    end

    -- se ja atingiu o limite de 10 tentativas.
    if (math.max(0, acertos) + math.max(0, erros)) >= 10 then
        -- se a quantidade de acertos for >= a acertos minimos que é = 6, ele passa na prova.
        if acertos >= config.min_acertos then
            doPlayerAddExp(cid, config.exp)
            setPlayerStorageValue(cid, config.storage_saga, -1)
            setPlayerStorageValue(cid, config.storage_next_saga, 1)
            setPlayerStorageValue(cid, config.storage_counter, -1) 
            doSendAnimatedText(pos, "PASS!", 215) -- branco
            doPlayerSendTextMessage(cid, 22, "Voce passou no exame escrito! A Próxima etapa é a Floresta da Morte.")
        else
            setPlayerStorageValue(cid, config.storage_counter, 0)
            setPlayerStorageValue(cid, config.storage_errors, 0)
            doSendAnimatedText(pos, "FAILED", 180) -- vermelho
            doPlayerSendTextMessage(cid, 22, "Voce nao obteve acertos suficientes. Tente novamente clicando no papel.")
        end
        return true
    end

    -- mecânica de cancelar cola.
    if getPlayerStorageValue(cid, config.storage_is_cheating) == 1 then
        setPlayerStorageValue(cid, config.storage_is_cheating, 0) 
        setPlayerStorageValue(cid, config.storage_errors, math.max(0, erros) + 1)
        doSendAnimatedText(pos, "STOP", 198) -- laranja
        doPlayerSendTextMessage(cid, 22, "Voce parou de colar e perdeu a questao por nervosismo!")
        doSendMagicEffect(pos, 2) 
        return true
    end

    -- checagem do examinador ao clicar.
    if getGlobalStorageValue(config.storage_danger) == 1 then
        setPlayerStorageValue(cid, config.storage_counter, 0) 
        setPlayerStorageValue(cid, config.storage_errors, 0)
        setPlayerStorageValue(cid, config.storage_is_cheating, 0)
        doTeleportThing(cid, config.pos_kick)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_RED, "VOCE FOI PEGO! Seu progresso na prova foi resetado.")
        return true
    end

    -- contador
    setPlayerStorageValue(cid, config.storage_is_cheating, 1)
    doSendAnimatedText(pos, "2s...", 30) -- verde
    
    addEvent(function()
        if isCreature(cid) and getPlayerStorageValue(cid, config.storage_is_cheating) == 1 then
            local currentPos = getThingPos(cid)
            
            if getGlobalStorageValue(config.storage_danger) == 1 then
                setPlayerStorageValue(cid, config.storage_counter, 0)
                setPlayerStorageValue(cid, config.storage_errors, 0)
                setPlayerStorageValue(cid, config.storage_is_cheating, 0)
                doTeleportThing(cid, config.pos_kick)
                return
            end
            
            doSendAnimatedText(currentPos, "1s...", 30) -- verde
            
            addEvent(function()
                if isCreature(cid) and getPlayerStorageValue(cid, config.storage_is_cheating) == 1 then
                    setPlayerStorageValue(cid, config.storage_is_cheating, 0)
                    
                    -- busca o valor atualizado para somar corretamente
                    local acertos_agora = getPlayerStorageValue(cid, config.storage_counter)
                    local novos_acertos = math.max(0, acertos_agora) + 1
                    
                    setPlayerStorageValue(cid, config.storage_counter, novos_acertos)
                    
                    doSendMagicEffect(getThingPos(cid), 13)
                    doSendAnimatedText(getThingPos(cid), "SUCESSO!", 30) -- verde
                    doPlayerSendTextMessage(cid, 22, "Questao respondida! ("..novos_acertos.."/10)")
                end
            end, 1000)
        end
    end, 1000)

    return true
end