local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

-- [ CONFIGURATIONS ]
local MONSTERS_AMBUSH = {"Oto-Nin Specialist", "Oto-Nin Specialist"} 
local CITY_POS = {x = 3032, y = 2890, z = 7} 
local CAVE_POS = {x = 3002, y = 2728, z = 9} 
local CHECK_RADIUS = 15 

npcHandler.messages[MESSAGE_WALKAWAY] = nil
npcHandler.messages[MESSAGE_FAREWELL] = nil

-- [ HELPER FUNCTIONS ]
function isAtCity(npcId) return getDistanceBetween(getThingPos(npcId), CITY_POS) <= CHECK_RADIUS end
function isAtCave(npcId) return getDistanceBetween(getThingPos(npcId), CAVE_POS) <= CHECK_RADIUS end

function hasUtakaSummon(cid)
    local summons = getCreatureSummons(cid)
    for _, summon in ipairs(summons or {}) do
        if getCreatureName(summon) == "Utaka" then return true end
    end
    return false
end

function hasIsacSummon(cid)
    local summons = getCreatureSummons(cid)
    for _, summon in ipairs(summons or {}) do
        if getCreatureName(summon) == "Isac" then return true end
    end
    return false
end

-- [ KIDNAP EVENT ]
local function executeKidnap(cid, npcId)
    if not isPlayer(cid) or not isCreature(npcId) then return end
    local npcPos = getThingPos(npcId)
    local npcName = getCreatureName(npcId)

    for i = 1, 3 do
        local monster = doCreateMonster(MONSTERS_AMBUSH[math.random(#MONSTERS_AMBUSH)], {x = npcPos.x + math.random(-1,1), y = npcPos.y + math.random(-1,1), z = npcPos.z})
        if monster then doMonsterSetTarget(monster, cid) end
    end

    doCreatureSay(npcId, "SOCORRO! QUEM SÃO VOCÊS?!", TALKTYPE_SAY)

    addEvent(function()
        if isCreature(npcId) then
            doSendMagicEffect(getThingPos(npcId), 10) 
            doRemoveCreature(npcId)
            addEvent(function() doCreateNpc(npcName, npcPos) end, 60 * 1000)
            
            if isPlayer(cid) then
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Os ninjas levaram o garoto!")
                setPlayerStorageValue(cid, STORAGE_MISSION_ISAC, ISAC_STATUS_UTAKA_KIDNAPPED)
            end
        end
    end, 3000)
end

-- [ GREET CALLBACK ]
function greetCallback(cid)
    local st = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)
    local read = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC_READ_UTAKA)
    local npcId = getNpcCid()

    -- [ SECURITY CHECK & ENDINGS ]
    -- Se a missão acabou ou o status de leitura foi ativado
    if st == ISAC_STATUS_COMPLETE or st >= ISAC_STATUS_HERO or read >= 1 then
        
        -- FINAL HERO: Ambos Vivos (ou missão completa com desfecho positivo)
        if st == ISAC_STATUS_HERO or (st == ISAC_STATUS_COMPLETE and st ~= ISAC_STATUS_ISAC_DEAD and st ~= ISAC_STATUS_UTAKA_DEAD and st ~= ISAC_STATUS_BOTH_DEAD) then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Utaka sorri para voce, ele parece feliz e tranquilo.")
            return false 

        -- FINAL ISAC DEAD: Apenas Utaka Vivo
        elseif st == ISAC_STATUS_ISAC_DEAD then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Utaka aparenta estar muito triste. Ele nao e mais o mesmo depois que Isac se foi.")
            return false 

        -- FINAL UTAKA DEAD ou BOTH DEAD: Utaka Morreu
        elseif st == ISAC_STATUS_UTAKA_DEAD or st == ISAC_STATUS_BOTH_DEAD then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "O lugar onde o garoto costumava brincar agora esta em absoluto silencio.")
            return false 
        end
    end

    -- [ ACTIVE MISSION STAGES ]

    -- Stage: Find Utaka (Kidnap Event)
    if st == ISAC_STATUS_FIND_UTAKA then
        if isAtCity(npcId) then
            npcHandler:setMessage(MESSAGE_GREET, "Oi! O Isac te mandou aqui? Espera... quem sao esses ninjas?!")
            addEvent(executeKidnap, 1000, cid, npcId)
        else
            npcHandler:setMessage(MESSAGE_GREET, "Oi! Voce deveria estar procurando por mim perto da cidade, nao aqui.")
        end
    
    -- Stage: Kidnapped (Player should go back to Isac)
    elseif st == ISAC_STATUS_UTAKA_KIDNAPPED then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Ele esta preso em uma das bases dos ninjas do som. Encontre-o com Isac para resgata-lo.")
        return false
    
    -- Stage: Rescue (Cave rescue)
    elseif st == ISAC_STATUS_SAVING_UTAKA then
        if isAtCave(npcId) then
            if not hasUtakaSummon(cid) then
                npcHandler:setMessage(MESSAGE_GREET, "Socorro! O Isac esta com voce? Eu nao vou a lugar nenhum sozinho! Se ele estiver aqui, me diga para {ir}!")
            else
                npcHandler:setMessage(MESSAGE_GREET, "Vamos sair daqui, por favor!")
            end
        else
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Ele esta preso em uma das bases dos ninjas do som. Encontre-o com Isac para resgata-lo.")
            return false
        end

    -- [ ENDING DIALOGUES - FIRST INTERACTION ]
    elseif st == ISAC_STATUS_HERO then
        npcHandler:setMessage(MESSAGE_GREET, "Obrigado por salvar a mim e ao Isac. Eu estava com tanto medo...")
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC_READ_UTAKA, 1)

    elseif st == ISAC_STATUS_ISAC_DEAD then
        local summons = getCreatureSummons(cid)
        for _, s in ipairs(summons or {}) do
            if getCreatureName(s) == "Utaka" then
                doRemoveCreature(s)
                doSendMagicEffect(getThingPos(cid), 2)
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Voce deixou Utaka em seguranca na vila.")
                break
            end
        end
        npcHandler:setMessage(MESSAGE_GREET, "Eu... eu estou seguro agora, mas o Isac... por que ele teve que nos deixar?")
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC_READ_UTAKA, 1)
        
    else
        npcHandler:setMessage(MESSAGE_GREET, "Oi! Voce viu o Isac por ai? Ele prometeu me ensinar um jutsu novo hoje!")
    end
    
    npcHandler:addFocus(cid)
    return true
