local name, storage = 'neji', 11112

function onCombat(cid, target)
if isPlayer(cid) and getCreatureStorage(cid, storage) < 0 and isMonster(target) and getCreatureName(target):lower() == name then
doChangeSpeed(cid, oldspeed)
return true
end 
end