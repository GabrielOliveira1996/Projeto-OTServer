local damage_type = COMBAT_KATON_DAMAGE
local effect_projetil = 94 -- efeito da bola de fogo voando
local effect_explosao = 15 -- efeito das labaredas expandindo
local storage_exhaust = 20011
local cooldown = 4
local range = 7

-- areas de explosao do losango, ela ocorre em ondas
-- onda 1 - centro
local area_1 = {{x=0, y=0}}

-- onda 2 - losango pequeno
local area_2 = {
    {x=0, y=-1}, {x=0, y=1}, {x=-1, y=0}, {x=1, y=0}
}

-- onda 3 - losango expandido
local area_3 = {
    {x=0, y=-2}, {x=0, y=2}, {x=-2, y=0}, {x=2, y=0},
    {x=-1, y=-1}, {x=1, y=-1}, {x=-1, y=1}, {x=1, y=1}
}

-- funcao de dano por area
local function applyDiamondDamage(cid, pos, area)
    if not isCreature(cid) then return end
    
    local level = getPlayerLevel(cid)
    local maglevel = getPlayerMagLevel(cid)
    local min = (level * 2.0) + (maglevel * 4.0) + 200
    local max = (level * 2.5) + (maglevel * 5.5) + 350

    for _, offset in ipairs(area) do
        local targetPos = {x = pos.x + offset.x, y = pos.y + offset.y, z = pos.z}
        doAreaCombatHealth(cid, damage_type, targetPos, 0, -min, -max, effect_explosao)
    end
end

local function executeGoukakyuuExplosion(cid, pos)
    if not isCreature(cid) then return end
    
    applyDiamondDamage(cid, pos, area_1)
    addEvent(applyDiamondDamage, 150, cid, pos, area_2)
    addEvent(applyDiamondDamage, 300, cid, pos, area_3)
end

local function moveGoukakyuu(cid, currentPos, look, steps)
    if not isCreature(cid) then return end

    local target = getTopCreature(currentPos).uid
    if isCreature(target) and target ~= cid then
        executeGoukakyuuExplosion(cid, currentPos)
        return
    end

    if steps <= 0 then
        executeGoukakyuuExplosion(cid, currentPos)
        return
    end

    local nextPos = {x = currentPos.x, y = currentPos.y, z = currentPos.z}
    if look == 0 then nextPos.y = nextPos.y - 1
    elseif look == 1 then nextPos.x = nextPos.x + 1
    elseif look == 2 then nextPos.y = nextPos.y + 1
    elseif look == 3 then nextPos.x = nextPos.x - 1
    end

    if doTileQueryAdd(cid, nextPos) ~= RETURNVALUE_NOERROR and not isCreature(getTopCreature(nextPos).uid) then
        executeGoukakyuuExplosion(cid, currentPos)
        return
    end

    doSendMagicEffect(nextPos, effect_projetil)
    addEvent(moveGoukakyuu, 100, cid, nextPos, look, steps - 1)
end

function onCastSpell(cid, var)
    if exhaustion.check(cid, storage_exhaust) then
        doPlayerSendCancel(cid, "Cooldown[" .. exhaustion.get(cid, storage_exhaust) .. "]")
        return false
    end

    exhaustion.set(cid, storage_exhaust, cooldown)
    
    local p = getCreaturePosition(cid)
    local look = getCreatureLookDirection(cid)
    
    local startPos = {x=p.x, y=p.y, z=p.z}
    moveGoukakyuu(cid, startPos, look, range)
    return true
end