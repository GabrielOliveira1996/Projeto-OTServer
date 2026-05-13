local config = {
    type = COMBAT_PHYSICALDAMAGE,
    invisibleOutfit = 0 
}

-- Efeitos normais e efeitos de Fusão (Novos IDs e Direções)
local effectsNormal = { [0] = 29, [1] = 27, [2] = 30, [3] = 28 }
local effectsFusion = { 
    [0] = 46, -- Cima
    [1] = 47, -- Direita
    [2] = 45, -- Baixo
    [3] = 35  -- Esquerda
}

-- Funções Auxiliares (Obrigatórias)
local function canWalk(pos)
    local tile = getTileInfo(pos)
    if not tile or tile.thingID == 0 then return false end
    local item = getThingFromPos({x=pos.x, y=pos.y, z=pos.z, stackpos=0})
    if item.uid > 0 and hasProperty(item.uid, CONST_PROP_BLOCKSOLID) then 
        return false 
    end
    return true
end

local function getLateralPos(pos, dir)
    local left, right = {x=pos.x, y=pos.y, z=pos.z}, {x=pos.x, y=pos.y, z=pos.z}
    if dir == 0 or dir == 2 then
        left.x = pos.x - 1
        right.x = pos.x + 1
    else
        left.y = pos.y - 1
        right.y = pos.y + 1
    end
    return left, right
end

local function doSafeDamage(cid, targetPos, type, min, max)
    local tile = getTileInfo(targetPos)
    if tile and tile.creatures > 0 then
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
    local level = getPlayerLevel(cid)
    local fist = getPlayerSkillLevel(cid, SKILL_FIST)
    local isFused = getPlayerStorageValue(cid, STORAGE_IS_FUSED) > 0

    local distance = (level >= 100 and 5) or (level >= 50 and 4) or 3
    local originalOutfit = getCreatureOutfit(cid)
    
    -- Fica invisível durante o giro
    doSetCreatureOutfit(cid, {lookType = config.invisibleOutfit}, -1)
    doCreatureSetNoMove(cid, true)

    for i = 1, distance do
        addEvent(function()
            if not isCreature(cid) then return end
            
            local currentPos = getCreaturePosition(cid)
            local nextPos = getPosByDir(currentPos, dir)
            
            if canWalk(nextPos) then
                -- FÓRMULA DE DANO AJUSTADA
                local minDmg, maxDmg
                if isFused then
                    -- Dano na Fusão (Mais forte)
                    minDmg = -((fist * 5.0) + (level * 2.5)) 
                    maxDmg = -((fist * 7.5) + (level * 4.0))
                else
                    -- Dano Normal
                    minDmg = -((fist * 3.0) + (level * 1.5)) 
                    maxDmg = -((fist * 4.5) + (level * 3.0))
                end
                
                -- Aplica dano na frente e nas laterais
                doSafeDamage(cid, nextPos, config.type, minDmg, maxDmg)
                local posL, posR = getLateralPos(nextPos, dir)
                doSafeDamage(cid, posL, config.type, minDmg, maxDmg)
                doSafeDamage(cid, posR, config.type, minDmg, maxDmg)

                doTeleportThing(cid, nextPos, true)

                if isFused then
                    local effectPos = {x = nextPos.x, y = nextPos.y, z = nextPos.z}
                    local offsets = {
                        [0] = {x = 1, y = 1}, -- Cima 
                        [1] = {x = 0, y = 1}, -- Direita
                        [2] = {x = 1, y = 1}, -- Baixo
                        [3] = {x = 0, y = 1}  -- Esquerda
                    }

                    local configOffset = offsets[dir]
                    if configOffset then
                        effectPos.x = effectPos.x + configOffset.x
                        effectPos.y = effectPos.y + configOffset.y
                    end
                    doSendMagicEffect(effectPos, effectsFusion[dir] or 45)
                else
                    doSendMagicEffect(nextPos, effectsNormal[dir] or 29)
                end
            else
                distance = i 
            end

            if i == distance then
                if isCreature(cid) then
                    doCreatureSetNoMove(cid, false)
                    if isFused then
                        -- Se ainda estiver em fusão, volta para a roupa da fusão
                        doSetCreatureOutfit(cid, {lookType = FIRST_FUSION_OUTFIT}, -1)
                    else
                        -- Se não, volta para o que era antes (Kiba normal)
                        doSetCreatureOutfit(cid, originalOutfit, 0)
                    end
                end
            end
        end, i * 60)
    end
end

function onCastSpell(cid, var)
    if not isPlayer(cid) then return false end
    executeTsuuga(cid)
    return true
end