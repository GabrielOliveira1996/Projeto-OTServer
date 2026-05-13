local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

-- [ CONFIGURATIONS ]
local ACADEMY_POS = {x = 3058, y = 3016, z = 6}
local FOREST_POS = {x = 2982, y = 3194, z = 7} -- POSIÇÃO EXATA DO ONDEATH
local CHECK_RADIUS = 10 

-- [ HELPER FUNCTIONS ]
-- Substituído getSelf() por getNpcCid()
local function isAtAcademy() 
    local npcPos = getThingPos(getNpcCid())
    return getDistanceBetween(npcPos, ACADEMY_POS) <= CHECK_RADIUS 
end

local function isAtForest() 
    local npcPos = getThingPos(getNpcCid())
    return getDistanceBetween(npcPos, FOREST_POS) <= CHECK_RADIUS 
end

local function spawnClone(cid, playerPos)
    local monsterToSummon = "Failed Bunshin"
    local spawnPos = {x=playerPos.x+1, y=playerPos.y, z=playerPos.z}
    local clone = doCreateMonster(monsterToSummon, spawnPos)
    if isCreature(clone) then
        doConvinceCreature(cid, clone)
        doSendMagicEffect(spawnPos, 10) 
        doSetCreatureOutfit(clone, getCreatureOutfit(cid), -1)
        addEvent(function()
            if isCreature(clone) then
                local currentPos = getThingPos(clone)
                if currentPos and currentPos.x ~= 0 then
                    doRemoveCreature(clone)
                    doSendMagicEffect(currentPos, 10)
                end
            end
        end, 3500)
        return true
    end
    return false
end

function onThink() 
    npcHandler:onThink() 
end

-- [ GREET CALLBACK ]
function onGreet(cid)
    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    local name = getCreatureName(cid)

    if isAtAcademy() then
        if status <= SAGA_STAGE_ACADEMIC_EXAM then
            npcHandler:setMessage(MESSAGE_GREET, "Finalmente! " .. name .. ", mostre-me o seu {bunshin}!")
        elseif status == SAGA_STAGE_MIZUKI_PROPOSAL then
            npcHandler:setMessage(MESSAGE_GREET, "Voce de novo, " .. name .. "? Va descansar um pouco.")
        else
            npcHandler:setMessage(MESSAGE_GREET, "Ola, " .. name .. "! Como vao as missoes?")
        end
        npcHandler:addFocus(cid)
        return true

    elseif isAtForest() then
        if status >= SAGA_STAGE_REGISTRATION_PHOTO then
            npcHandler:setMessage(MESSAGE_GREET, "Va agora, Genin! Seu futuro como ninja apenas comecou.")
            npcHandler:addFocus(cid)
            return true
        elseif status == SAGA_STAGE_FOREST_DELIVERY then
            npcHandler:setMessage(MESSAGE_GREET, "Voce conseguiu, " .. name .. "! Voce protegeu o pergaminho e salvou minha vida. Aproxime-se, voce agora e um {Genin}.")
            npcHandler:addFocus(cid)
            return true
        end
    end

    return false 
end

-- [ MESSAGE CALLBACK ]
function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local message = msg:lower()
    local name = getCreatureName(cid)
    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    local irukaCid = getNpcCid()

    if isAtAcademy() then
        if (msgcontains(message, 'bunshin') or msgcontains(message, 'clone')) and status <= SAGA_STAGE_ACADEMIC_EXAM then
            if spawnClone(cid, getCreaturePosition(cid)) then
                doCreatureSay(irukaCid, 'MAS O QUE FOI ISSO?! ' .. name .. ', isso não e um clone, e um desastre ambulante! REPROVADO!', TALKTYPE_SAY)
                setPlayerStorageValue(cid, SAGA_STORAGE, SAGA_STAGE_MIZUKI_PROPOSAL)
                doPlayerAddExp(cid, 2000)
                doSendMagicEffect(getThingPos(cid), 12) 
            end
        end

    elseif isAtForest() then
        if (msgcontains(message, 'genin') or msgcontains(message, 'graduacao')) then
            if status == SAGA_STAGE_FOREST_DELIVERY then
                npcHandler:say('Sim, voce demonstrou coragem e aprendeu um jutsu poderoso para proteger seus companheiros. Parabens, voce agora e oficialmente um Genin de Konoha!', cid)
                
                setPlayerStorageValue(cid, SAGA_STORAGE, SAGA_STAGE_REGISTRATION_PHOTO)
                doPlayerAddExp(cid, 25000)
                doSendMagicEffect(getThingPos(cid), 2)
            end
        end
    end

    return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, "Continue com os estudos. Ate logo, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ate mais, |PLAYERNAME|.")

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())