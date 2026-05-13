function onStatsChange(cid, attacker, type, combat, value)
    -- Verifica se quem recebe o dano é um jogador e se é perda de vida
    if isPlayer(cid) and (type == STATSCHANGE_HEALTHLOSS) then
        
        -- Verifica se o Sharingan está engatilhado (Storage 312345)
        if getPlayerStorageValue(cid, STORAGE_SHARINGAN) > 0 then
            
            -- Dodge 100% garantido
            doSendMagicEffect(getCreaturePosition(cid), 26) -- Efeito visual do dodge
            doSendAnimatedText(getCreaturePosition(cid), "DODGE!", 180)
            
            -- DESATIVA o storage para o próximo ataque não ter dodge
            setPlayerStorageValue(cid, STORAGE_SHARINGAN, -1)
            
            return false -- Cancela 100% deste dano atual
        end
    end

    return true
end