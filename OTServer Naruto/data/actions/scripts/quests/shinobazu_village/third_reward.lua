function onUse(cid, item, fromPosition, itemEx, toPosition)
    -- 1. Verifica se já fez a quest
    if getPlayerStorageValue(cid, STORAGE_SHINOBAZU_THIRD_REWARD) ~= -1 then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "O baú está vazio.")
        return true
    end

    -- 2. Configuração dos itens para facilitar a checagem de peso
    -- {id, quantidade, peso unitário em oz}
    local itemsToGive = {
        {id = 2152, count = 100, weight = 0.1}, -- green notes
        {id = 2645, count = 1,  weight = 53.0}, -- blue cloak
        {id = 2546, count = 50, weight = 0.8}, -- explosive kunai
        {id = 2151, count = 30, weight = 0.2}  -- genin pills
    }

    -- Calcula o peso total (aprox. 250-300 oz dependendo dos seus itens)
    local totalWeight = 8.0 -- peso da própria bag (ID 1987)
    for _, info in ipairs(itemsToGive) do
        totalWeight = totalWeight + (info.weight * info.count)
    end

    -- 3. Verificação de Capacidade
    if getPlayerFreeCap(cid) < totalWeight then
        doPlayerSendCancel(cid, "Você não tem capacidade suficiente. Você precisa de " .. totalWeight .. " oz.")
        return true
    end

    -- 4. Entrega dos itens
    local bag = doPlayerAddItem(cid, 1987, 1) -- Cria a bolsa
    if bag then
        for _, info in ipairs(itemsToGive) do
            doAddContainerItem(bag, info.id, info.count)
        end
        
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você encontrou um kit de suprimentos ninja!")
        doSendMagicEffect(getThingPos(cid), CONST_ME_MAGIC_BLUE)
        
        -- Marca a storage apenas após o sucesso da entrega
        setPlayerStorageValue(cid, STORAGE_SHINOBAZU_THIRD_REWARD, 1)
    else
        -- Caso o player esteja sem espaço nos slots de inventário
        doPlayerSendCancel(cid, "Você não tem espaço no inventário para carregar a bolsa.")
    end

    return true
end