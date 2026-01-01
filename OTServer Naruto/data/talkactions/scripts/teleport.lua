local configs = {
level = 10, -- level para usar
vocations = {1, 2, 3, 4}, -- vocações que usam
firstdimension = {x=160, y=54, z=7}, -- pos primeira dimenção
seconddimension = {x=148, y=54, z=7}, -- pos segunda dimenção
mana = 320 -- mana usada
}

function onSay(cid, words)

        if getPlayerLevel(cid) < configs.level then
                return doPlayerSendCancel(cid, "To use teleport you need level " .. configs.level..".")
        end

        if not isInArray(configs.vocations, getPlayerVocation(cid)) then
                return doPlayerSendCancel(cid, "His vocation does not allow to use the teleport.")
        end
                
        if getPlayerMana(cid) < configs.mana then
                doSendMagicEffect(getThingPos(cid), 2)
                return doPlayerSendCancel(cid, "You dont have mana.")
        end

        if words == "first dimension" then
                doTeleportThing(cid, configs.firstdimension)
        elseif words == "second dimension" then
                doTeleportThing(cid, configs.seconddimension)
        end
        doCreatureAddMana(cid, -configs.mana)
        doSendMagicEffect(getThingPos(cid), 10)
        return true

end