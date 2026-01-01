function onUse(cid, item, itemEx)
local percent = 10 -- Porcentagem de cura
local type = "ambos" -- Tipo de cura (health / mana / ambos)
local exha = 0.5 -- Tempo de exhaustion em segundos

if exhaustion.check(cid, 7322) then
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED) return true
elseif itemEx.uid == cid then
doPlayerSendCancel(cid, "Você não pode usar rapido demais.") return true
end
if type == "health" then
doCreatureAddHealth(cid, getCreatureMaxHealth(cid)*(percent/100))
elseif type == "mana" then
doPlayerAddMana(cid, getPlayerMaxMana(cid)*(percent/100))
elseif type == "ambos" then
doCreatureAddHealth(cid, getCreatureMaxHealth(cid)*(percent/100))
doPlayerAddMana(cid, getPlayerMaxMana(cid)*(percent/100))
doSendMagicEffect(getPlayerPosition(cid), 69)
end
exhaustion.set(cid, 7322, exha)
doRemoveItem(item.uid, 1)
return true
end