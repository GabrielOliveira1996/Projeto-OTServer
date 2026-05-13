local config = {
    chance_quebrar = 20, -- 20% de chance de sumir ao usar
    efeito_tiro = CONST_FUUMA_SHURIKEN_THROW, 
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
        doPlayerSendCancel(cid, "Este item deve estar no slot de munição ou em uma bolsa na munição.")
        return true
    end

    if exhaustion.check(cid, config.storage_exhaust) then
        doPlayerSendCancel(cid, "Aguarde " .. exhaustion.get(cid, config.storage_exhaust) .. " segundo(s) para usar a big shuriken novamente.")
        return true
    end

    local target = itemEx.uid
    if not isCreature(target) then 
        target = getCreatureTarget(cid) 
    end

    if not isCreature(target) or target == cid then 
        doPlayerSendCancel(cid, "Você precisa de um alvo selecionado.")
        return true 
    end
    
    if getDistanceBetween(getThingPos(cid), getThingPos(target)) > config.range then
        doPlayerSendCancel(cid, "O alvo esta muito longe.")
        return true
    end

    local skill = getPlayerSkillLevel(cid, SKILL_DISTANCE)
    local level = getPlayerLevel(cid)
    
    local min = 25 + (skill * 1.5) + (level * 0.3)
    local max = 45 + (skill * 2.1) + (level * 0.5)
    local damage = math.random(min, max)

    doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -damage, -damage, config.efeito_impacto)
    doSendDistanceShoot(getThingPos(cid), getThingPos(target), config.efeito_tiro)

    exhaustion.set(cid, config.storage_exhaust, config.cooldown)

    if math.random(1, 100) <= config.chance_quebrar then
        doRemoveItem(item.uid, 1)
    end

    return true
end