local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

npcHandler.topic = {}

-- Configurações
local STORAGE_PRIMEIRA_VEZ = 110

-- 1. SILENCIA AS MENSAGENS INTERNAS PARA EVITAR DUPLICIDADE
npcHandler.messages[MESSAGE_WALKAWAY] = nil
npcHandler.messages[MESSAGE_FAREWELL] = nil

-- 2. FUNÇÃO DE DESPEDIDA (SOBRESCREVENDO A LIB)
function npcHandler:onWalkAway(cid)
    if not self:isFocused(cid) then return false end
    
    -- Usamos selfSay apenas na despedida para garantir que não bugue a aba de NPC
    selfSay("O Pais do Fogo ja foi um lugar quente e acolhedor... hoje, so restam cinzas e medo.")
    
    -- Limpa a mensagem de greet para não repetir ao sair
    self:setMessage(MESSAGE_GREET, nil)
    self.topic[cid] = 0
    self:releaseFocus(cid)
    return true
end

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function greetCallback(cid)
    local status = getPlayerStorageValue(cid, STORAGE_PRIMEIRA_VEZ)
    
    if status <= 0 then
        -- Define a mensagem na aba de NPC
        npcHandler:setMessage(MESSAGE_GREET, "Pare ai mesmo, viajante. Pelas suas vestes, voce parece novo nestas bandas... Voce tem nocao de onde esta se metendo ao seguir para o sul?")
        npcHandler.topic[cid] = 1
    else
        local randomDialogs = {
            "Mantenha os olhos abertos. Os membros da Kuroi Hasu sao perigosos.",
            "As patrulhas ANBU estao exaustas. Se a vila ao sudoeste cair, nada impedira o avanco deles.",
            "Triste epoca para ser um shinobi... lutando contra sombras em nossa propria casa."
        }
        npcHandler:setMessage(MESSAGE_GREET, randomDialogs[math.random(1, #randomDialogs)])
        npcHandler.topic[cid] = 0
    end
    
    return true -- Retornar true aqui faz a mensagem aparecer na ABA do NPC
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    -- KUROI HASU: Disponível sempre
    if msgcontains(msg, 'kuroi hasu') or msgcontains(msg, 'kuroi') or msgcontains(msg, 'hasu') then
        npcHandler:say("A Kuroi Hasu e uma organizacao anomala e cruel. Eles tentam oprimir os mais fracos e dominar as regioes do Pais do Fogo sob uma ideologia doente.", cid)
        return true
    end

    -- Lógica do Diálogo Inicial
    if npcHandler.topic[cid] == 1 then
        if msgcontains(msg, 'sim') or msgcontains(msg, 'sei') or msgcontains(msg, 'nao') or msgcontains(msg, 'não') then
            npcHandler:say("Escute bem... Para o {sudoeste} existe uma pequena vila que sobrevive sob o fio da navalha, em conflito constante com a Kuroi Hasu.", cid)
            npcHandler.topic[cid] = 2
        end
    elseif npcHandler.topic[cid] == 2 then
        npcHandler:say("O sul esta quase totalmente tomado por essa organizacao. O Pais do Fogo ja nao e mais o mesmo... E triste ver a situacao em que nos encontramos.", cid)
        setPlayerStorageValue(cid, STORAGE_PRIMEIRA_VEZ, 1)
        npcHandler.topic[cid] = 0
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())