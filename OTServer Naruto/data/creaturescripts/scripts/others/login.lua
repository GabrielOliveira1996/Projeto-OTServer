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

    -- missions
    --jhon
    registerCreatureEvent(cid, "KuroiHasuKill")
    registerCreatureEvent(cid, "KuroiCheckArea")

    -- isac missions    
    registerCreatureEvent(cid, "IsacDungeonMonsterDeathCount")
    registerCreatureEvent(cid, "IsacAndUtakaDeathCondition")
    registerCreatureEvent(cid, "PlayerDeathInMission")
    if getPlayerStorageValue(cid, 2701) == 4 then
        setPlayerStorageValue(cid, 2701, 3) -- Volta para o estágio de pedir ajuda
        setPlayerStorageValue(cid, 2705, 0) -- Reseta as ondas
    end

    -- Daizou missions
    registerCreatureEvent(cid, "DaizouKillCount") -- progresso geral das missões

    -- itens
    registerCreatureEvent(cid, "IsacsSwordProtect") -- combo da espada de isac

    -- taito missions
    registerCreatureEvent(cid, "TaitoKillMission")

    -- registro de eventos 
    setPlayerStorageValue(cid, 305, -1) -- desativa sozo sasei ao logar
    registerCreatureEvent(cid, "AllyProtect") -- party protect
    registerCreatureEvent(cid, "Mail")
    registerCreatureEvent(cid, "GuildMotd")
    --registerCreatureEvent(cid, "killer")
    registerCreatureEvent(cid, "Logout") -- isso ativa eventos
    registerCreatureEvent(cid, "Idle")
    registerCreatureEvent(cid, "attackguild")   
    registerCreatureEvent(cid, "SkullCheck")
    registerCreatureEvent(cid, "ReportBug")
    --registerCreatureEvent(cid, "LookTypes")
    --registerCreatureEvent(cid, "Corpse")
    registerCreatureEvent(cid, "Buff")
    --registerCreatureEvent(cid, "EvolutionOfVocations")
    registerCreatureEvent(cid, "CharacterProgression")
    registerCreatureEvent(cid, "akatsukiring") -- akatsuki ring
    registerCreatureEvent(cid, "mkillm")
    registerCreatureEvent(cid, "Gennin") -- sistema de genin
    registerCreatureEvent(cid, "Bunshin") -- naruto
    registerCreatureEvent(cid, "Summon") 
    registerCreatureEvent(cid, "Summon1") 
    registerCreatureEvent(cid, "Summon2") 
    registerCreatureEvent(cid, "PlayerJutsuList") -- envio da lista de jutsus ao logar
    registerCreatureEvent(cid, "sharingan") -- sasuke -- desativa ao deslogar
    registerCreatureEvent(cid, "byakugan") -- clã hyuuga -- desativa ao deslogar
    setPlayerStorageValue(cid, 301, -1) -- sasuke susanoo -- desativa ao deslogar
    setPlayerStorageValue(cid, 302, -1) -- sasuke susanoo -- desativa ao deslogar
    setPlayerStorageValue(cid, 45001, 0) -- hinata byakugan -- desativa ao deslogar
    setPlayerStorageValue(cid, 45002, 0) -- hinata INVENCIBILIDADE DO SHUGOHAKKE -- desativa ao deslogar
    setPlayerStorageValue(cid, 45003, 0) -- hinata juken -- desativa ao deslogar
    setPlayerStorageValue(cid, 45005, 0) -- hinata jusho soshiken -- desativa ao deslogar
    
    doRemoveCondition(cid, CONDITION_OUTFIT) -- hinata remove a roupa dos leões gêmeos.

    registerCreatureEvent(cid, "MushiExplosion") -- shino mushi bunshin explosion
    --registerCreatureEvent(cid, "ShinoAutoAttack") -- shino auto attack

    -- reset de estados do Sage Mode ao logar
    if getPlayerStorageValue(cid, 45007) == 1 then 
        setPlayerStorageValue(cid, 45007, 0)
        doCreatureSetNoMove(cid, false) 
    end
    if getPlayerStorageValue(cid, 45008) == 1 then 
        setPlayerStorageValue(cid, 45008, 0)
    end
    if getPlayerStorageValue(cid, 45009) == 1 then 
        setPlayerStorageValue(cid, 45009, 0)
    end
    if getPlayerStorageValue(cid, 45010) == 1 then 
        setPlayerStorageValue(cid, 45010, 0)
    end

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
    setPlayerStorageValue(cid, 92000, 1) -- ryuu mission.
    setPlayerStorageValue(cid, 14755, -1)
    setPlayerStorageValue(cid, 312345, -1) -- reset do sharingan ao logar.

    -- logica de inicialização de sagas
    if getPlayerStorageValue(cid, 11000) < 1 then
        setPlayerStorageValue(cid, 11000, 1) -- Começa no Estágio 1 (Iruka)
    end

    local storagelose1 = 92000
    if getPlayerStorageValue(cid, 92001) >= 1 and getPlayerStorageValue(cid, 92002) >= 1 and getPlayerStorageValue(cid, 92003) >= 1 then
        setPlayerStorageValue(cid, storagelose1, -1)
    end

    -- Reset da Saga Escolta (Demon Brothers) ao deslogar/logar
    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    local demonBrosStatus = getPlayerStorageValue(cid, SAGA_AUX_DEMON_BROS_EVENT)

    -- Só reseta se ele estiver na fase de escolta E o evento estiver "aberto" (status 1)
    -- Se já for status 2, NUNCA reseta.
    if status == SAGA_STAGE_WAVES_ESCORT and demonBrosStatus == 1 then
        -- Verificamos se ele realmente matou os 2 antes de resetar (Segurança extra)
        local kills = getPlayerStorageValue(cid, SAGA_AUX_DEMON_BROS_KILLCOUNT)
        if kills < 2 then
            setPlayerStorageValue(cid, SAGA_AUX_DEMON_BROS_EVENT, 0) 
            setPlayerStorageValue(cid, SAGA_AUX_DEMON_BROS_KILLCOUNT, 0)
        else
            -- Se por algum motivo ele tem 2 kills mas o status ainda era 1, corrigimos agora
            setPlayerStorageValue(cid, SAGA_AUX_DEMON_BROS_EVENT, 2)
        end
    end


    -- kiba fusion
    local STORAGE_IS_FUSED = 16000 
    local STORAGE_BONUS_SPEED = 16004

    if getPlayerStorageValue(cid, STORAGE_IS_FUSED) > 0 then
        doRemoveCondition(cid, CONDITION_ATTRIBUTES)
        doRemoveCondition(cid, CONDITION_OUTFIT)

        local bSpeed = getPlayerStorageValue(cid, STORAGE_BONUS_SPEED)
        if bSpeed > 0 then
            doChangeSpeed(cid, -bSpeed)
        end

        setPlayerStorageValue(cid, STORAGE_IS_FUSED, -1)
        setPlayerStorageValue(cid, STORAGE_BONUS_SPEED, 0)
    end

    -- mantem a vocação salva no storage 1992
    --if getPlayerStorageValue(cid, 1992) ~= -1 then
    --    doPlayerSetVocation(cid, getPlayerStorageValue(cid, 1992))
    --end 

    -- envio de dados do akamaru
    --addEvent(function()
        --if isPlayer(cid) then
            --doUpdateAkamaruClient(cid)
        --end
    --end, 1000)

    return true
end