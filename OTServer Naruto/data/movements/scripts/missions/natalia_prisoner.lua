local config = {
    storage = 34095,
    valueRequired = 4, 
    newValue = 5,     
    monsterName = "Natalia Prisoner",
    transformTo = "Kuroi's Henchman",
    jhonSummonName = "Jhon Lee"
}

function onStepIn(cid, item, position, fromPosition)
    if not isPlayer(cid) then return true end

    -- só funciona se já falou com o comandante
    if getPlayerStorageValue(cid, config.storage) ~= config.valueRequired then
        return true
    end

    local nataliaCid = nil
    local spectators = getSpectators(getThingPos(cid), 7, 7, false)
    if spectators then
        for _, spec in ipairs(spectators) do
            if isMonster(spec) and getCreatureName(spec) == config.monsterName then
                nataliaCid = spec
                break
            end
        end
    end

    if not nataliaCid then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_SMALL, "Espere ela reaparecer na sela.")
        return true
    end

    local jhonCid = nil
    local summons = getCreatureSummons(cid)
    for _, summon in ipairs(summons) do
        if getCreatureName(summon) == config.jhonSummonName then
            jhonCid = summon
            break
        end
    end

    if not jhonCid then
        doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Jhon Lee precisa estar aqui para ver isso.")
        return true
    end

    -- EXECUÇÃO DA FARSA
    local nataliaPos = getThingPos(nataliaCid)
    doRemoveCreature(nataliaCid)
    doCreateMonster(config.transformTo, nataliaPos)
    doSendMagicEffect(nataliaPos, CONST_ME_POFF)

    doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Era apenas um capanga transformado na Natalia.")
    doCreatureSay(jhonCid, "Jhon Lee: Era tudo uma isca falsa, vamos voltar para a cabana.", TALKTYPE_SAY)

    setPlayerStorageValue(cid, config.storage, config.newValue)

    addEvent(function()
        if isCreature(jhonCid) then
            doSendMagicEffect(getThingPos(jhonCid), CONST_ME_POFF)
            doRemoveCreature(jhonCid)
        end
    end, 3000)

    return true
end