local storage_status = 305 -- Storage para verificar se está ativo
local healing_interval = 1000 -- Cura a cada 1 segundo
local mana_drain_interval = 2000 -- Gasto de mana a cada 2 segundos
local effect_interval = 2000 -- Efeito visual a cada 2 segundos

local heal_amount = 200
local mana_drain_amount = 150
local effect_id = 12 -- Substitua pelo ID do efeito visual das marcas na testa/corpo

function onSozoTick(cid)
    if not isCreature(cid) then return end
    if getPlayerStorageValue(cid, storage_status) <= 0 then return end

    local currentMana = getCreatureMana(cid)
    local maxMana = getCreatureMaxMana(cid)

    -- Condição: Se a mana ficar abaixo de 10%, desativa
    if currentMana < (maxMana * 0.10) then
        setPlayerStorageValue(cid, storage_status, -1)
        doPlayerSendTextMessage(cid, 22, "Sozo Saisei deactivated due to low mana.")
        doSendMagicEffect(getThingPos(cid), 2) -- Efeito de fumaça
        return
    end

    doCreatureAddHealth(cid, heal_amount)
    
    local time = os.time()
    if time % 2 == 0 then
        doCreatureAddMana(cid, -mana_drain_amount)
        doSendMagicEffect(getThingPos(cid), effect_id)
    end

    addEvent(onSozoTick, healing_interval, cid)
end

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, storage_status) > 0 then
        setPlayerStorageValue(cid, storage_status, -1)
        doPlayerSendTextMessage(cid, 22, "Sozo Saisei: OFF")
        return true
    end

    if getCreatureMana(cid) < (getCreatureMaxMana(cid) * 0.10) then
        doPlayerSendCancel(cid, "You don't have enough mana to activate Sozo Saisei.")
        return false
    end

    setPlayerStorageValue(cid, storage_status, 1)
    doPlayerSendTextMessage(cid, 22, "Sozo Saisei: ON")
    doCreatureSay(cid, "SOZO SAISEI!", TALKTYPE_MONSTER)
    doSendMagicEffect(getThingPos(cid), effect_id)
    
    onSozoTick(cid)
    return true
end