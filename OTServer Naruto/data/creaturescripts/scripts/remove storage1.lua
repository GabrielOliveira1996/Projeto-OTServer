local monsters = { 
    ["kiba"] = {stor = 11125, lose = 2}
}

function onDeath(monster, corpse, deathList)
local m = monsters[getCreatureName(monster):lower()]
if not m then return true end
for _, cid in pairs (deathList) do
    if isCreature(cid) and isPlayer(cid) then
            setPlayerStorageValue(cid, m.stor, getPlayerStorageValue(cid, m.stor) - m.lose)
    end
end
return true
end