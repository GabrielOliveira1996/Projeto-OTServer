function onDeath(cid, corpse, deathList)
local Storage,monstName,players = 11134, "Kiba", {}
if isMonster(cid) and string.lower(getCreatureName(cid)) == string.lower(monstName) then
doCreatureSay(cid, "Você venceu o kiba.", TALKTYPE_ORANGE_1)
for _, check in pairs(deathList) do
if isPlayer(check) then
table.insert(players, check)
end
end
for _, var in pairs(players) do
setPlayerStorageValue(var, Storage, 1)
doPlayerAddExp(var, 195000)
end
end 
return true
end