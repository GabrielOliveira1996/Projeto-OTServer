config_isac = {
    storage = 2701,
    storage_wave = 2705,
    storage_contagem = 2706,
    centerPos = {x = 3001, y = 2732, z = 9},
    waves = {
        [1] = {mobs = {"Oto-Nin Mutant"}, msg = "Isac: They're coming! Protect the boy at all costs!"},
        [2] = {mobs = {"Oto-Nin Specialist"}, msg = "Isac: They don't stop appearing! Keep fighting!"},
        [3] = {mobs = {"Oto-Nin Specialist"}, msg = "Isac: The path is clear! Run to the exit with Utaka, I'll hold them off!"},
        [4] = {mobs = {"Oto-Nin Specialist"}, msg = "Isac: Go now! I can't hold them forever!"},
        [5] = {mobs = {"Oto-Nin Specialist"}, msg = "Isac: LEAVE THIS PLACE NOW!"},
        [6] = {mobs = {"Oto-Nin Specialist"}, msg = "Isac: Curse... there are too many of them!"},
        [7] = {mobs = {"Oto-Nin Specialist"}, msg = "Isac: Argh... stay strong, Utaka!"},
        [8] = {mobs = {"Oto-Nin Specialist"}, msg = "Isac: Run! Don't look back!"},
        [9] = {mobs = {"Oto-Nin Specialist"}, msg = "Isac: THAT'S ENOUGH! I'll end this!"},
        [10] = {mobs = {"Oto-Nin Specialist"}, msg = "Isac: We did it! We survived the massacre!", final = true}
    }
}

function spawnWaveIsac(cid, waveIndex)
    if not isPlayer(cid) then return end
    
    local wave = config_isac.waves[waveIndex]
    if not wave then return end

    setPlayerStorageValue(cid, config_isac.storage_wave, waveIndex)
    setPlayerStorageValue(cid, config_isac.storage_contagem, #wave.mobs)
    
    for _, mobName in ipairs(wave.mobs) do
        -- Lógica de dispersão (Igual ao script do Lee)
        local spawnPos = {
            x = config_isac.centerPos.x + math.random(-5, 5), 
            y = config_isac.centerPos.y + math.random(-5, 5), 
            z = config_isac.centerPos.z
        }
        
        local m = doCreateMonster(mobName, spawnPos)
        
        -- Se falhar na dispersão (parede), força no centro exato que você corrigiu
        if not m then
            m = doCreateMonster(mobName, config_isac.centerPos)
        end

        if type(m) == "number" and m > 0 then
            doSendMagicEffect(getThingPos(m), 10)
            registerCreatureEvent(m, "IsacDungeonMonsterDeathCount")
            doCreatureSetStorage(m, 88888, cid) 
            
            -- Faz o monstro focar no jogador imediatamente
            addEvent(function()
                if isCreature(m) and isPlayer(cid) then
                    doMonsterSetTarget(m, cid)
                end
            end, 100)
        else
            print(">> [AVISO] Falha ao criar monstro: " .. mobName .. ". Verifique o nome no XML.")
        end
    end

    if wave.msg then
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, wave.msg)
    end
end