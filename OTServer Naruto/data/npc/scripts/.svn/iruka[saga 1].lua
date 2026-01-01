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
local storagelose = 11109 -- storage que vai perder
local storageGain = 11110 -- storage que vai receber
local storageGain1 = 31313 -- storage que vai receber e ficar fixa para bloqueio
local var = 4000

if msgcontains(msg, 'bunshin no jutsu') and getPlayerStorageValue(cid, storagegain1) >= 1 then
selfSay('Você já fez o exame genin.', cid)
setPlayerStorageValue(cid, storagelose, -1)
end

if msgcontains(msg, 'bunshin no jutsu') and getPlayerStorageValue(cid, storagelose) >= 1 then
selfSay('Você ainda não está capacitado para virar genin.', cid)
setPlayerStorageValue(cid, storagelose, -1)
setPlayerStorageValue(cid, storageGain, 1)
setPlayerStorageValue(cid, storageGain1, 1)
doPlayerAddExp(cid, var)
else
selfSay('Você ainda não está pronto para o teste.', cid)
end

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())