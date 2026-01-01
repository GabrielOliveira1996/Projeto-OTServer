function onUse(cid, item, frompos, item2, topos)
if item2.itemid == 2361 then
doPlayerSendCancel(cid,"Você não pode fazer isso.")
else
if getPlayerAccess(cid) >= 3 then
playerpos = getPlayerPosition(cid)
doTeleportThing(cid,topos)
doSendMagicEffect(playerpos,10)
doSendMagicEffect(topos,10)
doSendAnimatedText(playerpos,"Kawarimi",35)
else
doPlayerSendCancel(cid,"Você não pode usar.")
end
end
return 1
end