local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
    return false
end

local talkUser = NPCHANDLER_CONVBEHAVIOR == CONVERSATION_DEFAULT and 0 or cid


local storageTazuna = 123456 -- storage que vai possibilitar de pegar outras vezes o tazuna


if msgcontains(msg, 'tazuna') and (#getCreatureSummons(cid) < 1) and getPlayerStorageValue(cid, storageTazuna) > -1 and getPlayerItemCount(cid, 2313) >= 1 then
    selfSay('Proteja-o.', cid)
    doConvinceCreature(cid, doSummonMonster(cid, 'tazuna'))
end

return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())