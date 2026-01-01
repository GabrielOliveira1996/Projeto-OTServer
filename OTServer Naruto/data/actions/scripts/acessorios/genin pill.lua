function onUse(cid, item, itemEx)
local type = "ambos" -- Tipo de cura (health / mana / ambos)
local exha = 0.5 -- Tempo de exhaustion em segundos
local hp = 100
local chakra = 100

if exhaustion.check(cid, 7320) then
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED) return true
elseif itemEx.uid == cid then
doPlayerSendCancel(cid, "Você não pode usar rápido demais.") return true
end
if type == "health" then
doCreatureAddHealth(cid, hp)
elseif type == "mana" then
doPlayerAddMana(cid, chakra)
elseif type == "ambos" then
doCreatureAddHealth(cid, hp)
doPlayerAddMana(cid, chakra)
doSendMagicEffect(getPlayerPosition(cid), 69)
end
exhaustion.set(cid, 7320, exha)
doRemoveItem(item.uid, 1)
return true
end