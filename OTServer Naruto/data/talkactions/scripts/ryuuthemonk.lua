function onSay(cid, words, param)

local questsinfo1 = "~Ryuu The Monk Mission \nRyuu e os seus amigos estão sendo perseguidos pelos seguidores do templo de Ashar, ele precisa que você mate o lider dessa ceita para que ele e seus amigos fiquem livres dessa perseguição."

if getPlayerStorageValue(cid, 92001) == 1 then
doShowTextDialog(cid, 7100, questsinfo1)
return true
end

local questsinfo2 = "~Ryuu The Monk Mission \nVá até Ryuu e fale com ele."

if getPlayerStorageValue(cid, 92002) == 1 then
doShowTextDialog(cid, 7100, questsinfo2)
return true
end

local questsinfo3 = "~Ryuu The Monk Mission \nMissão finalizada com sucesso."

if getPlayerStorageValue(cid, 92003) == 1 then
doShowTextDialog(cid, 7100, questsinfo3)
return true
end
end