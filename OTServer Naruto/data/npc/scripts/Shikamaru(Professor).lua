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

if msgcontains(msg, 'teach') and getPlayerVocation(cid) == 1 or getPlayerVocation(cid) == 2 or getPlayerVocation(cid) == 3 or getPlayerVocation(cid) == 4 then
doPlayerSendTextMessage(cid, 27, "Para aprender algum jutsu fale 'learn nome do jutsu'.")
doPlayerSendTextMessage(cid, 27, "Kage Mane No Jutsu(Level 10)")
doPlayerSendTextMessage(cid, 27, "Kage Kibaku Fuuda(Level 30)")
doPlayerSendTextMessage(cid, 27, "Primeiro Treinamento(Level 50)")
doPlayerSendTextMessage(cid, 27, "Kage Nui(Level 50)")
doPlayerSendTextMessage(cid, 27, "Kage Nui No Kimara(Level 80)")
doPlayerSendTextMessage(cid, 27, "Kage Mane No Sensha(Level 100)")
doPlayerSendTextMessage(cid, 27, "Kage Mane No Kibaru(Level 120)")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Kage No Kishashou(Level 150)")
doPlayerSendTextMessage(cid, 27, "Kage Kishabari No Jutsu(Level 200)")
doPlayerSendTextMessage(cid, 27, "Kage Mane No Yaiba(Level 250)")
doPlayerSendTextMessage(cid, 27, "Terceiro Treinamento(Level 300)")
end

if msgcontains(msg, 'learn kage mane no jutsu') and getPlayerLevel(cid) >= 10 then
doPlayerLearnInstantSpell(cid, "kage mane no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kage kibaku fuuda') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "kage kibaku fuuda")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'primeiro treinamento') and getPlayerVocation(cid) == 1 and getPlayerLevel(cid) >= 50 then
doPlayerSetVocation(cid, 2)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kage nui') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "kage nui")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kage nui no kimara') and getPlayerLevel(cid) >= 80 then
doPlayerLearnInstantSpell(cid, "kage nui no kimara")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn tajuu kage bunshin no jutsu') and getPlayerLevel(cid) >= 75 then
doPlayerLearnInstantSpell(cid, "tajuu kage bunshin no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kage mane no sensha') and getPlayerLevel(cid) >= 100 then
doPlayerLearnInstantSpell(cid, "kage mane no sensha")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kage mane no kibaru') and getPlayerLevel(cid) >= 120 then
doPlayerLearnInstantSpell(cid, "kage mane no kibaru")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 2 and getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 3)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kage no kishashou') and getPlayerLevel(cid) >= 150 then
doPlayerLearnInstantSpell(cid, "kage no kishashou")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kage kishabari no jutsu') and getPlayerLevel(cid) >= 200 then
doPlayerLearnInstantSpell(cid, "kage kishabari no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kage mane no yaiba') and getPlayerLevel(cid) >= 250 then
doPlayerLearnInstantSpell(cid, "kage mane no yaiba")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 3 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 4)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())