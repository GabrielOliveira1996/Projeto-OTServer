-- Função local para substituir a isSummon que está faltando no seu servidor
local function checkIsSummon(cid)
    return isCreature(cid) and getCreatureMaster(cid) ~= cid
end

function onDeath(cid, corpse, killer)
    if not isMonster(cid) then return true end
    
    -- 1. Tenta pegar o dono pela storage que setamos no spawn
    local playerID = getCreatureStorage(cid, 88888)
    local player = isPlayer(playerID) and playerID or nil

    -- 2. Se não achou (storage falhou), tenta pelo killer direto ou master do summon
    if not player then
        if isPlayer(killer) then
            player = killer
        elseif checkIsSummon(killer) then 
            player = getCreatureMaster(killer)
        end
    end

    -- 3. Se ainda assim não achou, o script para aqui (não era monstro da quest)
    if not isPlayer(player) then return true end

    -- [LOGICA DE CONTAGEM]
    local missionSt = getPlayerStorageValue(player, STORAGE_MISSION_ISAC)

    -- Verifica se o player está na missão ativa (4) ou em estado de baixas (8, 9, 10)
    if missionSt == ISAC_STATUS_SAVING_UTAKA or (missionSt >= ISAC_STATUS_ISAC_DEAD and missionSt <= ISAC_STATUS_BOTH_DEAD) then
        -- Usando a constante para a contagem de monstros (STORAGE_MISSION_ISAC_COUNT)
        local count = getPlayerStorageValue(player, STORAGE_MISSION_ISAC_COUNT)
        
        if count > 0 then
            local newCount = count - 1
            setPlayerStorageValue(player, STORAGE_MISSION_ISAC_COUNT, newCount)
            
            if newCount <= 0 then
                -- Usando a constante para a Wave atual (STORAGE_MISSION_ISAC_WAVES)
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
                    -- Se for a última wave e ninguém morreu, vira Herói
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