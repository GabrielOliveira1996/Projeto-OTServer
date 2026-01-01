function onDeath(cid, corpse, deathList)
local Storage,monstName,players = 11161, "Kimimaru Cursed", {}
if isMonster(cid) and string.lower(getCreatureName(cid)) == string.lower(monstName) then
doCreatureSay(cid, "Você venceu o kimimaru cursed.", TALKTYPE_ORANGE_1)
for _, check in pairs(deathList) do
if isPlayer(check) then
table.insert(players, check)
end
end
for _, var in pairs(players) do
setPlayerStorageValue(var, Storage, 1)
doPlayerAddExp(var, 3750000)
end
end 
return true
end