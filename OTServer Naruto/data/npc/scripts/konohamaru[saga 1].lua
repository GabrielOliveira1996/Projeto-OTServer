local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

-- MODIFICACAO NO ONTHINK: Silencio ao afastar
function onThink() 
    if npcHandler:isFocused(cid) then
        local coords = getCreaturePosition(cid)
        local myCoords = getCreaturePosition(getSelf())
        if (getDistanceBetween(coords, myCoords) > 4) then
            npcHandler:releaseFocus(cid)
        end
    end
    npcHandler:onThink() 
end

-- Saudacao Dinamica
function onGreet(cid)
    local playerName = getCreatureName(cid)
    local storageVenceuHokage = 11116
    local storageJaAprendeu = 11117

    if getPlayerStorageValue(cid, storageJaAprendeu) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Ei chefe! Algum dia eu vou te vencer e me tornar o Hokage!")
    elseif getPlayerStorageValue(cid, storageVenceuHokage) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Ei, voce! Aquela tecnica que voce usou no vovo foi incrivel! Voce poderia me ensinar? Por favor, vamos pode ser o meu {Sensei}?")
    else
        npcHandler:setMessage(MESSAGE_GREET, "Saia da frente! Eu sou o neto do Honoravel Terceiro Hokage!")
    end

    npcHandler:addFocus(cid)
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local storagelose = 11116 -- Storage de quem entregou a foto
    local storageGain = 11117 -- Storage de quem treinou o Konohamaru
    local expBonus = 6000

    if msgcontains(msg, 'sensei') then
        -- 1. Verifica se o jogador pode ensinar o Konohamaru
        if getPlayerStorageValue(cid, storagelose) >= 1 then
            selfSay('Incrivel! Entao a partir de hoje eu sou seu discipulo e voce e o meu Chefe! Vou praticar ate superar voce e o meu vovo. Obrigado, Chefe!', cid)
            
            setPlayerStorageValue(cid, storagelose, -1)
            setPlayerStorageValue(cid, storageGain, 1)
            doPlayerAddExp(cid, expBonus)
            doSendMagicEffect(getThingPos(cid), 14) -- Efeito visual
            
        -- 2. Se ja treinou
        elseif getPlayerStorageValue(cid, storageGain) >= 1 then
            selfSay('Eu ja entendi, Chefe! Agora deixe comigo, eu vou treinar muito!', cid)
        
        -- 3. Ignora se nao tiver a storage necessaria
        else
            return false
        end
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Garante o silencio total ao se afastar ou dar bye
npcHandler.messages[MESSAGE_FAREWELL] = ""
npcHandler.messages[MESSAGE_WALKAWAY] = ""

npcHandler:addModule(FocusModule:new())