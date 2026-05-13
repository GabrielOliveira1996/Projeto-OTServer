function onThink(interval)
    for _, cid in ipairs(getPlayersOnline()) do
        -- 1. Definição das Storages
        local storage_player_med = 45007
        local storage_clone_med = 45010
        local storage_sennin = 45008
        local storage_energy = 45009
        
        -- 2. Verificação de Vocação (Apenas 3, 4, 12 ou 13 podem ganhar)
        local voc = getPlayerVocation(cid)
        local canGainSoul = (voc == 3 or voc == 4 or voc == 12 or voc == 13)

        -- Se não for uma das vocações permitidas, pula pro próximo player
        if canGainSoul then
            local current_energy = tonumber(getPlayerStorageValue(cid, storage_energy)) or 0
            local is_sennin = (getPlayerStorageValue(cid, storage_sennin) == 1)
            local is_meditating = (getPlayerStorageValue(cid, storage_player_med) == 1)

            -- Cálculo de Bônus de Meditação
            local bonus = 0
            if is_meditating then bonus = bonus + 1 end
            
            -- Bônus de Clones meditando
            local summons = getCreatureSummons(cid)
            if getPlayerStorageValue(cid, storage_clone_med) == 1 then
                for _, bunshin in ipairs(summons) do
                    if getCreatureNoMove(bunshin) then
                        bonus = bonus + 1
                    end
                end
            end

            -- Ganho Automático (Sennin Mode)
            local ganho_automatico_soul = 0
            if is_sennin then
                ganho_automatico_soul = 4
            end

            -- APLICAÇÃO DOS VALORES
            if (bonus > 0 or ganho_automatico_soul > 0) then
                -- Energia (Storage)
                local nova_energia = math.min(100, current_energy + bonus + (ganho_automatico_soul * 2))
                setPlayerStorageValue(cid, storage_energy, nova_energia)
                
                -- Soul Points (O que você queria travar)
                local total_soul_gain = (is_meditating and bonus or 0) + ganho_automatico_soul
                
                if total_soul_gain > 0 and getPlayerSoul(cid) < 100 then 
                    doPlayerAddSoul(cid, total_soul_gain) 
                    doSendMagicEffect(getCreaturePosition(cid), 13)
                    doSendAnimatedText(getCreaturePosition(cid), "+" .. total_soul_gain, TEXTCOLOR_ORANGE)
                end
            end
        end -- Fim do if canGainSoul
    end
    return true
end