function onCastSpell(cid, var)

if getPlayerLevel(cid) >= 40 and getPlayerLevel(cid) <= 149 and getPlayerVocation(cid) == 33 then
doSetCreatureOutfit(cid, {lookType = 117}, -1)
doPlayerSetVocation(cid, 92)
doSendMagicEffect(getCreaturePosition(cid), 76)
end

if getPlayerLevel(cid) >= 80 and getPlayerLevel(cid) <= 149 and getPlayerVocation(cid) == 92 then
doSetCreatureOutfit(cid, {lookType = 118}, -1)
doPlayerSetVocation(cid, 61)
doSendMagicEffect(getCreaturePosition(cid), 76)
end

if getPlayerLevel(cid) >= 120 and getPlayerLevel(cid) <= 149 and getPlayerVocation(cid) == 61 then
doSetCreatureOutfit(cid, {lookType = 118}, -1)
doPlayerSetVocation(cid, 62)
doSendMagicEffect(getCreaturePosition(cid), 76)
end

if getPlayerLevel(cid) >= 150 and getPlayerLevel(cid) <= 250 and getPlayerStorageValue(cid, 20001) == 1 then
doSetCreatureOutfit(cid, {lookType = 166}, -1)
doPlayerSetVocation(cid, 63)
doSendMagicEffect(getCreaturePosition(cid), 76)
return true
end
end
