function onDeath(cid, corpse, deathList)
    if not isMonster(cid) then return true end

    local name = getCreatureName(cid):lower()
    -- Verificação direta sem depender da lib table.contains
    if name ~= "gozu" and name ~= "meizu" then 
        return true 
    end

    local targets = {}
    -- Identifica todos os jogadores que participaram (incluindo donos de summons)
    for _, killer in ipairs(deathList) do
        if isCreature(killer) then
            local master = getCreatureMaster(killer)
            local player = (master ~= nil and isPlayer(master)) and master or killer
            
            if isPlayer(player) then
                -- Verifica se o player já está na lista local para não repetir
                local alreadyAdded = false
                for _, p in ipairs(targets) do
                    if p == player then
                        alreadyAdded = true
                        break
                    end
                end

                if not alreadyAdded then
                    table.insert(targets, player)
                end
            end
        end
    end

    -- Processa o progresso para cada jogador identificado no combate
    for _, player in ipairs(targets) do
        local status = getPlayerStorageValue(player, SAGA_STORAGE)
        local event = getPlayerStorageValue(player, SAGA_AUX_DEMON_BROS_EVENT)

        -- Só ganha ponto quem está na etapa certa da saga
        if status == SAGA_STAGE_WAVES_ESCORT then
            local currentKills = math.max(0, getPlayerStorageValue(player, SAGA_AUX_DEMON_BROS_KILLCOUNT))
            local newKills = currentKills + 1
            
            setPlayerStorageValue(player, SAGA_AUX_DEMON_BROS_KILLCOUNT, newKills)

            if newKills >= 2 then
                setPlayerStorageValue(player, SAGA_AUX_DEMON_BROS_EVENT, 2)
                doPlayerSendTextMessage(player, 22, "Voce e seu grupo derrotaram os Demon Brothers! Prossiga com Tazuna.")
                doSendMagicEffect(getThingPos(player), 12)
            else
                doPlayerSendTextMessage(player, 20, "Um dos irmaos foi derrotado! Falta " .. (2 - newKills) .. ".")
            end
        end
    end
    return true
end