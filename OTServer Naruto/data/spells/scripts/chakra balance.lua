function onCastSpell(cid, var)

if getPlayerLevel(cid) >= 50 and getPlayerVocation(cid) == 80 then --- sai
doSetCreatureOutfit(cid, {lookType = 187}, -1)
doPlayerSetVocation(cid, 57)
doSendMagicEffect(getCreaturePosition(cid), 75)
end

if getPlayerLevel(cid) >= 100 and getPlayerLevel(cid) <= 149 and getPlayerVocation(cid) == 93 then --- sai
doSetCreatureOutfit(cid, {lookType = 187}, -1)
doPlayerSetVocation(cid, 57)
doSendMagicEffect(getCreaturePosition(cid), 75)
end

if getPlayerLevel(cid) >= 300 and getPlayerVocation(cid) == 94 then --- sai
doSetCreatureOutfit(cid, {lookType = 188}, -1)
doPlayerSetVocation(cid, 60)
doSendMagicEffect(getCreaturePosition(cid), 75)
end

if getPlayerLevel(cid) >= 100 and getPlayerLevel(cid) <= 149 and getPlayerVocation(cid) == 69 then --- sakura -- arrumado
doSetCreatureOutfit(cid, {lookType = 387}, -1)
doPlayerSetVocation(cid, 14)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 250 and getPlayerLevel(cid) <= 299 and getPlayerVocation(cid) == 98 then --- sakura shi -- arrumado
doSetCreatureOutfit(cid, {lookType = 69}, -1)
doPlayerSetVocation(cid, 15)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 400 and getPlayerLevel(cid) <= 449 and getPlayerVocation(cid) == 99 then --- sakura shi -- arrumado
doSetCreatureOutfit(cid, {lookType = 12}, -1)
doPlayerSetVocation(cid, 16)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 100 and getPlayerLevel(cid) <= 149 and getPlayerVocation(cid) == 95 then --- neji -- arrumado
doSetCreatureOutfit(cid, {lookType = 206}, -1)
doPlayerSetVocation(cid, 29)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 250 and getPlayerLevel(cid) <= 299 and getPlayerVocation(cid) == 100 then --- neji shipp -- arrumado
doSetCreatureOutfit(cid, {lookType = 68}, -1)
doPlayerSetVocation(cid, 31)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 400 and getPlayerLevel(cid) <= 449 and getPlayerVocation(cid) == 101 then --- neji strong -- arrumado
doSetCreatureOutfit(cid, {lookType = 171}, -1)
doPlayerSetVocation(cid, 32)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 100 and getPlayerLevel(cid) <= 149 and getPlayerVocation(cid) == 96 then --- chouji
doSetCreatureOutfit(cid, {lookType = 180}, -1)
doPlayerSetVocation(cid, 49)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 300 and getPlayerVocation(cid) == 97 then --- chouji stronger
doSetCreatureOutfit(cid, {lookType = 181}, -1)
doPlayerSetVocation(cid, 51)
doSendMagicEffect(getCreaturePosition(cid), 71)
return true
end
end
