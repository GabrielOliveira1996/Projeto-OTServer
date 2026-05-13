function onDeath(cid, corpse, deathList)
    --local storage = 11121
    local storage = 11122
    local monstName = "Second Zabuza"
    local players = {}
    local experience = 100000
    local swordId = 2407
    local swordChance = 2 -- 2% de chance de dropar

    -- verifica se quem morreu foi o zabuza
    if isMonster(cid) and string.lower(getCreatureName(cid)) == string.lower(monstName) then
        
        -- filtra a deathList para encontrar jogadores ou donos de summons
        for _, check in ipairs(deathList) do
            if isPlayer(check) then
                table.insert(players, check)
            elseif isSummon(check) then
                local master = getCreatureMaster(check)
                if isPlayer(master) then
                    table.insert(players, master)
                end
            end
        end

        -- aplica a recompensa para cada jogador que participou da luta
        for _, var in ipairs(players) do
            if isPlayer(var) then
                setPlayerStorageValue(var, storage, 1)
                doPlayerAddExp(var, experience)
                doPlayerSendTextMessage(var, 22, "Zabuza foi derrotado! Prepare-se: Haku esta atacando. Nao baixe a guarda!")
                doSendMagicEffect(getThingPos(var), 12) 

                -- chance de dropar a zabuza sword = id 2407
                if math.random(1, 100) <= swordChance then
                    doPlayerAddItem(var, swordId, 1)
                    doPlayerSendTextMessage(var, MESSAGE_EVENT_ORANGE, "Voce encontrou a poderosa Zabuza Sword!")
                end
            end
        end
    end 
    return true
end