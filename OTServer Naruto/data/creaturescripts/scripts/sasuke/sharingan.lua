function onStatsChange(cid, attacker, type, combat, value)
    -- Verifica se quem recebe o dano é um jogador e se é perda de vida
    if isPlayer(cid) and (type == STATSCHANGE_HEALTHLOSS) then
        
        -- Verifica se o Sharingan está Ativo (Storage 10001)
        if getPlayerStorageValue(cid, 312345) > 0 then
            
            -- Verifica se o dano é físico ou distância (Taijutsu/Kunai)
            if combat == COMBAT_PHYSICALDAMAGE or combat == COMBAT_DISTANCEDAMAGE then
                
                -- Chance de 15% de esquivar
                if math.random(1, 100) <= 15 then
                    doSendMagicEffect(getCreaturePosition(cid), 26)
                    doSendAnimatedText(getCreaturePosition(cid), "DODGE!", 180) -- Texto subindo
                    return false -- Retornar false cancela o dano no statschange
                end
            end
        end
    end

    return true
end