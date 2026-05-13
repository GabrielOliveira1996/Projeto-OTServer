function onCastSpell(cid, var)
    local summons = getCreatureSummons(cid)
    local playerLevel = getPlayerLevel(cid)
    local storage_bunshins_meditando = 45010 -- storage específica para o estado dos bunshins

    -- sair da meditação
    if getPlayerStorageValue(cid, storage_bunshins_meditando) == 1 then
        local bunshinNumber = math.max(1, math.min(10, math.floor(playerLevel / 10)))
        local monsterToSummon = bunshinNumber .. "bunshin"

        for _, bunshin in ipairs(summons) do
            -- identifica pelo noMove, que é o padrão de estado dessa meditação
            if getCreatureNoMove(bunshin) == true then
                local pos = getCreaturePosition(bunshin)
                doRemoveCreature(bunshin)
                
                local clone = createBunshin(monsterToSummon, pos, cid)
                if isCreature(clone) then
                    doConvinceCreature(cid, clone)
                end
            end
        end

        setPlayerStorageValue(cid, storage_bunshins_meditando, 0)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Your clones stopped meditating.")
        return true
    end

    -- inicia meditação dos bunshins
    if #summons == 0 then
        doPlayerSendCancel(cid, "You need to summon a Bunshin before meditating.")
        return false
    end

    local processed_count = 0
    for _, bunshin in ipairs(summons) do
        -- apenas bunshins ativos, que não estão travados entram na meditação
        if getCreatureNoMove(bunshin) == false then
            local pos = getCreaturePosition(bunshin)
            doRemoveCreature(bunshin)

            local clone = createBunshin("bunshin meditate", pos, cid)
            local meditate_outfit = 13

            if isCreature(clone) then
                doConvinceCreature(cid, clone)
                doChangeSpeed(clone, -getCreatureSpeed(clone))
                doCreatureSetNoMove(clone, true)
                doSetCreatureOutfit(clone, {lookType = meditate_outfit}, -1)
                doSendMagicEffect(pos, 13)
                processed_count = processed_count + 1
            end
        end
    end
    
    if processed_count > 0 then
        setPlayerStorageValue(cid, storage_bunshins_meditando, 1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Clones meditating: " .. processed_count)
        return true
    end
    
    return false
end