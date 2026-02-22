function onDeath(cid, corpse, deathList)
local Storage,monstName,players = 11129, "Kin", {}
if isMonster(cid) and string.lower(getCreatureName(cid)) == string.lower(monstName) then
doCreatureSay(cid, "Você venceu o kin.", TALKTYPE_ORANGE_1)
for _, check in pairs(deathList) do
if isPlayer(check) then
table.insert(players, check)
end
end
for _, var in pairs(players) do
setPlayerStorageValue(var, Storage, 1)
doPlayerAddExp(var, 112500)
end
end 
return true
end