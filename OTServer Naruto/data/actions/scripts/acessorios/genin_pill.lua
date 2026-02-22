function onUse(cid, item, fromPosition, itemEx, toPosition)
    local config = {
        type = "ambos", -- health / mana / ambos
        exha = 500, -- tempo em milesegundos
        hp = 100,
        chakra = 100,
        storage = 7321
    }

    local target = itemEx.uid
    if target <= 0 or not isCreature(target) then
        target = cid
    end

    if getPlayerStorageValue(cid, config.storage) > os.time(t) then
        return false
    end

    local targetPos = getThingPos(target)

    if config.type == "health" or config.type == "ambos" then
        doCreatureAddHealth(target, config.hp)
    end

    if config.type == "mana" or config.type == "ambos" then
        if isPlayer(target) then
            doPlayerAddMana(target, config.chakra)
        end
    end

    local effect = (config.type == "ambos") and 69 or 12
    doSendMagicEffect(targetPos, effect)

    setPlayerStorageValue(cid, config.storage, os.time(t) + 1) 
    
    doRemoveItem(item.uid, 1)
    return true
end