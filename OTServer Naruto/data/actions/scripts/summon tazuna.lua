function onUse(cid, item, frompos, item2, topos)
doConvinceCreature(cid, doSummonCreature("Tazuna",topos))
if item.type > 1 then
doChangeTypeItem(item.uid,item.type-1)
else
doRemoveItem(item.uid,1)
end
return 1
end