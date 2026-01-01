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

if msgcontains(msg, 'teach') and getPlayerVocation(cid) == 33 or getPlayerVocation(cid) == 34 or getPlayerVocation(cid) == 35 or getPlayerVocation(cid) == 36 then
doPlayerSendTextMessage(cid, 27, "Para aprender algum jutsu fale 'learn nome do jutsu'.")
doPlayerSendTextMessage(cid, 27, "Katon Goukakyu no Jutsu(Level 30)")
doPlayerSendTextMessage(cid, 27, "Cursed Seal(Level 40)")
doPlayerSendTextMessage(cid, 27, "Chidori(Level 50)")
doPlayerSendTextMessage(cid, 27, "Katon Hiraji(Level 100)")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Chidori Nagashi(Level 150)")
doPlayerSendTextMessage(cid, 27, "Katon Ryuuka(Level 200)")
doPlayerSendTextMessage(cid, 27, "Kirin(Level 250)")
doPlayerSendTextMessage(cid, 27, "Manguekyo Sharingan(Level 300)")
doPlayerSendTextMessage(cid, 27, "Amaterasu(Level 300)")
doPlayerSendTextMessage(cid, 27, "Susanoo(Level 300)")
doPlayerSendTextMessage(cid, 27, "Terceiro Treinamento(Level 300)")
end

if msgcontains(msg, 'learn katon goukakyu no jutsu') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "katon goukakyu no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn cursed seal') and getPlayerLevel(cid) >= 40 then
doPlayerLearnInstantSpell(cid, "cursed seal")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn chidori') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "chidori")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn katon hiraji') and getPlayerLevel(cid) >= 100 then
doPlayerLearnInstantSpell(cid, "katon hiraji")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn chidori nagashi') and getPlayerLevel(cid) >= 150 then
doPlayerLearnInstantSpell(cid, "chidori nagashi")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 33 and getPlayerLevel(cid) >= 150 then
setPlayerStorageValue(cid, 20001, 1)
doPlayerSetVocation(cid, 35)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn katon ryuuka') and getPlayerLevel(cid) >= 200 then
doPlayerLearnInstantSpell(cid, "katon ryuuka")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kirin') and getPlayerLevel(cid) >= 250 then
doPlayerLearnInstantSpell(cid, "kirin")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn manguekyo sharingan') and getPlayerLevel(cid) >= 300 then
doPlayerLearnInstantSpell(cid, "manguekyo sharingan")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn amaterasu') and getPlayerLevel(cid) >= 300 then
doPlayerLearnInstantSpell(cid, "amaterasu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn susanoo') and getPlayerLevel(cid) >= 300 then
doPlayerLearnInstantSpell(cid, "susanoo")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 35 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 36)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())