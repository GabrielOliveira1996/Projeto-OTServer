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
local storagelose = 11144 -- storage que vai perder
local storageGain = 11145 -- storage que vai receber
local var = 22500

if msgcontains(msg, 'talk') and getPlayerStorageValue(cid, storagelose) > -1 then
selfSay('Da proxima viz você não irá escapar.', cid)
setPlayerStorageValue(cid, storagelose, -1)
setPlayerStorageValue(cid, storageGain, 1)
doPlayerAddExp(cid, var)
else
selfSay('...', cid)
end

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())