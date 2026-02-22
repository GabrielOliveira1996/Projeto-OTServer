local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

function onThink() 
    if npcHandler:isFocused(cid) then
        local coords = getCreaturePosition(cid)
        local myCoords = getCreaturePosition(getSelf())
        if (getDistanceBetween(coords, myCoords) > 4) then
            npcHandler:releaseFocus(cid)
        end
    end
    npcHandler:onThink() 
end

function onGreet(cid)
    local playerName = getCreatureName(cid)
    local fotoPendente = 11115
    local fotoEntregue = 11116
    local statusTazuna = 11120 -- Nossa storage única

    local missionStatus = getPlayerStorageValue(cid, statusTazuna)

    if missionStatus == -1 and getPlayerStorageValue(cid, fotoEntregue) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Ola " .. playerName .. ". Voce esta pronto para sua {primeira missao}?")
    elseif missionStatus == 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Ainda esta aqui, " .. playerName .. "? O Tazuna precisa chegar ao Pais das Ondas!")
    elseif missionStatus == 2 then
        npcHandler:setMessage(MESSAGE_GREET, "Bom trabalho na escolta, " .. playerName .. ". O construtor esta seguro.")
    elseif getPlayerStorageValue(cid, fotoEntregue) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Sua foto ja foi registrada. Va encontrar sua equipe.")
    elseif getPlayerStorageValue(cid, fotoPendente) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, playerName .. "! Que foto de registro ridicula e essa? Eu jamais aceitaria isso! {orioke no jutsu}")
    else
        npcHandler:setMessage(MESSAGE_GREET, "O que quer aqui? Estou ocupado.")
    end

    npcHandler:addFocus(cid)
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    -- configuracoes
    local storageFotoPendente = 11115 
    local storageFotoEntregue = 11116 
    local statusTazuna = 11120 
    local statusTazunaPosMatarZabuza = 90908

    -- entrega da foto
    if msgcontains(msg, 'orioke no jutsu') then
        if getPlayerStorageValue(cid, storageFotoPendente) >= 1 then
            selfSay('MAS O QUE?! Pare com isso agora! Esta bem, eu registro essa foto so para voce sair da minha sala!', cid)
            setPlayerStorageValue(cid, storageFotoPendente, -1)
            setPlayerStorageValue(cid, storageFotoEntregue, 1)
            doPlayerAddExp(cid, 6000)
            doSendMagicEffect(getThingPos(cid), 2)
        end

    -- missao Tazuna
    elseif msgcontains(msg, 'primeira missao') or msgcontains(msg, 'tazuna') then
        local missionStatus = getPlayerStorageValue(cid, statusTazuna)
        
        if missionStatus == 2 then
            selfSay('Voce ja completou esta missao.', cid)
            return true
        end

        -- Checar se o jogador já tem a missão liberada (Saga 11 concluída)
        if getPlayerStorageValue(cid, 11119) < 1 then
            selfSay('Voce ainda nao tem autorizacao para escoltar o senhor Tazuna.', cid)
            return true
        end

        -- Checar se o Tazuna já está vivo/invocado
        local summons = getCreatureSummons(cid)
        local hasTazuna = false
        for _, summon in ipairs(summons) do
            if getCreatureName(summon) == "Tazuna" then
                hasTazuna = true
                break
            end
        end

        if hasTazuna then
            selfSay('O Tazuna ja esta com voce! Va para o Pais das Ondas.', cid)
            return true
        end

        -- Se chegou aqui e não tem Tazuna, ele pode pegar (independente de ser status 1 ou -1)
        local playerPos = getCreaturePosition(cid)
        local spawnPos = getClosestFreeTile(cid, playerPos)

        if spawnPos then
            local tazuna = doCreateMonster("Tazuna", spawnPos)
            if isCreature(tazuna) then
                doConvinceCreature(cid, tazuna)
                doChangeSpeed(tazuna, -getCreatureSpeed(tazuna) + getCreatureSpeed(cid))
                doSendMagicEffect(spawnPos, 10)

                if missionStatus == -1 and getPlayerStorageValue(cid, statusTazunaPosMatarZabuza) < 1 then -- adicionada checagem para nao ganhar a storage se ja matou o Zabuza
                    selfSay('Sua missao sera escoltar o Tazuna ate o Pais das Ondas. Proteja-o com sua vida!', cid)
                    setPlayerStorageValue(cid, statusTazuna, 1) 
                else
                    selfSay('Vejo que voce perdeu o senhor Tazuna... Tome mais cuidado! Vamos tentar novamente.', cid)
                end
            end
        else
            selfSay('Nao ha espaco para o Tazuna aparecer aqui.', cid)
        end
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())