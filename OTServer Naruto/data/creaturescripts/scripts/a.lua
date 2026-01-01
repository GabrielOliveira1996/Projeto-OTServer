function onLogout(cid)

if getPlayerStorageValue(cid, 60000) > 0 then
setCreatureMaxHealth(cid, getCreatureMaxHealth(cid)-100)
setPlayerStorageValue(cid, 60000, -1)
end

if getPlayerStorageValue(cid, 60000) > 0 then
setCreatureMaxHealth(cid, getCreatureMaxHealth(cid)-200)
setPlayerStorageValue(cid, 60000, -1)
end

if getPlayerStorageValue(cid, 60000) > 0 then
setCreatureMaxHealth(cid, getCreatureMaxHealth(cid)-300)
setPlayerStorageValue(cid, 60000, -1)
return true
end
end
