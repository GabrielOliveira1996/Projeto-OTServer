local config = {
    chance_quebrar = 30, -- 30% de chance de sumir ao usar
    efeito_tiro = CONST_KUNAI_THROW, 
    efeito_impacto = 0,
    cooldown = 1,
    storage_exhaust = STORAGE_COOLDOWN_WEAPON_DISTANCE,
    range = 5
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
    local ammoSlot = getPlayerSlotItem(cid, 10)
    local isInsideAmmo = false

    if item.uid == ammoSlot.uid then
        isInsideAmmo = true
    elseif isContainer(ammoSlot.uid) then
        local size = getContainerSize(ammoSlot.uid)
        if size > 0 then
            for i = 0, (size - 1) do
                local slotItem = getContainerItem(ammoSlot.uid, i)
                if slotItem.uid == item.uid then
                    isInsideAmmo = true
                    break
                end
            end
        end
    end

    if not isInsideAmmo then
        doPlayerSendCancel(cid, "Este item deve estar no slot de municao ou em uma bolsa na municao.")
        return true
    end

    if exhaustion.check(cid, config.storage_exhaust) then
        doPlayerSendCancel(cid, "Aguarde " .. exhaustion.get(cid, config.storage_exhaust) .. " segundo(s) para usar a kunai novamente.")
        return true
    end

    local target = itemEx.uid
    if not isCreature(target) then 
        target = getCreatureTarget(cid) 
    end

    if not isCreature(target) or target == cid then 
        doPlayerSendCancel(cid, "Voce precisa de um alvo selecionado.")
        return true 
    end
    
    if getDistanceBetween(getThingPos(cid), getThingPos(target)) > config.range then
        doPlayerSendCancel(cid, "O alvo esta muito longe.")
        return true
    end

    local skill = getPlayerSkillLevel(cid, SKILL_DISTANCE)
    local level = getPlayerLevel(cid)
    local min = 5 + (skill * 1.2) + (level * 0.2)
    local max = 15 + (skill * 1.8) + (level * 0.4)
    local damage = math.random(min, max)

    doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -damage, -damage, config.efeito_impacto)
    doSendDistanceShoot(getThingPos(cid), getThingPos(target), config.efeito_tiro)

    exhaustion.set(cid, config.storage_exhaust, config.cooldown)

    -- Lógica Simplificada:
    -- Se o número aleatório for menor ou igual à chance de quebrar, remove o item.
    -- Se for maior, o item não é removido (fica no inventário).
    if math.random(1, 100) <= config.chance_quebrar then
        doRemoveItem(item.uid, 1)
    end

    return true
end