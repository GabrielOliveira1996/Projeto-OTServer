-- CONFIGURAÇÕES
local SKILL_CHAKRA = 6 -- ID da skill Fishing
local TREES_IDS = {4038, 4040, 4039, 4037} 
local MANA_PER_TICK = 30
local SKILL_TRY_AMOUNT = 1 
local TICK_INTERVAL = 2000 
local SAGA_STORAGE = 11000

if not KinoboriTrain then KinoboriTrain = {} end

local function doKinoboriTick(cid, lastX, lastY, lastZ)
    -- Verifica se o player ainda existe e se o treino não foi cancelado
    if not isPlayer(cid) or not KinoboriTrain[cid] then 
        return false 
    end

    local currentPos = getCreaturePosition(cid)
    
    -- COMPARAÇÃO ABSOLUTA
    if currentPos.x ~= lastX or currentPos.y ~= lastY or currentPos.z ~= lastZ then
        doCreatureSay(cid, "Minha concentracao quebrou!", TALKTYPE_SAY)
        KinoboriTrain[cid] = nil
        return false
    end

    local targetPos = getPosByDir(currentPos, getCreatureLookDirection(cid))
    local targetItem = getThingfromPos(targetPos)

    -- Verifica Mana
    if getPlayerMana(cid) < MANA_PER_TICK then
        doCreatureSay(cid, "Estou sem chakra...", TALKTYPE_SAY)
        KinoboriTrain[cid] = nil
        doSendMagicEffect(currentPos, 2)
        return false
    end

    -- Verifica se ainda está olhando para a árvore
    if not isInArray(TREES_IDS, targetItem.itemid) then
        doCreatureSay(cid, "Perdi o contato com a arvore!", TALKTYPE_SAY)
        KinoboriTrain[cid] = nil
        return false
    end

    -- Execução do Treino
    doPlayerAddMana(cid, -MANA_PER_TICK)
    doPlayerAddSkillTry(cid, SKILL_CHAKRA, SKILL_TRY_AMOUNT)
    doSendMagicEffect(targetPos, 3) 

    -- [LOGICA DE CONCLUSÃO DA ETAPA]
    if getPlayerStorageValue(cid, SAGA_STORAGE) == SAGA_STAGE_CLIMP_THE_TREE then
        local currentSkill = getPlayerSkillLevel(cid, SKILL_CHAKRA)
        
        -- Conclui a saga ao atingir nível 15 de Controle de Chakra
        if currentSkill >= 15 then
            KinoboriTrain[cid] = nil 
            setPlayerStorageValue(cid, SAGA_STORAGE, SAGA_STAGE_PROTECT_THE_TAZUNA_ON_THE_BRIDGE)
            doPlayerAddSkill(cid, SKILL_CHAKRA, 10) -- Recompensa
            
            doCreatureSay(cid, "Eu consegui! Finalmente tenho controle sobre o meu chakra!", TALKTYPE_SAY)
            doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Saga Atualizada: Voce dominou o Kinobori! Tazuna esta indo para a ponte, va protege-lo!")
            return false
        end
    end
    
    -- Mensagens aleatórias durante o treino
    local esforco = math.random(1, 10)
    if esforco == 1 then
        doCreatureSay(cid, "Concentrar... concentrar...", TALKTYPE_MONSTER_SAY)
    elseif esforco == 2 then
        doCreatureSay(cid, "Quase la!", TALKTYPE_MONSTER_SAY)
    end

    -- Agenda o próximo ciclo
    addEvent(doKinoboriTick, TICK_INTERVAL, cid, lastX, lastY, lastZ)
end

function onCastSpell(cid, var)
    -- Verifica se o player já passou da fase de receber a instrução do Kakashi
    if getPlayerStorageValue(cid, SAGA_STORAGE) < SAGA_STAGE_CLIMP_THE_TREE then
        doPlayerSendCancel(cid, "Voce ainda nao recebeu instrucoes do Kakashi.")
        return false
    end

    -- Toggle: Se já estiver treinando, desliga
    if KinoboriTrain[cid] then
        KinoboriTrain[cid] = nil
        doCreatureSay(cid, "Vou dar uma pausa.", TALKTYPE_SAY)
        return false
    end

    -- Verifica se está de frente para a árvore
    local pPos = getCreaturePosition(cid)
    local targetPos = getPosByDir(pPos, getCreatureLookDirection(cid))
    local targetItem = getThingfromPos(targetPos)

    if not isInArray(TREES_IDS, targetItem.itemid) then
        doPlayerSendCancel(cid, "Fique de frente para uma arvore para iniciar o treinamento.")
        return false
    end

    -- Inicia o estado de treinamento
    KinoboriTrain[cid] = true
    doCreatureSay(cid, "Kinobori no Jutsu!", TALKTYPE_SAY)
    
    addEvent(function()
        if isPlayer(cid) and KinoboriTrain[cid] then
            local startPos = getCreaturePosition(cid)
            doKinoboriTick(cid, startPos.x, startPos.y, startPos.z)
        end
    end, 100)

    return true
end