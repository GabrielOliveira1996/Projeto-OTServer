function onUse(cid, item, itemEx)
local percent = 5 -- Porcentagem de cura
local type = "mana" -- Tipo de cura (mana)
local exha = 1.0 -- Tempo de exhaustion em segundos
local itemid = 2125 -- id do item que tem que ser usado

if exhaustion.check(cid, 7323) then
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED) return true
elseif itemEx.uid == cid then
doPlayerSendCancel(cid, "Você não pode usar rapido demais.") return true
end

if getPlayerSlotItem(cid, 2).itemid == itemid and type == "mana" then
doPlayerAddMana(cid, getPlayerMaxMana(cid)*(percent/100))
doSendMagicEffect(getPlayerPosition(cid), 12)
end
exhaustion.set(cid, 7323, exha)
return true
end