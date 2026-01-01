function onSay(cid, words, param)

local questsinfo1 = "Ryuu The Monk. \nRyuu e os seus amigos estão sendo perseguidos pelos seguidores do templo de Ashar, ele precisa que você mate 800 monks para ele."

if getPlayerStorageValue(cid, 76669) >= 2 then
doShowTextDialog(cid, 7528, questsinfo1)
return true
end
end