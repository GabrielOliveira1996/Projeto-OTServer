local storage_status = 305

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, storage_status) > 0 then
        setPlayerStorageValue(cid, storage_status, -1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Sozo Saisei: OFF")
        doSendMagicEffect(getThingPos(cid), 2) -- fumaca ao desligar
        return true
    end

    -- só ativa de tiver mais de 10% de chakra
    if getCreatureMana(cid) < (getCreatureMaxMana(cid) * 0.10) then
        doPlayerSendCancel(cid, "You don't have enough mana to activate Sozo Saisei.")
        return false
    end

    setPlayerStorageValue(cid, storage_status, 1)
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Sozo Saisei: ON")
    doCreatureSay(cid, "SOZO SAISEI!", TALKTYPE_MONSTER)
    doSendMagicEffect(getThingPos(cid), 12) -- Efeito das marcas aparecendo
    return true
end