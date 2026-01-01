function onCastSpell(cid, var)

if getPlayerLevel(cid) >= 100 and getPlayerLevel(cid) <= 149 and getPlayerVocation(cid) == 57 then --- sai
doSetCreatureOutfit(cid, {lookType = 187}, -1)
doPlayerSetVocation(cid, 80)
doSendMagicEffect(getCreaturePosition(cid), 76)
end

if getPlayerLevel(cid) >= 200 and getPlayerLevel(cid) <= 299 and getPlayerVocation(cid) == 59 then --- sai shippuden
doSetCreatureOutfit(cid, {lookType = 187}, -1)
doPlayerSetVocation(cid, 93)
doSendMagicEffect(getCreaturePosition(cid), 76)
end

if getPlayerLevel(cid) >= 350 and getPlayerLevel(cid) <= 449 and getPlayerVocation(cid) == 60 then --- sai stronger
doSetCreatureOutfit(cid, {lookType = 188}, -1)
doPlayerSetVocation(cid, 94)
doSendMagicEffect(getCreaturePosition(cid), 76)
return true
end
end
