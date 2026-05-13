function onCastSpell(cid, var)
    if not isCreature(cid) then return false end

    local playerName = getCreatureName(cid):lower()
    local summons = getCreatureSummons(cid)
    
    -- --- CONFIGURAÇÃO ---
    local MaxSummon = 2      
    local monsterBase = "Zabuza Bunshin" 
    -- --------------------

    -- 1. Contagem de Bunshins ativos
    local currentBunshinCount = 0
    if summons and #summons > 0 then
        for i = 1, #summons do
            local summon = summons[i]
            if getCreatureName(summon):lower() == playerName then 
                currentBunshinCount = currentBunshinCount + 1
            end
        end
    end

    if currentBunshinCount >= MaxSummon then
        return false
    end

    -- 2. Posição de Spawn
    local playerpos = getThingPos(cid)
    local spawnPos = getClosestFreeTile(cid, playerpos)
    
    if not spawnPos or (getTilePzInfo(spawnPos)) then
        return false
    end

    -- 3. CRIAÇÃO DO CLONE
    local clone = createBunshin(monsterBase, spawnPos, cid)
    
    if isCreature(clone) then
        doConvinceCreature(cid, clone) 
        doSendMagicEffect(spawnPos, 10) 

        -- --- SOLUÇÃO PARA O CLONE ATACAR NA HORA ---
        local masterTarget = getCreatureTarget(cid) -- Pega quem o Zabuza está atacando
        if masterTarget > 0 then
            -- 1. Força o alvo do clone para o mesmo do Zabuza
            doMonsterSetTarget(clone, masterTarget)
            
            -- 2. "Ativa" a agressividade do monstro (opcional, dependendo da source)
            doMonsterChangeTarget(clone) 
        end
        -- -------------------------------------------

        return true
    end

    return false
end