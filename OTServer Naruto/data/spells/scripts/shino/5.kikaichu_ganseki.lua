function onCastSpell(cid, var)
    local ml = getPlayerMagLevel(cid)
    local target = getCreatureTarget(cid)
    
    local cooldownStorage = 23005
    local cooldownTime = 2 

    if target == 0 then
        doPlayerSendCancel(cid, "You need a target.")
        return false
    end

    if getPlayerStorageValue(cid, cooldownStorage) > os.time() then
        local remaining = getPlayerStorageValue(cid, cooldownStorage) - os.time()
        doPlayerSendCancel(cid, "Wait " .. remaining .. " seconds.")
        return false
    end

    local min = (ml * 4.5) + 100
    local max = (ml * 9.5) + 250
    
    if getCreatureCondition(target, CONDITION_PARALYZE) then
        min = min * 1.3
        max = max * 1.5 
        doSendMagicEffect(getCreaturePosition(target), 31)
    end

    doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -min, -max, 14)
    
    local manaDrain = (ml * 2) + 50
    doTargetCombatMana(cid, target, -manaDrain, -manaDrain, 12)

    setPlayerStorageValue(cid, cooldownStorage, os.time() + cooldownTime)

    return true
end