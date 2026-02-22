function onStatsChange(cid, attacker, type, combat, value)
    -- Se não houver atacante ou o dano não for de perda de vida, ignora
    if not isCreature(attacker) or not isCreature(cid) then return true end
    if type ~= STATSCHANGE_HEALTHLOSS then return true end

    -- Verifica se ambos são Players
    if isPlayer(cid) and isPlayer(attacker) then
        
        -- 1. PROTEÇÃO DE PARTY (GRUPO)
        local attackerParty = getPlayerParty(attacker)
        local targetParty = getPlayerParty(cid)
        if attackerParty ~= nil and attackerParty == targetParty then
            return false -- Cancela o dano totalmente
        end
        
        -- 2. PROTEÇÃO DE GUILD (CLÃ)
        local attackerGuild = getPlayerGuildId(attacker)
        local targetGuild = getPlayerGuildId(cid)
        if attackerGuild ~= 0 and attackerGuild == targetGuild then
            return false -- Cancela o dano totalmente
        end
    end

    return true -- Permite o dano se não forem aliados
end