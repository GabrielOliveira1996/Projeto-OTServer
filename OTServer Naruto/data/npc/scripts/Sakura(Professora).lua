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
doPlayerSendTextMessage(cid, 27, "Chiyute no Jutsu(Level 10)")
doPlayerSendTextMessage(cid, 27, "Cumulated Chakra Strike(Level 30)")
doPlayerSendTextMessage(cid, 27, "Heal Friend(Level 40)")
doPlayerSendTextMessage(cid, 27, "Chakra no Mesu(Level 50)")
doPlayerSendTextMessage(cid, 27, "Primeiro Treinamento(Level 50)")
doPlayerSendTextMessage(cid, 27, "Doku Chiyo(Level 80)")
doPlayerSendTextMessage(cid, 27, "Sozo Sasei(Level 120)")
doPlayerSendTextMessage(cid, 27, "Jinshin(Level 150)")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Ouka Sho(Level 250)")
doPlayerSendTextMessage(cid, 27, "Terceiro Treinamento(Level 300)")
end

if msgcontains(msg, 'learn chiyute no jutsu') and getPlayerLevel(cid) >= 10 then
doPlayerLearnInstantSpell(cid, "chiyute no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn cumulated chakra strike') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "cumulated chakra strike")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn heal friend') and getPlayerLevel(cid) >= 40 then
doPlayerLearnInstantSpell(cid, "heal friend")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn chakra no mesu') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "chakra no mesu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'primeiro treinamento') and getPlayerVocation(cid) == 13 and getPlayerLevel(cid) >= 50 then
doPlayerSetVocation(cid, 14)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn doku chiyo') and getPlayerLevel(cid) >= 80 then
doPlayerLearnInstantSpell(cid, "doku chiyo")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn sozo sasei') and getPlayerLevel(cid) >= 120 then
doPlayerLearnInstantSpell(cid, "sozo sasei")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn jinshin') and getPlayerLevel(cid) >= 150 then
doPlayerLearnInstantSpell(cid, "jinshin")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 14 and getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 15)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn ouka sho') and getPlayerLevel(cid) >= 250 then
doPlayerLearnInstantSpell(cid, "ouka sho")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 15 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 16)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())