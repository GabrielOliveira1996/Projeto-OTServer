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

if msgcontains(msg, 'teach') and getPlayerVocation(cid) == 76 or getPlayerVocation(cid) == 77 or getPlayerVocation(cid) == 78 or getPlayerVocation(cid) == 79 then
doPlayerSendTextMessage(cid, 27, "Para aprender algum jutsu fale 'learn nome do jutsu'.")
doPlayerSendTextMessage(cid, 27, "Dai Shoo No Me(Level 30)")
doPlayerSendTextMessage(cid, 27, "Dai Senkai(Level 50)")
doPlayerSendTextMessage(cid, 27, "Primeiro Treinamento(Level 50)")
doPlayerSendTextMessage(cid, 27, "Sou Shuu Jin(Level 70)")
doPlayerSendTextMessage(cid, 27, "Shou Shuu Destruction(Level 130)")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Nekate Shuu Deki(Level 170)")
doPlayerSendTextMessage(cid, 27, "Sou Choju Shuu(Level 220)")
doPlayerSendTextMessage(cid, 27, "Terceiro Treinamento(Level 300)")
end

if msgcontains(msg, 'learn dai shoo no me') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "dai shoo no me")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn dai senkai') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "dai senkai")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'primeiro treinamento') and getPlayerVocation(cid) == 76 and getPlayerLevel(cid) >= 50 then
doPlayerSetVocation(cid, 77)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn sou shuu jin') and getPlayerLevel(cid) >= 70 then
doPlayerLearnInstantSpell(cid, "sou shuu jin")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn shou shuu destruction') and getPlayerLevel(cid) >= 130 then
doPlayerLearnInstantSpell(cid, "shou shuu destruction")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 77 and getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 78)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn nekate shuu deki') and getPlayerLevel(cid) >= 170 then
doPlayerLearnInstantSpell(cid, "nekate shuu deki")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn sou choju shuu') and getPlayerLevel(cid) >= 220 then
doPlayerLearnInstantSpell(cid, "sou choju shuu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 78 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 79)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())