local function getSummonObj(cid, name)
    local summons = getCreatureSummons(cid)
    for _, s in ipairs(summons or {}) do
        if getCreatureName(s) == name then return s end
    end
    return nil
end

function onStepIn(cid, item, position, fromPosition)
    if not isPlayer(cid) then return true end
    
    local st = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)
    local wave = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC_WAVES)

    -- [1] ENTRANCE (ActionID 5945)
    if item.actionid == 5945 then
        -- Only allows entry if the player is currently in the saving stage
        if st ~= ISAC_STATUS_SAVING_UTAKA then
            doTeleportThing(cid, fromPosition)
            doSendMagicEffect(fromPosition, 2)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "Voce nao tem motivos para entrar aqui agora.")
            return true
        end
        return true 
    end

    -- [2] EXIT (ActionID 2702)
    if item.actionid == 2702 then
        -- Safety check for refusal/giving up
        if st == ISAC_STATUS_UTAKA_KIDNAPPED then
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Voce desistiu do resgate. Fale com o Isac novamente.")
            return true
        end

        -- Check if player is in the mission window (saving to failed/almost done)
        if st >= ISAC_STATUS_SAVING_UTAKA and st <= 6 then
            -- Wave check: Player must defeat 10 waves before leaving
            if wave < 10 then
                doTeleportThing(cid, fromPosition)
                doSendMagicEffect(fromPosition, 2)
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Derrote as 10 hordas! " .. (wave < 0 and 0 or wave) .. "/10")
                return true
            end

            local sIsac = getSummonObj(cid, "Isac")
            local sUtaka = getSummonObj(cid, "Utaka")

            -- SCENE FINALIZATION LOGIC
            
            -- [FINAL A] BOTH ALIVE
            if sIsac and sUtaka then
                setPlayerStorageValue(cid, STORAGE_MISSION_ISAC, ISAC_STATUS_HERO)
                
                -- Isac speaks before leaving
                doCreatureSay(sIsac, "Eu levarei o Utaka em seguranca para a vila. Tome isto como agradecimento... Ja nao preciso mais dela, vou cuidar do Utaka e viver em paz na vila.", TALKTYPE_SAY)
                
                -- Reward: Isac's Worn Bandana
                doPlayerAddItem(cid, 2323, 1) 
                doSendMagicEffect(getCreaturePosition(cid), 14)
                
                doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Isac entregou sua bandana velha e desgastada. Ele parece decidido em nao retornar para Konoha.")
                
                -- Removal events
                addEvent(function() if isCreature(sIsac) then doRemoveCreature(sIsac) end end, 7000)
                addEvent(function() if isCreature(sUtaka) then doRemoveCreature(sUtaka) end end, 7000)
                
                doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Missao cumprida! Voces sobreviveram! Retorne a vila Kyokai para ver como eles estao.")
            
            -- [FINAL C] ONLY UTAKA DIED (Isac Alive)
            elseif sIsac and not sUtaka then
                setPlayerStorageValue(cid, STORAGE_MISSION_ISAC, ISAC_STATUS_UTAKA_DEAD)
                
                -- Reward: Scroll of Utaka
                doPlayerAddItem(cid, 6132, 1) 
                doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Voce encontrou um pergaminho sujo de poeira nos restos do campo de batalha... O chakra de Utaka ainda pulsa nele.")
                
                doCreatureSay(sIsac, "Eu preciso processar o que aconteceu aqui... nos vemos na vila.", TALKTYPE_SAY)
                addEvent(function() if isCreature(sIsac) then doRemoveCreature(sIsac) end end, 5000)
                doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Utaka morreu. Isac partiu para a vila sozinho.")
            
            -- [FINAL B] ONLY ISAC DIED (Utaka Alive)
            elseif sUtaka and not sIsac then
                setPlayerStorageValue(cid, STORAGE_MISSION_ISAC, ISAC_STATUS_ISAC_DEAD)
                
                doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "O garoto nao esta bem, leve-o em seguranca para a vila kyokai e fale com ele.")
                -- Reward: Isac's Ivory Tanto
                doPlayerAddItem(cid, 2431, 1) 
            
            -- [FINAL D] BOTH DIED
            else
                setPlayerStorageValue(cid, STORAGE_MISSION_ISAC, ISAC_STATUS_BOTH_DEAD)
                doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Ambos morreram. Retorne ao Shikaku para relatar o ocorrido.")
            end
            
            return true
        end

        -- If already finished, just let them walk
        if st >= ISAC_STATUS_HERO then return true end
        
        -- Block anyone else
        doTeleportThing(cid, fromPosition)
        return true
    end

    return true
end