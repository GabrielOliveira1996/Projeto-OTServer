local config = {
    type = COMBAT_PHYSICALDAMAGE,
    storage = 23001,
    cooldown = 2,
    invisibleOutfit = 0 
}

local effects = {
    [0] = 29, [1] = 27, [2] = 30, [3] = 28
}

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

    local distance = (level >= 100 and 7) or (level >= 50 and 5) or 3
    local originalOutfit = getCreatureOutfit(cid)
    
    doSetCreatureOutfit(cid, {lookType = config.invisibleOutfit}, -1)
    doCreatureSetNoMove(cid, true)

    for i = 1, distance do
        addEvent(function()
            if not isCreature(cid) then return end
            
            local currentPos = getCreaturePosition(cid)
            local nextPos = getPosByDir(currentPos, dir)
            
            if canWalk(nextPos) then
                local minDmg = -((fist * 1.0) + (level * 1.0))
                local maxDmg = -((fist * 1.5) + (level * 1.5))
                
                doSafeDamage(cid, nextPos, config.type, minDmg, maxDmg)
                
                local posL, posR = getLateralPos(nextPos, dir)
                doSafeDamage(cid, posL, config.type, minDmg, maxDmg)
                doSafeDamage(cid, posR, config.type, minDmg, maxDmg)

                doTeleportThing(cid, nextPos, true)
                doSendMagicEffect(nextPos, effects[dir] or 29)
            else
                distance = i
            end

            if i == distance then
                if isCreature(cid) then
                    doSetCreatureOutfit(cid, originalOutfit, 0)
                    doCreatureSetNoMove(cid, false)
                end
            end
        end, i * 60)
    end
end

function onCastSpell(cid, var)
    if not isPlayer(cid) then
        return false 
    end

    if exhaustion.check(cid, config.storage) then
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end

    exhaustion.set(cid, config.storage, config.cooldown)
    executeTsuuga(cid)

    return true
end