function onCastSpell(cid, var)
    local playerLevel = getPlayerLevel(cid)
    local playerName = getCreatureName(cid):lower()
    local summons = getCreatureSummons(cid)
    local getSkill = getPlayerSkillLevel(cid, 6)
    local voc = getPlayerVocation(cid)
    
    -- variavel deve ter o nivel maximo dos bunshins.
    -- lmebrar que isso tambem reflete a quantidade de bunshins que foram criados em monsters.
    -- exemplo: bunhin1, bunshin2 e etc...
    local LAST_BUNSHIN_LEVEL = 10 

    -- limite de invocacoes por niveis
    local MaxSummon = 1 
    if playerLevel >= 40 then
        MaxSummon = 4
    elseif playerLevel >= 30 then
        MaxSummon = 3
    elseif playerLevel >= 20 then
        MaxSummon = 2
    end

    -- contagem de bunshins invocados
    local currentBunshinCount = 0
    if summons and #summons > 0 then
        for i = 1, #summons do
            local summon = summons[i]
            if getCreatureName(summon):lower() == playerName then 
                currentBunshinCount = currentBunshinCount + 1
            end
        end
    end

    if currentBunshinCount >= MaxSummon then
        doPlayerSendCancel(cid, "Your current level allows only " .. MaxSummon .. " Bunshins.")
        doSendMagicEffect(getThingPos(cid), 2)
        return false
    end

    -- controle de chakra para utilizar bunshins com kyuubi
    local reqs = {[64] = 20, [65] = 30, [66] = 40, [67] = 50}
    if reqs[voc] and getSkill < reqs[voc] then
        doPlayerSendCancel(cid, "You cannot control your chakra to create Bunshins in this form.")
        doSendMagicEffect(getThingPos(cid), 73)
        return false
    end

    local bunshinNumber = math.floor(playerLevel / 10)
    if bunshinNumber < 1 then bunshinNumber = 1 end 
    if bunshinNumber > LAST_BUNSHIN_LEVEL then bunshinNumber = LAST_BUNSHIN_LEVEL end
    
    local monsterToSummon = bunshinNumber .. "bunshin"

    -- posicao de spawn
    local playerpos = getPlayerPosition(cid)
    local spawnPos = getClosestFreeTile(cid, playerpos)
    
    if not spawnPos or (getTilePzInfo(spawnPos)) then
        doPlayerSendCancel(cid, "There is not enough room to summon a Bunshin.")
        doSendMagicEffect(playerpos, 2)
        return false
    end

    -- criacao de clone
    local clone = createBunshin(monsterToSummon, spawnPos, cid)
    
    if isCreature(clone) then
        doConvinceCreature(cid, clone)
        doSendMagicEffect(spawnPos, 2)
        return true
    else
        -- caso o summon falhe por alguma erro inesperado, nessario enviar para o log ~~ verificar.
        doPlayerSendCancel(cid, "Failed to create Bunshin.")
        return false
    end
end