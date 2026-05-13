function onUse(cid, item, fromPosition, itemEx, toPosition)
    local config = DAIZOU_MISSIONS[5]

    if getPlayerStorageValue(cid, config.storageStatus) ~= 1 then
        doPlayerSendTextMessage(cid, 22, "O bau esta trancado.")
        return true
    end

    if getPlayerItemCount(cid, config.itemId) >= 1 then
        doPlayerSendTextMessage(cid, 22, "Voce ja recuperou o manuscrito. Fuja daqui!")
        return true
    end

    -- Dá o item ao player
    doPlayerAddItem(cid, config.itemId, 1)
    doPlayerSendTextMessage(cid, 19, "Voce pegou o Manuscrito! Cuidado, e uma emboscada!")
    
    -- Spawn de inimigos (Ninjas Renegados)
    local inimigos = {"ninja", "ninja"} -- Use nomes de monstros que existam no seu server
    for i = 1, #inimigos do
        local pos = {x = toPosition.x + math.random(-1, 1), y = toPosition.y + math.random(-1, 1), z = toPosition.z}
        doCreateMonster(inimigos[i], pos)
        doSendMagicEffect(pos, 2)
    end

    return true
end