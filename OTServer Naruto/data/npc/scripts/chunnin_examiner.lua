local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

-- Esta função roda a cada 1 ou 2 segundos (dependendo do seu server)
function onThink()
    local npcDir = 2 -- 0: Norte, 1: Leste, 2: Sul, 3: Oeste
    
    -- forçar o NPC a olhar para o Sul sempre
    if getCreatureLookDirection(getNpcCid()) ~= npcDir then
        doCreatureSetLookDirection(getNpcCid(), npcDir)
    end

    npcHandler:onThink()
end

-- desativa a função de virar para o jogador ao ser cumprimentado
npcHandler.focusDirection = false 

npcHandler:addModule(FocusModule:new())