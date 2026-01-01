function onUse(cid, interval, lastExecution)

local pos = {x = 2376,y = 3113,z = 8} 

if getPlayerLevel(cid) >= 1 then
doTeleportThing(cid, pos)
end
return true
end
