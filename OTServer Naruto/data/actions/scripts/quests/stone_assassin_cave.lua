local config = {
    pedra_id = 1304,          -- ID da pedra que vai sumir
    pedra_pos = {x=3213, y=3023, z=8}, -- Onde a pedra está exatamente
    tempo_voltar = 60,        -- Tempo para a pedra reaparecer (em segundos)
    efeito_sumir = 10,         -- Efeito quando a pedra some
    efeito_voltar = 10        -- Efeito quando a pedra volta
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
    -- localiza a pedra na posição configurada
    local pedra = getTileItemById(config.pedra_pos, config.pedra_id)

    -- verifica se a pedra existe no local
    if pedra.uid > 0 then
        -- remove a pedra e mostra efeito
        doRemoveItem(pedra.uid)
        doSendMagicEffect(config.pedra_pos, config.efeito_sumir)
        
        -- muda o ID da alavanca
        doTransformItem(item.uid, item.itemid == 1945 and 1946 or 1945)

        -- agenda o retorno da pedra
        addEvent(function()
            -- cria a pedra novamente
            doCreateItem(config.pedra_id, 1, config.pedra_pos)
            doSendMagicEffect(config.pedra_pos, config.efeito_voltar)
        end, config.tempo_voltar * 1000)

        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você ouviu um barulho de pedras se movendo.")
    else
        -- se a pedra não estiver lá, a alavanca não faz nada ou apenas transforma
        doPlayerSendCancel(cid, "O mecanismo está travado.")
        doTransformItem(item.uid, item.itemid == 1945 and 1946 or 1945)
    end

    return true
end