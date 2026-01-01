local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
if(not npcHandler:isFocused(cid)) then
return false
end

if getPlayerStorageValue(cid, 92004) == 1 then -- storage que retornara todo o script
return false
end

if msgcontains(msg, "hi") or msgcontains(msg, "oi") or msgcontains(msg, "ola") then
if getPlayerStorageValue(cid, 92000) == 1 then
npcHandler:say("Ola jovem, nos viemos do templo de 'Ashar'.", cid)
return true
end
end


if msgcontains(msg, "ashar") or msgcontains(msg, "templo") or msgcontains(msg, "temple") then
if getPlayerStorageValue(cid, 92000) == 1 then
npcHandler:say("Sim, nós fugimos de lá por não concordarmos com as léis e doutrinas nas quais eles seguem e agora somos perseguidos por isso.", cid)
return true
end
end


if msgcontains(msg, "ajuda") or msgcontains(msg, "help") then
if getPlayerStorageValue(cid, 92000) == 1 then
npcHandler:say("Perfeito, você sabe qual a 'localização' do templo?", cid)
return true
end
end


if msgcontains(msg, "local") or msgcontains(msg, "localização") or msgcontains(msg, "localizacao") then
if getPlayerStorageValue(cid, 92000) == 1 then
npcHandler:say("Fica ao norte daqui, não é muito longe, adentre as profundezas daquele templo e mate o lider 'Ashar', assim tudo será resolvido, você entendeu?.", cid)
return true
end
end


if msgcontains(msg, "yes") or msgcontains(msg, "sim") then
if getPlayerStorageValue(cid, 92000) == 1 then
npcHandler:say("Tudo bem, boa sorte.", cid)
setPlayerStorageValue(cid, 92001, 1) -- storage que sera modificada
return true
end
end


if msgcontains(msg, "mission") or msgcontains(msg, "missao") then
if getPlayerStorageValue(cid, 92001) == 1 then
npcHandler:say("Volte quando tiver terminado.", cid) 
return true
end
end


if msgcontains(msg, "mission") or msgcontains(msg, "missao") then
if getPlayerStorageValue(cid, 92002) == 1 then
npcHandler:say("Você é realmente um grande ninja, agora estamos a salvo, pegue a sua recompensa.", cid)
doPlayerAddItem(cid, 2160, 10) -- 10 red notes
doPlayerAddItem(cid, 5909, 100) -- 100 white tissues
doPlayerAddExp(cid, 1000000)
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você recebeu 1kk de experiência, 100 white tissues e 10 red notes.")
setPlayerStorageValue(cid, 92003, 1) -- msg da talk, confimação
setPlayerStorageValue(cid, 92002, -1) -- remove
setPlayerStorageValue(cid, 92004, 1) -- retorna todo o script impedindo o npc de falar
elseif(92003 == 1) then
npcHandler:say("Você tem todo o nosso respeito!", cid)
end
talkState[talkUser] = 0
return TRUE
end
end




npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())