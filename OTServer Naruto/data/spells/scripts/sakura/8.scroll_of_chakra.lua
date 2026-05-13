function onCastSpell(cid, var)
    local materials = {
        {id = 2132, count = 1}, -- Empty Scroll
        {id = 2789, count = 10}, -- Brown Mushrooms
        {id = 2677, count = 30} -- Fruits
    }
    
    for _, item in ipairs(materials) do
        if getPlayerItemCount(cid, item.id) < item.count then
            doPlayerSendTextMessage(cid, 22, "Missing: " .. item.count .. "x " .. getItemNameById(item.id) .. ".")
            return false
        end
    end

    for _, item in ipairs(materials) do
        doPlayerRemoveItem(cid, item.id, item.count)
    end

    doPlayerAddItem(cid, 2214, 1)
    doSendMagicEffect(getThingPos(cid), 14)
    doPlayerSendTextMessage(cid, 22, "You crafted a Scroll of Chakra!")
    doCreatureSay(cid, "Medical Ninjutsu: CHAKRA SEAL!", TALKTYPE_MONSTER)
    return true
end