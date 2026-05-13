local config = {
    type = COMBAT_PHYSICALDAMAGE,
    storage = 23007, 
    cooldown = 5,
    invisibleOutfit = 0,
    startEffect = 44,
    fixedDistance = 6
}

local effects = {
    [0] = 46, [1] = 47, [2] = 45, [3] = 35
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

local function getGatsuugaArea(pos, dir)
    local area = {}
    if dir == 0 or dir == 2 then
        table.insert(area, {x=pos.x - 1, y=pos.y, z=pos.z}) 
        table.insert(area, {x=pos.x - 2, y=pos.y, z=pos.z}) 
        table.insert(area, {x=pos.x + 1, y=pos.y, z=pos.z}) 
        table.insert(area, {x=pos.x + 2, y=pos.y, z=pos.z}) 
    else
        table.insert(area, {x=pos.x, y=pos.y - 1, z=pos.z}) 
        table.insert(area, {x=pos.x, y=pos.y - 2, z=pos.z}) 
        table.insert(area, {x=pos.x, y=pos.y + 1, z=pos.z}) 
        table.insert(area, {x=pos.x, y=pos.y + 2, z=pos.z}) 
    end
    return area
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

local function executeGatsuuga(cid)
    if not isCreature(cid) then return end

    local dir = getCreatureLookDirection(cid)
    local pos = getCreaturePosition(cid)
    
    doSendMagicEffect(pos, config.startEffect)

    local level, fist
    if isPlayer(cid) then
        level = getPlayerLevel(cid)
        fist = getPlayerSkillLevel(cid, SKILL_FIST)
    else
        local master = getCreatureMaster(cid)
        level = isPlayer(master) and getPlayerLevel(master) or 50
        fist = isPlayer(master) and getPlayerSkillLevel(master, SKILL_FIST) or 50
    end

    local distance = config.fixedDistance
    local originalOutfit = getCreatureOutfit(cid)
    
    doSetCreatureOutfit(cid, {lookType = config.invisibleOutfit}, -1)
    doCreatureSetNoMove(cid, true)

    for i = 1, distance do
        addEvent(function()
            if not isCreature(cid) then return end
            
            local currentPos = getCreaturePosition(cid)
            local nextPos = getPosByDir(currentPos, dir)
            
            if canWalk(nextPos) then
                local minDmg = -((fist * 2.5) + (level * 2.5))
                local maxDmg = -((fist * 2.5) + (level * 2.5))
                
                doSafeDamage(cid, nextPos, config.type, minDmg, maxDmg)
                
                local sidePos = getGatsuugaArea(nextPos, dir)
                for _, p in ipairs(sidePos) do
                    doSafeDamage(cid, p, config.type, minDmg, maxDmg)
                end

                doTeleportThing(cid, nextPos, true)

                local effectPos = {x = nextPos.x, y = nextPos.y, z = nextPos.z}
                
                if dir == 0 then -- norte
                    effectPos.x = nextPos.x + 1
                    effectPos.y = nextPos.y - 1
                elseif dir == 1 then -- leste
                    effectPos.x = nextPos.x + 1
                    effectPos.y = nextPos.y + 1
                elseif dir == 2 then -- sul
                    effectPos.x = nextPos.x + 1
                    effectPos.y = nextPos.y + 1
                elseif dir == 3 then -- oeste
                    effectPos.x = nextPos.x + 1
                    effectPos.y = nextPos.y + 1
                end
                
                doSendMagicEffect(effectPos, effects[dir] or 29)
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
    if isPlayer(cid) then
        if exhaustion.check(cid, config.storage) then
            doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
            return false
        end
        exhaustion.set(cid, config.storage, config.cooldown)
    end

    executeGatsuuga(cid)

    if isPlayer(cid) then
        local summons = getCreatureSummons(cid)
        local dir = getCreatureLookDirection(cid)
        for _, summon in ipairs(summons) do
            local sName = getCreatureName(summon):lower()
            if sName:find("akamaru") or sName == getPlayerName(cid):lower() then
                doCreatureSetLookDirection(summon, dir)
                executeGatsuuga(summon)
            end
        end
    end

    return true
end