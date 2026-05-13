function onKill(cid, target)
    if not isPlayer(cid) or not isMonster(target) then return true end

    local mID = getPlayerStorageValue(cid, TAITO_STORAGES.ACTIVE_MISSION)
    if mID <= 0 then return true end

    local mission = TAITO_MISSIONS[mID]
    
    -- Verifica se a missão é de matar e se o alvo é o correto
    if mission and mission.target and mission.goal then
        if getCreatureName(target):lower() == mission.target:lower() then
            local current = getPlayerStorageValue(cid, TAITO_STORAGES.MISSION_PROG)
            
            -- Só sobe o contador se ainda não terminou
            if current < mission.goal then
                local nextProg = current + 1
                setPlayerStorageValue(cid, TAITO_STORAGES.MISSION_PROG, nextProg)
                
                -- MENSAGEM NO CHAT (Aparece em branco/azul no console)
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "[Missao: " .. mission.name .. "] Alvos abatidos: " .. nextProg .. "/" .. mission.goal)
                
                -- Se completou agora
                if nextProg == mission.goal then
                    doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Objetivo concluido! Retorne ao Capitão Taito.")
                end
            end
        end
    end

    return true
end