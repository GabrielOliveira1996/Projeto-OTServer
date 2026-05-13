local damage_type = COMBAT_FUUTON_DAMAGE 
local effect_impacto = 39 
local cooldownTime = 3 
local storage_exhaust = 23008 

-- Configurações de Vocação e Custo
local voc_sennin = 11
local voc_kyuubi_sennin = 12
local voc_kyuubi_sennin_kage = 13
local custo_soul = 15

-- Áreas
local area_centro = { {x=0, y=0} }
local area_expandida = {
    {x=-1, y=-1}, {x=0, y=-1}, {x=1, y=-1},
    {x=-1, y=0},  {x=0, y=0},  {x=1, y=0},
    {x=-1, y=1},  {x=0, y=1},  {x=1, y=1}
}

local function executeDamage(cid, area, damage_type, pos)
    if not isCreature(cid) then return false end
    
    local level = getPlayerLevel(cid)
    local maglevel = getPlayerMagLevel(cid)
    local min = (level * 1.5) + (maglevel * 3.5) + 100
    local max = (level * 2.0) + (maglevel * 5.5) + 150

    for _, offset in ipairs(area) do
        local checkPos = {x = pos.x + offset.x, y = pos.y + offset.y, z = pos.z}
        local target = getTopCreature(checkPos).uid
        if isCreature(target) and target ~= cid then
            local master = getCreatureMaster(target)
            if master ~= cid then
                doTargetCombatHealth(cid, target, damage_type, -min, -max, effect_impacto)
            end
        end
    end
end

function onCastSpell(cid, var)
    local vocation = getPlayerVocation(cid)
    local sanin_mode_check = (vocation == voc_sennin or vocation == voc_kyuubi_sennin or vocation == voc_kyuubi_sennin_kage)

    -- Verifica quarta cauda
    if vocation == 68 then
        doPlayerSendCancel(cid, "This form does not allow the use of this jutsu.")
        doSendMagicEffect(getThingPos(cid), 2)
        return false
    end

    -- BLOQUEIO RIGOROSO DE SOUL POINTS
    if sanin_mode_check and getPlayerSoul(cid) < custo_soul then
        doPlayerSendCancel(cid, "You need at least " .. custo_soul .. " Soul Points to use this technique.")
        doSendMagicEffect(getThingPos(cid), 2)
        return false
    end

    -- Verificação de Cooldown
    if exhaustion.check(cid, storage_exhaust) then
        doPlayerSendCancel(cid, "Cooldown[" .. exhaustion.get(cid, storage_exhaust) .. "]")
        return false
    end

    -- Aplica Custo e Cooldown (Apenas se passou pelas verificações acima)
    if sanin_mode_check then
        doPlayerAddSoul(cid, -custo_soul)
        doSendMagicEffect(getThingPos(cid), 13)
    end
    exhaustion.set(cid, storage_exhaust, cooldownTime)

    -- Lógica de Posição
    local p = getCreaturePosition(cid)
    local look = getCreatureLookDirection(cid)
    local pos_dano = {x=p.x, y=p.y, z=p.z}
    if look == 0 then pos_dano.y = p.y - 1 
    elseif look == 1 then pos_dano.x = p.x + 1 
    elseif look == 2 then pos_dano.y = p.y + 1 
    elseif look == 3 then pos_dano.x = p.x - 1 
    end

    local pos_anim = {x=p.x, y=p.y, z=p.z}
    if look == 0 then pos_anim.x = p.x + 1 
    elseif look == 1 then pos_anim.y = p.y + 1; pos_anim.x = p.x + 2 
    elseif look == 2 then pos_anim.y = p.y + 2; pos_anim.x = p.x + 1 
    elseif look == 3 then pos_anim.y = p.y + 1
    end

    

    doSendMagicEffect(pos_anim, 32)
    executeDamage(cid, area_centro, damage_type, pos_dano) 
    addEvent(executeDamage, 600, cid, area_centro, damage_type, pos_dano)
    addEvent(executeDamage, 1200, cid, area_centro, damage_type, pos_dano)
    addEvent(executeDamage, 1800, cid, area_expandida, damage_type, pos_dano)
    addEvent(executeDamage, 2200, cid, area_expandida, damage_type, pos_dano)
    addEvent(executeDamage, 2600, cid, area_expandida, damage_type, pos_dano)

    return true
end