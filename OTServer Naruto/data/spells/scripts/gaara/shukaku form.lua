function onCastSpell(cid, var)

local outfit1 = 70
local level1 = 40
local outfit2 = 71
local level2 = 80
local outfit3 = 71
local level3 = 120

if getPlayerLevel(cid) >= level1 and getPlayerLevel(cid) <= 149 then
doSetCreatureOutfit(cid, {lookType = outfit1}, -1)
doPlayerSetVocation(cid, 74)
doSendMagicEffect(getCreaturePosition(cid), 95)
end

if getPlayerLevel(cid) >= level2 and getPlayerLevel(cid) <= 149 then
doSetCreatureOutfit(cid, {lookType = outfit2}, -1)
doPlayerSetVocation(cid, 75)
doSendMagicEffect(getCreaturePosition(cid), 95)
end

if getPlayerLevel(cid) >= level3 and getPlayerLevel(cid) <= 149 then
doSetCreatureOutfit(cid, {lookType = outfit3}, -1)
doPlayerSetVocation(cid, 83)
doSendMagicEffect(getCreaturePosition(cid), 95)
return true
end
end