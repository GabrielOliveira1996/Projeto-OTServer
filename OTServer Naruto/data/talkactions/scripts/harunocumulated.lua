
-- Script by LuckOake
function onSay(cid, words)
local waittime = 2 -- Tempo de exhaustion
local storage = 6818
local tempo = 1000000000000000 -- Tempo em segundos até a vocation sumir
local vocation = 69 -- Vocation ID
local mana = 200 -- Mana necessária
local outfit = {lookType = 2, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookTypeEx = 0, lookAddons = 0} -- Outfit
local useable_vocs = {"Sakura Train", "Sakura", "Haruno Power"} -- Vocations que podem usar a talk
local level = 100
local levelMax = 150

if not isInArray(useable_vocs, getPlayerVocationName(cid)) then
doPlayerSendCancel(cid, "Não pode usar esse chakra.") return true
elseif exhaustion.check(cid, storage) then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Aguarde " .. exhaustion.get(cid, storage) .. " segundos para usar o byakugan novamente.") return true
elseif getPlayerMana(cid) < mana then
doPlayerSendCancel(cid, "Voce nao tem chakra suficiente.") return true
elseif getPlayerLevel(cid) < level then
doPlayerSendCancel(cid, "Voce prescisa estar level "..level..".") return true
elseif getPlayerLevel(cid) >= levelMax then
doPlayerSendCancel(cid, "O level maximo para usar esse chakra é ("..levelMax..").") return true
end

exhaustion.set(cid, storage, waittime)
doPlayerAddMana(cid, -mana)
setPlayerStorageValue(cid, 8158, getPlayerVocation(cid))
doSetCreatureOutfit(cid, outfit, -1)
doPlayerSetVocation(cid, vocation)
addEvent(doPlayerSetVocation, tempo*1000, cid, getPlayerStorageValue(cid, 8158))
addEvent(doRemoveCondition, tempo*1000, cid, CONDITION_OUTFIT)
return true
end