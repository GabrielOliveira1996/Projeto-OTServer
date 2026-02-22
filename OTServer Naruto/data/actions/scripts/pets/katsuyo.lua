function onUse(cid, item, itemEx)
    local config = {
        percent = 10, -- porcentagem de cura
        exhaustionId = 7324, -- id da exaustao 
        exhTime = 1, -- tempo de exaustao em segundos
        reqItemId = 2142, -- id do item
        effect = 12 -- efeito visual
    }

    -- verifica se o jogador esta exausto
    if exhaustion.check(cid, config.exhaustionId) then
        local timeLeft = exhaustion.get(cid, config.exhaustionId)
        doPlayerSendCancel(cid, "You are exhausted. Wait " .. timeLeft .. "s.")
        return true
    end
    -- verifica se o item especifico esta equipado no slot do colar
    if getPlayerSlotItem(cid, CONST_SLOT_NECKLACE).itemid == config.reqItemId then
        local maxHealth = getCreatureMaxHealth(cid)
        local healAmount = math.floor(maxHealth * (config.percent / 100))
        -- adiciona a Vida
        doCreatureAddHealth(cid, healAmount)
        doSendMagicEffect(getThingPos(cid), config.effect)
        doPlayerSendTextMessage(cid, 23, "You restored " .. healAmount .. " health points.")
        -- define a exaustao
        exhaustion.set(cid, config.exhaustionId, config.exhTime)
    else
        -- caso tente usar o item sem estar com o colar especifico equipado
        doPlayerSendCancel(cid, "You must equip the specific necklace to use this.")
    end

    return true
end