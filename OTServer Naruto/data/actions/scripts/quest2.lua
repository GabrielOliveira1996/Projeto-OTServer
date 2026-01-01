function onUse(cid, item, frompos, item2, topos)
if item.uid == 1601 then
queststatus = getPlayerStorageValue(cid,1601)
if queststatus == -1 or queststatus == 0 then
doPlayerSendTextMessage(cid,22,"Você obteu este item.") -- a mensagen que ira aparecer quando vc pegar o item
item_uid = doPlayerAddItem(cid,2396,1) -- item_uid = doPlayerAddItem(cid,2500~id do item~,1~Quantidade~)
setPlayerStorageValue(cid,1601,1)
else
doPlayerSendTextMessage(cid,22,"Vazio.") -- ira aprecer quando vc ja tiver pego e tentar dnv
end
else
return 0
end
return 1
end