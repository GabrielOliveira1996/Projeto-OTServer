function onStatsChange(cid, attacker, type, combat, value)
    if type == STATSCHANGE_HEALTHLOSS and isPlayer(cid) then
        if getPlayerStorageValue(cid, 302) > 0 then
            return true
        end
        
        if getPlayerStorageValue(cid, 301) > 0 then
            if (getCreatureHealth(cid) / getCreatureMaxHealth(cid)) > 0.20 then
                return false 
            else
                setPlayerStorageValue(cid, 301, -1)
                -- mensagem de quebra do susanoo por dano
                doPlayerSendTextMessage(cid, 22, "Your Susano'o has dissipated!")
                return true
            end
        end
    end
    return true
end