local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local talkState = {}
local quest = 76669
local reward = 70000

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid
if(not npcHandler:isFocused(cid)) then
return false
elseif msgcontains(msg, "ashar") or msgcontains(msg, "templo") or msgcontains(msg, "temple") and talkState[talkUser] == 1 then
npcHandler:say("Sim, nós fugimos de lá por não concordarmos com as léis e doutrinas nas quais eles seguem e agora somos perseguidos por isso.", cid)
return true
end

if msgcontains(msg, "ajuda") or msgcontains(msg, "help") or msgcontains(msg, "missao") or msgcontains(msg, "mission") and talkState[talkUser] == 1 then
npcHandler:say("Perfeito, você sabe qual a 'localização' do templo?", cid)
return true
end

if msgcontains(msg, "local") or msgcontains(msg, "localização") or msgcontains(msg, "localizacao") and talkState[talkUser] == 1 then
npcHandler:say("Fica ao norte daqui, não é muito longe, vá até lá e elimine 800 monks, assim tudo será resolvido, você entendeu?.", cid)
talkState[talkUser] = 2
elseif msgcontains(msg, "yes") or msgcontains(msg, "sim") and talkState[talkUser] == 2 then
npcHandler:say("Tudo bem, boa sorte.", cid)
setPlayerStorageValue(cid, quest, 2)
talkState[talkUser] = 0
elseif msgcontains(msg, "mission") or msgcontains(msg, "missao") then
local str = getPlayerStorageValue(cid, quest)
if(str < 2) then
npcHandler:say("Ótimo, vá até o templo e mate 800 monks, você será bem recompensado.", cid) 
talkState[talkUser] = 1
return true
elseif(str == 2) then
npcHandler:say("Volte quando tiver finalizado a missão.", cid)
elseif(str == 3) then
npcHandler:say("Você é um grande shinobi, aqui está sua recompensa meu jovem.", cid)
doPlayerAddItem(cid, 2160, 10) -- 10 red notes
doPlayerAddItem(cid, 5909, 100) -- 100 white tissues
doPlayerAddExp(cid, 1000000)
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você recebeu 1kk de experiência, 100 white tissues e 10 red notes.")
setPlayerStorageValue(cid, quest, 4)
elseif(str == 4) then
npcHandler:say("Você tem o nosso respeito!", cid)
end
talkState[talkUser] = 0
end
return TRUE
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())