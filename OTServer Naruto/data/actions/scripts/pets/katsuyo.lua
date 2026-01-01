function onUse(cid, item, itemEx)
local percent = 5 -- Porcentagem de cura
local type = "health" -- Tipo de cura (health)
local exha = 1.0 -- Tempo de exhaustion em segundos
local itemid = 2142 -- id do item que tem que ser usado

if exhaustion.check(cid, 7324) then
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED) return true
elseif itemEx.uid == cid then
doPlayerSendCancel(cid, "Você não pode usar rápido demais.") return true
end
if type == "health" and getPlayerSlotItem(cid, 2).itemid == itemid then
doCreatureAddHealth(cid, getCreatureMaxHealth(cid)*(percent/100))
doSendMagicEffect(getPlayerPosition(cid), 12)
end
exhaustion.set(cid, 7324, exha)
return true
end