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

-- Saudacao Dinamica baseada no progresso
function onGreet(cid)
    local playerName = getCreatureName(cid)
    local fotoPendente = 11115
    local fotoEntregue = 11116
    local prontoParaMissao = 11119

    if getPlayerStorageValue(cid, prontoParaMissao) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Ola " .. playerName .. ". Voce esta pronto para sua {first mission}?")
    elseif getPlayerStorageValue(cid, fotoEntregue) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Sua foto ja foi registrada. Va encontrar sua equipe.")
    elseif getPlayerStorageValue(cid, fotoPendente) >= 1 then
        -- FALA CORRIGIDA: Ele apenas reclama da foto e diz que nao aceita.
        npcHandler:setMessage(MESSAGE_GREET, playerName .. "! Que foto de registro ridicula e essa? Voce pintou o rosto e fez caretas! Eu jamais aceitaria um documento oficial desse jeito! {orioke no jutsu}")
    else
        npcHandler:setMessage(MESSAGE_GREET, "O que quer aqui? Estou ocupado com os assuntos da vila.")
    end

    npcHandler:addFocus(cid)
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    -- Storages da Foto
    local storagelose1 = 11115 
    local storageGain1 = 11116 
    local experienciaFotografia = 6000

    -- Storages da Primeira Missao -Tazuna
    local storagelose2 = 11119 
    local storageGain2 = 11120 
    local storageTazuna = 123456 

    -- PARTE 1: Entrega da Foto
    if msgcontains(msg, 'orioke no jutsu') then
        if getPlayerStorageValue(cid, storagelose1) >= 1 then
            selfSay('MAS O QUE?! Pare com essa tecnica ridicula agora mesmo! *cof cof*... Que audacia a sua me pegar desprevenido... Esta bem, eu registro essa foto so para voce sair da minha sala!', cid)
            setPlayerStorageValue(cid, storagelose1, -1)
            setPlayerStorageValue(cid, storageGain1, 1)
            doPlayerAddExp(cid, experienciaFotografia)
            doSendMagicEffect(getThingPos(cid), 2)
        else
            return false
        end

    -- PARTE 2: Primeira Missao - zabuza e tazuna
    elseif msgcontains(msg, 'first mission') then
        if getPlayerStorageValue(cid, storagelose2) >= 1 then
            selfSay('Sua missao sera escoltar um construtor de pontes. Va e encontre um homem chamado Tazuna, voce tera que escoltar ele ate o Pais das Ondas.', cid)
            setPlayerStorageValue(cid, storagelose2, -1)
            setPlayerStorageValue(cid, storageGain2, 1)
            setPlayerStorageValue(cid, storageTazuna, 1)
        else
            return false
        end
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

-- Garante o silencio ao sair
npcHandler.messages[MESSAGE_FAREWELL] = ""
npcHandler.messages[MESSAGE_WALKAWAY] = ""

npcHandler:addModule(FocusModule:new())