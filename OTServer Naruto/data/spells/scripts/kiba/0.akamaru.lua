function onCastSpell(cid, var)
    local summonName = "Akamaru"
    local summons = getCreatureSummons(cid)

    ---------------------------------------------------------
    -- TRAVA DE FUSÃO: Impede sumon se estiver transformado
    ---------------------------------------------------------
    if getPlayerStorageValue(cid, STORAGE_IS_FUSED) > 0 then
        doPlayerSendCancel(cid, "Você não pode invocar o Akamaru enquanto estiver fundido.")
        doSendMagicEffect(getThingPos(cid), 2)
        return false
    end
    ---------------------------------------------------------

    local isDead, timeLeft, currentHp = getAkamaruState(cid)

    -- Verificação de morte/tempo de espera
    if isDead then
        if timeLeft > 0 then
            local minutes = math.floor(timeLeft / 60)
            local seconds = timeLeft % 60
            
            local timeStr = ""
            if minutes > 0 then
                timeStr = minutes .. "m e " .. seconds .. "s"
            else
                timeStr = seconds .. "s"
            end

            doPlayerSendCancel(cid, "Seu Akamaru esta ferido. Aguarde " .. timeStr .. ".")
            doSendMagicEffect(getThingPos(cid), 2) 
            return false
        end
    end

    -- Verifica se já está sumonado (usando o identificador que a Source reconhece)
    for _, summon in ipairs(summons) do
        if getCreatureStorage(summon, STORAGE_AKAMARU_IDENTIFIER) == 1 then
            doPlayerSendCancel(cid, "Seu Akamaru já está ao seu lado.")
            return false
        end
    end

    local pos = getThingPos(cid)
    local monster = doCreateMonster(summonName, pos)
    
    if monster then
        -- Ativa os atributos na Source via identificador
        doCreatureSetStorage(monster, STORAGE_AKAMARU_IDENTIFIER, 1)
        doConvinceCreature(cid, monster)

        -- LÓGICA DE OUTFIT/ADDON
        local baseOutfit = getAkamaruOutfit(cid)
        if baseOutfit and baseOutfit > 0 then
            doSetCreatureOutfit(monster, {lookType = baseOutfit}, -1)
        end

        -- Sincronização de HP (Essencial para não nascer sempre Full HP)
        if currentHp and currentHp > 0 then
            local maxHP = getCreatureMaxHealth(monster)
            if currentHp < maxHP then
                doCreatureAddHealth(monster, -(maxHP - currentHp))
            end
        end
        
        doSendMagicEffect(getThingPos(monster), 10) 
        return true
    end
    
    return false
end