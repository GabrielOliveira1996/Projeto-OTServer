function onTarget(cid, target)
local sto = 11110 -- storage
if isMonster(cid) and isPlayer(target) and getPlayerStorageValue(target, sto) < 1 then
return false
end
return true
end