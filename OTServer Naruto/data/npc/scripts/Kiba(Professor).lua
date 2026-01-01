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

if msgcontains(msg, 'teach') and getPlayerVocation(cid) == 9 or getPlayerVocation(cid) == 10 or getPlayerVocation(cid) == 11 or getPlayerVocation(cid) == 12 then
doPlayerSendTextMessage(cid, 27, "Para aprender algum jutsu fale 'learn nome do jutsu'.")
doPlayerSendTextMessage(cid, 27, "Akamaru(Level 10)")
doPlayerSendTextMessage(cid, 27, "Tsuuga(Level 30)")
doPlayerSendTextMessage(cid, 27, "Rouga(Level 50)")
doPlayerSendTextMessage(cid, 27, "Primeiro Treinamento(Level 50)")
doPlayerSendTextMessage(cid, 27, "Kizu(Level 70)")
doPlayerSendTextMessage(cid, 27, "Gatsuuga(Level 120)")
doPlayerSendTextMessage(cid, 27, "Garouga(Level 150)")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Terceiro Treinamento(Level 300)")
end

if msgcontains(msg, 'learn akamaru') and getPlayerLevel(cid) >= 10 then
doPlayerLearnInstantSpell(cid, "Akamaru")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn tsuuga') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "Tsuuga")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn rouga') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "Rouga")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'primeiro treinamento') and getPlayerVocation(cid) == 9 and getPlayerLevel(cid) >= 50 then
doPlayerSetVocation(cid, 10)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kizu') and getPlayerLevel(cid) >= 70 then
doPlayerLearnInstantSpell(cid, "Kizu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn gatsuuga') and getPlayerLevel(cid) >= 120 then
doPlayerLearnInstantSpell(cid, "Gatsuuga")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn garouga') and getPlayerLevel(cid) >= 150 then
doPlayerLearnInstantSpell(cid, "Garouga")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 10 and getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 11)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 11 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 12)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())