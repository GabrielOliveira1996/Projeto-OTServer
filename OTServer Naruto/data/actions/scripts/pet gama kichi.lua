function onUse(cid, item, frompos, item2, topos)

storage = 4191
storsol = 1203
if #getCreatureSummons(cid) > 1 then
        doPlayerSendCancel(cid,"Gama Kichi foi envocado.")
end

if getPlayerStorageValue(cid,storsol) == 1 then
local z = getCreatureSummons(cid)[1]
addEvent(setPlayerStorageValue,100,cid,storsol,-1)
doPlayerSay(cid,"Volte Gamakichi!",TALKTYPE_ORANGE_1)
doSendMagicEffect(getCreaturePosition(z), 2)
doSendDistanceShoot(getCreaturePosition(z), getPlayerPosition(cid), 3)
doRemoveCreature(z)
end

local summons = getCreatureSummons(cid)

local pet = {
["Gamakichi"] = {1,10000}
}

for k,v in pairs(pet) do -- 1

if getPlayerStorageValue(cid,storsol) < 1 then
if getPlayerLevel(cid) >= v[1] and getPlayerLevel(cid) < v[2] then -- 2
if (table.maxn(summons) < 1)then -- 3
x = doSummonCreature(k, getCreaturePosition(cid))
doConvinceCreature(cid, x)
setPlayerStorageValue(cid,4194,1)
setPlayerStorageValue(cid,storsol,1)
doCreatureSay(cid, k ..", Vamos lá!", TALKTYPE_ORANGE_1)
doSendMagicEffect(getThingPos(getCreatureSummons(cid)[1]), 2)
end
end
end
end
return true
end