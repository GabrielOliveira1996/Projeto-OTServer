local itens = {
["Shikamaru Train"] = {vida = 200, mana = 300},
["Kiba Train"] = {vida = 250, mana = 250},
["Sakura Train"] = {vida = 100, mana = 400},
["Shino Train"] = {vida = 200, mana = 300},
["Kankurou Train"] = {vida = 200, mana = 300},
["Temari Train"] = {vida = 300, mana = 200},
["Hinata Train"] = {vida = 250, mana = 250},
["Tenten Train"] = {vida = 200, mana = 400},
["Minato Train"] = {vida = 300, mana = 300}

}
function onLogin(cid)
if not itens[getPlayerVocationName(cid)] then
return true
end
if getPlayerStorageValue(cid, 65497) >= 1 then return true end

local gain = itens[getPlayerVocationName(cid)].vida
local enr = itens[getPlayerVocationName(cid)].mana
setCreatureMaxHealth(cid, getCreatureMaxHealth(cid)+gain)
setCreatureMaxMana(cid, getCreatureMaxMana(cid)+enr)
setPlayerStorageValue(cid, 65497, 1)
return true
end