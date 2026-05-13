function onUse(cid, item, fromPosition, itemEx, toPosition)
    local config = {
        type = "ambos",
        exha = 1, -- segundos
        hp = 50,
        chakra = 50,
        storage = STORAGE_COOLDOWN_PILL
    }

    if not exhaustion.check(cid, config.storage) then
        local target = itemEx.uid
        if not isCreature(target) then target = cid end

        if config.type == "health" or config.type == "ambos" then
            doCreatureAddHealth(target, config.hp)
        end
        if config.type == "mana" or config.type == "ambos" then
            doPlayerAddMana(target, config.chakra)
        end

        doSendMagicEffect(getThingPos(target), (config.type == "ambos" and 69 or 12))
        exhaustion.set(cid, config.storage, config.exha)
        doRemoveItem(item.uid, 1)
        return false
    else
        doPlayerSendCancel(cid, "Aguarde " .. exhaustion.get(cid, config.storage) .. "s para usar novamente.")
        return false
    end
end