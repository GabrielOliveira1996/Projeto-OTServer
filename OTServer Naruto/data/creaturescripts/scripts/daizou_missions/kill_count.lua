-- Garanta que o caminho para a lib esteja correto
dofile('data/lib/DAIZOU_MISSIONS.lua') 

function onKill(cid, target)
    -- Se não for player matando monstro, ignora
    if not isPlayer(cid) or not isMonster(target) then 
        return true 
    end

    local monsterName = getCreatureName(target):lower()
    -- Verificamos se o monstro é o lobo
    if monsterName == "wolf" then
        local config = DAIZOU_MISSIONS[4]
        local status = getPlayerStorageValue(cid, config.storageStatus)

        -- Se a missão estiver ativa (status 1)
        if status == 1 then
            local current = getPlayerStorageValue(cid, config.storageCount)
            -- Se retornar -1 ou nil, transformamos em 0
            if current < 0 then current = 0 end
            
            local novoValor = current + 1
            
            -- Salva o novo valor
            setPlayerStorageValue(cid, config.storageCount, novoValor)
            
            -- Envia a mensagem de progresso (usando 2 tipos de canais para garantir que você veja)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Progresso da Missao: " .. novoValor .. " de " .. config.goalCount .. " lobos mortos.")
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Lobo abatido! (" .. novoValor .. "/20)")

            -- Se atingiu o objetivo
            if novoValor >= config.goalCount then
                setPlayerStorageValue(cid, config.storageStatus, 2)
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Voce concluiu o exterminio! Volte ao Daizou.")
            end
        end
    end

    return true
end