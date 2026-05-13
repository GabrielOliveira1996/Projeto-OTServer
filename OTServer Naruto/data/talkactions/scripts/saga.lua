function onSay(cid, words, param, channel)
    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    
    -- Normaliza para o estágio 1 caso seja novo jogador
    local currentStep = (status <= 0) and SAGA_STAGE_ACADEMIC_EXAM or status
    local mission = SAGA_DATA[currentStep]

    if mission then
        -- Pegamos o texto do objetivo
        local goalText = mission.goal
        
        goalText = goalText:gsub("|PLAYERNAME|", getCreatureName(cid))

        local str = mission.title .. "\n\n"
        str = str .. "Objetivo:\n" .. goalText .. "\n\n"
        str = str .. "Recompensa Estimada:\n" .. mission.reward
        
        doPlayerSendTextMessage(cid, 27, str)
    else
        doPlayerSendTextMessage(cid, 27, "Parabens! Voce completou todas as sagas disponiveis.")
    end 

    return true
end