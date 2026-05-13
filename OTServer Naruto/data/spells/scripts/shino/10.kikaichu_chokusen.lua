local storage_cooldown = 23010
local cooldown_time = 4 
local range = 7 

local slow = createConditionObject(CONDITION_PARALYZE)
setConditionParam(slow, CONDITION_PARAM_TICKS, 3000)
setConditionFormula(slow, -0.8, 0, -0.8, 0)

function onCastSpell(cid, var)
    if getPlayerStorageValue(cid, storage_cooldown) > os.time() then
        local remaining = getPlayerStorageValue(cid, storage_cooldown) - os.time()
        doPlayerSendCancel(cid, "Wait " .. remaining .. " seconds.")
        return false
    end

    local ml = getPlayerMagLevel(cid)
    local pPos = getThingPos(cid)
    local pDir = getCreatureLookDirection(cid)

    for i = 1, range do
        addEvent(function()
            if not isCreature(cid) then return end
            
            local targetPos = {x = pPos.x, y = pPos.y, z = pPos.z}
            if pDir == 0 then targetPos.y = targetPos.y - i
            elseif pDir == 1 then targetPos.x = targetPos.x + i
            elseif pDir == 2 then targetPos.y = targetPos.y + i
            elseif pDir == 3 then targetPos.x = targetPos.x - i
            end

            doSendMagicEffect(targetPos, 14)

            local target = getTopCreature(targetPos).uid
            if isCreature(target) and target ~= cid then
                if getCreatureMaster(target) ~= cid then
                    
                    local min = (ml * 8.5) + 400
                    local max = (ml * 13.0) + 700
                    
                    doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -min, -max, 0)
                    doTargetCombatMana(cid, target, -300, -500, 12)
                    
                    doAddCondition(target, slow)
                end
            end
        end, 60 * i) 
    end

    setPlayerStorageValue(cid, storage_cooldown, os.time() + cooldown_time)
    return true
end