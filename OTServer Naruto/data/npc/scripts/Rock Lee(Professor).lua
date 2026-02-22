local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()
    local npcDir = 2 -- 0: Norte, 1: Leste, 2: Sul, 3: Oeste
    if getCreatureLookDirection(getNpcCid()) ~= npcDir then
        doCreatureSetLookDirection(getNpcCid(), npcDir)
    end
    npcHandler:onThink()
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
    return false
end

if msgcontains(msg, 'teach') and getPlayerVocation(cid) == 41 or getPlayerVocation(cid) == 42 or getPlayerVocation(cid) == 43 or getPlayerVocation(cid) == 44 then
doPlayerSendTextMessage(cid, 27, "Para aprender algum jutsu fale 'learn nome do jutsu'.")
doPlayerSendTextMessage(cid, 27, "Konoha Senpuu(Level 30)")
doPlayerSendTextMessage(cid, 27, "Open Gate(Level 40)")
doPlayerSendTextMessage(cid, 27, "Konoha Renpuu(Level 50)")
doPlayerSendTextMessage(cid, 27, "Konoha Dai Senpuu(Level 80)")
doPlayerSendTextMessage(cid, 27, "Omote Renge(Level 150)")
doPlayerSendTextMessage(cid, 27, "Treinamento Shippuden(Level 150)")
doPlayerSendTextMessage(cid, 27, "Ura Renge(Level 200)")
doPlayerSendTextMessage(cid, 27, "Reverse Lotus(Level 250)")
doPlayerSendTextMessage(cid, 27, "Terceiro Treinamento(Level 300)")
end

if msgcontains(msg, 'learn konoha senpuu') and getPlayerLevel(cid) >= 30 then
doPlayerLearnInstantSpell(cid, "konoha senpuu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn open gate') and getPlayerLevel(cid) >= 40 then
doPlayerLearnInstantSpell(cid, "open gate")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn konoha renpuu') and getPlayerLevel(cid) >= 50 then
doPlayerLearnInstantSpell(cid, "konoha renpuu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn konoha dai senpuu') and getPlayerLevel(cid) >= 80 then
doPlayerLearnInstantSpell(cid, "konoha dai senpuu")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn omote renge') and getPlayerLevel(cid) >= 150 then
doPlayerLearnInstantSpell(cid, "omote renge")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'treinamento shippuden') and getPlayerVocation(cid) == 41 and getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 43)
setPlayerStorageValue(cid, 20003, 1)
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn ura renge') and getPlayerLevel(cid) >= 200 then
doPlayerLearnInstantSpell(cid, "ura renge")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'learn reverse lotus') and getPlayerLevel(cid) >= 250 then
doPlayerLearnInstantSpell(cid, "reverse lotus")
doSendMagicEffect(getPlayerPosition(cid), 12)
end

if msgcontains(msg, 'terceiro treinamento') and getPlayerVocation(cid) == 43 and getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 44)
doSendMagicEffect(getPlayerPosition(cid), 12)
end
return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())