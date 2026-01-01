local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

-- MODIFICACAO NO ONTHINK: Silencio ao afastar
function onThink() 
    if npcHandler:isFocused(cid) then
        local coords = getCreaturePosition(cid)
        local myCoords = getCreaturePosition(getSelf())
        if (getDistanceBetween(coords, myCoords) > 4) then
            npcHandler:releaseFocus(cid)
        end
    end
    npcHandler:onThink() 
end

-- Saudacao Dinamica
function onGreet(cid)
    local storageFaseAtual = 11110 -- Storage de quem falhou no Iruka
    local storageProximaFase = 11111 -- Storage de quem ja aceitou roubar o pergaminho

    if getPlayerStorageValue(cid, storageProximaFase) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "O que ainda faz aqui? Va buscar o pergaminho no predio principal antes que alguem perceba!")
    elseif getPlayerStorageValue(cid, storageFaseAtual) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Ei " .. getCreatureName(cid) .. "... Eu vi o que aconteceu. O Iruka e muito rigoroso, nao acha? Se quiser virar um Genin de verdade, eu posso te ajudar. Quer {ajuda}?")
    else
        -- Para jogadores sem missao, ele da um oi generico e nao libera o 'talk'
        npcHandler:setMessage(MESSAGE_GREET, "Ola. Agora estou ocupado, volte mais tarde.")
    end

    npcHandler:addFocus(cid)
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local storagelose = 11110 -- Precisa desta para falar
    local storageGain = 11111 -- Ganha esta ao aceitar
    local var = 2000 -- Experiencia

    if msgcontains(msg, 'ajuda') then
        -- 1. Verifica se o jogador acabou de falhar no teste do Iruka
        if getPlayerStorageValue(cid, storagelose) >= 1 then
            selfSay('Escute bem... Existe um pergaminho com um jutsu muito poderoso no predio principal de Konoha. Ele contem jutsus proibidos que vao te dar o poder necessario para ser aprovado. Va, pegue o pergaminho e me encontre na floresta!', cid)
            
            setPlayerStorageValue(cid, storagelose, -1)
            setPlayerStorageValue(cid, storageGain, 1)
            doPlayerAddExp(cid, var)
            doSendMagicEffect(getThingPos(cid), 14) -- Efeito de "conspiracao/sombra"
            
        -- 2. Verifica se ele ja aceitou a missao
        elseif getPlayerStorageValue(cid, storageGain) >= 1 then
            selfSay('Va logo! O pergaminho nao vai sair de la sozinho.', cid)
            
        -- 3. Se nao tiver a missao, o NPC ignora a palavra chave
        else
            return false
        end
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Limpeza de mensagens de sistema
npcHandler.messages[MESSAGE_FAREWELL] = ""
npcHandler.messages[MESSAGE_WALKAWAY] = ""

npcHandler:addModule(FocusModule:new())