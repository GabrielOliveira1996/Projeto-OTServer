local firstItems = {
    -- [ID_DA_VOCACAO] = { {ITEM_ID, QUANTIDADE}, {ITEM_ID, QUANTIDADE} }
    [1] = {{2459, 1}, {2483, 1}, {2470, 1}, {2445, 1}, {3982, 1}},  -- Naruto
    [15] = {{2459, 1}, {2483, 1}, {2470, 1}, {2412, 1}, {3982, 1}},  -- Sasuke
    [24] = {{2459, 1}, {2483, 1}, {2470, 1}, {2445, 1}, {3982, 1}},  -- Sakura
    [33] = {{2459, 1}, {2483, 1}, {2470, 1}, {2445, 1}, {3982, 1}},  -- Naruto

    --[9]  = {{2459, 1}, {2483, 1}, {2470, 1}, {2445, 1}, {3982, 1}}, -- Kiba 
    --[19] = {{2459, 1}, {2483, 1}, {2470, 1}, {3982, 1}, {2410, 20}, {2445, 1}}, -- Shino
    --[41] = {{2459, 1}, {2483, 1}, {2470, 1}, {2445, 1}, {3982, 1}},  -- Rock Lee
    --[53] = {{2459, 1}, {2483, 1}, {2470, 1}, {2445, 1}, {3982, 1}}   -- Hinata
}

function onLogin(cid)
    local storage = 30001
    local voc = getPlayerVocation(cid)

    if getPlayerStorageValue(cid, storage) == -1 then
        
        if firstItems[voc] then
            for _, itemData in ipairs(firstItems[voc]) do
                local id = itemData[1]
                local count = itemData[2]
                doPlayerAddItem(cid, id, count)
            end
        end

        local bag = doPlayerAddItem(cid, 1987, 1)
        doAddContainerItem(bag, 2666, 3) -- meat
        doAddContainerItem(bag, 2410, 10) -- kunais
        doAddContainerItem(bag, 2399, 10) -- shurikens
        doAddContainerItem(bag, 2151, 5) -- genin pill
        
        setPlayerStorageValue(cid, storage, 1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Você recebeu seus itens ninja iniciais!")
    end

    return true
end