local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

function onCastSpell(cid, var)
    local getSkill = getPlayerSkillLevel(cid, 6) 
    local cooldownStorage = 23003
    local cooldownTime = 2
    local target = getCreatureTarget(cid) 

    if getPlayerStorageValue(cid, cooldownStorage) > os.time() then
        local remaining = getPlayerStorageValue(cid, cooldownStorage) - os.time()
        doPlayerSendCancel(cid, "Wait " .. remaining .. " seconds.")
        doSendMagicEffect(getCreaturePosition(cid), 2) 
        return false
    end

    local min = (getSkill * 1.5) + 100  
    local max = (getSkill * 2.5) + 150
    
    doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -min, -max, 17)
    setPlayerStorageValue(cid, cooldownStorage, os.time() + cooldownTime)

    return true
end