local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

-- [ CONFIGURATIONS ]
local VILLAGE_POS = {x = 3050, y = 3021, z = 7}
local FOREST_POS = {x = 2979, y = 3197, z = 7}
local CHECK_RADIUS = 10

npcHandler.messages[MESSAGE_WALKAWAY] = nil
npcHandler.messages[MESSAGE_FAREWELL] = nil

-- [ HELPER FUNCTIONS ]
function isAtVillage(npcId) return getDistanceBetween(getThingPos(npcId), VILLAGE_POS) <= CHECK_RADIUS end
function isAtForest(npcId) return getDistanceBetween(getThingPos(npcId), FOREST_POS) <= CHECK_RADIUS end

-- [ AMBUSH EVENT - PADRÃO UTAKA ]
local function startAmbushScene(cid, npcId)
    if not isPlayer(cid) or not isCreature(npcId) then return end
    
    local npcPos = getThingPos(npcId)
    local npcName = getCreatureName(npcId)
    local playerPos = getThingPos(cid)
    local irukaSpawnPos = {x = playerPos.x + 1, y = playerPos.y, z = playerPos.z}

    doCreatureSay(npcId, "Finalmente o pergaminho e meu! Voce foi util, mas agora... VOCE MORRE!", TALKTYPE_SAY)

    addEvent(function()
        if not isPlayer(cid) then return end
        
        -- Shuriken Effect
        doSendDistanceShoot(npcPos, playerPos, 7) 
        
        -- Iruka Dummy
        local irukaDummy = doCreateMonster("Iruka Protectors", irukaSpawnPos)
        if isCreature(irukaDummy) then
            doSendMagicEffect(irukaSpawnPos, 10)
            doCreatureSay(irukaDummy, "NARUTO, CUIDADO!!!", TALKTYPE_SAY)
        end

        addEvent(function()
            if not isPlayer(cid) then return end
            doCreatureSay(npcId, "Iruka... sempre protegendo esse monstro. Que ele e a propria Kyuubi!", TALKTYPE_SAY)

            addEvent(function()
                if not isPlayer(cid) then return end
                doPlayerSendTextMessage(cid, 22, "Iruka esta ferido! Proteja-o e derrote Mizuki!")
                
                -- Boss Mizuki
                local mizukiBoss = doCreateMonster("Mizuki", npcPos)
                if isCreature(mizukiBoss) then
                    doMonsterSetTarget(mizukiBoss, cid)
                    addEvent(function()
                        if isCreature(mizukiBoss) then doRemoveCreature(mizukiBoss) end
                    end, 60 * 1000)
                end

                -- REMOÇÃO E RETORNO (Lógica IDÊNTICA ao Utaka)
                if isCreature(npcId) then
                    doSendMagicEffect(getThingPos(npcId), 10) 
                    doRemoveCreature(npcId)
                    -- O retorno usa o npcName capturado no início
                    addEvent(function() doCreateNpc(npcName, npcPos) end, 60 * 1000)
                end
                
                addEvent(function() 
                    if isCreature(irukaDummy) then doRemoveCreature(irukaDummy) end 
                end, 61 * 1000)

            end, 5000)
        end, 4000)
    end, 2000)
end

-- [ GREET CALLBACK ]
function greetCallback(cid)
    local playerStatus = getPlayerStorageValue(cid, SAGA_STORAGE)
    local npcId = getNpcCid()
    local canTalk = false

    if isAtVillage(npcId) then
        if playerStatus == SAGA_STAGE_MIZUKI_PROPOSAL then
            npcHandler:setMessage(MESSAGE_GREET, "Ei... Eu vi o que aconteceu. Se quiser virar um Genin, eu posso te {ajudar}. Aceita?")
            canTalk = true
        elseif playerStatus == SAGA_STAGE_SCROLL_THEFT then
            npcHandler:setMessage(MESSAGE_GREET, "Va buscar o {pergaminho} na biblioteca antes que percebam!")
            canTalk = true
        end
    elseif isAtForest(npcId) then
        if playerStatus == SAGA_STAGE_FOREST_DELIVERY then
            npcHandler:setMessage(MESSAGE_GREET, "Finalmente! Voce conseguiu trazer o {pergaminho}?")
            canTalk = true
        end
    end

    -- Se não estiver na saga, retorna false e ignora o player (Não fala nada)
    if not canTalk then
        return false
    end

    npcHandler:addFocus(cid)
    return true
end

-- [ DIALOGUE CALLBACK ]
function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end
    local playerStatus = getPlayerStorageValue(cid, SAGA_STORAGE)
    local npcId = getNpcCid()

    if isAtVillage(npcId) then
        if (msgcontains(msg, 'ajuda') or msgcontains(msg, 'sim')) and playerStatus == SAGA_STAGE_MIZUKI_PROPOSAL then
            npcHandler:say('Pegue o pergaminho na biblioteca e me encontre na floresta ao sul!', cid)
            setPlayerStorageValue(cid, SAGA_STORAGE, SAGA_STAGE_SCROLL_THEFT)
        end
    elseif isAtForest(npcId) then
        if (msgcontains(msg, 'pergaminho') or msgcontains(msg, 'entrega')) and playerStatus == SAGA_STAGE_FOREST_DELIVERY then
            npcHandler:releaseFocus(cid)
            startAmbushScene(cid, npcId)
        end
    end
    return true
end

-- [ WALK AWAY / FAREWELL - PADRÃO UTAKA ]
function npcHandler:onWalkAway(cid)
    if not self:isFocused(cid) then return false end
    self:say("Tchau...", cid)
    self:releaseFocus(cid)
    return true
end

function npcHandler:onFarewell(cid)
    if not self:isFocused(cid) then return false end
    self:say("Se cuida.", cid)
    self:releaseFocus(cid)
    return true
end

-- [ SETUP CALLBACKS ]
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())