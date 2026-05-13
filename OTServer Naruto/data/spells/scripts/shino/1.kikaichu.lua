function onCastSpell(cid, var)
    local summons = getCreatureSummons(cid)
    local MaximoKikaichus = 2 
    local level = getPlayerLevel(cid)
    
    local kikaichuCount = 0
    if #summons > 0 then
        for _, summon in ipairs(summons) do
            if string.find(getCreatureName(summon):lower(), "kikaichu") then
                kikaichuCount = kikaichuCount + 1
            end
        end
    end

    if kikaichuCount >= MaximoKikaichus then
        doPlayerSendCancel(cid, "You have reached the maximum limit of kikaichus.")
        return false
    end

    if level < 10 then
        doPlayerSendCancel(cid, "You need level 10 to summon kikaichus.")
        return false
    end

    local monsterIndex = math.min(30, math.floor((level - 10) / 5) + 1)
    local monsterName = "kikaichu[" .. monsterIndex .. "]"
    
    local manaCost = 10 + ((monsterIndex - 1) * 2)

    if getPlayerMana(cid) < manaCost then
        doPlayerSendCancel(cid, "Not enough chakra.")
        return false
    end

    local creature = doCreateMonster(monsterName, getThingPos(cid))
    if creature then
        doConvinceCreature(cid, creature)
        doPlayerRemoveMana(cid, manaCost)
        doSendMagicEffect(getThingPos(creature), 10)

        local playerSpeed = getCreatureSpeed(cid)
        doChangeSpeed(creature, -getCreatureSpeed(creature) + playerSpeed)
        
        if monsterIndex >= 21 then
            registerCreatureEvent(creature, "summon1")
        end
    end

    return true
end