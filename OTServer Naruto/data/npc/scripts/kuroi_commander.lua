local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

npcHandler.topic = {} 

-- Variáveis de Controle da Trava (Cooldown)
local lastSpawn = 0 
local spawnDelay = 30 -- Segundos entre cada punição por insulto

-- 1. SILENCIA AS MENSAGENS INTERNAS
npcHandler.messages[MESSAGE_WALKAWAY] = nil
npcHandler.messages[MESSAGE_FAREWELL] = nil

-- 2. FUNÇÃO DE DESPEDIDA CUSTOMIZADA
function npcHandler:onWalkAway(cid)
    if not self:isFocused(cid) then return false end
    selfSay("Corra enquanto pode, verme. Meus homens vao adorar caçar voce.")
    self:setMessage(MESSAGE_GREET, nil)
    self.topic[cid] = 0
    self:releaseFocus(cid)
    return true
end

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function hasJhonLee(cid)
    local summons = getCreatureSummons(cid)
    if #summons > 0 then
        for _, summon in ipairs(summons) do
            if getCreatureName(summon) == "Jhon Lee" then return true end
        end
    end
    return false
end

function greetCallback(cid)
    local status = getPlayerStorageValue(cid, 34095)
    npcHandler.topic[cid] = 0
    
    if status == 3 then
        if hasJhonLee(cid) then
            npcHandler:setMessage(MESSAGE_GREET, "Olhem so... o rato saiu da toca e trouxe um amigo. Veio buscar a sua {Natalia}, Jhon Lee?")
            npcHandler.topic[cid] = 1
        else
            npcHandler:setMessage(MESSAGE_GREET, "Onde esta o traidor do Jhon Lee? Eu nao tenho negocios com voce, verme. Traga-o aqui para que eu possa matar os dois juntos!")
        end
    else
        npcHandler:setMessage(MESSAGE_GREET, "Saia daqui antes que eu use sua cabeça como decoração.")
    end
    
    npcHandler:addFocus(cid)
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end
    local msg = msg:lower()

    -- SISTEMA DE INSULTOS COM TRAVA (COOLDOWN)
    local insults = {"fuck", "shit", "bitch", "merda", "lixo", "verme", "idiota", "otario", "cu", "fdp", "filho da puta", "mother fucker", "puta que pariu", "caralho", "porra", "buceta", "arrombado", "desgraçado", "escroto", "vagabundo", "corno", "babaca", "bosta", "cuzão", "piranha", "vadia"}
    local insulted = false
    for _, word in ipairs(insults) do
        if msgcontains(msg, word) then
            insulted = true
            break
        end
    end

    if insulted then
        -- Verifica se o cooldown ainda está ativo
        if os.time() < (lastSpawn + spawnDelay) then
            npcHandler:say("Voce nao vale nem o esforço dos meus homens agora. Suma daqui!", cid)
            npcHandler:releaseFocus(cid)
            return true
        end

        -- Se passou o tempo, ativa a punição
        lastSpawn = os.time() 
        npcHandler:say("Voce tem muita coragem para um cadaver! HOMENS, ENSINEM MODOS A ELE!", cid)
        
        local pos = getThingPos(cid)
        local thugs = {"Kuroi Scout", "Kuroi Infiltrator"}
        
        for i = 1, 4 do 
            local spawnPos = {x=pos.x+math.random(-2,2), y=pos.y+math.random(-2,2), z=pos.z}
            local m = doSummonCreature(thugs[math.random(#thugs)], spawnPos)
            if m then doSendMagicEffect(spawnPos, 2) end
        end
        npcHandler:releaseFocus(cid)
        return true
    end

    -- LOGICA DA QUEST (Natalia / Armadilha Principal)
    if (msgcontains(msg, 'natalia') or msgcontains(msg, 'sim')) and npcHandler.topic[cid] == 1 then
        if not hasJhonLee(cid) then
            npcHandler:say("Ue? O seu amigo morreu no caminho? Volte quando ele estiver vivo!", cid)
            npcHandler.topic[cid] = 0
            return true
        end

        npcHandler:say("Hahaha! Voce caiu direto na armadilha! A sua Natalia e apenas uma isca. HOMENS, MATEM OS DOIS!", cid)
        
        local pos = getThingPos(cid)
        local kurois = {"Kuroi Scout", "Kuroi Infiltrator", "Kuroi Ascendant", "Kuroi Warfan"}

        for i = 1, 12 do 
            local monsterName = kurois[math.random(#kurois)] 
            local spawnPos = {x=pos.x+math.random(-3,3), y=pos.y+math.random(-3,3), z=pos.z}
            local m = doSummonCreature(monsterName, spawnPos)
            if m then doSendMagicEffect(spawnPos, 2) end
        end
        
        local npcName = getCreatureName(getNpcCid())
        local npcPos = getThingPos(getNpcCid())
        
        setPlayerStorageValue(cid, 34095, 4) 
        npcHandler:releaseFocus(cid)
        doRemoveCreature(getNpcCid())

        -- O NPC renasce após 2 minutos
        addEvent(function() doCreateNpc(npcName, npcPos) end, 120000)
    end
    return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())