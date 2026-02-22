local damage_type = COMBAT_FUUTON_DAMAGE 
local effect_impacto = 39 

-- Áreas (Coordenadas relativas ao centro)
local area_centro = { {x=0, y=0} }
local area_expandida = {
    {x=-1, y=-1}, {x=0, y=-1}, {x=1, y=-1},
    {x=-1, y=0},  {x=0, y=0},  {x=1, y=0},
    {x=-1, y=1},  {x=0, y=1},  {x=1, y=1}
}

-- Função que calcula a fórmula e aplica o dano
local function executeDamage(cid, area, damage_type, pos)
    if not isCreature(cid) then return false end
    
    -- SUA FÓRMULA AQUI
    local level = getPlayerLevel(cid)
    local maglevel = getPlayerMagLevel(cid)
    local min = (level * 1.5) + (maglevel * 3.5) + 100
    local max = (level * 2.0) + (maglevel * 5.5) + 150

    for _, offset in ipairs(area) do
        local checkPos = {x = pos.x + offset.x, y = pos.y + offset.y, z = pos.z}
        local target = getTopCreature(checkPos).uid
        
        if isCreature(target) and target ~= cid then
            -- Aplica o dano usando a fórmula calculada
            doTargetCombatHealth(cid, target, damage_type, -min, -max, effect_impacto)
        end
    end
end

function onCastSpell(cid, var)
    local p = getCreaturePosition(cid)
    local look = getCreatureLookDirection(cid)
    
    -- POSIÇÃO REAL DO DANO
    local pos_dano = {x=p.x, y=p.y, z=p.z}
    if look == 0 then pos_dano.y = p.y - 1 
    elseif look == 1 then pos_dano.x = p.x + 1 
    elseif look == 2 then pos_dano.y = p.y + 1 
    elseif look == 3 then pos_dano.x = p.x - 1 
    end

    -- POSIÇÃO DA ANIMAÇÃO (Sua calibração visual)
    local pos_anim = {x=p.x, y=p.y, z=p.z}
    if look == 0 then 
        pos_anim.y = p.y - 0 
        pos_anim.x = p.x + 1 
    elseif look == 1 then 
        pos_anim.y = p.y + 1 
        pos_anim.x = p.x + 2 
    elseif look == 2 then 
        pos_anim.y = p.y + 2 
        pos_anim.x = p.x + 1 
    elseif look == 3 then 
        pos_anim.y = p.y + 1
        pos_anim.x = p.x - 0
    end

    if not exhaustion.check(cid, 23003) then
        exhaustion.set(cid, 23003, 2)
        
        -- Efeito visual do Rasengan
        doSendMagicEffect(pos_anim, 32)

        -- SEQUÊNCIA DE PULSOS (Usando a nova lógica de fórmula)
        -- Pulsos no Centro (1 SQM)
        executeDamage(cid, area_centro, damage_type, pos_dano) 
        addEvent(executeDamage, 600, cid, area_centro, damage_type, pos_dano)
        addEvent(executeDamage, 1200, cid, area_centro, damage_type, pos_dano)
        
        -- Pulsos de Expansão (3x3)
        addEvent(executeDamage, 1800, cid, area_expandida, damage_type, pos_dano)
        addEvent(executeDamage, 2200, cid, area_expandida, damage_type, pos_dano)
        addEvent(executeDamage, 2600, cid, area_expandida, damage_type, pos_dano)

        return true
    else
        doPlayerSendCancel(cid, "Cooldown[" .. exhaustion.get(cid, 23003) .. "]")
        return false
    end
end