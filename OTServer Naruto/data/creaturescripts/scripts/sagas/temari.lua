function onDeath(cid, corpse, deathList)
local Storage,monstName,players = 11140, "Temari", {}
if isMonster(cid) and string.lower(getCreatureName(cid)) == string.lower(monstName) then
doCreatureSay(cid, "Você venceu a temari.", TALKTYPE_ORANGE_1)
for _, check in pairs(deathList) do
if isPlayer(check) then
table.insert(players, check)
end
end
for _, var in pairs(players) do
setPlayerStorageValue(var, Storage, 1)
doPlayerAddExp(var, 400000)
end
end 
return true
end