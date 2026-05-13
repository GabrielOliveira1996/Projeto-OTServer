function onDeath(cid, corpse, deathList)
    -- Configurações de Identidade e Itens
    local monstName = "Zabuza Momochi [Hidden Mist]"
    local npcName = "Haku"
    local swordId = 2407
    local swordChance = 2 -- 2% de chance
    
    local players = {}
    local haku_pos = getThingPos(cid)

    -- Verifica se quem morreu foi o Zabuza da Saga
    if isMonster(cid) and getCreatureName(cid) == monstName then
        
        -- 1. SISTEMA DE RECOMPENSA (Drop e Identificação de Players)
        for _, check in ipairs(deathList) do
            if isPlayer(check) then
                table.insert(players, check)
            elseif isSummon(check) then
                local master = getCreatureMaster(check)
                if isPlayer(master) then table.insert(players, master) end
            end
        end

        -- Remove duplicatas para evitar múltiplos loots ao mesmo player
        local uniquePlayers = {}
        for _, p in ipairs(players) do uniquePlayers[p] = true end

        for playerID, _ in pairs(uniquePlayers) do
            if isPlayer(playerID) then
                -- Chance de dropar a espada diretamente no inventário
                if math.random(1, 100) <= swordChance then
                    doPlayerAddItem(playerID, swordId, 1)
                    doPlayerSendTextMessage(playerID, MESSAGE_EVENT_ORANGE, "Voce pegou a Kubikiribocho antes do rastreador levar o corpo!")
                end

                -- Atualiza a Saga se o jogador estiver na fase correta
                if getPlayerStorageValue(playerID, SAGA_STORAGE) == SAGA_STAGE_WAVES_ESCORT then
                    setPlayerStorageValue(playerID, SAGA_STORAGE, SAGA_STAGE_WAVES_MIST)
                    
                    -- Mensagem de orientação após a cena do Haku (21 segundos)
                    addEvent(function()
                        if isPlayer(playerID) then
                            doPlayerSendTextMessage(playerID, 22, "Aquele ninja mascarado levou o corpo usando agulhas senbon... algo parece suspeito. Bom, agora preciso levar Tazuna ao cais.")
                            doSendMagicEffect(getThingPos(playerID), 12)
                        end
                    end, 21000)
                end
            end
        end

        -- 2. ENCENAÇÃO DO HAKU (Cutscene)
        local hakuAlreadyExists = false
        local spectators = getSpectators(haku_pos, 10, 10, false)
        if spectators then
            for _, s in ipairs(spectators) do
                if isNpc(s) and getCreatureName(s):lower() == npcName:lower() then
                    hakuAlreadyExists = true
                    break
                end
            end
        end

        if not hakuAlreadyExists then
            -- Cria o NPC exatamente onde o Zabuza caiu
            local haku = doCreateNpc(npcName, haku_pos)
            
            if haku then
                -- Efeito 10 (Senbons atingindo o Zabuza)
                doSendMagicEffect(haku_pos, 10)

                -- Diálogos lentos e fiéis
                addEvent(doCreatureSay, 1500, haku, "Obrigado... Eu estava esperando por uma oportunidade para mata-lo.", TALKTYPE_SAY)
                addEvent(doCreatureSay, 6000, haku, "Sou um rastreador da Vila da Nevoa. Nossa missao e cacar os ninjas renegados que fogem de nossa vila.", TALKTYPE_SAY)
                addEvent(doCreatureSay, 11000, haku, "Este corpo contem muitos segredos. Preciso leva-lo para que as informacoes não caiam em maos erradas.", TALKTYPE_SAY)
                addEvent(doCreatureSay, 16000, haku, "Agora, com licenca. Tenho que cuidar do resto.", TALKTYPE_SAY)

                -- Finalização da cena: Haku some e remove o corpo
                addEvent(function()
                    if isCreature(haku) then
                        local currentHakuPos = getThingPos(haku)
                        doSendMagicEffect(currentHakuPos, 2) -- Fumaça de Shunshin
                        doSendMagicEffect(haku_pos, 2) 
                        
                        -- Remove o corpo físico do chão
                        local corpseItem = getTileItemById(haku_pos, corpse.itemid)
                        if corpseItem.uid > 0 then
                            doRemoveItem(corpseItem.uid)
                        end
                        
                        doRemoveCreature(haku)
                    end
                end, 20000)
            end
        end
    end 
    return true
end