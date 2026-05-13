function onCastSpell(cid, var)
    local storage = 45007
    if getPlayerStorageValue(cid, storage) == 1 then
        setPlayerStorageValue(cid, storage, 0)
        doCreatureSetNoMove(cid, false)
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You stopped your meditation.")
    else
        setPlayerStorageValue(cid, storage, 1)
        doCreatureSetNoMove(cid, true)
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "You are now meditating.")
    end
    return true
end