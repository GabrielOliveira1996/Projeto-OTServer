function onCastSpell(cid, var)

if getPlayerLevel(cid) >= 50 then
doPlayerSetVocation(cid, 87)
doSendMagicEffect(getCreaturePosition(cid), 92)
end

if getPlayerLevel(cid) >= 100 then
doPlayerSetVocation(cid, 88)
doSendMagicEffect(getCreaturePosition(cid), 92)
end

if getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 89)
doSendMagicEffect(getCreaturePosition(cid), 92)
end

if getPlayerLevel(cid) >= 200 then
doPlayerSetVocation(cid, 90)
doSendMagicEffect(getCreaturePosition(cid), 92)
end

if getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 91)
doSendMagicEffect(getCreaturePosition(cid), 92)
return true
end
end