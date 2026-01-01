-- Script by LuckOake
function onSay(cid, words)
local waittime = 2 -- Tempo de exhaustion
local storage = 6823
local tempo = 1000000000000000 -- Tempo em segundos até a vocation sumir
local vocation = 73 -- Vocation ID
local mana = 200 -- Mana necessária
local outfit = {lookType = 167, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookTypeEx = 0, lookAddons = 0} -- Outfit
local useable_vocs = {"Rock Lee Shippuden", "Open Gate Four"} -- Vocations que podem usar a talk
local level = 150
local levelMax = 300

if not isInArray(useable_vocs, getPlayerVocationName(cid)) then
doPlayerSendCancel(cid, "Não pode abrir esse portao.") return true
elseif exhaustion.check(cid, storage) then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Aguarde " .. exhaustion.get(cid, storage) .. " segundos para usar o portao novamente.") return true
elseif getPlayerMana(cid) < mana then
doPlayerSendCancel(cid, "Voce nao tem energia suficiente.") return true
elseif getPlayerLevel(cid) < level then
doPlayerSendCancel(cid, "Voce prescisa estar level "..level..".") return true
elseif getPlayerLevel(cid) >= levelMax then
doPlayerSendCancel(cid, "O level maximo para usar esse portao é ("..levelMax..").") return true
end

exhaustion.set(cid, storage, waittime)
doPlayerAddMana(cid, -mana)
setPlayerStorageValue(cid, 8163, getPlayerVocation(cid))
doSetCreatureOutfit(cid, outfit, -1)
doPlayerSetVocation(cid, vocation)
addEvent(doPlayerSetVocation, tempo*1000, cid, getPlayerStorageValue(cid, 8163))
addEvent(doRemoveCondition, tempo*1000, cid, CONDITION_OUTFIT)
return true
end