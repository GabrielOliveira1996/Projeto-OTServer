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
local storagelose1 = 11115 -- storage que vai perder
local storageGain1 = 11116 -- storage que vai receber
local var1 = 6000


local storagelose2 = 11119 -- storage que vai perder
local storageGain2 = 11120 -- storage que vai receber
local storageTazuna = 123456 -- storage que vai possibilitar de pegar outras vezes o tazuna


if msgcontains(msg, 'orioke no jutsu') and getPlayerStorageValue(cid, storagelose1) > -1 then
selfSay('Esta bem eu aceito sua foto.', cid)
setPlayerStorageValue(cid, storagelose1, -1)
setPlayerStorageValue(cid, storageGain1, 1)
doPlayerAddExp(cid, var1)
end


if msgcontains(msg, 'first mission') and getPlayerStorageValue(cid, storagelose2) > -1 then
selfSay('Leve Tazuna com segurança para o pais dele.', cid)
setPlayerStorageValue(cid, storagelose2, -1)
setPlayerStorageValue(cid, storageGain2, 1)
setPlayerStorageValue(cid, storageTazuna, 1)
doPlayerAddItem(cid,2152,100)
end


if msgcontains(msg, 'tazuna') and (#getCreatureSummons(cid) < 1) and getPlayerStorageValue(cid, storageTazuna) > -1 and getPlayerItemCount(cid, 2313) <= 0 then
selfSay('Proteja-o.', cid)
doPlayerAddItem(cid,2313,1)
end

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())