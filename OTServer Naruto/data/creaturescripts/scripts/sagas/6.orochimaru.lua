function onDeath(cid, corpse, deathList)
    local storage = 11126 -- storage da saga11126
    local monstName = "Orochimaru"
    local players = {}
    local experience = 150000
    local itemID = 2656 -- item que e possivel ganhar
    local itemChance = 5 -- 5% de chance de drop direto

    -- verifica se a criatura que morreu é o orochimaru
    if isMonster(cid) and string.lower(getCreatureName(cid)) == string.lower(monstName) then
        doCreatureSay(cid, "Isso ainda não acabou...", TALKTYPE_ORANGE_1)

        -- filtra a deathList para encontrar jogadores ou donos de summons
        for _, check in ipairs(deathList) do
            local targetPlayer = nil
            
            if isPlayer(check) then
                targetPlayer = check
            elseif isSummon(check) then
                local master = getCreatureMaster(check)
                if isPlayer(master) then
                    targetPlayer = master
                end
            end

            -- insere na lista se for um jogador valido e ainda nao estiver na tabela
            if targetPlayer and not isInArray(players, targetPlayer) then
                table.insert(players, targetPlayer)
            end
        end

        -- aplica a recompensa para cada jogador que participou da luta
        for _, var in ipairs(players) do
            if isPlayer(var) then
                setPlayerStorageValue(var, storage, 1)
                doPlayerAddExp(var, experience)
                doPlayerSendTextMessage(var, 22, "Você sobreviveu ao ataque de Orochimaru!")
                doSendMagicEffect(getThingPos(var), 14) -- efeito de sucesso

                -- drop direto no inventario
                if math.random(1, 100) <= itemChance then
                    doPlayerAddItem(var, itemID, 1)
                    doPlayerSendTextMessage(var, MESSAGE_EVENT_ORANGE, "Você conseguiu encontrar um item que o Orochimaru deixou para trás.")
                end
            end
        end
    end 
    return true
end