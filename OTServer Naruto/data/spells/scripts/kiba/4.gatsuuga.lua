local config = {
    type = COMBAT_PHYSICALDAMAGE,
    invisibleOutfit = 0 
}

-- Efeitos normais e efeitos de Fusão (Super Gatsuuga)
local effectsNormal = { [0] = 29, [1] = 27, [2] = 30, [3] = 28 }
local effectsFusion = { [0] = 46, [1] = 47, [2] = 45, [3] = 35 }

-- Funções de suporte
local function canWalk(pos)
    if not pos or pos.x <= 0 then return false end
    local status, tile = pcall(getTileInfo, pos)
    if not status or not tile or tile.thingID == 0 then return false end
    local item = getThingFromPos({x=pos.x, y=pos.y, z=pos.z, stackpos=0})
    if item.uid > 0 and hasProperty(item.uid, CONST_PROP_BLOCKSOLID) then return false end
    return true
end

local function getLateralPos(pos, dir)
    local left, right = {x=pos.x, y=pos.y, z=pos.z}, {x=pos.x, y=pos.y, z=pos.z}
    if dir == 0 or dir == 2 then
        left.x, right.x = pos.x - 1, pos.x + 1
    else
        left.y, right.y = pos.y - 1, pos.y + 1
    end
    return left, right
end

local function doSafeDamage(cid, targetPos, type, min, max)
    local status, tile = pcall(getTileInfo, targetPos)
    if status and tile and tile.creatures > 0 then
        local hitCreatures = {} 
        for i = 0, 255 do
            local thing = getThingfromPos({x=targetPos.x, y=targetPos.y, z=targetPos.z, stackpos=i})
            local target = thing.uid
            if isCreature(target) and not isInArray(hitCreatures, target) then
                if target ~= cid and getCreatureMaster(target) ~= cid and getCreatureMaster(cid) ~= target then
                    doTargetCombatHealth(cid, target, type, min, max, 0)
                    table.insert(hitCreatures, target)
                end
            end
        end
    end
end

local function executeTsuuga(cid)
    if not isCreature(cid) then return end

    local dir = getCreatureLookDirection(cid)
    local level, fist
    local isFused = getPlayerStorageValue(cid, STORAGE_IS_FUSED) > 0

    if isPlayer(cid) then
        level, fist = getPlayerLevel(cid), getPlayerSkillLevel(cid, SKILL_FIST)
    else
        local master = getCreatureMaster(cid)
        level = isPlayer(master) and getPlayerLevel(master) or 50
        fist = isPlayer(master) and getPlayerSkillLevel(master, SKILL_FIST) or 50
    end

    local distance = (level >= 120 and 5) or (level >= 80 and 4) or 3
    local originalOutfit = getCreatureOutfit(cid)
    
    doSetCreatureOutfit(cid, {lookType = config.invisibleOutfit}, -1)
    doCreatureSetNoMove(cid, true)

    local stopMovement = false
    for i = 1, distance do
        addEvent(function()
            if not isCreature(cid) or stopMovement then return end
            
            local currentPos = getCreaturePosition(cid)
            local nextPos = getPosByDir(currentPos, dir)
            
            if canWalk(nextPos) then
                -- FÓRMULA DE DANO (Normal vs Fusão)
                local minDmg, maxDmg
                if isFused then
                    minDmg = -((fist * 6.0) + (level * 3.0)) 
                    maxDmg = -((fist * 9.0) + (level * 5.0))
                else
                    minDmg = -((fist * 3.5) + (level * 2.0)) 
                    maxDmg = -((fist * 5.0) + (level * 3.5))
                end
                
                doSafeDamage(cid, nextPos, config.type, minDmg, maxDmg)
                local posL, posR = getLateralPos(nextPos, dir)
                doSafeDamage(cid, posL, config.type, minDmg, maxDmg)
                doSafeDamage(cid, posR, config.type, minDmg, maxDmg)

                doTeleportThing(cid, nextPos, true)

                -- EFEITOS COM OFFSET
                if isFused then
                    local effectPos = {x = nextPos.x, y = nextPos.y, z = nextPos.z}
                    local offsets = {
                        [0] = {x = 1, y = 1}, -- Cima
                        [1] = {x = 0, y = 1}, -- Direita
                        [2] = {x = 1, y = 1}, -- Baixo
                        [3] = {x = 0, y = 1}  -- Esquerda
                    }
                    local off = offsets[dir]
                    effectPos.x, effectPos.y = effectPos.x + off.x, effectPos.y + off.y
                    doSendMagicEffect(effectPos, effectsFusion[dir] or 45)
                else
                    doSendMagicEffect(nextPos, effectsNormal[dir] or 29)
                end
            else
                stopMovement = true
            end

            if i == distance or stopMovement then
                if isCreature(cid) then
                    doCreatureSetNoMove(cid, false)
                    if isFused then
                        doSetCreatureOutfit(cid, {lookType = FIRST_FUSION_OUTFIT}, -1)
                    else
                        doSetCreatureOutfit(cid, originalOutfit, 0)
                    end
                end
            end
        end, i * 70)
    end
end

function onCastSpell(cid, var)
    executeTsuuga(cid)

    -- Combo com Bunshin (Só acontece se NÃO estiver fundido)
    if isPlayer(cid) and getPlayerStorageValue(cid, STORAGE_IS_FUSED) <= 0 then
        local summons = getCreatureSummons(cid)
        local dir = getCreatureLookDirection(cid)
        local playerName = getPlayerName(cid):lower()

        for _, summon in ipairs(summons) do
            local sName = getCreatureName(summon):lower()
            if sName == playerName then
                doCreatureSetLookDirection(summon, dir)
                executeTsuuga(summon)
            end
        end
    end
    return true
end