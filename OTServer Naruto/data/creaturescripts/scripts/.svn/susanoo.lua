function onStatsChange(cid, attacker, type, combat, value)
    local status = getCreatureStorage(cid, 301)
    if getPlayerLevel(cid) >= 400 and (type == STATSCHANGE_HEALTHLOSS) then
        if(status < os.time()) then
            return true
        end
        return false
    end
    return true
end
