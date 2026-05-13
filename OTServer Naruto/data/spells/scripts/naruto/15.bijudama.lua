local damage_type = COMBAT_KATON_DAMAGE
local effect_hit_corpo = 2 
local effect_bijudama_explosao = 53 
local effect_missil = 50 
local effect_carregamento = 51
local range = 6 
local cooldown_storage = 23014

-- tabela de vocações permitidas
local vocsAllowed = {9, 10} 

local area_centro = { {x=0, y=0} }
local area_expandida = {
    {x=-1, y=-1}, {x=0, y=-1}, {x=1, y=-1},
    {x=-1, y=0},  {x=0, y=0},  {x=1, y=0},
    {x=-1, y=1},  {x=0, y=1},  {x=1, y=1}
}

-- funcao auxiliar para verificar a vocação
local function isVocAllowed(cid, allowedList)
    local v = getPlayerVocation(cid)
    for i = 1, #allowedList do
        if v == allowedList[i] then return true end
    end
    return false
end

local function executeDamage(cid, area, damage_type, pos)
    if not isCreature(cid) then return false end
    
    local level = getPlayerLevel(cid)
    local maglevel = getPlayerMagLevel(cid)
    local min = (level * 4.5) + (maglevel * 7.5) + 400
    local max = (level * 5.5) + (maglevel * 9.5) + 600

    for _, offset in ipairs(area) do
        local checkPos = {x = pos.x + offset.x, y = pos.y + offset.y, z = pos.z}
        local target = getTopCreature(checkPos).uid
        
        if isCreature(target) and target ~= cid then
            doTargetCombatHealth(cid, target, damage_type, -min, -max, effect_hit_corpo)
        end
    end
end

local function startExplosion(cid, position)
    if not isCreature(cid) then return false end

    local pos_visual = {x = position.x + 1, y = position.y + 1, z = position.z}
    doSendMagicEffect(pos_visual, effect_bijudama_explosao)

    executeDamage(cid, area_expandida, damage_type, position) 
end

local function moveProjectile(cid, currentPos, look, steps)
    if not isCreature(cid) then return false end

    local targetHere = getTopCreature(currentPos).uid
    if isCreature(targetHere) and targetHere ~= cid then
        startExplosion(cid, currentPos)
        return true
    end

    if steps <= 0 then 
        startExplosion(cid, currentPos)
        return true 
    end

    local nextPos = {x = currentPos.x, y = currentPos.y, z = currentPos.z}
    if look == 0 then nextPos.y = nextPos.y - 1
    elseif look == 1 then nextPos.x = nextPos.x + 1
    elseif look == 2 then nextPos.y = nextPos.y + 1
    elseif look == 3 then nextPos.x = nextPos.x - 1
    end

    local targetNext = getTopCreature(nextPos).uid
    if not isCreature(targetNext) then
        if doTileQueryAdd(cid, nextPos) ~= RETURNVALUE_NOERROR then
            startExplosion(cid, currentPos)
            return true
        end
    end

    doSendMagicEffect(currentPos, effect_missil)
    addEvent(moveProjectile, 100, cid, nextPos, look, steps - 1)
end

local function fireBijudama(cid)
    if not isCreature(cid) then return false end
    local p = getCreaturePosition(cid)
    local look = getCreatureLookDirection(cid)
    
    local firstPos = {x=p.x, y=p.y, z=p.z}
    if look == 0 then firstPos.y = p.y - 1
    elseif look == 1 then firstPos.x = p.x + 1
    elseif look == 2 then firstPos.y = p.y + 1
    elseif look == 3 then firstPos.x = p.x - 1
    end

    moveProjectile(cid, firstPos, look, range)
end

function onCastSpell(cid, var)
    -- nova trava de vocacoes usando a tabela
    if not isVocAllowed(cid, vocsAllowed) then 
        doPlayerSendCancel(cid, "This jutsu can only be used in Kyuubi Mode.")
        return false 
    end

    if exhaustion.check(cid, cooldown_storage) then
        local cooldownRemaining = exhaustion.get(cid, cooldown_storage)
        doPlayerSendCancel(cid, "Cooldown: " .. cooldownRemaining .. "s.")
        return false
    end

    local pPos = getCreaturePosition(cid)
    doSendMagicEffect({x=pPos.x+1, y=pPos.y+1, z=pPos.z}, effect_carregamento)

    exhaustion.set(cid, cooldown_storage, 3)
    addEvent(fireBijudama, 1000, cid)
    
    return true
end