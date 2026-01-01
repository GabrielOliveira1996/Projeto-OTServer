function onStepIn(cid, item, pos, fromPosition)

local storage = 11123


if getPlayerStorageValue(cid, storage) < 1 then return true end
    
    for _, summon in pairs(getCreatureSummons(cid)) do
        if getCreatureName(summon):lower() == "tazuna" then
            doRemoveCreature(summon)
            break
        end
    end
    return true
end
