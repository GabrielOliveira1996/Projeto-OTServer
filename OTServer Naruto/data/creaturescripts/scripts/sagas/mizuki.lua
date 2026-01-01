function onDeath(cid, corpse, deathList)
    local storage = 11113
    local monstName = "Mizuki"
    local players = {}
    local experience = 10000

    -- verifica se quem morreu foi o Mizuki
    if isMonster(cid) and string.lower(getCreatureName(cid)) == string.lower(monstName) then
        
        -- filtra a deathList para encontrar apenas jogadores reais
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

        -- aplica a recompensa e a mensagem para cada jogador que participou
        for _, var in ipairs(players) do
            if isPlayer(var) then
                setPlayerStorageValue(var, storage, 1)
                doPlayerAddExp(var, experience)
                doPlayerSendTextMessage(var, 22, "Voce venceu o Mizuki. Fale com o Iruka.")
            end
        end
    end 
    return true
end