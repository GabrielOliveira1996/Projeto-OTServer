function onDeath(cid, corpse, deathList)
    local storage = 11118
    local monstName = "Ebisu"
    local players = {}
    local experience = 25000

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

        -- Aplica a recompensa para cada jogador que participou da luta
        for _, var in ipairs(players) do
            if isPlayer(var) then
                setPlayerStorageValue(var, storage, 1)
                doPlayerAddExp(var, experience)
                doPlayerSendTextMessage(var, 22, "Voce venceu o Ebisu! Va ate a floresta e encontre seu Jounin.")
                doSendMagicEffect(getThingPos(var), 12) -- Efeito de sucesso no player
            end
        end
    end 
    return true
end