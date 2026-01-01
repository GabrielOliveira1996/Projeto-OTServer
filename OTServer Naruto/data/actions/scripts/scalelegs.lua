function onUse(cid, item, fromPosition, itemEx, toPosition)

if item.uid == 17757 then
queststatus = getPlayerStorageValue(cid,50091)
if queststatus == -1 then
doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "You have found Dragon Scale Legs.")
doPlayerAddItem(cid,2469,1)
setPlayerStorageValue(cid,50091,1)
else
doPlayerSendTextMessage(cid,MESSAGE_INFO_DESCR, "It is empty.")
end
end
return 1
end
