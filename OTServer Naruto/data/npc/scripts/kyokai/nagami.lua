local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

-- Garante que o Nagami sempre olhe para o SUL (2)
function onThink()
    local npc = getNpcId()
    if isCreature(npc) then
        doCreatureSetLookDir(npc, 2) -- 0: Norte, 1: Leste, 2: Sul, 3: Oeste
    end
    npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local msg = msg:lower()
    local questStatus = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)

    -- [DIÁLOGOS SOBRE ISAC E UTAKA]
    if msgcontains(msg, 'isac') or msgcontains(msg, 'utaka') then
        if questStatus < ISAC_STATUS_START then
            npcHandler:say("O Isac entende de laminas. Ele sempre mantem as dele afiadas, embora nunca as use na frente dos outros. O garoto Utaka? Ele ainda e muito jovem para o aco pesado.", cid)
        elseif questStatus == ISAC_STATUS_HERO or questStatus == ISAC_STATUS_COMPLETE then
            npcHandler:say("Fiquei sabendo do que voce fez na caverna. Gracas a voce, aquele garoto podera crescer e empunhar uma das minhas melhores espadas.", cid)
        elseif questStatus == ISAC_STATUS_ISAC_DEAD then
            npcHandler:say("Um shinobi sem seu mestre e como uma lamina sem fio. Espero que o Utaka encontre um novo caminho.", cid)
        elseif questStatus == ISAC_STATUS_UTAKA_DEAD then
            npcHandler:say("O Isac veio aqui comprar pedras de amolar. Ele nao disse uma palavra, mas o jeito que ele segurava a kunai... ele busca vinganca.", cid)
        elseif questStatus == ISAC_STATUS_BOTH_DEAD then
            npcHandler:say("A vila perdeu dois bons espiritos. Armas sao feitas para proteger a vida, mas as vezes elas falham.", cid)
        end
    
    elseif msgcontains(msg, 'arma') or msgcontains(msg, 'weapon') or msgcontains(msg, 'ferreiro') then
        npcHandler:say("Meu aco e forjado com o fogo das montanhas de Kyokai. Se voce quer sobreviver la fora, nao saia com as maos vazias.", cid)
    end

    return true
end

-- Mensagens de saudação e despedida (Seguras no LUA)
npcHandler:setMessage(MESSAGE_GREET, "O aco fala mais alto que as palavras nas estradas de Kyokai, shinobi. Precisa de laminas novas ou veio apenas olhar o brilho do meu metal?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Mantenha suas laminas afiadas e seus olhos abertos.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "O perigo nao espera os indecisos. Ate logo.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())