local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function getActiveMission(cid)
    for id, config in pairs(DAIZOU_MISSIONS) do
        local s = getPlayerStorageValue(cid, config.storageStatus)
        if s == 1 or s == 2 then return id end
    end
    return 0
end

npcHandler:setCallback(CALLBACK_GREET, function(cid)
    local activeId = getActiveMission(cid)
    if activeId > 0 then
        npcHandler:setMessage(MESSAGE_GREET, "Voce ainda esta na missao {" .. DAIZOU_MISSIONS[activeId].name .. "}. Quer {entregar} ou {desistir}?")
    else
        local pts = math.max(0, getPlayerStorageValue(cid, PLAYER_PRESTIGE_POINTS))
        npcHandler:setMessage(MESSAGE_GREET, "Ola! Sou o Daizou. Voce tem " .. pts .. " pontos. Quer ver as {missoes}?")
    end
    talkState[cid] = 0
    return true
end)

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end
    local msg = msg:lower()
    local pPoints = math.max(0, getPlayerStorageValue(cid, PLAYER_PRESTIGE_POINTS))
    local activeId = getActiveMission(cid)

    -- 1. ENTREGA DE MISSÃO
    if activeId > 0 then
        local cfg = DAIZOU_MISSIONS[activeId]
        
        if msgcontains(msg, 'entregar') then
            -- Se NÃO tem itemId ou o ID é 0, checa o contador (Missions 1 e 4)
            if not cfg.itemId or cfg.itemId == 0 then 
                local progresso = getPlayerStorageValue(cid, cfg.storageCount)
                if progresso >= cfg.goalCount or getPlayerStorageValue(cid, cfg.storageStatus) == 2 then
                    npcHandler:say("Vejo que concluiu sua tarefa de " .. cfg.name .. "! Posso te dar a recompensa?", cid)
                    talkState[cid] = 1000
                else
                    npcHandler:say("Voce ainda nao terminou. Falta pouco! (" .. math.max(0, progresso) .. "/" .. cfg.goalCount .. ")", cid)
                end
            
            -- Se TEM itemId na LIB, checa o inventário (Missions 2, 3 e 5)
            else 
                if getPlayerItemCount(cid, cfg.itemId) >= cfg.goalCount then
                    npcHandler:say("Trouxe o que pedi (" .. cfg.name .. ")? Posso recolher?", cid)
                    talkState[cid] = 1000
                else
                    npcHandler:say("Voce ainda nao tem o item necessario. Volte quando tiver!", cid)
                end
            end

        elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) and talkState[cid] == 1000 then
            local canDeliver = false
            if not cfg.itemId or cfg.itemId == 0 then
                canDeliver = true -- Missão de matar/limpar
            elseif doPlayerRemoveItem(cid, cfg.itemId, cfg.goalCount) then
                canDeliver = true -- Missão de itens
            end

            if canDeliver then
                npcHandler:say(cfg.msgDone, cid)
                doPlayerAddItem(cid, cfg.rewardId, cfg.rewardCount)
                doPlayerAddExp(cid, cfg.experience)
                setPlayerStorageValue(cid, PLAYER_PRESTIGE_POINTS, pPoints + cfg.points)
                
                -- RESET DIÁRIO E LIMPEZA
                setPlayerStorageValue(cid, cfg.storageStatus, 0)
                setPlayerStorageValue(cid, cfg.storageCount, 0)
                setPlayerStorageValue(cid, cfg.storageTime, os.time() + 24 * 60 * 60)
                
                if doPlayerClearMapMarks then doPlayerClearMapMarks(cid) end
                talkState[cid] = 0
            else
                npcHandler:say("Ue, onde estao os itens?", cid)
                talkState[cid] = 0
            end
        end
        return true
    end

    -- 2. LISTAGEM DE MISSÕES
    if msgcontains(msg, 'missoes') or msgcontains(msg, 'missao') then
        local avail = {}
        for id, cfg in pairs(DAIZOU_MISSIONS) do
            local waitTime = getPlayerStorageValue(cid, cfg.storageTime)
            local status = getPlayerStorageValue(cid, cfg.storageStatus)

            if os.time() >= waitTime and status <= 0 and pPoints >= cfg.requiredPoints then
                table.insert(avail, "{" .. cfg.name .. "}")
            end
        end

        if #avail == 0 then
            npcHandler:say("Nao tenho tarefas para voce agora. Volte mais tarde!", cid)
        else
            npcHandler:say("Tenho estas: " .. table.concat(avail, ", ") .. ". Qual voce aceita?", cid)
            talkState[cid] = 10
        end

    elseif talkState[cid] == 10 then
        for id, cfg in pairs(DAIZOU_MISSIONS) do
            if msgcontains(msg, cfg.name:lower()) then
                npcHandler:say(cfg.msgStart, cid)
                talkState[cid] = id + 100
                return true
            end
        end

    -- 3. ACEITANDO A MISSÃO
    elseif (msgcontains(msg, 'yes') or msgcontains(msg, 'sim')) and talkState[cid] > 100 then
        local mId = talkState[cid] - 100
        local cfg = DAIZOU_MISSIONS[mId]
        
        setPlayerStorageValue(cid, cfg.storageStatus, 1)
        setPlayerStorageValue(cid, cfg.storageCount, 0)
        
        -- RESET DE SEGURANÇA (PONTOS DE CLIQUE)
        if mId == 1 then 
            for i = 15501, 15505 do setPlayerStorageValue(cid, i, 0) end
        elseif mId == 3 then 
            for i = 12032, 12035 do setPlayerStorageValue(cid, i, 0) end
        elseif mId == 4 or mId == 6 then
            setPlayerStorageValue(cid, cfg.storageCount, 0)
        end

        -- MARCAÇÃO DE MAPA
        if cfg.locations and #cfg.locations > 0 then
            local icon = cfg.mapMark or 11 
            for i = 1, #cfg.locations do
                doPlayerAddMapMark(cid, cfg.locations[i], icon, cfg.locations[i].name)
            end
            npcHandler:say("Marquei os pontos no mapa. Boa sorte!", cid)
        else
            npcHandler:say("Muito bem! Ficarei no aguardo.", cid)
        end
        
        talkState[cid] = 0
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())