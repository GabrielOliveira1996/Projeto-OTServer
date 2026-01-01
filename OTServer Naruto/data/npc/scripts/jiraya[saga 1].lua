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
local storagelose = 11134 -- storage que vai perder
local storageGain = 11135 -- storage que vai receber
local storagelose1 = 11143 -- storage que vai perder
local storageGain1 = 11144 -- storage que vai receber
local var = 22500
local var1 = 22500

if msgcontains(msg, 'orioke no jutsu') and getPlayerStorageValue(cid, storagelose) > -1 then
selfSay('Ok, ok, ok, acho que posso te treinar...', cid)
setPlayerStorageValue(cid, storagelose, -1)
setPlayerStorageValue(cid, storageGain, 1)
doPlayerAddExp(cid, var)

end

if msgcontains(msg, 'hokage') and getPlayerStorageValue(cid, storagelose1) > -1 then
selfSay('Vamos lá, vamos embusca do novo hokage.', cid)
setPlayerStorageValue(cid, storagelose1, -1)
setPlayerStorageValue(cid, storageGain1, 1)
doPlayerAddExp(cid, var1)

end

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())