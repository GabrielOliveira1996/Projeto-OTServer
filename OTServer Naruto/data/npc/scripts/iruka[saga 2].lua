local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

-- silencio ao afastar
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

-- saudacao dinamica baseada no progresso
function onGreet(cid)
    local storageVenceuMizuki = 11113
    local storageJaGanhouBandana = 11114

    if getPlayerStorageValue(cid, storageJaGanhouBandana) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Va agora, Genin! Seu futuro como ninja apenas comecou.")
    elseif getPlayerStorageValue(cid, storageVenceuMizuki) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Voce conseguiu, " .. getCreatureName(cid) .. "! Voce protegeu o pergaminho e salvou minha vida. Aproxime-se, voce agora e um {Genin}.")
    else
        npcHandler:setMessage(MESSAGE_GREET, "O que faz nesta floresta? Volte para Konoha.")
    end

    npcHandler:addFocus(cid)
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local storagelose = 11113 -- Storage que indica vitoria sobre Mizuki
    local storageGain = 11114 -- Proxima fase da saga
    local storageBandana = 1000 -- Storage da missao/bandana
    local expBonus = 2000 -- aumentado para 2000 conforme sua tabela inicial

    if msgcontains(msg, 'genin') then
        -- 1. verifica se o player derrotou o Mizuki e busca a recompensa
        if getPlayerStorageValue(cid, storagelose) >= 1 then
            selfSay('Sim, voce demonstrou coragem e aprendeu um jutsu poderoso para proteger seus companheiros. Parabens, voce agora e oficialmente um Genin de Konoha!', cid)
            
            setPlayerStorageValue(cid, storagelose, -1)
            setPlayerStorageValue(cid, storageGain, 1)
            setPlayerStorageValue(cid, storageBandana, 1)
            doPlayerAddExp(cid, expBonus)
            doSendMagicEffect(getThingPos(cid), 2) -- efeito de brilho/sucesso
            
        -- 2. se ja tiver recebido
        elseif getPlayerStorageValue(cid, storageGain) >= 1 then
            selfSay('Va descansar, voce agora tem uma longa jornada pela frente.', cid)
        
        -- 3. ignora se nao tiver a storage
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