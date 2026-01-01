local target = 0
local prevTarget = 0
local maxChaseDistance = 1000 --aqui é a distancia que ele vai correr atraz do pk no caso 1000 vai ser 1000 sqm
local origPos = 0
local lastAttack = 0
local followTimeout = 200

local function isSkulled(cid)
if(getPlayerSkullType(cid) >= 3 and isPlayerPzLocked(cid) == TRUE) then
return true
end

return false
end

local function goToOrigPos()
target = 0
lastAttack = 0
selfFollow(0)
doTeleportThing(getNpcCid(), origPos)
end

local function updateTarget()
if(isPlayer(target) == FALSE) then
goToOrigPos()
elseif(not isSkulled(target)) then
selfSay("Vou te Pegar!! Algum Dia...")
goToOrigPos()
end

if(target == 0) then
local list = getSpectators(getNpcPos(), 9, 9, false)
for i = 1, table.getn(list) do
local _target = list[i]
if(_target ~= 0) then
if(isPlayer(_target) == TRUE and isSkulled(_target)) then
if(getTilePzInfo(getCreaturePosition(_target)) == FALSE) then
if(selfFollow(_target)) then
target = _target
if(target ~= prevTarget) then
selfSay("Hahahah Seu Verme, é Hora de Morrer!")
end

prevTarget = target
break
end
end
end
end
end
end
end

function onCreatureAppear(cid)
if(cid == getNpcCid()) then
origPos = getNpcPos()
end
end

function onCreatureDisappear(cid)
if(cid == target) then
goToOrigPos()
end
end

function onCreatureMove(creature, oldPos, newPos)
--
end

function onThink()
updateTarget()

if(target == 0) then
return
end

local playerPos = getCreaturePosition(target)
local myPos = getNpcPos()

if(myPos.z ~= playerPos.z) then
goToOrigPos()
return
end

if(math.abs(myPos.x - origPos.x) > maxChaseDistance or math.abs(myPos.y - origPos.y) > maxChaseDistance) then
selfSay("I'll catch you next time.")
goToOrigPos()
return
end

if(lastAttack == 0) then
lastAttack = os.clock()
end

if(os.clock() - lastAttack > followTimeout) then
selfSay("Voce Esta Esgotando Meu Tempo, Voce Vai Morrer!")
goToOrigPos()
return
end

if((math.abs(playerPos.x - myPos.x) <= 1) and (math.abs(playerPos.y - myPos.y) <= 1)) then
doTargetCombatHealth(getNpcCid(), target, COMBAT_LIFEDRAIN, -200, -400, 9) --aqui e o dano que ele vai acertar no pk
lastAttack = os.clock()
end
end