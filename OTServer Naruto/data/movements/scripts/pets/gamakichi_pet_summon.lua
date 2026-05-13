local monsterName = "Gamakichi"
local effect = 2

function onEquip(cid, item, slot, pos, x)
    if not isPlayer(cid) then return true end

    addEvent(function()
        if not isPlayer(cid) then return end
        
        local summons = getCreatureSummons(cid)
        local hasSummon = false
        
        if summons and #summons > 0 then
            for _, summon in ipairs(summons) do
                if isCreature(summon) and getCreatureName(summon):lower() == monsterName:lower() then
                    hasSummon = true
                    break
                end
            end
        end

        if not hasSummon then
            local pPos = getThingPos(cid)
            if pPos then
                local katsuyo = doSummonCreature(monsterName, pPos)
                if isCreature(katsuyo) then
                    doConvinceCreature(cid, katsuyo)
                    doSendMagicEffect(getThingPos(katsuyo), effect)
                end
            end
        end
    end, 100)
    
    return true
end

function onDeEquip(cid, item, slot, pos, x)
    if not isPlayer(cid) then return true end

    addEvent(function()
        if not isPlayer(cid) then return end
        
        local currentSummons = getCreatureSummons(cid)
        if currentSummons and #currentSummons > 0 then
            for i = 1, #currentSummons do
                local s = currentSummons[i]
                if isCreature(s) and getCreatureName(s):lower() == monsterName:lower() then
                    local sPos = getThingPos(s)
                    if sPos then doSendMagicEffect(sPos, effect) end
                    doRemoveCreature(s)
                end
            end
        end
    end, 150)
    
    return true
end