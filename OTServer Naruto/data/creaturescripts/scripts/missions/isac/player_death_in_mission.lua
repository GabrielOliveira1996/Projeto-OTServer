function onPrepareDeath(cid, lastHitKiller, mostDamageKiller)
    if not isPlayer(cid) then return true end

    local st = getPlayerStorageValue(cid, 2701)
    
    -- Se o jogador morrer enquanto o Isac é um summon (st 4)
    if st == 4 then
        -- Voltamos para a storage 3 (Onde o NPC aceita ajudar e sumona o Isac)
        setPlayerStorageValue(cid, 2701, 3) 
        
        -- Resetamos as waves para que a dungeon recomece do zero
        setPlayerStorageValue(cid, 2705, 0) -- Wave atual
        setPlayerStorageValue(cid, 2706, 0) -- Monstros restantes
        
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Voce caiu em combate! Volte ao Isac para organizar um novo resgate.")
    end

    return true
end