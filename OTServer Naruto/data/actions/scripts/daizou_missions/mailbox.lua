function onUse(cid, item, fromPosition, itemEx, toPosition)
    local config = DAIZOU_MISSIONS[3]

    -- 1. Verifica se está na missão
    if getPlayerStorageValue(cid, config.storageStatus) ~= 1 then
        return false 
    end

    -- 2. Mapeamos qual ActionID corresponde a qual storage da sua LIB
    -- No RME, coloque ActionID 12032 na primeira caixa, 12033 na segunda... até 12035.
    local aid = item.actionid

    if aid < 12032 or aid > 12035 then
        doPlayerSendTextMessage(cid, 22, "Esta caixa nao parece ter cartas agora (Verifique o ActionID no RME).")
        return true
    end

    -- 3. Verifica se o player já coletou desta caixa específica
    if getPlayerStorageValue(cid, aid) == 1 then
        doPlayerSendTextMessage(cid, 22, "Voce ja recolheu a carta desta caixa.")
        return true
    end

    -- 4. Pega o contador atual de cartas
    local atual = math.max(0, getPlayerStorageValue(cid, config.storageCount))
    local novo_valor = atual + 1
    
    -- Salva o progresso
    setPlayerStorageValue(cid, config.storageCount, novo_valor)
    setPlayerStorageValue(cid, aid, 1) -- Marca que ESTA storage (caixa) já foi limpa
    
    doPlayerAddItem(cid, config.itemId, 1) -- Dá a Carta
    doSendMagicEffect(toPosition, 12) 
    
    doPlayerSendTextMessage(cid, 20, "Carta recolhida! Progresso: " .. novo_valor .. "/" .. config.goalCount)

    -- 5. Verifica se completou
    if novo_valor >= config.goalCount then
        setPlayerStorageValue(cid, config.storageStatus, 2)
        doPlayerSendTextMessage(cid, 19, "Voce coletou todas as cartas! Volte ao Daizou.")
    end

    return true
end