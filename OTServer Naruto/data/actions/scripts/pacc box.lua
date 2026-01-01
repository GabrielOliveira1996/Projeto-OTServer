function onUse(cid, item, frompos, item2, topos)
configs = {
premydays = 15 
}
doPlayerAddPremiumDays(cid, configs.premydays)
doPlayerSendTextMessage(cid, 25, "Você acabou de receber "..configs.premydays.." dias de premium account.")
doRemoveItem(item.uid, 1)
end