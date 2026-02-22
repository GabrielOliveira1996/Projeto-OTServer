local STORAGE_SHARINGAN = 312345 -- storage que identifica se o sharingan esta ativo

local function sharinganCycle(cid)
    -- verifica se o jogador ainda está online
    if not isPlayer(cid) then 
        return 
    end

    -- se o storage for removido ou resetado, para o ciclo
    if getPlayerStorageValue(cid, STORAGE_SHARINGAN) <= 0 then 
        return 
    end

    -- quantidade de chakra que gasta.
    local costPerSecond = 15
    
    if getPlayerMana(cid) >= costPerSecond then
        local removedMana = doPlayerRemoveMana(cid, -costPerSecond)
        doPlayerSendTextMessage(cid, 23, "Spent " .. removedMana .. " chakra points (Sharingan).")
        addEvent(sharinganCycle, 2000, cid) 
    else
        setPlayerStorageValue(cid, STORAGE_SHARINGAN, -1)
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "Your Sharingan deactivated due to low chakra.")
    end
end

function onCastSpell(cid, var)
    -- verifica se ja esta ativo para desligar
    if getPlayerStorageValue(cid, STORAGE_SHARINGAN) > 0 then
        doPlayerSendTextMessage(cid, 22, "Sharingan Deactivated.")
        setPlayerStorageValue(cid, STORAGE_SHARINGAN, -1)
        doSendMagicEffect(getCreaturePosition(cid), 26)
        return true
    end

    -- ativa o Sharingan
    doPlayerSendTextMessage(cid, 22, "Sharingan Activated.")
    setPlayerStorageValue(cid, STORAGE_SHARINGAN, 1)
    doSendMagicEffect(getCreaturePosition(cid), 26)
    sharinganCycle(cid)
    return true
end