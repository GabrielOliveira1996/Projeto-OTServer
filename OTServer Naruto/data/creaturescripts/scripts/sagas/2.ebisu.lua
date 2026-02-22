function onDeath(cid, corpse, deathList)
    local storage = 11118
    local monstName = "Ebisu"
    local players = {}
    local experience = 30000
    local konohamaruShirt = 2655
    local tunicaChance = 1 -- 1% de chance de dropar

    -- Verifica se quem morreu foi o Ebisu
    if isMonster(cid) and string.lower(getCreatureName(cid)) == string.lower(monstName) then
        
        -- Filtra a deathList para encontrar jogadores ou donos de summons
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
                doPlayerSendTextMessage(var, 22, "You have bested Ebisu! Make your way to the forest and find your Jounin.")
                doSendMagicEffect(getThingPos(var), 12) 
                -- chance de dropar 
                if math.random(1, 100) <= tunicaChance then
                    doPlayerAddItem(var, konohamaruShirt, 1)
                    doPlayerSendTextMessage(var, MESSAGE_EVENT_ORANGE, "You found Konohamaru's shirt.")
                end
            end
        end
    end 
    return true
end