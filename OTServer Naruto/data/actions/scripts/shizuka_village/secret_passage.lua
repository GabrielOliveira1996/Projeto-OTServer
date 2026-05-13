local config = {
    -- sequencia: fogo, vento, relampago, terra, agua
    sequence = {10001, 10002, 10003, 10004, 10005},
    
    -- storages
    storageStep = 45610, -- registra em qual passo o jogador esta
    
    -- configuração da escada e piso
    stairPos = {x = 2962, y = 3352, z = 8}, -- onde a escada vai aparecer
    stairID = 410,   -- ID do item da escada
    groundID = 996,  -- ID do piso original que sera restaurado
    timeToClose = 10, -- segundos que a escada fica aberta
    
    -- Efeitos
    effectSuccess = 10, 
    effectFail = 2,     
    effectComplete = 10 -- Efeito de abertura
}

local function removeStair(pos, stairID, groundID)
    local stair = getTileItemById(pos, stairID).uid
    if stair > 0 then
        doRemoveItem(stair)
        doCreateItem(groundID, 1, pos)
        doSendMagicEffect(pos, 2) -- efeito de fumaca ao fechar
    end
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
    local stairCheck = getTileItemById(config.stairPos, config.stairID).uid
    if stairCheck > 0 then
        doPlayerSendTextMessage(cid, 22, "O mecanismo ja esta ativo e a passagem esta aberta.")
        return true
    end

    local currentStep = math.max(0, getPlayerStorageValue(cid, config.storageStep))
    local expectedAID = config.sequence[currentStep + 1]

    if item.actionid == expectedAID then
        setPlayerStorageValue(cid, config.storageStep, currentStep + 1)
        doSendMagicEffect(toPosition, config.effectSuccess)
        
        if (currentStep + 1) == #config.sequence then
            
            local oldTile = getTileItemById(config.stairPos, config.groundID).uid
            if oldTile > 0 then
                doRemoveItem(oldTile)
            end

            doCreateItem(config.stairID, 1, config.stairPos)
            doSendMagicEffect(config.stairPos, config.effectComplete)
            doPlayerSendTextMessage(cid, 22, "Voce ouve um estrondo e uma passagem se abre no chao!")
            
            setPlayerStorageValue(cid, config.storageStep, 0)
            
            addEvent(removeStair, config.timeToClose * 1000, config.stairPos, config.stairID, config.groundID)
        else
            doPlayerSendTextMessage(cid, 20, "Um selo se ilumina (" .. (currentStep + 1) .. "/5).")
        end
    else
        if currentStep > 0 then
            setPlayerStorageValue(cid, config.storageStep, 0)
            doSendMagicEffect(toPosition, config.effectFail)
            doPlayerSendTextMessage(cid, 22, "A energia elemental se dispersa... Voce errou a ordem e o mecanismo resetou.")
        else
            doPlayerSendTextMessage(cid, 22, "Nada aconteceu.")
        end
    end

    return true
end