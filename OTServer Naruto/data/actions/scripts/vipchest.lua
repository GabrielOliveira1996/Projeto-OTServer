--
function onUse(cid, item, frompos, item2, topos)
 
if item.uid ==13541 then
queststatus = getPlayerStorageValue(cid,13540)
if queststatus == 1 then
doPlayerSendTextMessage(cid,22,"Você jah pegou sua recompensa.")
 
else
doPlayerSendTextMessage(cid,22,"Você Ganhou acesso vip permanente e uma Medal of Honor e uma Blue Orb de presente do GOD Brolly.")
doSendMagicEffect(topos,12)
coins_uid = doPlayerAddItem(cid,5785,1)
coins_uid = doPlayerAddItem(cid,7632,1)
setPlayerStorageValue(cid,13540,1)
end
return 0
end
return 1
end
