local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

npcHandler.topic = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function greetCallback(cid)
    local joined = getPlayerStorageValue(cid, TAITO_STORAGES.JOINED)
    local pts = math.max(0, getPlayerStorageValue(cid, TAITO_STORAGES.RANK_POINTS))
    local rank = getRankName(pts)

    if joined <= 0 then
        npcHandler:setMessage(MESSAGE_GREET, "Aproxime-se. Sou o Capitao Taito. Minha tropa esta exausta e precisamos de ajuda. Voce parece habilidoso. Esta disposto a nos dar {suporte}?")
        npcHandler.topic[cid] = 1
    else
        npcHandler:setMessage(MESSAGE_GREET, "Lider de Esquadrao Taito reportando. Rank: {" .. rank .. "} (" .. pts .. " pts). [MODO TESTE]\nEscolha: {missao + numero} ou {entregar}?")
        npcHandler.topic[cid] = 10
    end
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end
    local msg = msg:lower()
    local pts = math.max(0, getPlayerStorageValue(cid, TAITO_STORAGES.RANK_POINTS))

    -- RESET DEBUG
    if msgcontains(msg, 'resetar') then
        setPlayerStorageValue(cid, TAITO_STORAGES.ACTIVE_MISSION, 0)
        setPlayerStorageValue(cid, TAITO_STORAGES.MISSION_PROG, 0)
        setPlayerStorageValue(cid, TAITO_STORAGES.DAILY_LIMIT, 0)
        npcHandler:say("Storages resetadas.", cid)
        return true
    end

    -- ALISTAMENTO
    if npcHandler.topic[cid] == 1 and msgcontains(msg, 'suporte') then
        npcHandler:say("Agradeco a coragem. Pronto para sua primeira {missao}?", cid)
        setPlayerStorageValue(cid, TAITO_STORAGES.JOINED, 1)
        npcHandler.topic[cid] = 10

    -- SELEÇÃO DE MISSÃO
    elseif npcHandler.topic[cid] == 10 and msgcontains(msg, 'missao') then
        local mIndex = tonumber(msg:match("%d+"))
        if mIndex and TAITO_MISSIONS[mIndex] then
            local mData = TAITO_MISSIONS[mIndex]
            npcHandler:say("Missao " .. mIndex .. ": {" .. mData.name .. "}. " .. mData.desc .. " {Aceita}?", cid)
            npcHandler.tempMission = mIndex
            npcHandler.topic[cid] = 11
        else
            npcHandler:say("Diga 'missao' seguido do numero.", cid)
        end

    -- ACEITANDO
    elseif npcHandler.topic[cid] == 11 and msgcontains(msg, 'aceita') then
        local mID = npcHandler.tempMission
        setPlayerStorageValue(cid, TAITO_STORAGES.ACTIVE_MISSION, mID)
        setPlayerStorageValue(cid, TAITO_STORAGES.MISSION_PROG, 0)
        
        if TAITO_MISSIONS[mID].item then
            doPlayerAddItem(cid, TAITO_MISSIONS[mID].item, 1)
            npcHandler:say("Tome o item necessario. Boa sorte.", cid)
        else
            npcHandler:say("Entendido. Parta imediatamente.", cid)
        end
        npcHandler.topic[cid] = 0

    -- ENTREGANDO
    elseif msgcontains(msg, 'entregar') then
        local mID = getPlayerStorageValue(cid, TAITO_STORAGES.ACTIVE_MISSION)
        if mID <= 0 then
            npcHandler:say("Voce nao tem uma missao ativa.", cid)
            return true
        end

        local mData = TAITO_MISSIONS[mID]
        local ready = false
        
        if mData.type == "npc_delivery" or mData.type == "pos" then
            if getPlayerStorageValue(cid, TAITO_STORAGES.MISSION_PROG) >= 1 then ready = true 
            else npcHandler:say("O objetivo ainda nao foi cumprido no local ou com o contato.", cid) return true end

        elseif mData.goal and mData.target then
            local current = getPlayerStorageValue(cid, TAITO_STORAGES.MISSION_PROG)
            if current >= mData.goal then ready = true 
            else npcHandler:say("Incompleto: " .. current .. "/" .. mData.goal .. " alvos.", cid) return true end
        
        elseif mData.item and (not mData.type or mData.type == "") then
            if doPlayerRemoveItem(cid, mData.item, 1) then ready = true 
            else npcHandler:say("Cade o item da missao?", cid) return true end
        end

        if ready then
            npcHandler:say("Excelente trabalho. Aqui esta sua recompensa.", cid)
            
            -- ENTREGA DE RECOMPENSAS DA LIB
            doPlayerAddExperience(cid, mData.points * 1000)
            
            if mData.rewards then
                for _, reward in pairs(mData.rewards) do
                    doPlayerAddItem(cid, reward[1], reward[2])
                end
            end

            setPlayerStorageValue(cid, TAITO_STORAGES.RANK_POINTS, pts + mData.points)
            setPlayerStorageValue(cid, TAITO_STORAGES.ACTIVE_MISSION, 0)
            setPlayerStorageValue(cid, TAITO_STORAGES.MISSION_PROG, 0)
            setPlayerStorageValue(cid, TAITO_STORAGES.DAILY_LIMIT, 0)
        end
        npcHandler.topic[cid] = 0
    end

    return true
end

function npcHandler:onWalkAway(cid)
    if not self:isFocused(cid) then return false end
    selfSay("Pelos que cairam, nos ficaremos de pe.")
    self:releaseFocus(cid)
    return true
end

npcHandler.messages[MESSAGE_WALKAWAY] = nil
npcHandler.messages[MESSAGE_FAREWELL] = nil

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:addModule(FocusModule:new())