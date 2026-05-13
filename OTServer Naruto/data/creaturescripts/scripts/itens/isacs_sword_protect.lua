function onStatsChange(cid, attacker, type, combat, value)
    -- Verifica se quem está recebendo o dano é um Player e se é perda de vida
    if not isPlayer(cid) or type ~= STATSCHANGE_HEALTHLOSS or value <= 0 then 
        return true 
    end

    -- Verifica se o Player está segurando a Tanto de Isac (ID 2431)
    local leftHand = getPlayerSlotItem(cid, CONST_SLOT_LEFT).itemid
    local rightHand = getPlayerSlotItem(cid, CONST_SLOT_RIGHT).itemid
    
    if leftHand == 2431 or rightHand == 2431 then
        -- Cálculo da cura (20% do dano recebido)
        local healing = math.floor(value * 0.20)
        
        if healing > 0 then
            -- Usamos addEvent de 1ms para a cura acontecer logo após o dano ser computado
            addEvent(function()
                if isCreature(cid) then
                    doCreatureAddHealth(cid, healing)
                    doSendMagicEffect(getCreaturePosition(cid), 12) -- Efeito visual de cura
                    doSendAnimatedText(getCreaturePosition(cid), "+" .. healing, 30) -- Texto verde
                end
            end, 1)
        end
    end

    return true
end