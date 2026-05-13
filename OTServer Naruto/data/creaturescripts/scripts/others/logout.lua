function onLogout(cid)
    -- reset chakra no mesu da sakura
    if getPlayerStorageValue(cid, 99126) == 1 then
        setPlayerStorageValue(cid, 99126, -1)
        
        local playerLevel = getPlayerLevel(cid)
        local backVoc = 25 -- ID Padrão (Sakura Classic)
        local backLook = 387 -- LookType Padrão
        
        -- Define para qual vocação ela deve voltar baseado no level
        if playerLevel >= 250 then
            backVoc, backLook = 28, 343 -- Sakura shinsu
        elseif playerLevel >= 180 then
            backVoc, backLook = 27, 346 -- Sakura War
        elseif playerLevel >= 100 then
            backVoc, backLook = 26, 69  -- Sakura Shippuden
        end
        
        doPlayerSetVocation(cid, backVoc)
        doSetCreatureOutfit(cid, {lookType = backLook}, -1)
    end

    local summons = getCreatureSummons(cid)
    for _, bunshin in ipairs(summons) do
        -- Verifica se o criador (master) do monstro é o jogador que está deslogando
        if getCreatureMaster(bunshin) == cid then
            doRemoveCreature(bunshin)
        end
    end

    --- MISSÃO DE JHON LEE (ADAPTADO COM LIMPEZA) ---
    if getPlayerStorageValue(cid, 34095) == 1 then
        -- 1. Reseta as storages no banco de dados
        setPlayerStorageValue(cid, 34095, -1) -- Missão inativa
        setPlayerStorageValue(cid, 34096, 0)  -- Zera contagem
        setPlayerStorageValue(cid, 34097, 0)  -- Zera onda atual
        
        -- 2. Limpa os monstros da área que pertenciam a este player
        local center = {x = 3043, y = 3314, z = 7} -- Posição central da missão
        local spectators = getSpectators(center, 15, 15, false)
        if spectators then
            for _, spec in ipairs(spectators) do
                -- Se for monstro e a storage de dono (88888) for igual ao CID do player
                if isMonster(spec) and getCreatureStorage(spec, 88888) == cid then
                    doRemoveCreature(spec)
                end
            end
        end
    end
    -------------------------------------------------

    setPlayerStorageValue(cid, 45007, 0) -- Reseta Status Meditando
    setPlayerStorageValue(cid, 45008, 0) -- Reseta Energia
    setPlayerStorageValue(cid, 45009, 0) -- Reseta Energia
    
    local currentSoul = getPlayerSoul(cid)
    if currentSoul > 0 then
        doPlayerAddSoul(cid, -currentSoul)
    end

    -- Remove estados de ghost e movimentação travada
    doCreatureSetNoMove(cid, false)
    if doSetCreatureGhostMode then 
        doSetCreatureGhostMode(cid, false) 
    end
    
    -- Volta para a vocação base caso seja Sennin
    if getPlayerVocation(cid) == 11 then
        doPlayerSetVocation(cid, 2)
    end

    return true
end