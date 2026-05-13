function onCastSpell(cid, var)
    local summons = getCreatureSummons(cid)
    local akamaruFound = nil
    local bunshinFound = nil
    local akamaruName = ""
    
    -- 1. Localização do Pet (Cachorro ou Bunshin)
    for _, summon in ipairs(summons) do
        if getCreatureStorage(summon, STORAGE_AKAMARU_IDENTIFIER) == 1 then
            if getCreatureName(summon) == getPlayerName(cid) then
                bunshinFound = summon
            else
                akamaruFound = summon
                akamaruName = getCreatureName(summon)
            end
        end
    end

    -- --- TRANSFORMAÇÃO: Akamaru -> Bunshin ---
    if akamaruFound then
        local pos = getThingPos(akamaruFound)
        local currentHP = getCreatureHealth(akamaruFound)
        local maxHP = getCreatureMaxHealth(akamaruFound)
        local pct = currentHP / maxHP
        
        setPlayerStorageValue(cid, STORAGE_AKAMARU_ORIGINAL_NAME, akamaruName) 
        
        doRemoveCreature(akamaruFound)
        doSendMagicEffect(pos, 2)
        
        local newBunshin = createBunshin(akamaruName, pos, cid) 
        if newBunshin then
            doCreatureSetStorage(newBunshin, STORAGE_AKAMARU_IDENTIFIER, 1)
            doConvinceCreature(cid, newBunshin)
            
            -- O Bunshin geralmente herda o visual do Player, 
            -- então não mexemos no outfit aqui (o createBunshin já cuida disso).
            
            local newMax = getCreatureMaxHealth(newBunshin)
            local healthToSet = math.max(1, math.floor(newMax * pct))
            doCreatureAddHealth(newBunshin, -(newMax - healthToSet))
        end
        return true

    -- --- REVERSÃO: Bunshin -> Akamaru ---
    elseif bunshinFound then
        local pos = getThingPos(bunshinFound)
        local originalName = getPlayerStorageValue(cid, STORAGE_AKAMARU_ORIGINAL_NAME)
        local currentHP = getCreatureHealth(bunshinFound)
        local maxHP = getCreatureMaxHealth(bunshinFound)
        local pct = currentHP / maxHP
        
        if originalName == -1 or originalName == "" then originalName = "Akamaru" end
        
        doRemoveCreature(bunshinFound)
        doSendMagicEffect(pos, 2)
        
        local akamaru = doSummonCreature(originalName, pos)
        if akamaru then
            doCreatureSetStorage(akamaru, STORAGE_AKAMARU_IDENTIFIER, 1)
            doConvinceCreature(cid, akamaru)

            ---------------------------------------------------------
            -- RESTAURAÇÃO DO ADDON (PULO DO GATO)
            ---------------------------------------------------------
            local baseOutfit = getAkamaruOutfit(cid)
            if baseOutfit and baseOutfit > 0 then
                -- Forçamos o visual do Akamaru a voltar para o Addon salvo
                doSetCreatureOutfit(akamaru, {lookType = baseOutfit}, -1)
            end
            ---------------------------------------------------------
            
            local newMax = getCreatureMaxHealth(akamaru)
            local healthToSet = math.max(1, math.floor(newMax * pct))
            doCreatureAddHealth(akamaru, -(newMax - healthToSet))
        end
        return true
    else
        doPlayerSendCancel(cid, "Você precisa do Akamaru para usar este jutsu.")
        doSendMagicEffect(getThingPos(cid), 2)
        return false
    end
end