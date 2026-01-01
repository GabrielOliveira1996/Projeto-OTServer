local itens = {
["11110"] = {exp = 1000},
["11111"] = {exp = 1000},
["11112"] = {exp = 2000}

}
function onThink(cid)
if not itens[getPlayerStorageValue(cid)] then
return true
end

local gain = itens[getPlayerStorageValue(cid)].exp
getPlayerExperience(cid, getPlayerStorageValue(cid, getPlayerExperience)+gain) 
return true
end