-- annihilator chests

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 9911 then
   		queststatus = getPlayerStorageValue(cid,9910)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Staff of Starlight.")
   			doPlayerAddItem(cid,7735,1)
   			setPlayerStorageValue(cid,9910,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
elseif item.uid == 9912 then
   		queststatus = getPlayerStorageValue(cid,9910)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Sling Shot.")
   			doPlayerAddItem(cid,5907,1)
   			setPlayerStorageValue(cid,8200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   	
elseif item.uid == 9913 then
   		queststatus = getPlayerStorageValue(cid,9910)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Brutal Cutter.")
   			doPlayerAddItem(cid,7454,1)
   			setPlayerStorageValue(cid,9910,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
elseif item.uid == 9914 then
   		queststatus = getPlayerStorageValue(cid,9910)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Celestial Blade.")
   			doPlayerAddItem(cid,7417,1)
   			setPlayerStorageValue(cid,9910,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
elseif item.uid == 9915 then
   		queststatus = getPlayerStorageValue(cid,9910)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a ThunderRock Hammer.")
   			doPlayerAddItem(cid,7450,1)
   			setPlayerStorageValue(cid,9910,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
else
		return 0
   	end

   	return 1
end
