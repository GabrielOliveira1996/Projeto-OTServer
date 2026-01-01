function onStatsChange(cid, attacker, type, combat, value)
    local status = getCreatureStorage(cid, 301)
    if getPlayerLevel(cid) >= 200 and getPlayerLevel(cid) <= 299 and (type == STATSCHANGE_HEALTHLOSS) then
        if(status < os.time()) then
            return true
        end
        return false
    end
    return true
end

function onStatsChange(cid, attacker, type, combat, value)
    local status1 = getCreatureStorage(cid, 302)
    if getPlayerLevel(cid) >= 300 and getPlayerLevel(cid) <= 400 and (type == STATSCHANGE_HEALTHLOSS) then
        if(status1 < os.time()) then
            return true
        end
         return false
    end
    return true
end
