function onLook(cid, thing, position, lookDistance)
local nome = "Kage Bunshin no Jutsu"
if isMonster(thing.uid) and getCreatureMaster(thing.uid) and getCreatureName(thing.uid) == nome then
local string = " "..getCreatureName(getCreatureMaster(thing.uid)).." Level-"..getPlayerLevel(getCreatureMaster(thing.uid)).." Vocation - "..getPlayerVocationName(getCreatureMaster(thing.uid))..""
doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, string)
return false
end
return true
end