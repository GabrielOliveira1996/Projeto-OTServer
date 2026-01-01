function onDeEquip(cid, item, slot)

local monster = "Gamakichi"
if #getCreatureSummon(cid) >= 1 then
   for _, summon in ipairs(getCreatureSummon(cid)) do
           if getCreatureName(summon) == monster then
                  doSendMagicEffect(getPlayerPosition(summon), 21)
                  doRemoveCreature(summon)
           end
   end
end
return true
end