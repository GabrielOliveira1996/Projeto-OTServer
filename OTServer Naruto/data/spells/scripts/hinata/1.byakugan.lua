local BYA_STORAGE = 45001 
local costPerSecond = 10 -- custo de chakra a cada 2 segundos
local interval = 2000 -- 2 segundos

local function drainMana(cid)
    if not isPlayer(cid) then return end
    if getPlayerStorageValue(cid, BYA_STORAGE) <= 0 then return end

    if getCreatureMana(cid) < costPerSecond then
        setPlayerStorageValue(cid, BYA_STORAGE, -1)
        doPlayerSendTextMessage(cid, 22, "Byakugan Deactivated: Low Chakra.")
        return
    end

    doPlayerRemoveMana(cid, costPerSecond)
    doSendMagicEffect(getThingPos(cid), 13)
    addEvent(drainMana, interval, cid)
end

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, BYA_STORAGE) > 0 then
        setPlayerStorageValue(cid, BYA_STORAGE, -1)
        doPlayerSendTextMessage(cid, 22, "Byakugan Deactivated!")
        return true
    end

    setPlayerStorageValue(cid, BYA_STORAGE, 1)
    doPlayerSendTextMessage(cid, 22, "Byakugan Activated!")
    doSendMagicEffect(getThingPos(cid), 92) 
    
    drainMana(cid)
    return true
end