local porcentagem = 5 -- porcentagem de life que enche.
local delay = 3 -- segundos de delay.

function onEquip(cid, item, slot)
doAddHpPercent(cid, item.itemid)
return true
end

function doAddHpPercent(cid, item)
if isPlayer(cid) and getPlayerSlotItem(cid, CONST_SLOT_NECKLACE).itemid == item then
        local hpMax = getCreatureMaxHealth(cid)
        local heal = getCreatureMaxHealth(cid)*(porcentagem/100)
        doCreatureAddHealth(cid, heal)
        addEvent(doAddHpPercent, delay*1000, cid, item)
end
return true
end