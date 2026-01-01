function onEquip(cid, item, slot, pos, x)

local max = 1
local effect = 10
local mana = 500
local delay = 2
local summons = getCreatureSummons(cid)
if(table.maxn(summons) < max) then
        local pos = getThingPos(cid)
        local x = doSummonCreature("Gamakichi", pos)
        doConvinceCreature(cid, x)
        doSendMagicEffect(pos, effect)
        doCreatureAddMana(cid, mana)
return true
end

function doCreatureAddMana(cid, item, pos, slot, mana)
addEvent(doCreatureAddMana, delay*1000, cid, mana)
return true
end
end



