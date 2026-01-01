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

if msgcontains(msg, 'teach') and getPlayerVocation(cid) == 17 or getPlayerVocation(cid) == 18 or getPlayerVocation(cid) == 19 or getPlayerVocation(cid) == 20 then
doPlayerSendTextMessage(cid, 27, "Para aprender algum jutsu fale 'learn nome do jutsu'.")
doPlayerSendTextMessage(cid, 27, "Insetos")
doPlayerSendTextMessage(cid, 27, "Kikaichuu No Jutsu(Level 10)")
doPlayerSendTextMessage(cid, 27, "Jutsus")
doPlayerSendTextMessage(cid, 27, "Shunshin No Jutsu(Level 30)")
doPlayerSendTextMessage(cid, 27, "Kikai Sabaki No Jutsu(Level 50)")
doPlayerSendTextMessage(cid, 27, "Suzumebachi Tei(Level 100)")
doPlayerSendTextMessage(cid, 27, "Kikai Shunshin Tei(Level 150)")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Kikaichu Shokachu(Level 200)")
doPlayerSendTextMessage(cid, 27, "Terceiro Treinamento(Level 300)")
end

if msgcontains(msg, 'learn kikaichuu no jutsu') and getPlayerLevel(cid) >= 10 then
doPlayerLearnInstantSpell(cid, "kikaichuu no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn shunshin no jutsu') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "shunshin no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kikai sabaki no jutsu') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "kikai sabaki no jutsu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'primeiro treinamento') and getPlayerVocation(cid) == 17 and getPlayerLevel(cid) >= 50 then
doPlayerSetVocation(cid, 18)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn suzumebachi tei') and getPlayerLevel(cid) >= 100 then
doPlayerLearnInstantSpell(cid, "suzumebachi tei")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kikai shunshin tei') and getPlayerLevel(cid) >= 150 then
doPlayerLearnInstantSpell(cid, "kikai shunshin tei")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 18 and getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 19)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn kikaichu shokachu') and getPlayerLevel(cid) >= 200 then
doPlayerLearnInstantSpell(cid, "kikaichu shokachu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 19 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 20)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())