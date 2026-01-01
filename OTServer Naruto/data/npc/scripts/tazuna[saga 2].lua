local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
if not npcHandler:isFocused(cid) then
return false
end

local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


local storageTazuna = 123456
local storageZabuza = 123321
local storageGain = 11121


if msgcontains(msg, 'talk') and (#getCreatureSummons(cid) < 1) getPlayerStorageValue(cid, storageTazuna) < 1 and getPlayerStorageValue(cid, storageZabuza) < 1 then return true end
selfSay('Vamos até a ponte.', cid)

for _, summon in pairs(getCreatureSummons(cid)) do
        if getCreatureName(summon):lower() == "tazuna" then
            doRemoveCreature(summon)
            setPlayerStorageValue(cid, storageTazuna, -1)            
            setPlayerStorageValue(cid, storageZabuza, -1)
            setPlayerStorageValue(cid, storageGain, 1)
            break
        end
    end
    return true
end


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())