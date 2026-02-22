local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

function onThink() 
    if npcHandler:isFocused(cid) then
        local coords = getCreaturePosition(cid)
        local myCoords = getThingPos(getNpcCid())
        if (getDistanceBetween(coords, myCoords) > 4) then
            npcHandler:releaseFocus(cid)
        end
    end
    npcHandler:onThink() 
end

function onGreet(cid)
    local playerName = getCreatureName(cid)
    local storageVenceuEbisu = 11118
    local storagePassouTeste = 11119

    if getPlayerStorageValue(cid, storagePassouTeste) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Ola " .. playerName .. ". Va falar com o Hokage para sua primeira missao real.")
    elseif getPlayerStorageValue(cid, storageVenceuEbisu) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Ola " .. playerName .. ". Voce parece pronto para o teste final. Quer {iniciar}?")
    else
        npcHandler:setMessage(MESSAGE_GREET, "Ainda nao e sua hora. Volte quando terminar seus assuntos com o Konohamaru.")
    end

    npcHandler:addFocus(cid)
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local storagelose = 11118 
    local storageGain = 11119 
    local expBonus = 5000
    local cloneName = "Kakashi Bunshin"

    if msgcontains(msg, 'iniciar') then
        if getPlayerStorageValue(cid, storagelose) >= 1 then
            selfSay('Muito bem! Mas sera que voce consegue lidar com os meus clones?', cid)
          
            local npcPos = getThingPos(getNpcCid())
            
            for i = 1, 10 do
                local spawnPos = {x = npcPos.x + math.random(-1, 1), y = npcPos.y + math.random(-1, 1), z = npcPos.z}
                doSummonCreature(cloneName, spawnPos)
                doSendMagicEffect(spawnPos, 2)
            end

            selfSay('Parabens, voce passou no meu teste!', cid)
            
            setPlayerStorageValue(cid, storagelose, -1)
            setPlayerStorageValue(cid, storageGain, 1)
            doPlayerAddExp(cid, expBonus)
            doSendMagicEffect(getThingPos(cid), 14) 
            
        elseif getPlayerStorageValue(cid, storageGain) >= 1 then
            selfSay('Va agora, o Terceiro Hokage esta te esperando.', cid)
        else
            return false
        end
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler.messages[MESSAGE_FAREWELL] = ""
npcHandler.messages[MESSAGE_WALKAWAY] = ""
npcHandler:addModule(FocusModule:new())