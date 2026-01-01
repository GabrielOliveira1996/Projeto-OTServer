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

if msgcontains(msg, 'teach') and getPlayerVocation(cid) == 57 or getPlayerVocation(cid) == 59 or getPlayerVocation(cid) == 60 or getPlayerVocation(cid) == 80 or getPlayerVocation(cid) == 93 or getPlayerVocation(cid) == 94 then
doPlayerSendTextMessage(cid, 27, "Para aprender algum jutsu fale 'learn nome do jutsu'.")
doPlayerSendTextMessage(cid, 27, "Kireme(Level 30)")
doPlayerSendTextMessage(cid, 27, "Sumi Nagashi(Level 50)")
doPlayerSendTextMessage(cid, 27, "Choju Giga(Level 70)")
doPlayerSendTextMessage(cid, 27, "Sumigasumi No Jutsu(Level 150)")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Choju Shoo(Level 200)")
doPlayerSendTextMessage(cid, 27, "Koshi Shoo No Tandan(Level 250)")
doPlayerSendTextMessage(cid, 27, "Terceiro Treinamento(Level 300)")
end

if msgcontains(msg, 'learn kireme') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "kireme")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn Sumi Nagashi') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "sumi nagashi")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn choju giga') and getPlayerLevel(cid) >= 70 then
doPlayerLearnInstantSpell(cid, "choju giga")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 57 and getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 59)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn sumigasumi no jutsu') and getPlayerLevel(cid) >= 150 then
doPlayerLearnInstantSpell(cid, "sumigasumi no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn choju shoo') and getPlayerLevel(cid) >= 200 then
doPlayerLearnInstantSpell(cid, "choju shoo")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn koshi shoo no tandan') and getPlayerLevel(cid) >= 250 then
doPlayerLearnInstantSpell(cid, "koshi shoo no tandan")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 59 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 60)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())