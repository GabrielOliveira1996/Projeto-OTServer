function onDeath(cid, corpse, deathList)
    -- [ CONFIGURATIONS ]
    local monstName = "Mizuki"
    local npcToSpawn = "Iruka"
    local summonToRemove = "Iruka Protectors"
    local spawnPos = {x = 2982, y = 3194, z = 7} -- POSIÇÃO FIXA SOLICITADA
    local checkRadius = 10 -- Raio para busca de monstros ao redor da morte

    -- Verifica se quem morreu foi o Boss Mizuki
    if isMonster(cid) and string.lower(getCreatureName(cid)) == string.lower(monstName) then
        local monsterPos = getThingPos(cid)

        -- [ LIMPEZA DE MONSTROS ]
        -- Varre a área onde o Mizuki morreu para remover os protetores
        local entities = getSpectators(monsterPos, checkRadius, checkRadius, false)
        if entities then
            for _, entity in ipairs(entities) do
                if isMonster(entity) and getCreatureName(entity) == summonToRemove then
                    doSendMagicEffect(getThingPos(entity), 2) -- Efeito Poof
                    doRemoveCreature(entity)
                end
            end
        end

        -- [ TRAVA ANTI-DUPLICATA ]
        -- Verifica se já existe um Iruka na posição de spawn antes de criar outro
        local spectatorsNearSpawn = getSpectators(spawnPos, 3, 3, false)
        local irukaAlreadyExists = false
        if spectatorsNearSpawn then
            for _, spectator in ipairs(spectatorsNearSpawn) do
                if isNpc(spectator) and getCreatureName(spectator) == npcToSpawn then
                    irukaAlreadyExists = true
                    break
                end
            end
        end

        -- [ SPAWN DO NPC ]
        if not irukaAlreadyExists then
            local irukaNpc = doCreateNpc(npcToSpawn, spawnPos)
            if irukaNpc then
                doSendMagicEffect(spawnPos, 10) -- Efeito de fumaça/teleporte
                
                -- O NPC some após 5 minutos
                addEvent(function()
                    if isCreature(irukaNpc) then 
                        doRemoveCreature(irukaNpc) 
                    end
                end, 5 * 60 * 1000)
            end
        end

        -- [ FEEDBACK VISUAL ]
        for _, killer in ipairs(deathList) do
            if isPlayer(killer) then
                doPlayerSendTextMessage(killer, 22, "Mizuki foi derrotado! Iruka esta te esperando logo adiante.")
            end
        end
    end 
    return true
end