-- Tabela para ligar o ActionID do mapa à Global Storage do silêncio
local config = {
    [16000] = {storage = 33001, monster = "Bandit"},
}

function onStepIn(cid, item, position, fromPosition)
    if not isPlayer(cid) then return true end

    local tile = config[item.actionid]
    if not tile then return true end

    local tempoAtual = os.time()
    local cooldown = getGlobalStorageValue(tile.storage)

    -- Só funciona se o cooldown de 1 minuto já acabou
    if tempoAtual >= cooldown then
        -- Define que o próximo monstro/fala só acontece daqui a 60 segundos
        setGlobalStorageValue(tile.storage, tempoAtual + 60)

        -- Cria o monstro
        local spawnPos = {x = position.x + 1, y = position.y, z = position.z}
        doCreateMonster(tile.monster, spawnPos)
        
        -- Efeitos e Mensagens
        doSendMagicEffect(position, CONST_ME_TELEPORT)
        doPlayerSendTextMessage(cid, 19, "Uma armadilha!")
    end

    return true
end