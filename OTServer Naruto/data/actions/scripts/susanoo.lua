function onUse(cid, item)

if getPlayerStorageValue(cid, 301) >= 1 then
    local status = getCreatureStorage(cid, 1115)
    if status > os.time() then
    return true
end