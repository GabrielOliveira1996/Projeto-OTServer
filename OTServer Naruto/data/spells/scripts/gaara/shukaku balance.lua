function onCastSpell(cid, var)

local outfit1 = 8
local level1 = 0

if getPlayerLevel(cid) >= level1 and getPlayerLevel(cid) <= 149 then
doSetCreatureOutfit(cid, {lookType = outfit1}, -1)
doPlayerSetVocation(cid, 5)
doSendMagicEffect(getCreaturePosition(cid), 95)
return true
end
end