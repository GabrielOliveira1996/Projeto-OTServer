local c= {
max = 5,
effect = 8
}

local function addEffect(cid, count)
if not(isPlayer(cid)) then return false end

local tmpPos = getPlayerPosition(cid)
doSendMagicEffect({x=tmpPos.x+1, y=tmpPos.y, z=tmpPos.z}, c.effect)

if count <= c.max then
addEvent(addEffect, 8, cid, count+1)
end
end

function onSay(cid, words, param)
if getPlayerVocation(cid) == 2 then
if getPlayerLevel(cid) >= 100 then
if getPlayerMana(cid) >= 2000 then
if getCreatureHealth(cid) >= 2000 then
doPlayerAddMana(cid, getPlayerMana(cid)/100*-90) else
end
doCreatureAddHealth(cid, getCreatureHealth(cid)/100*-90) else
end
addEvent(addEffect, 8, cid, 0)
doPlayerSendCancel(cid, "Susanoo Activated!")
end
return true
end
end