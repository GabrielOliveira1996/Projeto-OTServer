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

if msgcontains(msg, 'teach') and getPlayerVocation(cid) == 37 or getPlayerVocation(cid) == 38 or getPlayerVocation(cid) == 39 or getPlayerVocation(cid) == 40 then
doPlayerSendTextMessage(cid, 27, "Para aprender algum jutsu fale 'learn nome do jutsu'.")
doPlayerSendTextMessage(cid, 27, "Kage Bunshin no Jutsu(Level 10)")
doPlayerSendTextMessage(cid, 27, "Naruto Rendan(Level 30)")
doPlayerSendTextMessage(cid, 27, "Kyuubi Form(Level 40)")
doPlayerSendTextMessage(cid, 27, "Rasengan(Level 50)")
doPlayerSendTextMessage(cid, 27, "Tajuu Kage Bunshin no Jutsu(Level 75)")
doPlayerSendTextMessage(cid, 27, "Kyuubi Form (Level 80) Não prescisa aprender.")
doPlayerSendTextMessage(cid, 27, "Oodama Rasengan(Level 80)")
doPlayerSendTextMessage(cid, 27, "Kyuubi Form (Level 120) Não prescisa aprender.")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Rasenshuriken(Level 250)")
doPlayerSendTextMessage(cid, 27, "Rasen shuriken(Level 300)")
doPlayerSendTextMessage(cid, 27, "Terceiro Treinamento(Level 300)")
end

if msgcontains(msg, 'learn kage bunshin no jutsu') and getPlayerLevel(cid) >= 10 then
doPlayerLearnInstantSpell(cid, "kage bunshin no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn naruto rendan') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "naruto rendan")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kyuubi form') and getPlayerLevel(cid) >= 40 then
doPlayerLearnInstantSpell(cid, "kyuubi form")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn rasengan') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "rasengan")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn tajuu kage bunshin no jutsu') and getPlayerLevel(cid) >= 75 then
doPlayerLearnInstantSpell(cid, "tajuu kage bunshin no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn oodama rasengan') and getPlayerLevel(cid) >= 80 then
doPlayerLearnInstantSpell(cid, "oodama rasengan")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 37 and getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 39)
setPlayerStorageValue(cid, 20002, 1)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn rasenshuriken') and getPlayerLevel(cid) >= 250 then
doPlayerLearnInstantSpell(cid, "rasenshuriken")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn rasen shuriken') and getPlayerLevel(cid) >= 300 then
doPlayerLearnInstantSpell(cid, "rasen shuriken")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 39 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 40)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())