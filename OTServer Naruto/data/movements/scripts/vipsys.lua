function onStepIn(cid, item, pos)
teleport1 ={x=154, y=46, z=7} 
if isPlayer(cid) then
if item.actionid == 13540 then
vip = getPlayerStorageValue(cid,13540)
if vip == -1 then
doPlayerSendCancel(cid,"Esta area e exclusiva para players VIP.")
doTeleportThing(cid,teleport1)

else

end

end

end

end