function onDeath(cid, corpse, deathList)
local pos, monstName = {x = 3139, y = 2978, z = 7}, "Kiba"
local storage = 11134
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