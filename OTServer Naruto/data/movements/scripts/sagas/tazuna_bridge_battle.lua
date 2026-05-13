local cfg = {
    clone_name = "Haku Glass", 
    raio_quadrado = 4, 
    time_to_survive = 30, -- Tempo para Zabuza aparecer
    timeout_event = 60, -- Tempo total para falha (reset da ponte)
}

-- TABELA RESTAURADA (O erro era a falta desta parte no escopo global)
local frases = {
    "O que esta acontecendo? A visibilidade esta sumindo...",
    "Essa nevoa... e muito densa. Isso e estranho.",
    "Nao consigo enxergar o Tazuna! Onde ele esta?",
    "Sinto um chakra frio vindo de todos os lados...",
    "Zabuza? Nao... ele deveria estar morto!"
}

if not BridgeMonsters then BridgeMonsters = {} end

-- Função para limpar a arena (Haku Real e os Haku Glass)
local function clearHakuStage()
    for _, mid in ipairs(BridgeMonsters) do
        if isCreature(mid) then 
            local name = getCreatureName(mid):lower()
            -- Corrigido para incluir 'haku glass' na limpeza
            if name == "haku" or name == "haku bunshin" or name == "haku glass" then
                doRemoveCreature(mid) 
            end
        end
    end
    BridgeMonsters = {}
end

-- Função para spawnar o Zabuza
local function spawnZabuza(cid)
    if not isPlayer(cid) then return end
    
    clearHakuStage()
    
    doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Haku recua... A nevoa se dissipa por um momento e Zabuza aparece!")
    
    local pPos = getThingPos(cid)
    local zabuzaPos = {x = pPos.x + 2, y = pPos.y, z = pPos.z}
    
    local zabuza = doCreateMonster("Zabuza Momochi [The Final Mist]", zabuzaPos)
    if zabuza then
        table.insert(BridgeMonsters, zabuza)
        doSendMagicEffect(zabuzaPos, 2)
        doCreatureSay(zabuza, "Parece que voce se divertiu com meu subordinado. Agora o assunto e comigo!", TALKTYPE_MONSTER_SAY)
    end
end

local function resetBridge()
    for _, mid in ipairs(BridgeMonsters) do
        if isCreature(mid) then doRemoveCreature(mid) end
    end
    BridgeMonsters = {}
    setGlobalStorageValue(SAGA_AUX_BRIDGE_LOCK_STORAGE, 0)
end

local function startBattle(cid)
    if not isPlayer(cid) then 
        resetBridge()
        return 
    end
    
    local pPos = getThingPos(cid)
    doCreatureSay(cid, "E aquele ninja assassino! Entao o Zabuza realmente esta vivo!", TALKTYPE_SAY)
    
    -- 1. Spawn Haku Real
    local haku = doCreateMonster("Haku", {x = pPos.x + 1, y = pPos.y, z = pPos.z})
    if haku then
        table.insert(BridgeMonsters, haku)
        doSendMagicEffect(getThingPos(haku), 2)
        registerCreatureEvent(haku, "HakuDeath") 
    end

    -- 2. Spawn do Quadrado de Clones (Haku Glass)
    for dx = -cfg.raio_quadrado, cfg.raio_quadrado do
        for dy = -cfg.raio_quadrado, cfg.raio_quadrado do
            if math.abs(dx) == cfg.raio_quadrado or math.abs(dy) == cfg.raio_quadrado then
                local clonePos = {x = pPos.x + dx, y = pPos.y + dy, z = pPos.z}
                local clone = doCreateMonster(cfg.clone_name, clonePos)
                if clone then
                    table.insert(BridgeMonsters, clone)
                    doSendMagicEffect(clonePos, 14)
                    doCreatureSetNoMove(clone, true)
                end
            end
        end
    end

    -- [VITÓRIA POR SOBREVIVÊNCIA]
    addEvent(function()
        if getGlobalStorageValue(SAGA_AUX_BRIDGE_LOCK_STORAGE) > 0 then
            local hakuVivo = false
            for _, mid in ipairs(BridgeMonsters) do
                if isCreature(mid) and getCreatureName(mid):lower() == "haku" then
                    hakuVivo = true
                    break
                end
            end
            if hakuVivo then
                spawnZabuza(cid)
            end
        end
    end, cfg.time_to_survive * 1000)

    -- Timeout Geral
    addEvent(function()
        if getGlobalStorageValue(SAGA_AUX_BRIDGE_LOCK_STORAGE) > 0 then
            resetBridge()
        end
    end, cfg.timeout_event * 1000)
end

function onStepIn(cid, item, position, fromPosition)
    if not isPlayer(cid) then return true end

    local lockValue = getGlobalStorageValue(SAGA_AUX_BRIDGE_LOCK_STORAGE)

    -- Trava de saída
    if lockValue > 0 then
        if fromPosition.x > position.x then 
            doTeleportThing(cid, fromPosition) 
            doPlayerSendCancel(cid, "Uma barreira de chakra impede sua fuga!")
            return true
        end
    end

    -- Início do evento
    if getPlayerStorageValue(cid, SAGA_STORAGE) == SAGA_STAGE_PROTECT_THE_TAZUNA_ON_THE_BRIDGE then
        if lockValue > 0 and lockValue > os.time() then
            doPlayerSendCancel(cid, "O confronto ja esta acontecendo.")
            doTeleportThing(cid, fromPosition)
            return true
        end

        setGlobalStorageValue(SAGA_AUX_BRIDGE_LOCK_STORAGE, os.time() + cfg.timeout_event)
        
        -- Loop de frases
        for i = 1, #frases do
            addEvent(function()
                if isPlayer(cid) then
                    doCreatureSay(cid, frases[i], TALKTYPE_SAY)
                    doSendMagicEffect(getThingPos(cid), 21)
                end
            end, i * 2500)
        end

        -- Inicia batalha após as frases
        addEvent(startBattle, (#frases * 2500) + 1000, cid)
    end
    return true
end