function onUse(cid, item, fromPosition, itemEx, toPosition)
    local storageStatus = 12001
    local storageCount = 12002
    local goal = 5
    
    -- Verifica se está na missão
    if getPlayerStorageValue(cid, storageStatus) ~= 1 then
        return false
    end

    -- UNIQUE STORAGE PARA CADA LIXO (ActionID no RME)
    -- Se você colocar ActionID 12003 no primeiro lixo, 12004 no segundo, etc.
    local checkStorage = item.actionid
    if checkStorage < 1000 then -- Se você esqueceu de pôr ActionID no RME
         doPlayerSendTextMessage(cid, 22, "Erro: Este lixo nao tem ActionID configurado no mapa.")
         return true
    end

    if getPlayerStorageValue(cid, checkStorage) == 1 then
        doPlayerSendTextMessage(cid, 22, "Voce ja limpou este ponto de lixo.")
        return true
    end

    -- SOMA UM NO CONTADOR
    local atual = math.max(0, getPlayerStorageValue(cid, storageCount))
    setPlayerStorageValue(cid, storageCount, atual + 1)
    setPlayerStorageValue(cid, checkStorage, 1) -- Marca que ESSE lixo já foi
    
    doSendMagicEffect(toPosition, 12)
    doPlayerSendTextMessage(cid, 20, "Lixo removido!")

    if (atual + 1) >= goal then
        doPlayerSendTextMessage(cid, 19, "Voce limpou tudo! Volte ao Daizou.")
    end

    return true
end