end

-- [ DIALOGUE CALLBACK ]
function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end
    local st = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)
    local npcId = getNpcCid()

    -- Command to start following in the rescue
    if (msgcontains(msg, 'go') or msgcontains(msg, 'vamos') or msgcontains(msg, 'ir')) and st == ISAC_STATUS_SAVING_UTAKA then
        if not isAtCave(npcId) then
            selfSay("Aqui eu ja estou seguro, nao preciso te seguir.")
            return true
        end

        if not hasIsacSummon(cid) then
            selfSay("Onde esta o Isac?! Eu nao saio daqui sem ele!")
            return true
        end

        if hasUtakaSummon(cid) then
            selfSay("Eu ja estou te seguindo!")
        else
            selfSay("Por favor, me leve para casa.")
            local utakaSummon = doSummonCreature("Utaka", getThingPos(cid)) 
            if utakaSummon then doConvinceCreature(cid, utakaSummon) end

            -- External function for waves if exists
            if _G["spawnWaveIsac"] then spawnWaveIsac(cid, 1) end

            local npcName = getCreatureName(npcId)
            local npcPos = getThingPos(npcId)
            doRemoveCreature(npcId)
            addEvent(function() doCreateNpc(npcName, npcPos) end, 60000) 
        end
        npcHandler:releaseFocus(cid)
    end
    return true
end

-- [ WALK AWAY / FAREWELL ]
function npcHandler:onWalkAway(cid)
    if not self:isFocused(cid) then return false end
    local st = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)
    if st == ISAC_STATUS_SAVING_UTAKA then
        self:say("Nao me deixe aqui sozinho! Eles vao voltar!", cid)
    else
        self:say("Tchau...", cid)
    end
    self:releaseFocus(cid)
    return true
end

function npcHandler:onFarewell(cid)
    if not self:isFocused(cid) then return false end
    self:say("Se cuida.", cid)
    self:releaseFocus(cid)
    return true
end

-- [ SETUP CALLBACKS ]
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())