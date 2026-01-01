local itens = {
["Shikamaru Shippuden"] = {vida = 1000, mana = 2000},
["Gaara Shippuden"] = {vida = 500, mana = 2500},
["Kiba Shippuden"] = {vida = 1500, mana = 1500},
["Sakura Shippuden"] = {vida = 500, mana = 2500},
["Shino Shippuden"] = {vida = 1000, mana = 2000},
["Kankurou Shippuden"] = {vida = 1000, mana = 2000},
["Temari Shippuden"] = {vida = 2000, mana = 1000},
["Neji Shippuden"] = {vida = 1500, mana = 1500},
["Sasuke Shippuden"] = {vida = 1000, mana = 2000},
["Naruto Shippuden"] = {vida = 1500, mana = 1500},
["Rock Lee Shippuden"] = {vida = 2500, mana = 500},
["Ino Shippuden"] = {vida = 500, mana = 2500},
["Chouji Shippuden"] = {vida = 2000, mana = 1000},
["Hinata Shippuden"] = {vida = 1500, mana = 1500},
["Sai Shippuden"] = {vida = 1000, mana = 2000},
["Tenten Shippuden"] = {vida = 1000, mana = 2000},
["Minato Shippuden"] = {vida = 1500, mana = 1500}

}
function onLogin(cid)
if not itens[getPlayerVocationName(cid)] then
return true
end
if getPlayerStorageValue(cid, 65498) >= 1 then return true end

local gain = itens[getPlayerVocationName(cid)].vida
local enr = itens[getPlayerVocationName(cid)].mana
setCreatureMaxHealth(cid, getCreatureMaxHealth(cid)+gain)
setCreatureMaxMana(cid, getCreatureMaxMana(cid)+enr)
setPlayerStorageValue(cid, 65498, 1)
return true
end