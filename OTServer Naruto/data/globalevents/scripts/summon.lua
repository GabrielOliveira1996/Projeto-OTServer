function onThink(interval, lastExecution, thinkInterval)
local maxDistance = 8
    for _, pid in pairs(getPlayersOnline()) do
        local summons = getCreatureSummons(pid)
        if #summons ~= 0 then
                for _, sid in pairs (summons) do
                        if getThingPos(sid).z ~= getThingPos(pid).z or getDistanceBetween(getThingPos(sid), getThingPos(pid)) > maxDistance then
                                doTeleportThing(sid, getThingPos(pid), false)
                                doSendMagicEffect(getThingPos(sid), 2)
                        end
                end
        end
    end
return true
end