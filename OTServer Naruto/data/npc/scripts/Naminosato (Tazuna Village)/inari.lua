local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) 
    -- O Inari ignora saudações e não entra em foco privado
    if msgcontains(msg, 'hi') or msgcontains(msg, 'ola') then
        --selfSay("Me deixem em paz...") 
        return false
    end
    return npcHandler:onCreatureSay(cid, type, msg) 
end
function onThink() npcHandler:onThink() end

-- Inari não possui keywords, ele apenas reage ao Tazuna
npcHandler:addModule(FocusModule:new())