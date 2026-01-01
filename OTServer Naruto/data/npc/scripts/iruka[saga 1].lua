local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

-- MODIFICAÇÃO NO ONTHINK: Limpa o foco sem falar nada
function onThink() 
    if npcHandler:isFocused(cid) then
        local coords = getCreaturePosition(cid)
        local myCoords = getCreaturePosition(getSelf())
        -- Se o player estiver a mais de 4 metros, remove o foco silenciosamente
        if (getDistanceBetween(coords, myCoords) > 4) then
            npcHandler:releaseFocus(cid)
        end
    end
    npcHandler:onThink() 
end

function onGreet(cid)
    local storageGain1 = 31313
    if getPlayerStorageValue(cid, storageGain1) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Voce ainda esta aqui, " .. getCreatureName(cid) .. "? Va praticar, voce precisa dominar o Bunshin se quiser se tornar um ninja!")
    else
        npcHandler:setMessage(MESSAGE_GREET, "Finalmente voce chegou, " .. getCreatureName(cid) .. "! Os pergaminhos estao prontos. Voce praticou o seu Bunshin? Se estiver pronto para o teste, use o seu {bunshin no jutsu}.")
    end
    npcHandler:addFocus(cid)
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local storagelose = 11109 
    local storageGain = 11110 
    local storageGain1 = 31313 
    local var = 2000

    if msgcontains(msg, 'bunshin no jutsu') then
        if getPlayerStorageValue(cid, storagelose) >= 1 then
            selfSay('Mas o que foi isso?! Voce criou apenas um clone murcho e sem vida... Sinto muito, ' .. getCreatureName(cid) .. ', voce ainda nao esta capacitado para virar genin.', cid)
            setPlayerStorageValue(cid, storagelose, -1)
            setPlayerStorageValue(cid, storageGain, 1)
            setPlayerStorageValue(cid, storageGain1, 1)
            doPlayerAddExp(cid, var)
            doSendMagicEffect(getThingPos(cid), 2)
        else
            selfSay('Voce falhou no teste, va treinar para estar capacitado para o proximo teste!', cid)
        end
    end
    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Forçamos as mensagens de despedida a serem strings vazias na criação do handler
npcHandler.messages[MESSAGE_FAREWELL] = ""
npcHandler.messages[MESSAGE_WALKAWAY] = ""

npcHandler:addModule(FocusModule:new())