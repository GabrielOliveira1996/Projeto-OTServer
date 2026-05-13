function onDeath(cid, corpse, killer)
    if not isMonster(cid) then return true end
    
    local player = isPlayer(killer) and killer or getThingFromPos(config_kuroi.centerPos).uid
    
    if not isPlayer(player) then
        local spectators = getSpectators(config_kuroi.centerPos, 15, 15, false)
        if spectators then
            for _, spec in ipairs(spectators) do
                if isPlayer(spec) and getPlayerStorageValue(spec, config_kuroi.storage) == 1 then
                    player = spec
                    break
                end
            end
        end
    end

    if isPlayer(player) and getPlayerStorageValue(player, config_kuroi.storage) == 1 then
        local remaining = getPlayerStorageValue(player, config_kuroi.storage_contagem)
        
        if remaining > 0 then
            local new_count = remaining - 1
            setPlayerStorageValue(player, config_kuroi.storage_contagem, new_count)
            
            if new_count <= 0 then
                local currentWave = getPlayerStorageValue(player, config_kuroi.storage_onda_atual)
                local nextWave = currentWave + 1
                local waveData = config_kuroi.waves[currentWave]
                local delay = waveData and waveData.delay or 5000
                
                doPlayerSendTextMessage(player, MESSAGE_EVENT_ADVANCE, "Onda limpa! Próxima em " .. (delay/1000) .. "s.")
                
                addEvent(function()
                    if isPlayer(player) then
                        spawnWaveKuroi(player, nextWave) 
                    end
                end, delay)
            else
                doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_BLUE, "[Kuroi Hasu] Faltam " .. new_count .. " membros.")
            end
        end
    end
    return true
end