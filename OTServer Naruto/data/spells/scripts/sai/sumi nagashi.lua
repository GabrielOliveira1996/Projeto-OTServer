function onCastSpell(cid, var)

    if #getCreatureSummons(cid) > 3 then
            doPlayerSendCancel(cid, "Você não pode summonar mais Snakes.")
    return false
    end
    
    local summon, useCreateMonster = 3, false
            
    if type(doSummonMonster) then
            summon = doSummonMonster(cid, "Paralize Snake")
            if summon == 4 then
                    doPlayerSendCancel(cid, "Você não pode summonar mais Snakes.")
            return false
            end
            summon = getCreatureSummons(cid)
            summon = summon[#summon]
            if isCreature(summon) and getCreatureMaster(summon) == cid then
                    doSendMagicEffect(getThingPos(summon), CONST_ME_MAGIC_BLUE)
                    return true
            else
                    useCreateMonster = true
            end
    else
            useCreateMonster = true
    end
    
    if useCreateMonster then
            local pos = getThingPos(cid)
            pos.y = pos.y + 1
            summon = doCreateMonster("Paralize Snake", pos, false)
            if summon == true then
                    doPlayerSendCancel(cid, "Você não pode summonar mais Snakes.")
            return false
            end
    end
    
    if not isCreature(summon) then return false end
    doConvinceCreature(cid, summon)
    if getCreatureMaster(summon) ~= cid then
            doRemoveCreature(summon)
    return false
    end
    
    doSendMagicEffect(getThingPos(summon), CONST_ME_MAGIC_BLUE)
return true
end