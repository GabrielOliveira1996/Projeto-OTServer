local config = {
    deathListEnabled = getBooleanFromString(getConfigInfo('deathListEnabled')),
    sqlType = getConfigInfo('sqlType'),
    maxDeathRecords = getConfigInfo('maxDeathRecords')
}

config.sqlType = config.sqlType == "sqlite" and DATABASE_ENGINE_SQLITE or DATABASE_ENGINE_MYSQL

function onDeath(cid, corpse, lastHitKiller, mostDamageKiller)
    if(config.deathListEnabled ~= TRUE) then
        return
    end

    -- REMOVIDO: Toda a lógica de capturar nomes de killers e a query de INSERT.
    -- O C++ (IOLoginData::playerDeath) já faz o registro da morte automaticamente.

    local playerGuid = getPlayerGUID(cid)

    -- MANTER APENAS A LIMPEZA: Isso garante que o jogador tenha apenas o limite de mortes configurado.
    local rows = db.getResult("SELECT `id` FROM `player_deaths` WHERE `player_id` = " .. playerGuid .. ";")
    if(rows:getID() ~= -1) then
        local amount = rows:getRows(true) - config.maxDeathRecords
        if(amount > 0) then
            if(config.sqlType == DATABASE_ENGINE_SQLITE) then
                for i = 1, amount do
                    db.executeQuery("DELETE FROM `player_deaths` WHERE `rowid` = (SELECT `rowid` FROM `player_deaths` WHERE `player_id` = " .. playerGuid .. " ORDER BY `date` LIMIT 1);")
                end
            else
                -- Deleta os registros mais antigos se passar do limite (ex: 10 mortes)
                db.executeQuery("DELETE FROM `player_deaths` WHERE `player_id` = " .. playerGuid .. " ORDER BY `date` LIMIT " .. amount .. ";")
            end
        end
        rows:free() 
    end

    -- Se você quiser adicionar um efeito visual ao morrer, pode colocar aqui:
    -- doSendMagicEffect(getPlayerPosition(cid), CONST_ME_POFF)
end