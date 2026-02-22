local damage_type = COMBAT_FUUTON_DAMAGE 
local effect_explosao_corpo = 39 
local effect_rasenshuriken = 32 
local effect_missil = 5  
local range = 5 

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
    local min = (level * 2.5) + (maglevel * 5.5) + 200
    local max = (level * 3.5) + (maglevel * 7.5) + 300

    for _, offset in ipairs(area) do
        local checkPos = {x = pos.x + offset.x, y = pos.y + offset.y, z = pos.z}
        local target = getTopCreature(checkPos).uid
        
        if isCreature(target) and target ~= cid then
            doTargetCombatHealth(cid, target, damage_type, -min, -max, effect_explosao_corpo)
        end
    end
end

local function startExplosion(cid, position)
    if not isCreature(cid) then return false end

    local pos_32 = {x = position.x + 1, y = position.y + 1, z = position.z}
    doSendMagicEffect(pos_32, effect_rasenshuriken)

    executeDamage(cid, area_centro, damage_type, position) 
    addEvent(executeDamage, 600, cid, area_centro, damage_type, position)
    addEvent(executeDamage, 1200, cid, area_centro, damage_type, position)
    addEvent(executeDamage, 1800, cid, area_expandida, damage_type, position)
    addEvent(executeDamage, 2200, cid, area_expandida, damage_type, position)
    addEvent(executeDamage, 2600, cid, area_expandida, damage_type, position)
end

local function moveProjectile(cid, currentPos, look, steps)
    if not isCreature(cid) then return false end

    -- 1. COLISÃO DIRETA NO ALVO
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

    -- 2. CHECAGEM DE PAREDE (Se não houver criatura bloqueando o tile)
    local targetNext = getTopCreature(nextPos).uid
    if not isCreature(targetNext) then
        if doTileQueryAdd(cid, nextPos) ~= RETURNVALUE_NOERROR then
            startExplosion(cid, currentPos)
            return true
        end
    end

    -- 3. DISPARO VISUAL
    local shootStart = {x = currentPos.x, y = currentPos.y, z = currentPos.z}
    local shootEnd = {x = nextPos.x, y = nextPos.y, z = nextPos.z}
    if look == 0 or look == 2 then
        shootStart.x = shootStart.x + 1
        shootEnd.x = shootEnd.x + 1
    end

    doSendDistanceShoot(shootStart, shootEnd, effect_missil)
    addEvent(moveProjectile, 120, cid, nextPos, look, steps - 1)
end

function onCastSpell(cid, var)
    if exhaustion.check(cid, 23004) then
        doPlayerSendCancel(cid, "Cooldown[" .. exhaustion.get(cid, 23004) .. "]")
        return false
    end

    local p = getCreaturePosition(cid)
    local look = getCreatureLookDirection(cid)
    
    local firstPos = {x=p.x, y=p.y, z=p.z}
    if look == 0 then firstPos.y = p.y - 1
    elseif look == 1 then firstPos.x = p.x + 1
    elseif look == 2 then firstPos.y = p.y + 1
    elseif look == 3 then firstPos.x = p.x - 1
    end

    -- TRAVA DE PAREDE IMEDIATA:
    -- Se o primeiro SQM já for uma parede, explode na frente do player e nem inicia o move
    if doTileQueryAdd(cid, firstPos) ~= RETURNVALUE_NOERROR and not isCreature(getTopCreature(firstPos).uid) then
        exhaustion.set(cid, 23004, 3)
        startExplosion(cid, p) -- Explode no pé do Naruto para não atravessar
        return true
    end

    exhaustion.set(cid, 23004, 3)
    moveProjectile(cid, firstPos, look, range)
    return true
end