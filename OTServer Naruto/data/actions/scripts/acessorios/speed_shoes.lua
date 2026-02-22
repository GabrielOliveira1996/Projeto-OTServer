function onUse(cid, item, fromPosition, itemEx, toPosition)
    local maxDist = 2 -- distancia maxima de teleporte
    local manaCost = 20 -- custo de chakra
    local cooldown = 5 -- tempo em segundos de cooldown
    local storage = 48521 -- storage para cooldown
    local playerPos = getCreaturePosition(cid)
    
    -- verifica cooldown
    if os.time() - getPlayerStorageValue(cid, storage) < cooldown then
        local timeLeft = cooldown - (os.time() - getPlayerStorageValue(cid, storage))
        doPlayerSendTextMessage(cid, 23, "You are exhausted. Wait " .. timeLeft .. " seconds.")
        return true
    end

    -- verifica se o destino e valido
    if toPosition.x == 0 or toPosition.x == 65535 then
        doPlayerSendTextMessage(cid, 23, "Select a valid destination on the ground.")
        return true
    end

    -- checagem de chakra
    if getCreatureMana(cid) < manaCost then
        doPlayerSendTextMessage(cid, 23, "You do not have enough chakra.")
        doSendMagicEffect(playerPos, 2)
        return true
    end

    -- verifica a distancia
    if getDistanceBetween(playerPos, toPosition) > maxDist then
        doPlayerSendTextMessage(cid, 23, "The destination is too far away.")
        return true
    end

    -- impede gastar mana se clicar na mesma posicao
    if toPosition.x == playerPos.x and toPosition.y == playerPos.y then
        return false
    end

    -- execucao do shunshin
    doSendMagicEffect(playerPos, 2) -- fumaca na saida
    
    -- teleporte
    doTeleportThing(cid, toPosition, false)
    
    -- gasto de chakra e definicao do cooldown
    doPlayerRemoveMana(cid, manaCost)
    setPlayerStorageValue(cid, storage, os.time())

    -- Efeito de fumaça na chegada
    doSendMagicEffect(toPosition, 2)
    
    return true
end