function onStepIn(cid, item, position, fromPosition)

local tileConfig = {
kickPos = fromPosition,
kickEffect = CONST_ME_POFF,
kickMsg = "You need to be a vip to access this area.",
enterMsg = "Welcome to vip area. Enjoy!",
enterEffect = CONST_ME_MAGIC_BLUE,
vipStorage = 13540,
}

if(getPlayerStorageValue(cid, tileConfig.vipStorage) <= 0) then
doTeleportThing(cid, tileConfig.kickPos)
doSendMagicEffect(tileConfig.kickPos, tileConfig.kickEffect)
doPlayerSendCancel(cid, tileConfig.kickMsg)
return
end

doPlayerSendTextMessage(cid, 25, tileConfig.enterMsg)
doSendMagicEffect(position, tileConfig.enterEffect)
return true
end