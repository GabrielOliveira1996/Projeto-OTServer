local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function clearMissionSummons(cid)
    local summons = getCreatureSummons(cid)
    local namesToRemove = {"Isac", "Utaka"}
    for _, summon in ipairs(summons or {}) do
        local sName = getCreatureName(summon)
        for _, targetName in ipairs(namesToRemove) do
            if sName == targetName then
                doSendMagicEffect(getThingPos(summon), 2)
                doRemoveCreature(summon)
            end
        end
    end
end

local function greetCallback(cid)
    local st = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)
    local read = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC_READ)
    
    npcHandler:setMessage(MESSAGE_FAREWELL, "Cumpra o objetivo. Dispensado.") 
    npcHandler:setMessage(MESSAGE_WALKAWAY, "Adeus.")

    -- [START AND PROGRESS]
    if st == -1 then
        npcHandler:say("Voce. Preciso de um voluntario para uma missao ao Norte. Enviamos um Jounin para a vila Kyokai no Mura e ele parou de nos enviar relatorios. Voce pode me {ajudar}?", cid)
    
    elseif st >= ISAC_STATUS_START and st <= 6 or st == 11 then
        npcHandler:say("Ainda em Konoha? Voce recebeu uma missao. Va para o Norte e encontre o Isac.", cid)
    
    -- [REACTIONS TO ENDINGS]
    elseif st == ISAC_STATUS_HERO then 
        clearMissionSummons(cid)
        npcHandler:say("Excelente trabalho! Estou muito feliz em ver que o Isac e o garoto retornaram vivos. Konoha agradece seu empenho exemplar. Tome isso como recompensa.", cid)
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC, ISAC_STATUS_COMPLETE)
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC_READ, 1)
        doPlayerAddItem(cid, 2160, 10) 
        doPlayerAddExp(cid, 1000000) 

    elseif st == ISAC_STATUS_ISAC_DEAD then 
        clearMissionSummons(cid)
        npcHandler:say("Entao o Isac... ele se foi? Lamento profundamente, ele era um grande amigo. Deixe o garoto comigo, eu cuidarei para que ele fique em seguranca. Voce fez o que pode.", cid)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Voce entregou Utaka aos cuidados de Shikaku.")
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC, ISAC_STATUS_COMPLETE)
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC_READ, 1)
        doPlayerAddItem(cid, 2160, 10)
        doPlayerAddExp(cid, 1000000)

    elseif st == ISAC_STATUS_UTAKA_DEAD then 
        clearMissionSummons(cid)
        npcHandler:say("Relatorio recebido. Uma pena que perdemos o garoto... Mas fico satisfeito que o Isac tenha retornado vivo. Ele precisara de tempo para se recuperar. Dispensado.", cid)
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC, ISAC_STATUS_COMPLETE)
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC_READ, 1)
        doPlayerAddItem(cid, 2160, 10)
        doPlayerAddExp(cid, 1000000)

    elseif st == ISAC_STATUS_BOTH_DEAD then 
        npcHandler:say("Entao todos morreram? Que lastima. Voce falhou em sua prioridade maxima. Saia da minha frente, preciso reorganizar as defesas do Norte.", cid)
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC, ISAC_STATUS_COMPLETE)
        setPlayerStorageValue(cid, STORAGE_MISSION_ISAC_READ, 1)
        doPlayerAddItem(cid, 2123, 1) 
        doPlayerAddItem(cid, 2160, 10)
        doPlayerAddExp(cid, 1000000)
        
    -- [POST-MISSION]
    elseif st == ISAC_STATUS_COMPLETE then
        if read == 1 then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Shikaku parece ocupado analisando novos relatorios de Konoha.")
            return false
        else
            npcHandler:say("O relatorio da missao ao Norte ja foi arquivado. Descanse para uma futura proxima tarefa.", cid)
        end
    end

    npcHandler:addFocus(cid)
    return false 
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end
    local st = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)

    if msgcontains(msg, 'missao') or msgcontains(msg, 'mission') or msgcontains(msg, 'ajudar') or msgcontains(msg, 'help') or msgcontains(msg, 'sim') or msgcontains(msg, 'yes') then
        if st == -1 then
            npcHandler:say("O nome dele e Isac. Ele conhece aquela regiao norte como ninguem. Encontre-o e descubra o que esta acontecendo.", cid)
            setPlayerStorageValue(cid, STORAGE_MISSION_ISAC, ISAC_STATUS_START)
        else
            npcHandler:say("O tempo e essencial. Parta imediatamente.", cid)
        end
    end
    return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())