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

if msgcontains(msg, 'teach') and getPlayerVocation(cid) == 5 or getPlayerVocation(cid) == 7 or getPlayerVocation(cid) == 8 then
doPlayerSendTextMessage(cid, 27, "Para aprender algum jutsu fale 'learn nome do jutsu'.")
doPlayerSendTextMessage(cid, 27, "Suna Shuriken(Level 10)")
doPlayerSendTextMessage(cid, 27, "Sabaku Kyu(Level 30)")
doPlayerSendTextMessage(cid, 27, "Suna Wall(Level 40)")
doPlayerSendTextMessage(cid, 27, "Shukaku Form(Level 40)")
doPlayerSendTextMessage(cid, 27, "Suna No Yoroi(Level 50)")
doPlayerSendTextMessage(cid, 27, "Primeiro Treinamento(Level 50)")
doPlayerSendTextMessage(cid, 27, "Sajin Sougeki(Level 70)")
doPlayerSendTextMessage(cid, 27, "Suna Ryuuna No Jutsu(Level 80)")
doPlayerSendTextMessage(cid, 27, "Suna Shigure(Level 130)")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Suna Jinji No Jutsu(Level 170)")
doPlayerSendTextMessage(cid, 27, "Suna Bakuhatsu no Jutsu(Level 250)")
doPlayerSendTextMessage(cid, 27, "Terceiro Treinamento(Level 300)")
end

if msgcontains(msg, 'learn Suna Shuriken') and getPlayerLevel(cid) >= 10 then
doPlayerLearnInstantSpell(cid, "Suna Shuriken")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn Sabaku Kyu') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "Sabaku Kyu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn Suna Wall') and getPlayerLevel(cid) >= 40 then
doPlayerLearnInstantSpell(cid, "Suna Wall")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn Shukaku Form') and getPlayerLevel(cid) >= 40 then
doPlayerLearnInstantSpell(cid, "Shukaku Form")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn Sajin Sougeki') and getPlayerLevel(cid) >= 70 then
doPlayerLearnInstantSpell(cid, "Sajin Sougeki")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn Suna Ryuuna No Jutsu') and getPlayerLevel(cid) >= 80 then
doPlayerLearnInstantSpell(cid, "Suna Ryuuna No Jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn Suna Shigure') and getPlayerLevel(cid) >= 130 then
doPlayerLearnInstantSpell(cid, "Suna Shigure")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 5 and getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 7)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn Suna Jinji No Jutsu') and getPlayerLevel(cid) >= 170 then
doPlayerLearnInstantSpell(cid, "Suna Jinji No Jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn rasenshuriken') and getPlayerLevel(cid) >= 250 then
doPlayerLearnInstantSpell(cid, "Suna Bakuhatsu no Jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 7 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 8)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())