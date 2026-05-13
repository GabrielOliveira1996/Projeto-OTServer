local ST_PEDRA_ALTAR = 1060 

function onUse(cid, item, fromPosition, target, toPosition, isHotkey)
    -- Se o jogador NÃO tem a pedra no altar, ele coloca uma
    if getPlayerStorageValue(cid, ST_PEDRA_ALTAR) < 1 then
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Voce grava seu nome em uma pequena pedra e a deposita na fonte.")
        setPlayerStorageValue(cid, ST_PEDRA_ALTAR, 1)
        doSendMagicEffect(toPosition, 3) -- Efeito de fumaça ou brilho
    else
        -- Se ele já tem, ele a retira (simboliza o retorno da missão)
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Voce retira a pedra com seu nome da fonte. Um ciclo se fecha.")
        setPlayerStorageValue(cid, ST_PEDRA_ALTAR, 0)
        doSendMagicEffect(toPosition, 2) -- Efeito diferente para retirada
    end
    return true
end