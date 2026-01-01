local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
if not npcHandler:isFocused(cid) then
return false
end

if msgcontains(msg, 'teach') and getPlayerVocation(cid) == 13 or getPlayerVocation(cid) == 14 or getPlayerVocation(cid) == 15 or getPlayerVocation(cid) == 16 then
doPlayerSendTextMessage(cid, 27, "Para aprender algum jutsu fale 'learn nome do jutsu'.")
doPlayerSendTextMessage(cid, 27, "Fuusajin No Jutsu(Level 30)")
doPlayerSendTextMessage(cid, 27, "Reppushou No Jutsu(Level 50)")
doPlayerSendTextMessage(cid, 27, "Primeiro Treinamento(Level 50)")
doPlayerSendTextMessage(cid, 27, "Renkuudan No Jutsu(Level 90)")
doPlayerSendTextMessage(cid, 27, "Fuuton Ninpou(Level 130)")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Fuuton Sensha(Level 170)")
doPlayerSendTextMessage(cid, 27, "Terceiro Treinamento(Level 300)")
end

if msgcontains(msg, 'learn fuusajin no jutsu') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "fuusajin no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn reppushou no jutsu') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "reppushou no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'primeiro treinamento') and getPlayerVocation(cid) == 25 and getPlayerLevel(cid) >= 50 then
doPlayerSetVocation(cid, 26)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn Renkuudan no jutsu') and getPlayerLevel(cid) >= 90 then
doPlayerLearnInstantSpell(cid, "Renkuudan no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn fuuton ninpou') and getPlayerLevel(cid) >= 130 then
doPlayerLearnInstantSpell(cid, "fuuton ninpou")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 26 and getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 27)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn fuuton sensha') and getPlayerLevel(cid) >= 170 then
doPlayerLearnInstantSpell(cid, "fuuton sensha")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 27 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 28)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())