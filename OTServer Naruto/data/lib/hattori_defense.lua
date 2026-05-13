-- Tabela de Configuração (Global para ser lida em qualquer lugar)
config_kuroi = {
    storage = 34095,
    storage_contagem = 34096,
    storage_onda_atual = 34097,
    rewardItem = 2400,
    centerPos = {x = 3036, y = 3314, z = 7},
    waves = {
        [1] = {name = "Horda 1", mobs = {
            "Kuroi Scout",
            "Kuroi Scout",
            "Kuroi Scout",
            "Kuroi Infiltrator", 
            "Kuroi Infiltrator",
            "Kuroi Infiltrator",
            "Kuroi Warfan",
        }, delay = 2000},
        [2] = {name = "Horda 2", mobs = {
            "Kuroi Scout",
            "Kuroi Scout",
            "Kuroi Scout",
            "Kuroi Scout",
            "Kuroi Infiltrator",
            "Kuroi Infiltrator",
            "Kuroi Infiltrator",
            "Kuroi Infiltrator",
            "Kuroi Warfan",
            "Kuroi Warfan",
        }, delay = 2000},
        [3] = {name = "Horda 3", mobs = {
            "Kuroi Scout",
            "Kuroi Scout",
            "Kuroi Scout",
            "Kuroi Scout",
            "Kuroi Scout",
            "Kuroi Infiltrator",
            "Kuroi Infiltrator",
            "Kuroi Infiltrator",
            "Kuroi Infiltrator",
            "Kuroi Infiltrator",
            "Kuroi Warfan",
            "Kuroi Warfan",
            "Kuroi Warfan",
        }, delay = 2000},
        [4] = {name = "Horda 4", mobs = {
            "Kuroi Scout",
            "Kuroi Scout",
            "Kuroi Scout",
            "Kuroi Scout",
            "Kuroi Scout",
            "Kuroi Infiltrator",
            "Kuroi Infiltrator",
            "Kuroi Infiltrator",
            "Kuroi Infiltrator",
            "Kuroi Infiltrator",
            "Kuroi Warfan",
            "Kuroi Warfan",
            "Kuroi Warfan",
        }, delay = 2000}
    }
}

-- Função de Spawn (Sem o _G, pois na Lib ela já se torna global automaticamente)
function spawnWaveKuroi(cid, waveIndex)
    if not isPlayer(cid) then return end
    
    local wave = config_kuroi.waves[waveIndex]
    if not wave then 
        setPlayerStorageValue(cid, config_kuroi.storage, 2)
        doPlayerAddItem(cid, config_kuroi.rewardItem, 1)
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Jhon Lee: Gracas a voce eles recuaram!")
        return 
    end

    setPlayerStorageValue(cid, config_kuroi.storage_onda_atual, waveIndex)
    setPlayerStorageValue(cid, config_kuroi.storage_contagem, #wave.mobs)
    doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "[Kuroi Hasu] Onda: " .. wave.name .. " (" .. waveIndex .. "/10)")
    
    local playerName = getCreatureName(cid) -- Pega o nome do dono

    for _, mobName in ipairs(wave.mobs) do
        local spawnPos = {x = config_kuroi.centerPos.x + math.random(-5, 5), y = config_kuroi.centerPos.y + math.random(-5, 5), z = config_kuroi.centerPos.z}
        local m = doCreateMonster(mobName, spawnPos)
        if m then
            doSendMagicEffect(spawnPos, 10)
            registerCreatureEvent(m, "KuroiHordaDeath")
            doCreatureSetStorage(m, 88888, cid) 
        end
    end
end