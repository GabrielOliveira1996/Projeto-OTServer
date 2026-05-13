function onUse(cid, item, fromPosition, itemEx, toPosition)
    -- 1. Verifica se já fez a quest
    if getPlayerStorageValue(cid, STORAGE_REWARD_ASSASSIN_CAVE) ~= -1 then
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "O baú está vazio.")
        return true
    end

    -- {id, quantidade, peso unitário em oz}
    local itemsToGive = {
        {id = 2152, count = 50, weight = 0.1}, -- green notes
        {id = 3966, count = 1,  weight = 44.0}, -- taiyou-ken
        {id = 2411, count = 1,  weight = 28.0}, -- ryou no ha
        --{id = 2399, count = 100, weight = 0.8}, -- shurikens
        {id = 2677, count = 100, weight = 0.2}, -- strawberry
        {id = 2151, count = 20, weight = 0.2}  -- genin pills
    }

    -- calcula o peso total (aprox. 250-300 oz dependendo dos seus itens)
    local totalWeight = 8.0 -- peso da própria bag
    for _, info in ipairs(itemsToGive) do
        totalWeight = totalWeight + (info.weight * info.count)
    end

    -- verificação de Capacidade
    if getPlayerFreeCap(cid) < totalWeight then
        doPlayerSendCancel(cid, "Você não tem capacidade suficiente. Você precisa de " .. totalWeight .. " oz.")
        return true
    end

    -- entrega dos itens
    local bag = doPlayerAddItem(cid, 1987, 1) -- Cria a bolsa
    if bag then
        for _, info in ipairs(itemsToGive) do
            doAddContainerItem(bag, info.id, info.count)
        end
        
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Você encontrou alguns itens!")
        doSendMagicEffect(getThingPos(cid), CONST_ME_MAGIC_BLUE)
        
        -- marca a storage apenas após o sucesso da entrega
        setPlayerStorageValue(cid, STORAGE_REWARD_ASSASSIN_CAVE, 1)
    else
        -- caso o player esteja sem espaço nos slots de inventário
        doPlayerSendCancel(cid, "Você não tem espaço no inventário para carregar a bolsa.")
    end

    return true
end