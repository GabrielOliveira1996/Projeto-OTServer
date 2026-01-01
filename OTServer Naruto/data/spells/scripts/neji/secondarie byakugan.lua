function onCastSpell(cid, var)

if getPlayerLevel(cid) >= 50 then
doPlayerSetVocation(cid, 68)
doSendMagicEffect(getCreaturePosition(cid), 92)
end

if getPlayerLevel(cid) >= 100 then
doPlayerSetVocation(cid, 83)
doSendMagicEffect(getCreaturePosition(cid), 92)
end

if getPlayerLevel(cid) >= 150 then
doPlayerSetVocation(cid, 84)
doSendMagicEffect(getCreaturePosition(cid), 92)
end

if getPlayerLevel(cid) >= 200 then
doPlayerSetVocation(cid, 85)
doSendMagicEffect(getCreaturePosition(cid), 92)
end

if getPlayerLevel(cid) >= 300 then
doPlayerSetVocation(cid, 86)
doSendMagicEffect(getCreaturePosition(cid), 92)
return true
end
end