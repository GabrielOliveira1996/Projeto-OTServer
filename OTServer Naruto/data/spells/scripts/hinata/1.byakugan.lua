local BYA_STORAGE = 45001 
local costPerSecond = 2

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, BYA_STORAGE) > 0 then
        setPlayerStorageValue(cid, BYA_STORAGE, -1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Byakugan deactivated!")
        return true
    end

    setPlayerStorageValue(cid, BYA_STORAGE, 1)
    doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Byakugan activated!")
    doSendMagicEffect(getThingPos(cid), 92) 

    local function drainMana(cid)
        if not isPlayer(cid) or getPlayerStorageValue(cid, BYA_STORAGE) <= 0 then 
            return 
        end

        if getCreatureMana(cid) < costPerSecond then
            setPlayerStorageValue(cid, BYA_STORAGE, -1)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Byakugan deactivated: Low Chakra.")
            return
        end

        doPlayerRemoveMana(cid, costPerSecond)
        doSendMagicEffect(getThingPos(cid), 13) 
        addEvent(drainMana, 2000, cid)
    end

    drainMana(cid)
    return true
end