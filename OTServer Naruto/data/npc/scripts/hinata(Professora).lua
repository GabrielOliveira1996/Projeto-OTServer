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

if msgcontains(msg, 'teach') and getPlayerVocation(cid) == 53 or getPlayerVocation(cid) == 54 or getPlayerVocation(cid) == 55 or getPlayerVocation(cid) == 56 then
doPlayerSendTextMessage(cid, 27, "Para aprender algum jutsu fale 'learn nome do jutsu'.")
doPlayerSendTextMessage(cid, 27, "Byakugan(Level 10)")
doPlayerSendTextMessage(cid, 27, "Hakke Hiasangi(Level 30)")
doPlayerSendTextMessage(cid, 27, "Hakke Juho Hasangeki(Level 50)")
doPlayerSendTextMessage(cid, 27, "Mizu Hari(Level 70)")
doPlayerSendTextMessage(cid, 27, "Juken(Level 100)")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Hakke Soshiken Sho(Level 150)")
doPlayerSendTextMessage(cid, 27, "Shugohakke Rokujuyon Sho(Level 200)")
doPlayerSendTextMessage(cid, 27, "Juuho Soshiken(Level 250)")
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

if msgcontains(msg, 'primeiro treinamento') and getPlayerVocation(cid) == 53 and getPlayerLevel(cid) >= 50 then
doPlayerSetVocation(cid, 54)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn hakke juho hasangeki') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "hakke juho hasangeki")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn mizu hari') and getPlayerLevel(cid) >= 70 then
doPlayerLearnInstantSpell(cid, "mizu hari")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn juken') and getPlayerLevel(cid) >= 100 then
doPlayerLearnInstantSpell(cid, "juken")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 54 and getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 55)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn hakke soshiken sho') and getPlayerLevel(cid) >= 150 then
doPlayerLearnInstantSpell(cid, "hakke soshiken sho")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn shugohakke rokujuyon sho') and getPlayerLevel(cid) >= 200 then
doPlayerLearnInstantSpell(cid, "shugohakke rokujuyon sho")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn juuho soshiken') and getPlayerLevel(cid) >= 250 then
doPlayerLearnInstantSpell(cid, "juuho soshiken")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 55 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 56)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())