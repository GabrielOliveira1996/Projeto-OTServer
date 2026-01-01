function onDeath(cid, corpse, deathList)
local pos, monstName = {x = 3085, y = 3054, z = 7}, "Neji"
local storage = 11137
if isMonster(cid) and string.lower(getCreatureName(cid)) == string.lower(monstName) then
        for _, pid in pairs(deathList) do
                if isPlayer(pid) then
                         doTeleportThing(pid, pos)
                                 setPlayerStorageValue(pid, storage, 1)
                                           end
                                        end
                                        return true
                                end
          return true
end