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
local storagelose1 = 1000 -- storage que vai perder
local storageGain1 = 1001 -- storage que vai receber
local storagelose2 = 1001 -- storage que vai perder
local storageGain2 = 1002 -- storage que vai receber
local storagelose3 = 1004 -- storage que vai perder
local storageGain3 = 1005 -- storage que vai receber
local storagelose4 = 1006 -- storage que vai perder
local storageGain4 = 1007 -- storage que vai receber
local var4 = 2500

if msgcontains(msg, 'missoes') and getPlayerStorageValue(cid, storagelose1) > -1 then
selfSay('Ok, como você quizer, apenas peça a sua primeira missão.', cid)
setPlayerStorageValue(cid, storagelose1, -1)
setPlayerStorageValue(cid, storageGain1, 1)
end

--------------------------------------------------------------------------------------------------------

if msgcontains(msg, '1 missao') and getPlayerStorageValue(cid, storagelose2) > -1 then
selfSay('Vá até rio ao nordeste de konoha e apanhe o lixo.', cid)
setPlayerStorageValue(cid, storagelose2, -1)
setPlayerStorageValue(cid, storageGain2, 1)
end

--------------------------------------------------------------------------------------------------------

if msgcontains(msg, '2 missao') and getPlayerStorageValue(cid, storagelose3) > -1 then
selfSay('Encontre o gato perdido, procure por toda a cidade.', cid)
setPlayerStorageValue(cid, storagelose3, -1)
setPlayerStorageValue(cid, storageGain3, 1)
doPlayerAddExp(cid, var3)
doPlayerAddItem(cid, 2160, 5)
end

--------------------------------------------------------------------------------------------------------

if msgcontains(msg, '3 missao') and getPlayerStorageValue(cid, storagelose4) > -1 then
selfSay('Vá até a montanha dos hokages e fale com o homem chamando kyusuke, diga a ele para consertar as luzes de konoha.', cid)
setPlayerStorageValue(cid, storagelose4, -1)
setPlayerStorageValue(cid, storageGain4, 1)
doPlayerAddExp(cid, var4)
doPlayerAddItem(cid, 2160, 7)
end

return true
end


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())