local storagecheck = 31313
local storagelose = 11109

function onLogin(cid)
if getPlayerStorageValue(cid, storagecheck) >= 1 then
setPlayerStorageValue(cid, storagelose, -10)
return true
end
end

