--configuracoes
local storage_status = 301 -- 
local storage_drain = 302 -- storage que guarda a informacao de que a vida esta sendo drenada
local health_loss_interval = 2000 -- intervalo de perda de vida onde 1000 é igual 1 seg.
local health_loss_amount = 150 -- quantidade de vida perdida intervalo

function onLossTick(cid)
    if not isCreature(cid) then return end
    if getPlayerStorageValue(cid, storage_status) <= 0 then return end

    local currentHpPercent = getCreatureHealth(cid) / getCreatureMaxHealth(cid)
    
    if currentHpPercent <= 0.20 then
        setPlayerStorageValue(cid, storage_status, -1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Your Susano'o has dissipated!") 
        doSendMagicEffect(getThingPos(cid), 2)
        return
    end

    setPlayerStorageValue(cid, storage_drain, 1) 
    doCreatureAddHealth(cid, -health_loss_amount)
    setPlayerStorageValue(cid, storage_drain, -1) 
    doSendMagicEffect(getThingPos(cid), 40)
    addEvent(onLossTick, health_loss_interval, cid)
end

function onCastSpell(cid, var)
    -- desativa manualmente
    if getPlayerStorageValue(cid, storage_status) > 0 then
        setPlayerStorageValue(cid, storage_status, -1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Susano'o Deactivated")
        return true
    end

    -- checa a vida esta abaixo de 20% se estiver nao usa susanoo
    local currentHpPercent = getCreatureHealth(cid) / getCreatureMaxHealth(cid)
    if currentHpPercent <= 0.20 then
        doPlayerSendCancel(cid, "You are too weak to summon Susano'o.")
        return false
    end

    -- ativa susanoo
    setPlayerStorageValue(cid, storage_status, 1)
    doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Susano'o Activated!")
    doCreatureSay(cid, "SUSANOO!", TALKTYPE_MONSTER)
    doSendMagicEffect(getThingPos(cid), 40)
    onLossTick(cid)
    return true
end