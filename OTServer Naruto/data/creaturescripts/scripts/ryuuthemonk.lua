function onDeath(cid, corpse, deathList)
local monstName,players,storage = "Ashar", {}, 92001
 
if isMonster(cid) and string.lower(getCreatureName(cid)) == string.lower(monstName) then
for _, check in pairs(deathList) do
if isPlayer(check) and getCreatureStorage(check, storage) == 1 then
doCreatureSay(check, "Você matou Ashar o líder da ceita.", TALKTYPE_ORANGE_1)
setPlayerStorageValue(check, 92002, 1)
setPlayerStorageValue(check, 92001, -1)
end
end 
end
return true
end 