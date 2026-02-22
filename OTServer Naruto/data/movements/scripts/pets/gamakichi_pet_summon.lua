local monsterName = "Gamakichi"
local effect = 2

-- funcao para invocar ao colocar o item
function onEquip(cid, item, slot, pos, x)
    local max = 1
    local summons = getCreatureSummons(cid)
    
    local currentKatsuyoCount = 0
    if summons and #summons > 0 then
        for i = 1, #summons do
            if getCreatureName(summons[i]):lower() == monsterName:lower() then
                currentKatsuyoCount = currentKatsuyoCount + 1
            end
        end
    end

    if currentKatsuyoCount < max then
        local playerPos = getThingPos(cid)
        local katsuyo = doSummonCreature(monsterName, playerPos)
        
        if isCreature(katsuyo) then
            doConvinceCreature(cid, katsuyo)
            doSendMagicEffect(getThingPos(katsuyo), effect)
        end
    end
    return true
end

-- funcao para remover ao tirar o item
function onDeEquip(cid, item, slot, pos, x)
    local summons = getCreatureSummons(cid)
    
    if summons and #summons > 0 then
        for i = 1, #summons do
            local summon = summons[i]
            if getCreatureName(summon):lower() == monsterName:lower() then
                local katsuyoPos = getThingPos(summon)
                doRemoveCreature(summon)
                doSendMagicEffect(katsuyoPos, effect) 
            end
        end
    end
    return true
end