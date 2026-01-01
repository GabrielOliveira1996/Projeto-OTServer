function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 9206 then
   		queststatus = getPlayerStorageValue(cid,9200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Slayer Armor.")
   			doPlayerAddItem(cid,2503,1)
   			setPlayerStorageValue(cid,9200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
elseif item.uid == 9207 then
   		queststatus = getPlayerStorageValue(cid,9200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Solar Axe.")
   			doPlayerAddItem(cid,8925,1)
   			setPlayerStorageValue(cid,9200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   	
elseif item.uid == 9208 then
   		queststatus = getPlayerStorageValue(cid,9200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Firewalker Boots.")
   			doPlayerAddItem(cid,9933,1)
   			setPlayerStorageValue(cid,9200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
elseif item.uid == 9209 then
   		queststatus = getPlayerStorageValue(cid,9200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a elethriel's elemental bow and slayer arrow.")
   			doPlayerAddItem(cid,8858,1)
   			doPlayerAddItem(cid,2352,1)
   			setPlayerStorageValue(cid,9200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
elseif item.uid == 9210 then
   		queststatus = getPlayerStorageValue(cid,9200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a slayer mage armor.")
   			doPlayerAddItem(cid,2505,1)
   			setPlayerStorageValue(cid,9200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
elseif item.uid == 9211 then
   		queststatus = getPlayerStorageValue(cid,9200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a staff of sceptre.")
   			doPlayerAddItem(cid,7410,1)
   			setPlayerStorageValue(cid,9200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
elseif item.uid == 9212 then
   		queststatus = getPlayerStorageValue(cid,9200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a sword of calamity.")
   			doPlayerAddItem(cid,8932,1)
   			setPlayerStorageValue(cid,9200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   

elseif item.uid == 9213 then
   		queststatus = getPlayerStorageValue(cid,9200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a skullcrusher.")
   			doPlayerAddItem(cid,7423,1)
   			setPlayerStorageValue(cid,9200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
elseif item.uid == 9214 then
   		queststatus = getPlayerStorageValue(cid,9200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Blessed Shield.")
   			doPlayerAddItem(cid,2523,1)
   			setPlayerStorageValue(cid,9200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
else
		return 0
   	end

   	return 1
end
