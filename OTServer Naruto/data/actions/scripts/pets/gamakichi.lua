function onUse(cid, item, itemEx)
    local config = {
        percent = 10, -- porcentagem de cura
        exhaustionId = 7323, -- id da exaustao
        exhTime = 1, -- tempo de exaustao em segundos
        reqItemId = 2125, -- id do item que precisa estar equipado
        effect = 12 -- efeito visual
    }
    -- verifica se o jogador esta exausto
    if exhaustion.check(cid, config.exhaustionId) then
        local timeLeft = exhaustion.get(cid, config.exhaustionId)
        doPlayerSendCancel(cid, "You are exhausted. Wait " .. timeLeft .. "s.")
        return true
    end
    -- verifica se o item especifico esta no slot 2 (colar)
    if getPlayerSlotItem(cid, CONST_SLOT_NECKLACE).itemid == config.reqItemId then
        local maxMana = getPlayerMaxMana(cid)
        local healAmount = math.floor(maxMana * (config.percent / 100))
        -- adiciona a mana
        doPlayerAddMana(cid, healAmount)
        -- efeito visual e mensagem no server log
        doSendMagicEffect(getThingPos(cid), config.effect)
        doPlayerSendTextMessage(cid, 23, "You restored " .. healAmount .. " points of chakra.")
        -- define a exaustão
        exhaustion.set(cid, config.exhaustionId, config.exhTime)
    else
        doPlayerSendCancel(cid, "You need to have the specific item equipped to use this.")
    end
    return true
end