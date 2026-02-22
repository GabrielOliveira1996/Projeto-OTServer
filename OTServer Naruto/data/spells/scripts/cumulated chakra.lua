function onCastSpell(cid, var)


if getPlayerLevel(cid) >= 100 and getPlayerLevel(cid) <= 149 and getPlayerVocation(cid) == 14 then --- sakura classic cumulated -- arrumado
    doSetCreatureOutfit(cid, {lookType = 2}, -1)
    doPlayerSetVocation(cid, 69)
    doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 200 and getPlayerLevel(cid) <= 299 and getPlayerVocation(cid) == 15 then --- sakura shippuden cumulated -- arrumado
doSetCreatureOutfit(cid, {lookType = 2}, -1)
doPlayerSetVocation(cid, 98)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 400 and getPlayerLevel(cid) <= 449 and getPlayerVocation(cid) == 16 then --- sakura strong cumulated -- arrumado
doSetCreatureOutfit(cid, {lookType = 13}, -1)
doPlayerSetVocation(cid, 99)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 100 and getPlayerLevel(cid) <= 149 and getPlayerVocation(cid) == 29 then --- neji
doSetCreatureOutfit(cid, {lookType = 100}, -1)
doPlayerSetVocation(cid, 95)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 250 and getPlayerLevel(cid) <= 299 and getPlayerVocation(cid) == 31 then --- neji shipp
doSetCreatureOutfit(cid, {lookType = 14}, -1)
doPlayerSetVocation(cid, 100)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 400 and getPlayerLevel(cid) <= 449 and getPlayerVocation(cid) == 32 then --- neji strong
doSetCreatureOutfit(cid, {lookType = 15}, -1)
doPlayerSetVocation(cid, 101)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 100 and getPlayerLevel(cid) <= 149 and getPlayerVocation(cid) == 49 then --- chouji
doSetCreatureOutfit(cid, {lookType = 183}, -1)
doPlayerSetVocation(cid, 96)
doSendMagicEffect(getCreaturePosition(cid), 90)
end

if getPlayerLevel(cid) >= 300 and getPlayerVocation(cid) == 51 then --- chouji stronger
doSetCreatureOutfit(cid, {lookType = 182}, -1)
doPlayerSetVocation(cid, 97)
doSendMagicEffect(getCreaturePosition(cid), 71)
return true
end
end
