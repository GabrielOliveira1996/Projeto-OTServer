local BYA_STORAGE = 45001
local cooldownStorage = 23001
local cooldownTime = 2

local IMMUNE_MONSTERS = {"Trainer"}

local function doPushStep(target, source)
    if not isCreature(target) or not isCreature(source) then return false end
    
    if isMonster(target) then
        local targetName = getCreatureName(target):lower()
        if isInArray(IMMUNE_MONSTERS, targetName) then
            return false
        end
    end
    
    local tPos = getThingPos(target)
    local sPos = getThingPos(source)
    
    local dir = getDirectionTo(sPos, tPos)
    local pushPos = getPosByDir(tPos, dir)
    
    if pushPos.x == 0 or pushPos.y == 0 then return false end

    if doTileQueryAdd(target, pushPos) == RETURNVALUE_NOERROR then
        doTeleportThing(target, pushPos, true)
        doSendMagicEffect(tPos, 1) 
        return true
    end
    
    return false
end

function onCastSpell(cid, var)
    if os.time() < getPlayerStorageValue(cid, cooldownStorage) then
        doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED)
        return false
    end

    local target = getCreatureTarget(cid)
    
    if not target or not isCreature(target) then
        doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
        return false
    end

    local skill = getPlayerSkillLevel(cid, 6)
    local level = getPlayerLevel(cid)
    local isByakugan = getPlayerStorageValue(cid, BYA_STORAGE) > 0

    local min = (skill * 1.5) + (level * 1.0)
    local max = (skill * 2.0) + (level * 1.5)
    
    if isByakugan then
        min, max = min * 2.5, max * 2.0
    end

    doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -min, -max, 112)
    
    local canPushMore = doPushStep(target, cid)

    if canPushMore then
        addEvent(function()
            if isCreature(target) and isCreature(cid) then
                doPushStep(target, cid)
            end
        end, 150)
    end

    doSendMagicEffect(getThingPos(cid), 92)
    
    if isByakugan then
        doSendAnimatedText(getThingPos(target), "TENKETSU!", 180)
    end

    setPlayerStorageValue(cid, cooldownStorage, os.time() + cooldownTime)

    return true
end