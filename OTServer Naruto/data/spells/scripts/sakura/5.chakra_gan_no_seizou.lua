function onCastSpell(cid, var)
    local pillID = 2151
    local ingredientID = 2677
    local ingredientQty = 3
    
    -- 1. Checa ingredientes
    if getPlayerItemCount(cid, ingredientID) < ingredientQty then
        doPlayerSendCancel(cid, "You need " .. ingredientQty .. " medicinal herbs.")
        return false
    end

    -- 2. Localiza a mochila
    local backpack = getPlayerSlotItem(cid, 3)
    if backpack.uid == 0 then
        doPlayerSendCancel(cid, "You need a backpack.")
        return false
    end

    -- procura por um stack existente, loop manual por slots, e umagambiarra, corrigir dps
    local size = getContainerSize(backpack.uid)
    for i = 0, (size - 1) do
        local item = getContainerItem(backpack.uid, i)
        
        -- se achou o item e ele tem menos de 100 unidades
        if item.itemid == pillID and item.type < 100 then
            if doPlayerRemoveItem(cid, ingredientID, ingredientQty) then
                doTransformItem(item.uid, pillID, item.type + 1)
                doSendMagicEffect(getThingPos(cid), 12)
                doPlayerSendTextMessage(cid, 20, "You added a pill to your stack!")
                return true
            end
        end
    end

    local newItem = doCreateItemEx(pillID, 1)
    if doPlayerAddItemEx(cid, newItem, false) == RETURNVALUE_NOERROR then
        if doPlayerRemoveItem(cid, ingredientID, ingredientQty) then
            doSendMagicEffect(getThingPos(cid), 12)
            doPlayerSendTextMessage(cid, 20, "You crafted a Medicinal Pill!")
            return true
        else
            doRemoveItem(newItem)
        end
    else
        doPlayerSendCancel(cid, "Your backpack is full.")
    end

    return false
end