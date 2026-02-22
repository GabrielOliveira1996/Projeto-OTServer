local config = {
    loginMessage = getConfigValue('loginMessage')
}

function onLogin(cid)
    -- configuração de perda de experiencia ao morrer
    local loss = getConfigValue('deathLostPercent')
    if(loss ~= nil) then        
        doPlayerSetLossPercent(cid, PLAYERLOSS_EXPERIENCE, loss * 10)
    end

    local accountManager = getPlayerAccountManager(cid)
    
    if(accountManager == MANAGER_NONE) then
        local lastLogin, str = getPlayerLastLoginSaved(cid), config.loginMessage
        
        if(lastLogin > 0) then      
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, str)
            str = "Your last visit was on " .. os.date("%a %b %d %X %Y", lastLogin) .. "."
        end
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, str)

    elseif(accountManager == MANAGER_NAMELOCK) then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, it appears that your character has been namelocked, what would you like as your new name?")
    elseif(accountManager == MANAGER_ACCOUNT) then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, type 'account' to manage your account and if you want to start over then type 'cancel'.")
    else
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Hello, type 'account' to create an account or type 'recover' to recover an account.")
    end

    -- efeito visual de login
    if(not isPlayerGhost(cid)) then
        doSendMagicEffect(getCreaturePosition(cid), CONST_ME_TELEPORT)
    end

    -- registro de eventos 
    setPlayerStorageValue(cid, 305, -1) -- desativa sozo sasei ao logar
    registerCreatureEvent(cid, "AllyProtect") -- party protect
    registerCreatureEvent(cid, "Mail")
    registerCreatureEvent(cid, "GuildMotd")
    --registerCreatureEvent(cid, "killer")
    registerCreatureEvent(cid, "Idle")
    registerCreatureEvent(cid, "attackguild")   
    registerCreatureEvent(cid, "SkullCheck")
    registerCreatureEvent(cid, "ReportBug")
    registerCreatureEvent(cid, "LookTypes")
    registerCreatureEvent(cid, "TransformVoc")
    registerCreatureEvent(cid, "Corpse")
    registerCreatureEvent(cid, "Buff")
    registerCreatureEvent(cid, "VocationHpeMana")
    registerCreatureEvent(cid, "VocationHpeManaOne")
    registerCreatureEvent(cid, "VocationHpeManaTwo")
    registerCreatureEvent(cid, "akatsukiring") -- akatsuki ring
    registerCreatureEvent(cid, "mkillm")
    registerCreatureEvent(cid, "Gennin") -- sistema de genin
    registerCreatureEvent(cid, "Bunshin") -- naruto
    registerCreatureEvent(cid, "Summon") 
    registerCreatureEvent(cid, "Summon1") 
    registerCreatureEvent(cid, "Summon2") 
    registerCreatureEvent(cid, "sharingan") -- sasuke -- desativa ao deslogar
    registerCreatureEvent(cid, "byakugan") -- clã hyuuga -- desativa ao deslogar
    registerCreatureEvent(cid, 301, -1) -- sasuke susanoo -- desativa ao deslogar
    registerCreatureEvent(cid, 302, -1) -- sasuke susanoo -- desativa ao deslogar

    -- logica da Arena
    if (InitArenaScript ~= 0) then
        InitArenaScript = 1
        for i = 42300, 42309 do
            setGlobalStorageValue(i, 0)
            setGlobalStorageValue(i+100, 0)
        end
    end

    if getPlayerStorageValue(cid, 42309) < 1 then
        for i = 42300, 42309 do
            setPlayerStorageValue(cid, i, 0)
        end
        setPlayerStorageValue(cid, 14755, -1)
    end

    if getPlayerStorageValue(cid, 42319) < 1 then
        for i = 42310, 42319 do
            setPlayerStorageValue(cid, i, 0)
        end
    end

    if getPlayerStorageValue(cid, 42329) < 1 then
        for i = 42320, 42329 do
            setPlayerStorageValue(cid, i, 0)
        end
    end

    if getPlayerStorageValue(cid, 42355) == -1 then
        setPlayerStorageValue(cid, 42355, 0)
    end

    if(getPlayerStorageValue(cid, 1337) == 1) then
        return false
    end

    -- inicialização de storages ao Logar
    setPlayerStorageValue(cid, 42350, 0) -- time to kick.
    setPlayerStorageValue(cid, 42352, 0) -- is not in arena.
    setPlayerStorageValue(cid, 11109, 1) -- saga inicial.
    setPlayerStorageValue(cid, 92000, 1) -- ryuu mission.
    setPlayerStorageValue(cid, 14755, -1)
    setPlayerStorageValue(cid, 312345, -1) -- reset do sharingan ao logar.

    -- logica de Missões e storages especificas
    local storagecheck = 31313
    local storagelose = 11109
    if getPlayerStorageValue(cid, storagecheck) >= 1 then
        setPlayerStorageValue(cid, storagelose, -1)
    end

    local storagelose1 = 92000
    if getPlayerStorageValue(cid, 92001) >= 1 and getPlayerStorageValue(cid, 92002) >= 1 and getPlayerStorageValue(cid, 92003) >= 1 then
        setPlayerStorageValue(cid, storagelose1, -1)
    end

    -- mantem a vocação salva no storage 1992
    if getPlayerStorageValue(cid, 1992) ~= -1 then
        doPlayerSetVocation(cid, getPlayerStorageValue(cid, 1992))
    end 

    -- envio de dados do akamaru
    addEvent(function()
        if isPlayer(cid) then
            doUpdateAkamaruClient(cid)
        end
    end, 1000)

    return true
end