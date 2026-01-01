function onDeEquip(cid, item, slot, summon, summons, effect)

local effect = 10

summons = getCreatureSummons(cid)
for _, summon in pairs(summons) do
  doSendMagicEffect(getThingPos(summon), effect)
  doRemoveCreature(summon)
end
return true
end



