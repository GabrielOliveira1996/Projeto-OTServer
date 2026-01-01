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

if msgcontains(msg, 'teach') and getPlayerVocation(cid) == 29 or getPlayerVocation(cid) == 31 or getPlayerVocation(cid) == 32 then
doPlayerSendTextMessage(cid, 27, "Para aprender algum jutsu fale 'learn nome do jutsu'.")
doPlayerSendTextMessage(cid, 27, "Byakugan(Level 10)")
doPlayerSendTextMessage(cid, 27, "Hakke Hiasangi(Level 30)")
doPlayerSendTextMessage(cid, 27, "Hakeshou Kaiten(Level 50)")
doPlayerSendTextMessage(cid, 27, "Hakke Fujin No Jutsu(Level 70)")
doPlayerSendTextMessage(cid, 27, "Cumulated Chakra(Level 100)")
doPlayerSendTextMessage(cid, 27, "Hakke Hiasangi Fujin(Level 130)")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Hakke Hasangeki(Level 160)")
doPlayerSendTextMessage(cid, 27, "Hakke Fujin Hari(Level 220)")
doPlayerSendTextMessage(cid, 27, "Cumulated Chakra(Level 250)")
doPlayerSendTextMessage(cid, 27, "Terceiro Treinamento(Level 300)")
end

if msgcontains(msg, 'learn byakugan') and getPlayerLevel(cid) >= 10 then
doPlayerLearnInstantSpell(cid, "byakugan")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn hakke hiasangi') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "hakke hiasangi")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn cumulated chakra') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "cumulated chakra")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn hakeshou kaiten') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "hakeshou kaiten")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn hakke fujin no jutsu') and getPlayerLevel(cid) >= 70 then
doPlayerLearnInstantSpell(cid, "hakke fujin no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn hakke hiasangi fujin') and getPlayerLevel(cid) >= 130 then
doPlayerLearnInstantSpell(cid, "hakke hiasangi fujin")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 29 and getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 31)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn hakke hasangeki') and getPlayerLevel(cid) >= 160 then
doPlayerLearnInstantSpell(cid, "hakke hasangeki")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn hakke fujin hari') and getPlayerLevel(cid) >= 220 then
doPlayerLearnInstantSpell(cid, "hakke fujin hari")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 31 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 32)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())