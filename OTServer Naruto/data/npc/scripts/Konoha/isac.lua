local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

npcHandler.topic = {} 

-- SILENCE DEFAULT MESSAGES
npcHandler.messages[MESSAGE_WALKAWAY] = nil
npcHandler.messages[MESSAGE_FAREWELL] = nil

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

-- [CALLBACK] DYNAMIC GREET
local function greetCallback(cid)
    local st = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)
    local read = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC_READ)

    -- [SECURITY LOCK: MISSION FINISHED OR FINAL DIALOGUE READ]
    if st == ISAC_STATUS_COMPLETE or read >= 1 then
        if st == ISAC_STATUS_HERO or (st == ISAC_STATUS_COMPLETE and read >= 1) then 
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Isac parece focado na reconstrucao de sua vida, e demonstra ter uma eterna gratidao por voce.")
        elseif st == ISAC_STATUS_UTAKA_DEAD then 
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Isac parece mergulhado em um profundo luto e nao quer conversar.")
        elseif st == ISAC_STATUS_BOTH_DEAD or st == ISAC_STATUS_ISAC_DEAD then 
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "O lugar parece estranhamente silencioso...")
        else
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Isac sorri para voce e acena, focado em seus deveres na vila.")
        end
        return false 
    end

    -- [FINAL REACTIONS - FIRST TIME]

    if st == ISAC_STATUS_HERO then
        npcHandler:setMessage(MESSAGE_GREET, "Voce foi um verdadeiro heroi. Utaka esta seguro agora, sou eternamente grato. Diga ao Shikaku que eu estou bem, e que continuarei aqui para proteger a vila e o Utaka.")
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC_READ, 1)
        
    elseif st == ISAC_STATUS_UTAKA_DEAD then
        -- Cleanup if still summoned
        local summons = getCreatureSummons(cid)
        for _, s in ipairs(summons or {}) do
            if getCreatureName(s) == "Isac" then
                doSendMagicEffect(getThingPos(s), 2)
                doRemoveCreature(s)
            end
        end

        npcHandler:setMessage(MESSAGE_GREET, "Eu agradeço a sua ajuda. Reporte a situação para o Shikaku, e diga que em breve voltarei para Konoha. Agora, me deixe sozinho. Preciso de um tempo para processar o que aconteceu com o Utaka...")
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC_READ, 1)

    elseif st == ISAC_STATUS_ISAC_DEAD or st == ISAC_STATUS_BOTH_DEAD then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "O lugar onde Isac deveria estar agora parece frio e vazio...")
        return false

    -- [ACTIVE MISSION STAGES]

    elseif st == ISAC_STATUS_SAVING_UTAKA then
        npcHandler:setMessage(MESSAGE_GREET, "Nao temos tempo para conversar! O Utaka ainda corre perigo la dentro, vamos logo!")

    elseif st == ISAC_STATUS_UTAKA_KIDNAPPED then
        npcHandler:setMessage(MESSAGE_GREET, "Ninjas do pais do som levaram ele? Preciso da sua ajuda para resgata-lo, voce pode me {ajudar} a salva-lo?")

    elseif st == ISAC_STATUS_FIND_UTAKA then
        npcHandler:setMessage(MESSAGE_GREET, "Ainda nao encontrou ele? Utaka esta ao norte colhendo cogumelos. Va busca-lo, por favor.")

    elseif st == ISAC_STATUS_START then
        npcHandler:setMessage(MESSAGE_GREET, "Ola. Este lugar e calmo, mas as vezes sinto que o perigo espreita... O que o traz aqui? E sobre a {konoha}?")
    
    else
        npcHandler:setMessage(MESSAGE_GREET, "Ola, viajante. E um dia calmo hoje, nao acha?")
    end
    
    npcHandler:addFocus(cid)
    return true
end

-- [CALLBACK] DIALOGUES
function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end
    local st = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)

    if (msgcontains(msg, 'mission') or msgcontains(msg, 'shikaku') or msgcontains(msg, 'konoha')) then
        if st == ISAC_STATUS_START then
            npcHandler:say("Entao o Shikaku finalmente enviou alguem para me buscar... Eu sabia que esse dia chegaria.", cid)
            addEvent(function()
                if isPlayer(cid) and npcHandler:isFocused(cid) then
                    npcHandler:say("Antes de partirmos, preciso de um favor. Existe um garoto aqui, Utaka... ele esta ao {norte} depois da ponte colhendo cogumelos. Va ate la e chame-o para mim.", cid)
                end
            end, 2500)
            setPlayerStorageValue(cid, STORAGE_MISSION_ISAC, ISAC_STATUS_FIND_UTAKA)
        end

    elseif (msgcontains(msg, 'ajudar') or msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) and st == ISAC_STATUS_UTAKA_KIDNAPPED then
        npcHandler:say("Sua coragem me surpreende... Prepare-se. Cada segundo conta!", cid)
        
        local isacSummon = doSummonCreature("Isac", getThingPos(cid))
        if isacSummon then doConvinceCreature(cid, isacSummon) end
        
        local npcId = getNpcId()
        local npcPos = getThingPos(npcId)
        doSendMagicEffect(npcPos, 10)
        doRemoveCreature(npcId)
        
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC, ISAC_STATUS_SAVING_UTAKA)
        addEvent(function() doCreateNpc("Isac", npcPos) end, 60000)
        npcHandler:releaseFocus(cid)

    elseif (msgcontains(msg, 'nao') or msgcontains(msg, 'no')) and st == ISAC_STATUS_UTAKA_KIDNAPPED then
        npcHandler:say("Eu entendo. Seguirei sozinho entao... adeus, ninja.", cid)
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC, ISAC_STATUS_FAILED_RESCUE)
        npcHandler:releaseFocus(cid)
    end

    return true
end

function npcHandler:onWalkAway(cid)
    if not self:isFocused(cid) then return false end
    local st = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)
    if st == ISAC_STATUS_SAVING_UTAKA then
        self:say("Rapido! Cada segundo conta!", cid)
    else
        self:say("Va com cuidado.", cid)
    end
    self:releaseFocus(cid)
    return true
end

function npcHandler:onFarewell(cid)
    if not self:isFocused(cid) then return false end
    self:say("Ate logo.", cid)
    self:releaseFocus(cid)
    return true
end

function onThink()
    local npcDir = 2 
    if npcHandler.focus == 0 then
        if getCreatureLookDirection(getNpcId()) ~= npcDir then
            doCreatureSetLookDirection(getNpcId(), npcDir)
        end
    end
    npcHandler:onThink()
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())