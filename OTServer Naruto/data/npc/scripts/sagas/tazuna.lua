local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

npcHandler.topic = {} 

-- [CONFIGURAÇÃO DA BATALHA]
local cfg = {
    clone_name = "Haku Glass", 
    raio_quadrado = 4, 
    time_to_survive = 300, 
    zabuza_fight_time = 300, 
    timeout_event = 740, 
}

local frases = {
    "O que esta acontecendo? A nevoa esta aumentando...",
    "Zabuza e aquele ninja assassino? Nao... ele deveria estar morto!"
}

if not BridgeMonsters then BridgeMonsters = {} end

-- [FUNÇÕES DE APOIO]
local function clearHakuStage()
    -- Limpa Monstros (Summonados pela função do script)
    for _, mid in ipairs(BridgeMonsters) do
        if isCreature(mid) then doRemoveCreature(mid) end
    end
    BridgeMonsters = {}

    -- Limpa NPCs da cena (Zabuza, Haku, Gato, Bandidos que ficaram de sobras)
    local names = {"zabuza", "haku", "gato", "bandit"}
    -- Certifique-se de que a posição abaixo corresponde ao centro da sua ponte
    local spectators = getSpectators({x = 1000, y = 1000, z = 7}, 20, 20, false) 
    if spectators then
        for _, spec in ipairs(spectators) do
            if isNpc(spec) then
                local npcName = getCreatureName(spec):lower()
                for _, name in ipairs(names) do
                    if npcName == name then
                        doRemoveCreature(spec)
                    end
                end
            end
        end
    end
end

local function resetBridge(cid, success)
    clearHakuStage()
    if not success then
        setGlobalStorageValue(SAGA_AUX_BRIDGE_LOCK_STORAGE, 0)
        if isPlayer(cid) then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "O evento foi encerrado. Voce falhou em proteger Tazuna!")
        end
    end
end

local function spawnZabuza(cid)
    if not isPlayer(cid) then return end
    clearHakuStage() -- Limpa clones e Haku antes de nascer Zabuza
    
    doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Haku recua... A nevoa se dissipa e Zabuza aparece!")
    
    local pPos = getThingPos(cid)
    local zabuzaPos = {x = pPos.x + 2, y = pPos.y, z = pPos.z}
    local zabuza = doCreateMonster("Zabuza Momochi [The Final Mist]", zabuzaPos)
    
    if zabuza then
        table.insert(BridgeMonsters, zabuza)
        doSendMagicEffect(zabuzaPos, 2)
        doCreatureSay(zabuza, "Parece que voce se divertiu com meu subordinado. Agora o assunto e comigo!", TALKTYPE_MONSTER_SAY)
        registerCreatureEvent(zabuza, "ZabuzaDeath")
        
        addEvent(function()
            if isCreature(zabuza) then resetBridge(cid, false) end
        end, cfg.zabuza_fight_time * 1000)
    end
end

local function startBattle(cid)
    if not isPlayer(cid) then resetBridge() return end
    local pPos = getThingPos(cid)
    doCreatureSay(cid, "E aquele ninja assassino! Zabuza esta vivo!", TALKTYPE_SAY)
    
    local haku = doCreateMonster("Haku", {x = pPos.x + 1, y = pPos.y, z = pPos.z})
    if haku then table.insert(BridgeMonsters, haku) end

    for dx = -cfg.raio_quadrado, cfg.raio_quadrado do
        for dy = -cfg.raio_quadrado, cfg.raio_quadrado do
            if math.abs(dx) == cfg.raio_quadrado or math.abs(dy) == cfg.raio_quadrado then
                local clone = doCreateMonster(cfg.clone_name, {x = pPos.x + dx, y = pPos.y + dy, z = pPos.z})
                if clone then
                    table.insert(BridgeMonsters, clone)
                    doCreatureSetNoMove(clone, true)
                end
            end
        end
    end

    addEvent(function()
        local hakuVivo = false
        for _, mid in ipairs(BridgeMonsters) do
            if isCreature(mid) and getCreatureName(mid):lower() == "haku" then hakuVivo = true break end
        end
        if hakuVivo then spawnZabuza(cid) end
    end, cfg.time_to_survive * 1000)
end

