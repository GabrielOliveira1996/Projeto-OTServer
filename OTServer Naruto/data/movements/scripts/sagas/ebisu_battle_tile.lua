local EBISU_POS = {x = 3025, y = 3068, z = 7} 
local GLOBAL_EBISU_ID = 9333 -- Armazenaremos o ID da criatura aqui

function onStepIn(cid, item, position, fromPosition)
    if not isPlayer(cid) then return true end

    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    
    -- O tile só reage se o jogador estiver na etapa do Konohamaru
    if status == SAGA_STAGE_HOKAGE_GRANDSON then
        
        -- 1. Verificar se o jogador está com o Konohamaru (Summon)
        local hasSummon = false
        local summons = getCreatureSummons(cid)
        if summons and #summons > 0 then
            for _, summon in ipairs(summons) do
                if getCreatureName(summon):lower() == "konohamaru" then
                    hasSummon = true
                    break
                end
            end
        end

        if not hasSummon then
            doPlayerSendTextMessage(cid, 22, "Voce precisa que o Konohamaru esteja com voce para conseguir o material.")
            return true
        end

        -- 2. Mecanismo de Trava Global por ID (Anti-Lure Total)
        local lastEbisuID = getGlobalStorageValue(GLOBAL_EBISU_ID)
        
        -- Se existir um ID registrado, verificamos se essa criatura ainda está viva no mapa
        if isCreature(lastEbisuID) then
            -- Se o Ebisu está vivo (na sauna ou na China), o script não deixa sumonar outro
            doPlayerSendTextMessage(cid, 22, "O Ebisu ja esta em combate em algum lugar da vila! Voce deve encontra-lo ou esperar.")
            return true
        end

        -- 3. Início do Evento: Spawn do Ebisu
        local ebisu = doCreateMonster("Ebisu", EBISU_POS)
        
        if isCreature(ebisu) then
            -- Salvamos o ID ÚNICO deste Ebisu na Global Storage
            setGlobalStorageValue(GLOBAL_EBISU_ID, ebisu)
            
            doSendMagicEffect(EBISU_POS, 10) -- Fumaça
            doCreatureSay(ebisu, "Konohamaru-sama! O que pensa que esta fazendo com esse garoto problematico?!", TALKTYPE_SAY)
            
            addEvent(function()
                if isCreature(ebisu) then
                    doCreatureSay(ebisu, "Eu, Ebisu, o tutor de elite, nao permitirei que corrompa o neto do Hokage!", TALKTYPE_SAY)
                end
            end, 2000)

            doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Ebisu apareceu! Proteja seu aluno!")
        end
    end
    
    return true
end