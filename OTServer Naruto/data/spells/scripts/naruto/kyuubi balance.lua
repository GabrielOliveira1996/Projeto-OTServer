-- Declare uma variável global para armazenar o identificador do evento
local manaRemovalEvent

function onCastSpell(cid, var)
    local outfit1 = 352
    local outfit2 = 353
    local outfit3 = 164

    if getPlayerLevel(cid) >= 0 and getPlayerLevel(cid) <= 149 and (getPlayerVocation(cid) == 64 or getPlayerVocation(cid) == 65 or getPlayerVocation(cid) == 66) then
        applySpellEffects(cid, outfit1, 37)
    elseif getPlayerLevel(cid) >= 200 and getPlayerLevel(cid) <= 319 and getPlayerVocation(cid) == 67 and getPlayerStorageValue(cid, 20002) == 1 then
        applySpellEffects(cid, outfit2, 39)
    elseif getPlayerLevel(cid) >= 400 and getPlayerLevel(cid) <= 449 and getPlayerVocation(cid) == 81 then
        applySpellEffects(cid, outfit3, 40)
        return true  -- Encerra a função se a condição for atendida
    end
end

function applySpellEffects(cid, lookType, vocation)
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 73)
    doChangeSpeed(cid, -300)
    stopEvent(manaRemovalEvent)
end
