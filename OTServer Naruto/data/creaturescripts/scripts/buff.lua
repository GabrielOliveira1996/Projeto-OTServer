efeitos = {
[8] = 70, -- ID da vocation, depois ID do efeito!
[98] = 71,
[99] = 71,
[12] = 72,
[67] = 73,
[20] = 74,
[4] = 75,
[71] = 106,
[72] = 106,
[73] = 106,
[82] = 106,
[61] = 76,
[62] = 76,
[63] = 76,

[65] = 73, --- kyuubi 2
[66] = 73, --- kyuubi 3
[67] = 73, --- kyuubi shippuden 3

[80] = 75, --- sai 100
[93] = 75, --- sai level 200
[94] = 75, --- sai level 300

[95] = 90,  --- neji cumulated level 100
[101] = 90,  --- neji cumulated level 100

}
function doEffect(cid)
local delay = 1
if isCreature(cid) == TRUE then
doSendMagicEffect(getCreaturePosition(cid), efeitos[getPlayerVocation(cid)])
addEvent(doEffect, delay*100000000000000000, cid)
end
return TRUE
end
function onThink(cid)
for voc, efec in pairs(efeitos) do
if voc == getPlayerVocation(cid) then
doEffect(cid)
break
end
end
return TRUE
end