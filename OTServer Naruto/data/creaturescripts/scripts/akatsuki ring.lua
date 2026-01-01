function onDeath(cid, corpse, deathList)
local itemTransf = { -- id do item que tem que ter, id do item que vai transformar
        [2173] = 2124
}
           if isPlayer(cid) and itemTransf[getPlayerSlotItem(cid, 9).itemid] then
        doTransformItem(getPlayerSlotItem(cid, 9).uid, itemTransf[getPlayerSlotItem(cid, 9).itemid])
end
           return true
        end