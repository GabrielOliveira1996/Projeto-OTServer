local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}
function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
function creatureSayCallback(cid, type, msg)
if(not npcHandler:isFocused(cid)) then
return false
end
local talkUser = NPCHANDLER_CONVbehavior == CONVERSATION_DEFAULT and 0 or cid
-- Conversa Jogador/NPC
local storage = 11110 -- Aqui storage que o player tera que ter para falar com o npc.
if(msgcontains(msg, 'sim') and getStor(cid, storage) == 1) then
if getStor(cid, 11111) == 1 then selfSay('Ok, Então vamos.')
return true
end
setStor(cid, 11111, 1)
else
selfSay('...')
return true
end
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
function setStor(cid, sto, value)
return setPlayerStorageValue(cid, sto, value)
end
function getStor(cid, value)
return getPlayerStorageValue(cid, value)
end