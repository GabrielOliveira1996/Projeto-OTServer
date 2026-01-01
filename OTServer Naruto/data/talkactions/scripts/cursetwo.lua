-- Script by LuckOake
local function endTransform(cid)
if isCreature(cid) and getPlayerStorageValue(cid, 8153) > 0 then
doPlayerSetVocation(cid, getPlayerStorageValue(cid, 8153))
setPlayerStorageValue(cid, 8153, -1)
doRemoveCondition(cid, CONDITION_OUTFIT)
end
end

function onSay(cid, words)
local waittime = 2 -- Tempo de exhaustion
local storage = 6812
local tempo = 1000000000000000 -- Tempo em milesegundos (1seg = 1000) até a vocation sumir
local vocation = 62 -- Vocation ID
local mana = 200 -- Mana necessária
local outfit = {lookType = 318, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookTypeEx = 0, lookAddons = 0} -- Outfit
local useable_vocs = {"Sasuke Train","Sasuke", "Cursed Seal One", "Cursed Seal Two"} -- Vocations que podem usar a talk
local level = 80
local levelMax = 150

if not isInArray(useable_vocs, getPlayerVocationName(cid)) then
doPlayerSendCancel(cid, "Essa vocaçao nao possui o selo.") return true
elseif exhaustion.check(cid, storage) then
doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Aguarde " .. exhaustion.get(cid, storage) .. " segundos para usar esse selo novamente.") return true
elseif getPlayerMana(cid) < mana then
doPlayerSendCancel(cid, "Voce nao tem chakra suficiente.") return true
elseif getPlayerLevel(cid) < level then
doPlayerSendCancel(cid, "Voce prescisa estar level "..level..".") return true
elseif getPlayerLevel(cid) >= levelMax then
doPlayerSendCancel(cid, "O level maximo para usar esse selo é ("..levelMax..").") return true
end

exhaustion.set(cid, storage, waittime)
doPlayerAddMana(cid, -mana)
setPlayerStorageValue(cid, 8153, getPlayerVocation(cid))
doSetCreatureOutfit(cid, outfit, -1)
doPlayerSetVocation(cid, vocation)
addEvent(endTransform, tempo, cid)
return true
end


