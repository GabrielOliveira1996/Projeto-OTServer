local items = {
{itemId = 2125, count = 1, chance = 80},
{itemId = 2142, count = 1, chance = 80},
}

function onUse(cid, item, frompos, item2, topos)

    local totalChance, randomTable, randomNumber = 0, {}, 0
    
    for _, itemInfo in pairs (items) do
            randomTable[itemInfo.itemId] = {min = totalChance + 1, max = itemInfo.chance, count = itemInfo.count or 1}
            totalChance = totalChance + itemInfo.chance
    end
    
    randomNumber = math.random(1, totalChance)
    
    for itemId, itemInfo in pairs (randomTable) do
            local min, max = itemInfo.min, itemInfo.min + itemInfo.max
            if randomNumber >= min and randomNumber <= max then
                    local newItem = doPlayerAddItem(cid, itemId, itemInfo.count, false)
                    if not newItem then return doPlayerSendCancel(cid, "Você não tem espaço livre para receber o item!") end
                    doRemoveItem(item.uid, 1)
                    local iInfo = getItemInfo(itemId)
                    doPlayerSendTextMessage(cid, 27, "Você acabou de receber um item ("..iInfo.name..")!")
                    break
            end
    end

return true
end