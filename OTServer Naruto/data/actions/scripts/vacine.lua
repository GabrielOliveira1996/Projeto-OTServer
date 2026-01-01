function doRefilSecond(cid, mana, hp, delay) -- function by vodka
if isCreature(cid) then
doCreatureAddMana(cid, mana)
doCreatureAddHealth(cid, hp)
doSendMagicEffect(getCreaturePosition(cid), 12)
if delay ~= 1 then
addEvent(doRefilSecond, 1000, cid, mana , hp , delay -1)
end
else
return LUA_ERROR
end
return nil
end
if exhaustion.check(cid, 7322) then
doPlayerSendDefaultCancel(cid, RETURNVALUE_YOUAREEXHAUSTED) return true
function onUse(cid, item, fromPosition, itemEx, toPosition)
local config = {
hp = 20, -- qnto de hp irá ganha por segundo
mana = 20, -- qnto de mana irá ganhar por segundo
seconds = 5, -- por qnto segundos ele irá ganhar o hp e mana 
exha = 3
}
exhaustion.set(cid, 7322, exha)
doRefilSecond(cid, config.mana,config.hp, config.seconds)
doPlayerAddSoul(cid, -0)
doRemoveItem(item.uid, 1)
return TRUE
end