local dur = 2
local itemid = 2125

local function heal(cid, mana)

if getPlayerSlotItem(cid, 2).itemid >= 1 then
doCreatureAddMana(cid, 500)
end
addEvent(heal, dur * 1000, cid, true)
return true
end

function onLogin(cid)

if getPlayerSlotItem(cid, 2).itemid <= 1 then
doPlayerSendCancel(cid,"Você não possui um pet.")
return false
end

if getPlayerSlotItem(cid, 2).itemid >= 1 then
heal(cid, doCreatureAddMana(cid, 500))
return true
end
end