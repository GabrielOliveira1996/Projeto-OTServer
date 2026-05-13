local colheita = {
    [4170] = {itemGanhado = 2789, nome = "Brown Mushroom", tempoRespawn = 180, quantidade = 1},
    [4171] = {itemGanhado = 2789, nome = "Brown Mushrooms", tempoRespawn = 180, quantidade = 3}, -- 3 Cogumelos
    [4155] = {itemGanhado = 2668, nome = "Tulip", tempoRespawn = 600, quantidade = 1}
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
    local config = colheita[item.itemid]
    
    if not config then return false end

    -- Define a quantidade (se não houver na tabela, assume 1)
    local qtd = config.quantidade or 1

    -- Dá o(s) item(ns) ao player
    doPlayerAddItem(cid, config.itemGanhado, qtd)
    
    local msg = qtd > 1 and "You collected " .. qtd .. " " .. config.nome .. "." or "You collected a " .. config.nome .. "."
    doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, msg)
    
    doSendMagicEffect(toPosition, 3) -- Efeito de colheita

    -- Lógica de sumir e reaparecer (Respawn)
    local itemId = item.itemid
    doRemoveItem(item.uid, 1)

    addEvent(function()
        doCreateItem(itemId, 1, toPosition)
        doSendMagicEffect(toPosition, 2) -- Efeito de planta nascendo
    end, config.tempoRespawn * 1000)

    return true
end