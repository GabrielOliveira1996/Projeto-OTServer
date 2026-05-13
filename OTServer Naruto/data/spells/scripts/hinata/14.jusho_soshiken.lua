local STORAGE_LION = 45005
local MANA_PER_SECOND = 100 -- consumo de chakra a cada 2 segundos 
local EFFECT_ACTIVATION = 56 -- efeito ao ativar jutsu
local OUTFIT_ID = 186 -- id da outfit dos leões gêmeos

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, STORAGE_LION) > 0 then
        setPlayerStorageValue(cid, STORAGE_LION, 0)
        doRemoveCondition(cid, CONDITION_OUTFIT) 
        doPlayerSendTextMessage(cid, 22, "Soshiken: Deactivated!")
        return true
    end

    -- verificação de mana mínima para ligar
    if getCreatureMana(cid) < MANA_PER_SECOND then
        doPlayerSendCancel(cid, "Low chakra to maintain Soshiken.")
        return false
    end

    -- ativa a storage e muda a outfit
    setPlayerStorageValue(cid, STORAGE_LION, 1)
    doSetCreatureOutfit(cid, {lookType = OUTFIT_ID}, -1) 
    
    doSendMagicEffect(getThingPos(cid), EFFECT_ACTIVATION)
    doPlayerSendTextMessage(cid, 22, "Jushou Soshiken: Activated!")

    -- função de loop apenas para consumo de mana e controle de outfit
    local function consumeManaLion(cid)
        if not isCreature(cid) or getPlayerStorageValue(cid, STORAGE_LION) <= 0 then
            if isCreature(cid) then 
                doRemoveCondition(cid, CONDITION_OUTFIT) 
            end
            return false
        end

        if getCreatureMana(cid) >= MANA_PER_SECOND then
            doPlayerRemoveMana(cid, -MANA_PER_SECOND)
            addEvent(consumeManaLion, 2000, cid) 
        else
            -- se o chakra acabar, remove a roupa e desliga
            setPlayerStorageValue(cid, STORAGE_LION, 0)
            doRemoveCondition(cid, CONDITION_OUTFIT)
            doPlayerSendTextMessage(cid, 22, "Jushou Soshiken Deactivated: Low Chakra!")
        end
    end

    consumeManaLion(cid)
    return true
end