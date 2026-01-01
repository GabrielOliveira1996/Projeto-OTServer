-- annihilator chests

function onUse(cid, item, frompos, item2, topos)

   	if item.uid == 8206 then
   		queststatus = getPlayerStorageValue(cid,8200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a DevilEye.")
   			doPlayerAddItem(cid,8852,1)
   			setPlayerStorageValue(cid,8200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end
elseif item.uid == 8207 then
   		queststatus = getPlayerStorageValue(cid,8200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Warsinger Bow.")
   			doPlayerAddItem(cid,8854,1)
   			setPlayerStorageValue(cid,8200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   	
elseif item.uid == 8208 then
   		queststatus = getPlayerStorageValue(cid,8200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Spellbook of Dark Mysteries.")
   			doPlayerAddItem(cid,8918,1)
   			setPlayerStorageValue(cid,8200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
elseif item.uid == 8209 then
   		queststatus = getPlayerStorageValue(cid,8200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Emerald Sword.")
   			doPlayerAddItem(cid,8930,1)
   			setPlayerStorageValue(cid,8200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
elseif item.uid == 8210 then
   		queststatus = getPlayerStorageValue(cid,8200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Hellforged Axe.")
   			doPlayerAddItem(cid,8924,1)
   			setPlayerStorageValue(cid,8200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
elseif item.uid == 8211 then
   		queststatus = getPlayerStorageValue(cid,8200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Obsidian Truncheon.")
   			doPlayerAddItem(cid,8928,1)
   			setPlayerStorageValue(cid,8200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
elseif item.uid == 8212 then
   		queststatus = getPlayerStorageValue(cid,8200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Master Archer's Armor.")
   			doPlayerAddItem(cid,8888,1)
   			setPlayerStorageValue(cid,8200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   

elseif item.uid == 8213 then
   		queststatus = getPlayerStorageValue(cid,8200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Fireborn Giant Armor.")
   			doPlayerAddItem(cid,8881,1)
   			setPlayerStorageValue(cid,8200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
elseif item.uid == 8214 then
   		queststatus = getPlayerStorageValue(cid,8200)
   		if queststatus == -1 then
   			doPlayerSendTextMessage(cid,22,"You have found a Robe of the Underworld.")
   			doPlayerAddItem(cid,8890,1)
   			setPlayerStorageValue(cid,8200,1)
   		else
   			doPlayerSendTextMessage(cid,22,"It is empty.")
   		end   
else
		return 0
   	end

   	return 1
end
