function onCastSpell(cid, var)

local outfit1 = 373
local outfit2 = 374
local outfit3 = 374

if getPlayerLevel(cid) >= 0 and getPlayerLevel(cid) <= 149 and getPlayerVocation(cid) == 70 or getPlayerVocation(cid) == 71 or getPlayerVocation(cid) == 72 then
doSetCreatureOutfit(cid, {lookType = outfit1}, -1)
doPlayerSetVocation(cid, 41)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 250 and getPlayerLevel(cid) <= 299 and getPlayerVocation(cid) == 73 and getPlayerStorageValue(cid, 20003) == 1 then
doSetCreatureOutfit(cid, {lookType = outfit2}, -1)
doPlayerSetVocation(cid, 43)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 400 and getPlayerVocation(cid) == 82 then
doSetCreatureOutfit(cid, {lookType = outfit3}, -1)
doPlayerSetVocation(cid, 44)
doSendMagicEffect(getCreaturePosition(cid), 90)
return true
end
end
