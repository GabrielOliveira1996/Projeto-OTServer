function onStatsChange(cid, attacker, type, combat, value)

    if isPlayer(cid) and getPlayerStorageValue(cid, 45002) >= os.time() then
        if type == STATSCHANGE_HEALTHLOSS then
            doSendMagicEffect(getThingPos(cid), 1) 
            return false 
        end
    end

    if type ~= STATSCHANGE_HEALTHLOSS or value <= 0 or not isCreature(attacker) then
        return true
    end

    local hyuugaVocs = {53, 54, 55, 56}
    local voc = getPlayerVocation(attacker)

    if isInArray(hyuugaVocs, voc) then
        if getPlayerStorageValue(attacker, 45001) > 0 then
            
            if combat == COMBAT_PHYSICALDAMAGE then
                
                if math.random(1, 100) <= 100 then
                    --print("Dano Original: " .. value);
                    local criticalExtra = math.ceil(value * 3.0)
                    --print("Crítico de " .. criticalExtra);
                    addEvent(function()
                        if isCreature(cid) then
                            doTargetCombatHealth(attacker, cid, COMBAT_ENERGYDAMAGE, -criticalExtra, -criticalExtra, 1)
                            doSendMagicEffect(getThingPos(cid), 1)
                            doSendAnimatedText(getThingPos(cid), "TENKETSU!", 180)
                        end
                    end, 20)

                    return true
                end
            end
        end
    end

    return true
end