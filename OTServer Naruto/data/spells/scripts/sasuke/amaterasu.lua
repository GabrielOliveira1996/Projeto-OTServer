function onCastSpell(cid, var)
 
local duration = 20 -- tempo em segundos
local exhaust = 2 -- exhaust da magia
local target = getCreatureTarget(cid)
local storage = 3001

 
if not isCreature(target) then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Escolha um alvo antes.")
        return false
end
 
if exhaustion.check(cid, storage) then
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Aguarde " .. exhaustion.get(cid, storage) .. " segundos para usar a spell novamente.")
        return false
end
 
exhaustion.set(cid, storage, exhaust)
doSendMagicEffect(getCreaturePosition(cid), 31) -- 31 é o sprite do sharingan
addEvent(goToTarget, 100, cid, target, duration-1)
return true
end
 
function goToTarget(cid, target, duration, pos)
 
if not isCreature(target) then
        return false
end
 
local pos = pos or getCreaturePosition(cid)
local target = getCreatureTarget(cid) > 0 and getCreatureTarget(cid) or target
local tpos = getCreaturePosition(target)
 
if pos.x == tpos.x and pos.y == tpos.y then
        nextPos = pos
else
        nextPos = getPosByDir(pos, getDirectionTo(pos, tpos))
end
 
doAreaCombatHealth(cid, storage, 1, nextPos, 0, -100, -200, 42) -- 42 é o efeito do amaterasu
 
if duration > 0 then
        addEvent(goToTarget, 100, cid, target, duration-1, nextPos)
end
 
end