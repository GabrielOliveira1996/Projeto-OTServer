local config = {
--[vocation id] = { level, nova voc, looktype, efeito, life, chakra}
[40] = { 25, 39, 66, 130, 10000, 10000},
[37] = { 25, 39, 66, 130, 10000, 10000}
}
function onSay(cid, words, param, channel)
doPlayerSay(cid, "transformar")
local voc = config[getPlayerVocation(cid)]
if voc then
if getPlayerLevel(cid) >= voc[1] then
doPlayerSetVocation(cid, voc[2])
doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Você Transformou!")
local outfit = {lookType = voc[3]}
doCreatureChangeOutfit(cid, outfit)
doSendMagicEffect(getCreaturePosition(cid), voc[4])
doCreatureAddHealth(cid, voc[5]) 
doCreatureAddMana(cid, voc[6])
else
doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Você precisa estar no level " .. voc[1] .. " para transformar.")
end
else
doPlayerSendCancel(cid, "Você não pode se Transformar!")
end
return true
end