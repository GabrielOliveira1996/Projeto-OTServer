local storage_cooldown = 23020 
local effect = 14 

function onAttack(cid, target)
    if not isPlayer(cid) or not isCreature(target) then return true end
    
    local shino_vocation = 19
    if getPlayerVocation(cid) ~= shino_vocation then return true end

    if getDistanceBetween(getThingPos(cid), getThingPos(target)) > 6 then return true end

    if getPlayerStorageValue(cid, storage_cooldown) > os.m_time() then
        return true
    end

    local ml = getPlayerMagLevel(cid)
    local level = getPlayerLevel(cid)
    local min = (level * 0.5) + (ml * 2.5) + 30
    local max = (level * 0.8) + (ml * 4.0) + 60

    doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -min, -max, effect)
    
    if math.random(1, 10) == 1 then
        doTargetCombatMana(cid, target, -20, -50, 12)
    end

    setPlayerStorageValue(cid, storage_cooldown, os.m_time() + 1500)
    
    return true
end