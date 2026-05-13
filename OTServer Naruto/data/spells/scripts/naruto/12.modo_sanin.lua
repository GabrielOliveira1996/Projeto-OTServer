local storage_energy = 45009
local storage_meditando = 45007
local storage_ativado = 45008
local voc_shippuden = 2
local voc_war = 3
local voc_hokage = 4
-- first sanin level
local voc_sennin = 11
local look_sennin = 164
-- second sanin level (kyuubi sanin mode)
local voc_kyuubi_sennin = 12
local look_kyuubi_sennin = 350
-- kage sanin level (kyuubi sanin mode)
local voc_kyuubi_sennin_kage = 13
local look_kyuubi_sennin_kage = 348

local SOUL_CONSUMPTION_AMOUNT = 1
local SOUL_CONSUMPTION_INTERVAL = 2

local function consumeSenninMode(cid)
    if not isCreature(cid) or getPlayerStorageValue(cid, storage_ativado) <= 0 then return end

    if getPlayerSoul(cid) >= SOUL_CONSUMPTION_AMOUNT then
        doPlayerAddSoul(cid, -SOUL_CONSUMPTION_AMOUNT)
        addEvent(consumeSenninMode, SOUL_CONSUMPTION_INTERVAL * 1000, cid)
    else
        setPlayerStorageValue(cid, storage_ativado, 0)
        doPlayerSetVocation(cid, voc_shippuden)
        doRemoveCondition(cid, CONDITION_OUTFIT)
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Modo Sábio esgotado! Chakra da Natureza insuficiente.")
    end
end

function onCastSpell(cid, var)
    -- trava se estiver meditando
    if getPlayerStorageValue(cid, storage_meditando) == 1 then
        doPlayerSendCancel(cid, "Não é possível ativar o Modo Sábio durante a meditação.")
        return false
    end

    -- se jÃ¡ estiver ativado, desativa
    if getPlayerStorageValue(cid, storage_ativado) == 1 then
        if currentVoc >= voc_kyuubi_sennin_kage then -- retorna ao hokage
            setPlayerStorageValue(cid, storage_ativado, 0)
            doPlayerSetVocation(cid, voc_hokage)
            doRemoveCondition(cid, CONDITION_OUTFIT)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Modo Sábio desativado.")
            return true
        elseif currentVoc >= voc_kyuubi_sennin then -- retorna ao war
            setPlayerStorageValue(cid, storage_ativado, 0)
            doPlayerSetVocation(cid, voc_war)
            doRemoveCondition(cid, CONDITION_OUTFIT)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Modo Sábio desativado.")
            return true
        elseif currentVoc >= voc_sennin then -- retorna ao shippuden
            setPlayerStorageValue(cid, storage_ativado, 0)
            doPlayerSetVocation(cid, voc_shippuden)
            doRemoveCondition(cid, CONDITION_OUTFIT)
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Modo Sábio desativado.")
            return true
        end
    end

    -- tenta ativar
    if getPlayerStorageValue(cid, storage_energy) >= 100 then
        if getPlayerSoul(cid) < SOUL_CONSUMPTION_AMOUNT then
            doPlayerSendCancel(cid, "Você precisa de pelo menos " .. SOUL_CONSUMPTION_AMOUNT .. " de Chakra da Natureza.")
            return true
        end

        -- LÃ³gica de nÃ­vel e vocaÃ§Ã£o
        local target_voc = voc_sennin
        local target_look = look_sennin
        
        local currentVoc = getPlayerVocation(cid)
        if getPlayerLevel(cid) >= 200 then
            if currentVoc == 3 then -- war
                target_voc = voc_kyuubi_sennin
                target_look = look_kyuubi_sennin
            elseif currentVoc == 4 then -- kage
                target_voc = voc_kyuubi_sennin_kage
                target_look = look_kyuubi_sennin_kage
            end
        end

        setPlayerStorageValue(cid, storage_ativado, 1)
        doPlayerSetVocation(cid, target_voc)
        doSetCreatureOutfit(cid, {lookType = target_look}, -1)
        doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Modo Sábio ativado!")
        consumeSenninMode(cid)
        return true
    else
        doPlayerSendCancel(cid, "Você precisa de mais Energia da Natureza para ativar o Modo Sábio.")
    end
    return false
end