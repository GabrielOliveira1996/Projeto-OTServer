function onUse(cid, interval, lastExecution)
on,storage,pos = getPlayersOnline(),11112,{x = 3114,y = 3035,z = 7}
if #on > 0 then
for i = 1, #on do
if getPlayerStorageValue(on[i], storage) >= 1 then
doTeleportThing(on[i], pos)
end
end
end
return true
end