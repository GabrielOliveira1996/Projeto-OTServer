if not anbuSpawns then anbuSpawns = {} end

local attackSpeed = 1000 
local maxChaseDistance = 15 
local searchRange = 15

local isReturning = {}
local lastBattleTime = {}
local lastAttack = 0

function onCreatureAppear(cid)
    if cid == getNpcId() then
        if not anbuSpawns[cid] then anbuSpawns[cid] = getNpcPos() end
        isReturning[cid] = false
        lastBattleTime[cid] = 0
    end
end

function onThink()
    local myId = getNpcId()
    local myPos = getNpcPos()
    local spawnPos = anbuSpawns[myId]
    if not spawnPos then return end

    local distFromSpawn = getDistanceBetween(myPos, spawnPos)
    local currentTime = os.clock()

    -- 1. EMERGÊNCIA / ANTI-LURE
    if distFromSpawn > maxChaseDistance + 5 then
        selfFollow(0)
        doTeleportThing(myId, spawnPos)
        isReturning[myId] = false
        return
    end

    -- 2. BUSCA DINÂMICA (Troca de alvo em tempo real)
    local spectators = getSpectators(myPos, searchRange, searchRange, false)
    local bestTarget = 0
    local minDistance = searchRange + 1

    if spectators then
        for i = 1, #spectators do
            local _temp = spectators[i]
            if isMonster(_temp) and getCreatureMaster(_temp) == _temp then
                local tPos = getCreaturePosition(_temp)
                local dToSpawn = getDistanceBetween(tPos, spawnPos)
                local dToMe = getDistanceBetween(myPos, tPos)

                -- Se o monstro está no raio de guarda e é mais perto que o alvo anterior encontrado nesta varredura
                if dToSpawn <= maxChaseDistance and dToMe < minDistance then
                    bestTarget = _temp
                    minDistance = dToMe
                end
            end
        end
    end

    -- Se encontramos um alvo melhor (ou mais perto) que o atual, trocamos!
    local currentTarget = getSpectators(myPos, 0, 0, false) -- Gambiarra para pegar alvo atual se a source não tem getTarget
    -- Aqui forçamos a troca:
    target = bestTarget

    -- 3. LOGICA DE MOVIMENTO E COMBATE
    if target ~= 0 then
        isReturning[myId] = false
        local tPos = getCreaturePosition(target)
        local distToTarget = getDistanceBetween(myPos, tPos)

        if distToTarget > 1 then
            -- Se não conseguir caminhar até o alvo (preso), ele ignora e volta pro spawn
            if not selfMoveTo(tPos.x, tPos.y, tPos.z) and distToTarget > 2 then
                target = 0
                isReturning[myId] = true
            end
        else
            -- Ataque
            local curMilli = os.clock() * 1000
            if (curMilli - lastAttack) >= attackSpeed then
                doTargetCombatHealth(myId, target, COMBAT_PHYSICALDAMAGE, -400, -800, 1)
                doSendMagicEffect(tPos, 1) 
                lastAttack = curMilli
            end
        end
        lastBattleTime[myId] = currentTime
    else
        -- 4. RETORNO FLUIDO
        if distFromSpawn > 1 then
            isReturning[myId] = true
            selfMoveTo(spawnPos.x, spawnPos.y, spawnPos.z)
        else
            isReturning[myId] = false
        end
    end
end