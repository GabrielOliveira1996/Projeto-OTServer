local STORAGE_JUKEN = 45003
local MANA_COST = 20 -- custo de chakra. 
local INTERVAL = 2 -- intervalo de consumo em segundos.

function chakraConsumption(cid)
    if not isCreature(cid) then return end
    if getPlayerStorageValue(cid, STORAGE_JUKEN) <= 0 then return end

    if getCreatureMana(cid) < MANA_COST then
        setPlayerStorageValue(cid, STORAGE_JUKEN, 0)
        doPlayerSendTextMessage(cid, 22, "Juken Deactived: Low Chakra.")
        return
    end

    doPlayerRemoveMana(cid, -MANA_COST)
    doSendMagicEffect(getThingPos(cid), 13)
    addEvent(chakraConsumption, INTERVAL * 1000, cid)
end

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, STORAGE_JUKEN) > 0 then
        setPlayerStorageValue(cid, STORAGE_JUKEN, 0)
        doPlayerSendTextMessage(cid, 22, "Juken Deactived!")
    else
        setPlayerStorageValue(cid, STORAGE_JUKEN, 1)
        doPlayerSendTextMessage(cid, 22, "Juken Activated!")
        chakraConsumption(cid)
    end
    return true
end