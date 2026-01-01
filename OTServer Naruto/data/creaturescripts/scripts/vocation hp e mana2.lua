local itens = {
["Shikamaru Master of shadowns"] = {vida = 2000, mana = 3000},
["Gaara Kazekage"] = {vida = 1500, mana = 3500},
["Kiba Stronger"] = {vida = 2500, mana = 2500},
["Sakura Stronger"] = {vida = 2000, mana = 3000},
["Shino Master Of Insects"] = {vida = 2000, mana = 3000},
["Kankurou Master Of Puppets"] = {vida = 2000, mana = 3000},
["Temari Stronger"] = {vida = 3000, mana = 2000},
["Neji Stronger"] = {vida = 2500, mana = 2500},
["Sasuke Akatsuki Member"] = {vida = 2000, mana = 3000},
["Naruto Sannin"] = {vida = 2500, mana = 2500},
["Rock Lee Stonger"] = {vida = 4000, mana = 1000},
["Ino Stronger"] = {vida = 1000, mana = 4000},
["Chouji Stronger"] = {vida = 3000, mana = 2000},
["Hinata Stronger"] = {vida = 2500, mana = 2500},
["Sai Stronger"] = {vida = 2000, mana = 3000},
["Tenten Master Of Weapons"] = {vida = 2000, mana = 3000},
["Minato Yondaime"] = {vida = 2500, mana = 2500}

}
function onLogin(cid)
if not itens[getPlayerVocationName(cid)] then
return true
end
if getPlayerStorageValue(cid, 65499) >= 1 then return true end

local gain = itens[getPlayerVocationName(cid)].vida
local enr = itens[getPlayerVocationName(cid)].mana
setCreatureMaxHealth(cid, getCreatureMaxHealth(cid)+gain)
setCreatureMaxMana(cid, getCreatureMaxMana(cid)+enr)
setPlayerStorageValue(cid, 65499, 1)
return true
end