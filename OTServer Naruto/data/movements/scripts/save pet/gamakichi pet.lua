local porcentagem = 5 -- porcentagem de life que enche.
local delay = 3 -- segundos de delay.

function onEquip(cid, item, slot)
doAddManaPercent(cid, item.itemid)
return 
end

function doAddManaPercent(cid, item, pos)
if isPlayer(cid) and getPlayerSlotItem(cid, CONST_SLOT_NECKLACE).itemid == item then
        local manaMax = getCreatureMaxMana(cid)
        local heal = getCreatureMaxMana(cid)*(porcentagem/100)
        doCreatureAddMana(cid, heal)
        addEvent(doAddManaPercent, delay*1000, cid, item)
return true
end
        local pos = getPlayerPosition(cid)
        local x = doCreateMonster("Gamakichi", pos)
        doConvinceCreature(cid, x)
return true
end


