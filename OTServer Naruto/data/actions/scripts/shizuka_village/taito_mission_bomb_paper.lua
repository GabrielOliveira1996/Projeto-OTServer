local config = {
    missionID = 6,
    area = {
        from = {x = 3023, y = 3511, z = 8}, 
        to = {x = 3032, y = 3516, z = 8}
    },
    danoMinMax = {500, 1000}, 
    tempoDetonacao = 3000, 
    raioExplosao = 2 
}

-- Função que causa o dano e espalha os efeitos
local function causarDano(pos, attackerID)
    -- Loop de varredura de área (X e Y)
    for x = -config.raioExplosao, config.raioExplosao do
        for y = -config.raioExplosao, config.raioExplosao do
            local currentPos = {x = pos.x + x, y = pos.y + y, z = pos.z}
            
            -- 1. Manda o efeito visual para CADA quadrado da área (Expansão)
            doSendMagicEffect(currentPos, 19) -- Efeito principal
            if math.random(1, 2) == 1 then -- Adiciona o 15 aleatoriamente para variar o visual
                doSendMagicEffect(currentPos, 15)
            end

            -- 2. Busca criatura para dar dano
            local thing = getThingfromPos({x=currentPos.x, y=currentPos.y, z=currentPos.z, stackpos=253})
            
            if thing.uid > 0 and isCreature(thing.uid) then
                local damage = math.random(config.danoMinMax[1], config.danoMinMax[2])
                
                doCreatureAddHealth(thing.uid, -damage)
                
                -- Se o atacante for um player, mostra o dano animado
                if isPlayer(attackerID) then
                    doSendAnimatedText(getThingPos(thing.uid), damage, 180)
                end
            end
        end
    end

    -- Mensagem final de sucesso
    if isPlayer(attackerID) then
        doPlayerSendTextMessage(attackerID, 22, "BOOM! Os suprimentos foram destruidos com sucesso.")
    end
end

function onUse(cid, item, fromPosition, itemEx, toPosition)
    -- Verificação de Missão
    if getPlayerStorageValue(cid, TAITO_STORAGES.ACTIVE_MISSION) ~= config.missionID then
        doPlayerSendTextMessage(cid, 22, "Voce nao sabe como usar este selo explosivo corretamente.")
        return true
    end

    -- Verificação Geográfica
    local pPos = getThingPos(cid)
    local inArea = (pPos.x >= config.area.from.x and pPos.x <= config.area.to.x and
                    pPos.y >= config.area.from.y and pPos.y <= config.area.to.y and
                    pPos.z == config.area.from.z)

    if not inArea then
        doPlayerSendTextMessage(cid, 22, "Voce precisa estar mais proximo dos suprimentos para plantar a bomba.")
        return true
    end

    -- Verificação de Progresso
    if getPlayerStorageValue(cid, TAITO_STORAGES.MISSION_PROG) >= 1 then
        doPlayerSendTextMessage(cid, 22, "Estes suprimentos ja foram sabotados.")
        return true
    end

    -- Ação de Plantar
    doRemoveItem(item.uid, 1)
    setPlayerStorageValue(cid, TAITO_STORAGES.MISSION_PROG, 1)
    
    local bombPos = {x = pPos.x, y = pPos.y, z = pPos.z}
    
    -- Efeito de "fumaça" imediato onde o player usou o item
    doSendMagicEffect(bombPos, 2)
    doCreatureSay(cid, "SELO EXPLOSIVO PLANTADO!", TALKTYPE_ORANGE_1)
    doPlayerSendTextMessage(cid, 20, "A bomba explodira em 3 segundos! CORRA!")

    -- Agenda a explosão
    addEvent(causarDano, config.tempoDetonacao, bombPos, cid)

    return true
end