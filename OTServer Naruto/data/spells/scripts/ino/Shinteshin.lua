local tempo = 10 -- Tempo de duração da spell em segundos
local exha = 2 -- Exhaust em segundos

function onCastSpell(cid, var)
    if exhaustion.check(cid, 18561) then
        doSendMagicEffect(getCreaturePos(cid), 2)
        doPlayerSendCancel(cid, "You are exhausted.") return false
    end

    local player = getCreaturePosition(cid)
    local target = getCreatureTarget(cid)
    local enemypos = getCreaturePosition(target)

    if isCreature(target) then
        doSendMagicEffect(enemypos, 2)
        exhaustion.set(cid, 18561, exha)
        setPlayerStorageValue(cid, 13978, 1)
        doPlayerSetNoMove(cid, true)
        doPlayerSetNoMove(target, true)
        local function f(uid)
            if not isCreature(uid) then return end
            doPlayerSetNoMove(uid, false)
        end
        addEvent(f, tempo * 1000, cid)
        addEvent(f, tempo * 10000, target)
    return true
    end
    doPlayerSendCancel(cid, "You need a target.")
return false
end