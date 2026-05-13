local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

npcHandler.topic = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function greetCallback(cid)
    npcHandler:setMessage(MESSAGE_GREET, "Saudações, soldado. Konoha está sob vigilância constante. Você traz o {relatorio} do Capitão Taito?")
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end
    local msg = msg:lower()

    local mID = getPlayerStorageValue(cid, TAITO_STORAGES.ACTIVE_MISSION)
    local prog = getPlayerStorageValue(cid, TAITO_STORAGES.MISSION_PROG)
    local mData = TAITO_MISSIONS[mID]

    if msgcontains(msg, 'relatorio') or msgcontains(msg, 'entrega') or msgcontains(msg, 'sim') then
        if mID == 4 and mData.type == "npc_delivery" and mData.contact == "kendo" then
            if prog < 1 then
                if doPlayerRemoveItem(cid, 1952, 1) then 
                    setPlayerStorageValue(cid, TAITO_STORAGES.MISSION_PROG, 1)
                    npcHandler:say("Excelente. Esse relatório sobre a Kuroi Hasu é vital para nossa estratégia. Taito fez bem em enviar você. Volte a Shizuka e informe que recebi a mensagem.", cid)
                    doSendMagicEffect(getCreaturePosition(cid), 27) 
                else
                    npcHandler:say("Você diz que tem o relatório, mas suas mãos estão vazias. Volte quando tiver o documento em mãos.", cid)
                end
            else
                npcHandler:say("Você já me entregou os documentos. Não perca tempo, retorne ao seu posto!", cid)
            end
        else
            npcHandler:say("Estou ocupado agora, volte em outro momento.", cid)
        end
        return true
    end

    return true
end

npcHandler.messages[MESSAGE_WALKAWAY] = nil
npcHandler.messages[MESSAGE_FAREWELL] = nil
function npcHandler:onWalkAway(cid)
    if not self:isFocused(cid) then return false end
    selfSay("Pela vontade do fogo!")
    self:releaseFocus(cid)
    return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())