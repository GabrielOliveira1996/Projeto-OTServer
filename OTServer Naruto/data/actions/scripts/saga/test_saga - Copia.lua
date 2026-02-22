function onUse(cid, item)

local var = 8000

if getPlayerStorageValue(cid, 11124) == 1 then
setPlayerStorageValue(cid, 11124, -1)
setPlayerStorageValue(cid, 11125, 1)
setPlayerStorageValue(cid, 11000, 1)
doPlayerSendTextMessage(cid, 22, "Você passou na prova.")
doPlayerAddExp(cid, var)
else
doPlayerSendTextMessage(cid, 22, "Você não pode fazer essa prova.")
return FALSE
end

return TRUE
end