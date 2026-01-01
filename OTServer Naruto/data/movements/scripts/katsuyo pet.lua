function onEquip(cid, item, slot, pos, x)
local max = 1
local effect = 10
local summons = getCreatureSummons(cid)
if(table.maxn(summons) < max) then
        local pos = getThingPos(cid)
        local x = doSummonCreature("Katsuyo", pos)
        doConvinceCreature(cid, x)
        doSendMagicEffect(pos, effect)
return true
end
end



