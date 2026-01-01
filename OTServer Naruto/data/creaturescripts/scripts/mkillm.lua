function onStatsChange(cid, attacker, type, combat, value)
    if isMonster(attacker) and isMonster(cid) and isMonster(getCreatureMaster(attacker)) and isMonster(getCreatureMaster(cid)) then
        return false
    end
    return true
end