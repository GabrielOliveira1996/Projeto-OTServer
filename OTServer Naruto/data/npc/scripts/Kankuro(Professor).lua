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

if msgcontains(msg, 'teach') and getPlayerVocation(cid) == 21 or getPlayerVocation(cid) == 22 or getPlayerVocation(cid) == 23 or getPlayerVocation(cid) == 24 then
doPlayerSendTextMessage(cid, 27, "Para aprender algum jutsu fale 'learn nome do jutsu'.")
doPlayerSendTextMessage(cid, 27, "Bonecos")
doPlayerSendTextMessage(cid, 27, "Karasu(Level 10)")
doPlayerSendTextMessage(cid, 27, "Kuroari(Level 30)")
doPlayerSendTextMessage(cid, 27, "Sanshouou(Level 120)")
doPlayerSendTextMessage(cid, 27, "Jutsus")
doPlayerSendTextMessage(cid, 27, "Doku(Level 30)")
doPlayerSendTextMessage(cid, 27, "Doku Natsu(Level 50)")
doPlayerSendTextMessage(cid, 27, "Primeiro Treinamento(Level 50)")
doPlayerSendTextMessage(cid, 27, "Doku Kenjin(Level 80)")
doPlayerSendTextMessage(cid, 27, "Toxic(Level 100)")
doPlayerSendTextMessage(cid, 27, "Dokungiri Zuyoku(Level 150)")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Doku Katsuko Hikiri(Level 200)")
doPlayerSendTextMessage(cid, 27, "Doku Natsu Hikiri(Level 250)")
doPlayerSendTextMessage(cid, 27, "Terceiro Treinamento(Level 300)")
end

if msgcontains(msg, 'learn karasu') and getPlayerLevel(cid) >= 10 then
doPlayerLearnInstantSpell(cid, "karasu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kuroari') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "kuroari")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn doku') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "doku")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn doku natsu') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "doku natsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'primeiro treinamento') and getPlayerVocation(cid) == 21 and getPlayerLevel(cid) >= 50 then
doPlayerSetVocation(cid, 22)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn doku kenjin') and getPlayerLevel(cid) >= 80 then
doPlayerLearnInstantSpell(cid, "doku kenjin")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn toxic') and getPlayerLevel(cid) >= 100 then
doPlayerLearnInstantSpell(cid, "toxic")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn sanshouou') and getPlayerLevel(cid) >= 120 then
doPlayerLearnInstantSpell(cid, "sanshouou")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn dokungiri zuyoku') and getPlayerLevel(cid) >= 150 then
doPlayerLearnInstantSpell(cid, "dokungiri zuyoku")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 22 and getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 23)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn doku katsuko hikiri') and getPlayerLevel(cid) >= 200 then
doPlayerLearnInstantSpell(cid, "ouka sho")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn sasori') and getPlayerLevel(cid) >= 200 then
doPlayerLearnInstantSpell(cid, "sasori")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn doku natsu hikiri') and getPlayerLevel(cid) >= 250 then
doPlayerLearnInstantSpell(cid, "ouka sho")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 23 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 24)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())