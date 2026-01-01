function onCastSpell(cid, var)

local outfit1 = 358
local outfit2 = 359

if getPlayerLevel(cid) >= 0 and getPlayerLevel(cid) <= 149 and getPlayerVocation(cid) == 92 or getPlayerVocation(cid) == 61 or getPlayerVocation(cid) == 62 then
doSetCreatureOutfit(cid, {lookType = outfit1}, -1)
doPlayerSetVocation(cid, 33)
doSendMagicEffect(getCreaturePosition(cid), 76)
end

if getPlayerLevel(cid) >= 150 and getPlayerLevel(cid) <= 250 and getPlayerVocation(cid) == 63 and getPlayerStorageValue(cid, 20001) == 1 then
doSetCreatureOutfit(cid, {lookType = outfit2}, -1)
doPlayerSetVocation(cid, 35)
doSendMagicEffect(getCreaturePosition(cid), 76)
return true
end
end