local function inariDiscurso(cid)
    local inari = getCreatureByName("Inari")
    if isCreature(inari) then
        addEvent(doCreatureSay, 1500, inari, "POR QUE VOCES AINDA TENTAM?!", TALKTYPE_SAY)
        addEvent(doCreatureSay, 6000, inari, "Herois nao existem! Gato vai destruir todos voces!", TALKTYPE_SAY)
        addEvent(doCreatureSay, 11000, inari, "A esperanca e apenas uma mentira...", TALKTYPE_SAY)
        addEvent(doCreatureSay, 16000, inari, "Vao embora daqui antes que todos morram!", TALKTYPE_SAY)
        
        addEvent(function()
            if isPlayer(cid) and getPlayerStorageValue(cid, SAGA_STORAGE) == SAGA_STAGE_FINALLY_A_BREAK then
                setPlayerStorageValue(cid, SAGA_STORAGE, SAGA_STAGE_CHAKRA_CONTROL_TRAINING)
                doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Saga Atualizada: Procure Kakashi na floresta ao sul!")
            end
        end, 16500)
    end
end

-- [SISTEMA NPC]
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

local function greetCallback(cid)
    -- [TRAVA DE SEGURANÇA ABSOLUTA]
    local lock = getGlobalStorageValue(SAGA_AUX_BRIDGE_LOCK_STORAGE)
    if lock > os.time() then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "Aguarde, ja existe um conflito ou cena importante em andamento na ponte!")
        return false 
    end

    local pStorage = tonumber(getPlayerStorageValue(cid, SAGA_STORAGE)) or -1

    -- [CORREÇÃO DA LÓGICA DE DIÁLOGO]
    if pStorage >= SAGA_STAGE_FIRST_REAL_MISSION_COMPLETED then
        return false
    elseif pStorage == SAGA_STAGE_PROTECT_THE_TAZUNA_ON_THE_BRIDGE then
        npcHandler:setMessage(MESSAGE_GREET, "Ola! Voce esta pronto para me acompanhar na {ponte}?")
    elseif pStorage == SAGA_STAGE_FINALLY_A_BREAK then
        npcHandler:setMessage(MESSAGE_GREET, "Finalmente chegamos em casa...")
    elseif pStorage >= SAGA_STAGE_CHAKRA_CONTROL_TRAINING then
        npcHandler:setMessage(MESSAGE_GREET, "Sinto muito pelo comportamento do Inari...")
    else
        npcHandler:setMessage(MESSAGE_GREET, "Finalmente chegamos em casa...")
    end
    
    npcHandler:addFocus(cid)
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end
    local pStorage = tonumber(getPlayerStorageValue(cid, SAGA_STORAGE)) or -1

    if msgcontains(msg, 'ponte') or msgcontains(msg, 'sim') then
        -- Saga da Batalha
        if pStorage == SAGA_STAGE_PROTECT_THE_TAZUNA_ON_THE_BRIDGE then
            -- Verifica se não há lock antes de prosseguir
            if getGlobalStorageValue(SAGA_AUX_BRIDGE_LOCK_STORAGE) > os.time() then
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "Aguarde, ja existe um conflito em andamento!")
                return false
            end

            npcHandler:say("Vamos começar os trabalhos...", cid)
            
            -- [LIMPEZA DE PALCO] Remove monstros ou NPCs de cenas que travaram ou sobraram
            clearHakuStage() 
            
            setGlobalStorageValue(SAGA_AUX_BRIDGE_LOCK_STORAGE, os.time() + cfg.timeout_event)
            
            for i = 1, #frases do
                addEvent(function() 
                    if isPlayer(cid) and getGlobalStorageValue(SAGA_AUX_BRIDGE_LOCK_STORAGE) > 0 then 
                        doCreatureSay(cid, frases[i], TALKTYPE_SAY) 
                    end 
                end, i * 2500)
            end
            
            addEvent(startBattle, (#frases * 2500) + 1000, cid)
            npcHandler:releaseFocus(cid) 
        
        -- Saga do Discurso do Inari
        elseif pStorage == SAGA_STAGE_FINALLY_A_BREAK then
            inariDiscurso(cid)
            npcHandler:releaseFocus(cid)
        end
    end
    return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())