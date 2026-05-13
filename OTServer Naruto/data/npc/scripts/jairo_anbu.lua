local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

npcHandler.topic = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function greetCallback(cid)
    npcHandler:setMessage(MESSAGE_GREET, "Identifique-se, ninja! Estamos sob alerta maximo. Voce trouxe os {suprimentos} medicos que o Capitao Taito prometeu?")
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end
    local msg = msg:lower()

    local mID = getPlayerStorageValue(cid, TAITO_STORAGES.ACTIVE_MISSION)
    local prog = getPlayerStorageValue(cid, TAITO_STORAGES.MISSION_PROG)
    local mData = TAITO_MISSIONS[mID]

    if msgcontains(msg, 'suprimento') or msgcontains(msg, 'ervas') or msgcontains(msg, 'entrega') or msgcontains(msg, 'sim') then
        -- VALIDAÇÃO: Missão 2 e se o contato na Lib é 'jairo'
        if mID == 2 and mData and mData.contact == "jairo" then
            if prog < 1 then
                if doPlayerRemoveItem(cid, 2549, 1) then -- ID das Ervas
                    setPlayerStorageValue(cid, TAITO_STORAGES.MISSION_PROG, 1)
                    npcHandler:say("Ah, finalmente! Nossos medicos estavam esperando por essas ervas. Shizuka agradece sua ajuda. Reporte ao Capitao Taito que a entrega foi feita.", cid)
                    doSendMagicEffect(getCreaturePosition(cid), 13)
                else
                    npcHandler:say("O Capitao disse que voce traria ervas, mas nao as vejo com voce. Volte quando as tiver.", cid)
                end
            else
                npcHandler:say("Voce ja entregou a carga. Nao perca tempo aqui, reporte ao Taito!", cid)
            end
        else
            -- Resposta caso o player tente entregar o item da Missão 4 para o Jairo
            npcHandler:say("Eu nao sou o destinatario dessa entrega. Se voce tem um relatorio para Konoha, deve procurar o General Kendo.", cid)
        end
        return true
    end

    return true
end

function npcHandler:onWalkAway(cid)
    if not self:isFocused(cid) then return false end
    selfSay("Mantenha a guarda alta.")
    self:releaseFocus(cid)
    return true
end

npcHandler.messages[MESSAGE_WALKAWAY] = nil
npcHandler.messages[MESSAGE_FAREWELL] = nil

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())