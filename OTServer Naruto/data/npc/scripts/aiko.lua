local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

npcHandler.topic = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local ST_PEDRA_ALTAR = 1060

function npcHandler:onWalkAway(cid)
    if not self:isFocused(cid) then return false end
    selfSay("Cuidado la fora... nao vire apenas mais uma pedra naquele altar.")
    self:releaseFocus(cid)
    return true
end

function greetCallback(cid)
    local p_status = getPlayerStorageValue(cid, ST_PEDRA_ALTAR)

    if p_status == 0 then
        npcHandler:setMessage(MESSAGE_GREET, "Voce... voce voltou! Vi que retirou sua pedra do altar. Fico tao feliz por voce... quem sabe o proximo a retirar a pedra nao seja o meu {pai}?")
    elseif p_status == 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Sua pedra ja esta la, eu vi. Va com cuidado. Estarei rezando para que voce volte logo para {buscala}.")
    else
        npcHandler:setMessage(MESSAGE_GREET, "Oi... Voce tambem veio deixar uma {pedra} no altar antes de partir?")
    end
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end
    local msg = msg:lower()
    local npcObj = getNpcCid()
    local p_status = getPlayerStorageValue(cid, ST_PEDRA_ALTAR)

    if msgcontains(msg, 'pedra') or msgcontains(msg, 'buscar') or msgcontains(msg, 'pai') or msgcontains(msg, 'altar') or msgcontains(msg, 'despedida') then
        
        if p_status == 1 then
            npcHandler:say("Nao se preocupe com sua marca. Eu cuidarei para que nada aconteca enquanto voce estiver fora.", cid)
        else
            npcHandler:say("Este e a Fonte da Despedida. Todos os ninjas que vao lutar contra a Kuroi Hasu deixam uma pedra com seu nome gravado aqui.", cid)
            
            addEvent(function()
                if isPlayer(cid) and isCreature(npcObj) and npcHandler:isFocused(cid) then
                    doCreatureSay(npcObj, "Se eles voltam, eles retiram a pedra. Mas olhe so... existem centenas acumuladas. Quase ninguem volta para buscar a sua.", TALKTYPE_PRIVATE_NP, false, cid)
                end
            end, 4000)
            
            addEvent(function()
                if isPlayer(cid) and isCreature(npcObj) and npcHandler:isFocused(cid) then
                    doCreatureSay(npcObj, "O meu pai... ele partiu faz tres meses. A pedra dele ainda esta ali. Eu venho todos os dias ver se ele ja a retirou, mas ela continua la.", TALKTYPE_PRIVATE_NP, false, cid)
                end
            end, 9000)
        end
        return true
    end

    return true
end

npcHandler.messages[MESSAGE_WALKAWAY] = nil
npcHandler.messages[MESSAGE_FAREWELL] = nil

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())