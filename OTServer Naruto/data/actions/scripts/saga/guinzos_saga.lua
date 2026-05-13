function onUse(cid, item, fromPosition, itemEx, toPosition)
    local sagaStorage = SAGA_STORAGE 
    local permissionStorage = 11002 -- SAGA_KASHI_TEST
    local cooldownStorage = 32055 
    local experienceGain = 15000
    local cloneName = "Kakashi Bunshin"
    local realGuizoAID = 3803 
    local fakeGuizoAID = 3804
    local currentStatus = getPlayerStorageValue(cid, sagaStorage)
    local hasPermission = getPlayerStorageValue(cid, permissionStorage)

    if currentStatus ~= SAGA_STAGE_MEET_JOUNIN then
        return false
    end

    if hasPermission < 1 then
        return false
    end

    -- 3. Sistema de Cooldown (5 segundos)
    if getPlayerStorageValue(cid, cooldownStorage) > os.time() then
        doPlayerSendCancel(cid, "Please wait a few seconds to try again.")
        return true
    end

    -- LÓGICA DO GUIZO FALSO (ActionID 3804)
    if item.actionid == fakeGuizoAID then
        setPlayerStorageValue(cid, cooldownStorage, os.time() + 5)
        doPlayerSendTextMessage(cid, 22, "Droga! Era uma armadilha!")
        doSendMagicEffect(toPosition, 10)
        
        local clone = doCreateMonster(cloneName, toPosition)
        if isCreature(clone) then
            doMonsterSetTarget(clone, cid)
            doCreatureSay(clone, "Te peguei!", TALKTYPE_SAY)
        end
        return true
    end

    -- LÓGICA DO GUIZO VERDADEIRO (ActionID 3803)
    if item.actionid == realGuizoAID then
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Parabens. Voce encontrou o guizo verdadeiro!")
        doSendMagicEffect(getThingPos(cid), 12) 
        
        -- Finaliza o teste e limpa a permissão auxiliar
        setPlayerStorageValue(cid, sagaStorage, SAGA_STAGE_FIRST_MISSION)
        setPlayerStorageValue(cid, permissionStorage, -1) -- Reseta a permissão
        
        doPlayerAddExp(cid, experienceGain)
        doCreatureSay(cid, "Kakashi: No mundo ninja, aqueles que quebram as regras sao lixo, e verdade... mas aqueles que abandonam seus amigos sao piores que lixo! Voce passou!", TALKTYPE_SAY)
        return true
    end

    return false
end