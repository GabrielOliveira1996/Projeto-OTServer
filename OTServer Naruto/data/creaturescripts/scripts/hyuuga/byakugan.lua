function onStatsChange(cid, attacker, type, combat, value)
    if isPlayer(cid) and getPlayerStorageValue(cid, 45002) >= os.time() then
        if type == STATSCHANGE_HEALTHLOSS then
            doSendMagicEffect(getThingPos(cid), 1) -- efeito de defesa
            return false 
        end
    end

    if isCreature(attacker) and getPlayerStorageValue(attacker, 45004) > 0 then
        return true
    end

    return true
end