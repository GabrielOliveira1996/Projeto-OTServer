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

if msgcontains(msg, 'itens') then
selfSay('Eu construo os seguintes itens:', cid)
selfSay('Uchiha Symbol, é necessário 50 white tissues e 50 red tissues.', cid)
selfSay('Uchiha Jacket, é necessário 5 uchiha symbols e 500 black tissues.', cid)
selfSay('Caso queira que eu construa algo apenas fale "craft item name".', cid)
return true
end

--uchiha symbol


if msgcontains(msg, 'craft uchiha symbol') then
if getPlayerItemCount(cid, 5909) >= 50 and getPlayerItemCount(cid, 5913) >= 50 then
selfSay('Item feito com sucesso, pegue-o.', cid)
doPlayerRemoveItem(cid, 5909, 50) -- remove white tissue
doPlayerRemoveItem(cid, 5913, 50) -- remove red tissue
doPlayerAddItem(cid, 5911, 1) -- adiciona uchiha symbol
else
selfSay('Você não possui os itens necessários.', cid)
return true
end
end

--uchiha jacket


if msgcontains(msg, 'craft uchiha jacket') then
if getPlayerItemCount(cid, 5911) >= 5 and getPlayerItemCount(cid, 5912) >= 500 then
selfSay('Item feito com sucesso, pegue-o.', cid)
doPlayerRemoveItem(cid, 5911, 5) -- remove uchiha symbol
doPlayerRemoveItem(cid, 5912, 500) -- remove black tissue
doPlayerAddItem(cid, 2654, 1) -- adiciona uchiha jacket
else
selfSay('Você não possui os itens necessários.', cid)
return true
end
end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())