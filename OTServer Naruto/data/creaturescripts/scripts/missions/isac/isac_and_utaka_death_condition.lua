-- Função local para substituir a isSummon que está faltando no seu servidor
local function checkIsSummon(cid)
    return isCreature(cid) and getCreatureMaster(cid) ~= cid
end

function onDeath(cid, corpse, killer)
    -- [PARTE 1: SE QUEM MORREU FOI UM ALIADO (SUMMON)]
    if checkIsSummon(cid) then
        local master = getCreatureMaster(cid)
        if isPlayer(master) then
            local name = getCreatureName(cid)
            local st = getPlayerStorageValue(master, STORAGE_MISSION_ISAC)
            local wave = getPlayerStorageValue(master, STORAGE_MISSION_ISAC_WAVES)

            if name == "Isac" then
                -- [LOGICA CORRIGIDA]
                -- Se a wave for 0, ele ainda não chegou no ponto de início das hordas (morreu no caminho)
                if wave <= 0 then
                    setPlayerStorageValue(master, STORAGE_MISSION_ISAC, ISAC_STATUS_UTAKA_KIDNAPPED) 
                    setPlayerStorageValue(master, STORAGE_MISSION_ISAC_WAVES, 0) 
                    doPlayerSendTextMessage(master, MESSAGE_STATUS_WARNING, "Isac morreu no caminho! Voce falhou em protege-lo. Volte e reagrupe com ele.")
                else
                    -- Se a wave for 1 ou maior, significa que o massacre já começou na caverna.
                    -- Independente de ser wave 1 ou 10, a morte dele aqui é o sacrifício.
                    
                    -- Se Utaka já estiver morto (st 9), vai para o final 10 (Ambos mortos)
                    -- Senão, vai para o final 8 (Isac morto, Utaka vivo)
                    setPlayerStorageValue(master, STORAGE_MISSION_ISAC, (st == ISAC_STATUS_UTAKA_DEAD and ISAC_STATUS_BOTH_DEAD or ISAC_STATUS_ISAC_DEAD))
                    doPlayerSendTextMessage(master, MESSAGE_STATUS_WARNING, "Isac caiu defendendo a saida... Va, salve o garoto!")
                end

            elseif name == "Utaka" then
                -- Se Isac já estiver morto (st 8), vai para o final 10 (Ambos mortos)
                -- Senão, vai para o final 9 (Utaka morto, Isac vivo)
                setPlayerStorageValue(master, STORAGE_MISSION_ISAC, (st == ISAC_STATUS_ISAC_DEAD and ISAC_STATUS_BOTH_DEAD or ISAC_STATUS_UTAKA_DEAD))
                doPlayerSendTextMessage(master, MESSAGE_STATUS_WARNING, "Utaka foi assassinado! O garoto se foi...")
            end
        end
        return true 
    end

    -- [PARTE 2: SE QUEM MORREU FOI UM MONSTRO (INIMIGO)]
    if not isMonster(cid) then return true end
    
    local playerID = getCreatureStorage(cid, 88888)
    local player = isPlayer(playerID) and playerID or nil

    if not player then
        if isPlayer(killer) then
            player = killer
        elseif checkIsSummon(killer) then
            player = getCreatureMaster(killer)
        end
    end

    if not isPlayer(player) then return true end

    local missionSt = getPlayerStorageValue(player, STORAGE_MISSION_ISAC)

    -- Continua contando mesmo se os aliados morrerem (estados 8, 9, 10 são os estados de luto/falha parcial)
    if missionSt == ISAC_STATUS_SAVING_UTAKA or (missionSt >= ISAC_STATUS_ISAC_DEAD and missionSt <= ISAC_STATUS_BOTH_DEAD) then
        local count = getPlayerStorageValue(player, STORAGE_MISSION_ISAC_COUNT) 
        
        if count > 0 then
            local newCount = count - 1
            setPlayerStorageValue(player, STORAGE_MISSION_ISAC_COUNT, newCount)
            
            if newCount <= 0 then
                local currentWave = getPlayerStorageValue(player, STORAGE_MISSION_ISAC_WAVES) 
                local nextWave = currentWave + 1
                
                if config_isac.waves[nextWave] then
                    doPlayerSendTextMessage(player, MESSAGE_EVENT_ADVANCE, "Onda limpa! Proxima em 3 segundos.")
                    addEvent(function()
                        if isPlayer(player) then 
                            spawnWaveIsac(player, nextWave) 
                        end
                    end, 3000)
                else
                    -- Se era a última wave e Isac/Utaka estão vivos, st vira 7 (Sucesso Total)
                    -- Se alguém já morreu, o st continua sendo 8, 9 ou 10 (Sucesso Parcial/Fracasso)
                    if missionSt == ISAC_STATUS_SAVING_UTAKA then
                        setPlayerStorageValue(player, STORAGE_MISSION_ISAC, ISAC_STATUS_HERO)
                    end
                    doPlayerSendTextMessage(player, MESSAGE_EVENT_ADVANCE, "Voce sobreviveu a todas as hordas! Saia da caverna agora!")
                end
            else
                doPlayerSendTextMessage(player, MESSAGE_STATUS_CONSOLE_BLUE, "[Missao] Monstros restantes: " .. newCount)
            end
        end
    end

    return true
end