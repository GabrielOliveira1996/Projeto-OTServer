local duration = 5
local effect = 14
local storage_cooldown = 23007
local cooldown_time = 10 

local slow = createConditionObject(CONDITION_PARALYZE)
setConditionParam(slow, CONDITION_PARAM_TICKS, 2000)
setConditionParam(slow, CONDITION_PARAM_SPEED, -400)
setConditionFormula(slow, -0.7, 0, -0.7, 0)

local function applyBarrierEffect(pos, casterId)
    if not isCreature(casterId) then return end
    
    doSendMagicEffect(pos, effect)
    
    local ml = getPlayerMagLevel(casterId)
    local manaDrain = (ml * 3) + 50 
    
    local spectators = getSpectators(pos, 0, 0, false)
    
    if spectators and #spectators > 0 then
        for _, victim in ipairs(spectators) do
            if isCreature(victim) then
                local victimPos = getThingPos(victim)
                if victimPos.x == pos.x and victimPos.y == pos.y and victimPos.z == pos.z then
                    if victim ~= casterId and getCreatureMaster(victim) ~= casterId then
                        doTargetCombatMana(0, victim, -manaDrain, -manaDrain, 2)
                        doAddCondition(victim, slow)
                        doTargetCombatHealth(0, victim, COMBAT_EARTHDAMAGE, -50, -100, 0)
                    end
                end
            end
        end
    end
end

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, storage_cooldown) > os.time() then
        local remaining = getPlayerStorageValue(cid, storage_cooldown) - os.time()
        doPlayerSendCancel(cid, "You must wait " .. remaining .. " seconds to use Mushi Kabe again.")
        return false
    end

    local pPos = getThingPos(cid)
    local lookDir = getCreatureLookDirection(cid)
    local barrierTiles = {}

    if lookDir == NORTH or lookDir == SOUTH then
        for x = -2, 2 do
            for y = 1, 2 do
                local offset = (lookDir == NORTH) and -y or y
                table.insert(barrierTiles, {x = pPos.x + x, y = pPos.y + offset, z = pPos.z})
            end
        end
    else
        for y = -2, 2 do
            for x = 1, 2 do
                local offset = (lookDir == WEST) and -x or x
                table.insert(barrierTiles, {x = pPos.x + offset, y = pPos.y + y, z = pPos.z})
            end
        end
    end

    setPlayerStorageValue(cid, storage_cooldown, os.time() + cooldown_time)

    for i = 0, duration - 1 do
        addEvent(function()
            if isCreature(cid) then
                for _, pos in ipairs(barrierTiles) do
                    applyBarrierEffect(pos, cid)
                end
            end
        end, i * 1000)
    end

    doCreatureSay(cid, "Hijutsu: Mushi Kabe!", TALKTYPE_MONSTER)
    return true
end