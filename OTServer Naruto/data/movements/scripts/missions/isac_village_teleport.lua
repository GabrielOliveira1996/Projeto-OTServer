local config = {
    storage = 2701,
    centroVila = {x = 3019, y = 2936, z = 7}, 
    msgLoop = "O tempo se dobra diante de voce. Nao ha como sair da vila agora.",
    msgEntrada = "Voce se sente estranho. Algo parece ter mudado."
}

function onStepIn(cid, item, position, lastPosition, fromPosition, toPosition)
    if not isPlayer(cid) then return true end

    local status = getPlayerStorageValue(cid, config.storage)

    -- MOMENTO QUE O PLAYER ENTRA NA VILA (Vindo de Konoha)
    -- Se ele tem a missão (1) e pisa na entrada, ele fica "Preso" (status 2)
    if status == 1 then
        setPlayerStorageValue(cid, config.storage, 2)
        doPlayerSendTextMessage(cid, 22, config.msgEntrada)
        doSendMagicEffect(getCreaturePosition(cid), 31) -- Efeito de distorção
        return true
    end

    -- LÓGICA DE SAÍDA (O Loop)
    -- Se ele tentar sair enquanto estiver na fase de investigação (status 2 até antes de vencer o boss)
    if status >= 2 and status < 10 then -- (Assumindo que 10 é o fim da quest)
        doTeleportThing(cid, fromPosition) -- Joga ele um piso para trás
        doSendMagicEffect(getCreaturePosition(cid), 2) -- Efeito de fumaça/impacto
        doPlayerSendTextMessage(cid, 21, config.msgLoop)
    end

    return true
end