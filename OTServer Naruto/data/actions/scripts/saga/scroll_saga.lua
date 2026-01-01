function onUse(cid, item, fromPosition, itemEx, toPosition)

    local experience = 2000
    local storageFaseAnterior = 11111 -- storage que o mizuki deu
    local storageProximaFase = 11112  -- storage que indica que ja roubou
    local idDoEfeitoCausado = 2

    -- 1. verifica se o jogador ja pegou o pergaminho
    if getPlayerStorageValue(cid, storageProximaFase) >= 1 then
        doPlayerSendTextMessage(cid, 22, "O pergaminho ja foi roubado ou voce ja completou esta saga.")
        return true
    end

    -- 2. verifica se o jogador esta EXATAMENTE na missao de roubo
    if getPlayerStorageValue(cid, storageFaseAnterior) >= 1 then
        setPlayerStorageValue(cid, storageFaseAnterior, -1)
        setPlayerStorageValue(cid, storageProximaFase, 1)
        doPlayerAddExp(cid, experience)
        -- gera o efeito visual sobre a posicao do pergaminho
        doSendMagicEffect(toPosition, idDoEfeitoCausado) 
        doPlayerSendTextMessage(cid, 22, "Voce leu os segredos do pergaminho e memorizou o Jutsu. Va encontrar Mizuki na floresta!")
        return true
    else
        -- 3. caso o jogador nao tenha a missao do mizuki
        doPlayerSendTextMessage(cid, 22, "Voce nao consegue entender os selos deste pergaminho ainda.")
        return false
    end
end