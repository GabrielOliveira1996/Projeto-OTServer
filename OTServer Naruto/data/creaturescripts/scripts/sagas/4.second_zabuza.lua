local cfg = {
    zabuza_npc = "Zabuza", 
    haku_npc = "Haku",     
    gato_npc = "Gato",     
    capanga_npc = "Bandit", 
    effect_shunshin = 10, 
    effect_blood = 0,     
    effect_snow = 79,    
    bridge_lock_storage = SAGA_AUX_BRIDGE_LOCK_STORAGE, 
    scene_duration = 140, -- Tempo total da trava
    -- Recompensas
    kubikiribocho = 2407,
    haku_outfit_item = 2486,
    chance = 2 -- 2%
}

function onDeath(cid, corpse, killer)
    if getCreatureName(cid):lower() ~= "zabuza momochi [the final mist]" then return true end

    -- TRAVA RIGIDA NO TAZUNA
    setGlobalStorageValue(cfg.bridge_lock_storage, os.time() + cfg.scene_duration)

    local deathPos = getThingPos(cid)
    local players = {}
    for i = 1, #killer do
        if isPlayer(killer[i]) then table.insert(players, killer[i]) end
    end
    local mainKiller = players[1]

    addEvent(function() if isCreature(cid) then doRemoveCreature(cid) end end, 100)

    local zabuzaID, hakuID, gatoID = 0, 0, 0
    local bandits = {}

    -- [CENÁRIO - TEMPOS E FALAS ORIGINAIS]
    addEvent(function()
        for _, pid in ipairs(players) do
            doPlayerSendTextMessage(pid, MESSAGE_EVENT_ADVANCE, "Haku se sacrificou para salvar o Zabuza... O destino de uma ferramenta termina aqui.")
        end
        hakuID = doCreateNpc(cfg.haku_npc, deathPos)
        zabuzaID = doCreateNpc(cfg.zabuza_npc, {x = deathPos.x + 1, y = deathPos.y, z = deathPos.z})
        if isCreature(zabuzaID) then
            doCreatureSetLookDir(zabuzaID, 3)
            doSendMagicEffect(getThingPos(zabuzaID), 2)
            doCreatureSay(zabuzaID, "Haku... Agora acabou. A sua utilidade chegou ao fim...", TALKTYPE_SAY)
        end
    end, 1000)

    addEvent(function() if isCreature(zabuzaID) then doCreatureSay(zabuzaID, "Como uma ferramenta, ele apenas cumpriu o seu papel ate o fim.", TALKTYPE_SAY) end end, 8000)

    addEvent(function()
        local gatoPos = {x = deathPos.x - 4, y = deathPos.y, z = deathPos.z}
        gatoID = doCreateNpc(cfg.gato_npc, gatoPos)
        if isCreature(gatoID) then
            doCreatureSetLookDir(gatoID, 1)
            doSendMagicEffect(gatoPos, 2)
            doCreatureSay(gatoID, "Zabuza, voce me decepcionou. Olhe o seu estado... Eu nao pago fracassados. O contrato acabou!", TALKTYPE_SAY)
        end
    end, 14000)

    addEvent(function() if isCreature(gatoID) then doCreatureSay(gatoID, "Kukuku! Olhe so para esse lixo no chao. Esse pirralho morreu de uma forma patetica!", TALKTYPE_SAY) end end, 20000)

    addEvent(function() if isPlayer(mainKiller) then doCreatureSay(mainKiller, "ZABUZA, COMO VOCE PODE PERMITIR ISSO?!", TALKTYPE_SAY) end end, 26000)
    addEvent(function() if isCreature(zabuzaID) then doCreatureSay(zabuzaID, "Cale a boca garoto... O haku esta morto, o que importa?", TALKTYPE_SAY) end end, 32000)
    addEvent(function() if isPlayer(mainKiller) then doCreatureSay(mainKiller, "Entao voce vai ficar vendo ele tratar o Haku assim?", TALKTYPE_SAY) end end, 38000)
    addEvent(function() if isCreature(zabuzaID) then doCreatureSay(zabuzaID, "Garoto... voce nao entende o jeito shinobi. Eu o usei como o Gato me usou.", TALKTYPE_SAY) end end, 44000)
    addEvent(function() if isPlayer(mainKiller) then doCreatureSay(mainKiller, "Seu ingrato. Haku te amava, ele viveu por voce!", TALKTYPE_SAY) end end, 50000)
    addEvent(function() if isCreature(zabuzaID) then doCreatureSay(zabuzaID, "Voce fala demais.", TALKTYPE_SAY) end end, 56000)
    addEvent(function() if isCreature(zabuzaID) then doCreatureSay(zabuzaID, "Suas palavras cortam mais fundo do que qualquer lamina.", TALKTYPE_SAY) end end, 62000)
    addEvent(function() if isCreature(zabuzaID) then doCreatureSay(zabuzaID, "Sabe, Haku sempre foi muito suave e gentil. E agora, por sua culpa, eu sinto isso tambem.", TALKTYPE_SAY) end end, 68000)
    addEvent(function() if isPlayer(mainKiller) then doCreatureSay(mainKiller, "...", TALKTYPE_SAY) end end, 72000)
    addEvent(function() if isCreature(zabuzaID) then doCreatureSay(zabuzaID, "O que foi, o gato comeu a sua lingua?!", TALKTYPE_SAY) end end, 78000)
    addEvent(function() if isCreature(zabuzaID) then doCreatureSay(zabuzaID, "Ate os shinobis sao humanos...", TALKTYPE_SAY) end end, 84000)
    addEvent(function() if isCreature(zabuzaID) then doCreatureSay(zabuzaID, "Garoto, me de sua kunai.", TALKTYPE_SAY) end end, 90000)

    -- [MASSACRE]
    addEvent(function()
        if isCreature(gatoID) then
            doCreatureSay(gatoID, "Chega dessa conversa fiada! Homens, matem todos!", TALKTYPE_SAY)
            local gPos = getThingPos(gatoID)
            for i = 1, 5 do 
                local bandit = doCreateNpc(cfg.capanga_npc, {x = gPos.x + math.random(-2, 2), y = gPos.y + math.random(-3, 3), z = gPos.z})
                if bandit then 
                    table.insert(bandits, bandit) 
                    doCreatureSetLookDir(bandit, 1)
                    doSendMagicEffect(getThingPos(bandit), 10)
                end
            end
        end
    end, 94000)

    addEvent(function()
        if isCreature(zabuzaID) then
            for i, bID in ipairs(bandits) do
                addEvent(function()
                    if isCreature(zabuzaID) and isCreature(bID) then
                        doTeleportThing(zabuzaID, getThingPos(bID))
                        doSendMagicEffect(getThingPos(bID), cfg.effect_blood)
                        doSendMagicEffect(getThingPos(zabuzaID), 10)
                        doRemoveCreature(bID)
                    end
                end, i * 1000)
            end
        end
    end, 96000)

    addEvent(function()
        if isCreature(zabuzaID) and isCreature(gatoID) then
            doCreatureSay(zabuzaID, "Gato... voce vai para o inferno comigo!", TALKTYPE_SAY)
            doTeleportThing(zabuzaID, getThingPos(gatoID))
            doSendMagicEffect(getThingPos(zabuzaID), 10)
            addEvent(doRemoveCreature, 500, gatoID)
        end
    end, 100000)

    -- [FINALIZAÇÃO E RECOMPENSAS]
    addEvent(function()
        if isCreature(zabuzaID) then
            doTeleportThing(zabuzaID, {x = deathPos.x + 1, y = deathPos.y, z = deathPos.z})
            doSendMagicEffect(getThingPos(zabuzaID), 10)
            doCreatureSay(zabuzaID, "Haku... voce esta ai? Gostaria de poder te ver... uma ultima vez...", TALKTYPE_SAY)
        end
    end, 104000)

    addEvent(function()
        for i = 1, 15 do
            addEvent(function()
                local snowPos = {x = deathPos.x + math.random(-5, 5), y = deathPos.y + math.random(-5, 5), z = deathPos.z}
                doSendMagicEffect(snowPos, cfg.effect_snow) 
            end, i * 500)
        end
    end, 108000)

    addEvent(function()
        if isCreature(zabuzaID) then 
            doCreatureSay(zabuzaID, "Se for possivel... eu gostaria de ir para o mesmo lugar que voce...", TALKTYPE_SAY) 
        end
        
        -- Lógica de Drop e Missão para os jogadores
        for _, pid in ipairs(players) do
            if isPlayer(pid) then
                doPlayerAddExperience(pid, 200000)
                doPlayerSendTextMessage(pid, MESSAGE_STATUS_CONSOLE_ORANGE, "Voce recebeu 200.000 pontos de experiencia pela conclusao do arco.")

                -- Sorteio da Kubikiribocho (2%)
                if math.random(1, 100) <= cfg.chance then
                    doPlayerAddItem(pid, cfg.kubikiribocho, 1)
                    doPlayerSendTextMessage(pid, MESSAGE_EVENT_ORANGE, "Voce obteve a lendaria Kubikiribocho!")
                end
                
                -- Sorteio da Roupa do Haku (2%)
                if math.random(1, 100) <= cfg.chance then
                    doPlayerAddItem(pid, cfg.haku_outfit_item, 1)
                    doPlayerSendTextMessage(pid, MESSAGE_EVENT_ORANGE, "Voce obteve os trajes de Haku!")
                end

                -- Atualização da Storage de Saga
                setPlayerStorageValue(pid, SAGA_STORAGE, SAGA_STAGE_FIRST_REAL_MISSION_COMPLETED)
                -- Mensagem Final de Conclusão
                doPlayerSendTextMessage(pid, MESSAGE_EVENT_ADVANCE, "Missao concluida! O pais das Ondas agora esta em paz. Retorne para Konoha e relate ao Hokage!")
            end
        end
    end, 112000)

    -- [NOVO ADDEVENT: LIMPEZA DOS NPCS]
    addEvent(function()
        if isCreature(zabuzaID) then 
            doSendMagicEffect(getThingPos(zabuzaID), 2)
            doRemoveCreature(zabuzaID) 
        end
        if isCreature(hakuID) then 
            doSendMagicEffect(getThingPos(hakuID), 2)
            doRemoveCreature(hakuID) 
        end
        -- Libera a ponte para o próximo
        setGlobalStorageValue(cfg.bridge_lock_storage, 0)
    end, 128000)

    return false 
end