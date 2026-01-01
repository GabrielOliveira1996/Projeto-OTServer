function onLogin(cid)
    registerCreatureEvent(cid, "DeadTeleport")
return true
end

function onDeath(cid, corpse, deathlist)

local voc = {
[14] = {x=3029, y=3027, z=7}
}

local dead = voc[getPlayerVocation(cid)]
if isPlayer(cid) then
doTeleportThing(cid, dead)
end
return true
end

