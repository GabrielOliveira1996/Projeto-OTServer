function onUse(cid, item, fromPosition, itemEx, toPosition)

    local experienceGain = 5000
    local sagaStorage = SAGA_STORAGE 
    local mazeEntrancePos = {x = 3002, y = 3009, z = 8}
    local realScrollActionID = 3800 
    local fakeScrollActionID = 3801
    local currentStatus = getPlayerStorageValue(cid, sagaStorage)

    if currentStatus == SAGA_STAGE_SCROLL_THEFT then
        if item.actionid == fakeScrollActionID then
            doTeleportThing(cid, mazeEntrancePos)
            doSendMagicEffect(mazeEntrancePos, 2)
            doPlayerSendTextMessage(cid, 22, "DROGA! Este pergaminho era falso e continha uma armadilha de teleporte!")
            return true
        end
        if item.actionid == realScrollActionID then
            setPlayerStorageValue(cid, sagaStorage, SAGA_STAGE_FOREST_DELIVERY) 
            doPlayerAddExp(cid, experienceGain)
            doSendMagicEffect(toPosition, 12) -- efeito visual de conquista
            doPlayerSendTextMessage(cid, 22, "Voce encontrou o pergaminho verdadeiro! Agora corra para a floresta e encontre Mizuki!")
            return true
        end
        doPlayerSendTextMessage(cid, 22, "Este pergaminho parece ser apenas um rascunho.")
        return true
    else
        if currentStatus < SAGA_STAGE_SCROLL_THEFT then
            doPlayerSendTextMessage(cid, 22, "Este pergaminho esta selado. Voce nao consegue entender os selos ainda.")
        elseif currentStatus >= SAGA_STAGE_FOREST_DELIVERY then
            doPlayerSendTextMessage(cid, 22, "Voce ja memorizou os jutsus proibidos deste pergaminho.")
        end
        return false
    end
end