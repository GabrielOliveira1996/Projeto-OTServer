function onUse(cid, item, fromPosition, itemEx, toPosition)

    local experience = 4000
    local storageFaseAnterior = 11114 -- Storage que ganhou do Iruka na floresta
    local storageProximaFase = 11115  -- Storage de quem ja tirou a foto
    local efeitoDeFlash = 3

    -- 1. Verifica se o jogador ja tirou a foto
    if getPlayerStorageValue(cid, storageProximaFase) >= 1 then
        doPlayerSendTextMessage(cid, 22, "Voce ja tirou sua foto de registro ninja.")
        return true
    end

    -- 2. Verifica se o jogador esta na fase correta da saga
    if getPlayerStorageValue(cid, storageFaseAnterior) >= 1 then
        setPlayerStorageValue(cid, storageFaseAnterior, -1)
        setPlayerStorageValue(cid, storageProximaFase, 1)
        
        doPlayerAddExp(cid, experience)
        
        -- efeito de "flash" da camera
        doSendMagicEffect(getThingPos(cid), efeitoDeFlash) 
        
        doPlayerSendTextMessage(cid, 22, "Sorria! Foto tirada com sucesso para o registro de Genin.")
        return true
    else
        -- 3. Caso o jogador tente tirar a foto sem ter completado a fase anterior
        doPlayerSendTextMessage(cid, 22, "Voce precisa da autorizacao do Iruka para tirar a foto de registro.")
        return false
    end
end