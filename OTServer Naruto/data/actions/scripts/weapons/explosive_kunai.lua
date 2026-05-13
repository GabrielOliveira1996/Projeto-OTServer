local config = {
    chance_quebrar = 100,
    efeito_tiro = CONST_EXPLOSIVE_KUNAI_THROW,
    efeito_explosao = 16,
    cooldown = 1,
    storage_exhaust = STORAGE_COOLDOWN_WEAPON_DISTANCE,
    range = 6
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
        doPlayerSendCancel(cid, "Aguarde " .. exhaustion.get(cid, config.storage_exhaust) .. " segundo(s) para usar a kunai explosiva.")
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
    local min = 40 + (skill * 1.5) + (level * 0.3)
    local max = 70 + (skill * 2.2) + (level * 0.5)

    local targetPos = getThingPos(target)
    local area = {
        {x = targetPos.x, y = targetPos.y, z = targetPos.z},
        {x = targetPos.x + 1, y = targetPos.y, z = targetPos.z},
        {x = targetPos.x - 1, y = targetPos.y, z = targetPos.z},
        {x = targetPos.x, y = targetPos.y + 1, z = targetPos.z},
        {x = targetPos.x, y = targetPos.y - 1, z = targetPos.z}
    }

    doSendDistanceShoot(getThingPos(cid), targetPos, config.efeito_tiro)
    
    for _, pos in ipairs(area) do
        doAreaCombatHealth(cid, COMBAT_KATON_DAMAGE, pos, 0, -min, -max, config.efeito_explosao)
    end

    exhaustion.set(cid, config.storage_exhaust, config.cooldown)
    doRemoveItem(item.uid, 1)
    
    return true
end