function onCastSpell(cid, var)
    local playerLevel = getPlayerLevel(cid)
    local playerName = getCreatureName(cid)
    local playerSpeed = getCreatureSpeed(cid)
    local summons = getCreatureSummons(cid)
    local playerPos = getThingPos(cid)
    
    local MAX_SUMMONS = 1 
    local LAST_BUNSHIN_LEVEL = 5 

    local currentBunshinCount = 0
    if summons and #summons > 0 then
        for i = 1, #summons do
            local summon = summons[i]
            if getCreatureName(summon):lower() == playerName:lower() then 
                currentBunshinCount = currentBunshinCount + 1
            end
        end
    end

    if currentBunshinCount >= MAX_SUMMONS then
        doPlayerSendCancel(cid, "Você já possui um Bunshin ativo.")
        doSendMagicEffect(playerPos, 2) 
        return false
    end

    local bunshinNumber = math.floor(playerLevel / 10)
    if bunshinNumber < 1 then bunshinNumber = 1 end 
    if bunshinNumber > LAST_BUNSHIN_LEVEL then bunshinNumber = LAST_BUNSHIN_LEVEL end
    
    local monsterToSummon = bunshinNumber .. "bunshin"

    local spawnPos = getClosestFreeTile(cid, playerPos)
    if not spawnPos or getTilePzInfo(spawnPos) then
        doPlayerSendCancel(cid, "Você só pode invocar um Bunshin.")
        doSendMagicEffect(playerPos, 2)
        return false
    end

    local clone = createBunshin(monsterToSummon, spawnPos, cid)

    if isCreature(clone) then
        doConvinceCreature(cid, clone)
        doChangeSpeed(clone, -getCreatureSpeed(clone) + playerSpeed)
        doSendMagicEffect(spawnPos, 10)
        return true
    else
        doPlayerSendCancel(cid, "Invocação falhou: Monstro " .. monsterToSummon .. " não encontrado.")
        return false
    end
end