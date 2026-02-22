local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

function onCastSpell(cid, var)
    local getSkill = getPlayerSkillLevel(cid, 6) -- skill de fist/taijutsu
    local getMana = getCreatureMana(cid)
    
    local target = getCreatureTarget(cid)
    local playerName = getCreatureName(cid)
    local narutoVocations = {37, 39, 40}
    local cooldownStorage = 23001
    local cooldownTime = 2 -- tempo em segundos

    -- verifica alvo
    if target == 0 then
        doPlayerSendCancel(cid, "You need a target.")
        return false
    end

    -- verifica vocacao
    if not isInArray(narutoVocations, getPlayerVocation(cid)) then
        doPlayerSendCancel(cid, "You cannot use this jutsu in Kyuubi form.")
        return false
    end

    -- verificacao de Cooldown
    if getPlayerStorageValue(cid, cooldownStorage) > os.time() then
        local remaining = getPlayerStorageValue(cid, cooldownStorage) - os.time()
        doPlayerSendCancel(cid, "Wait " .. remaining .. " seconds.")
        return false
    end

    -- busca a validacao dos bushins
    local targetPos = getCreaturePosition(target)
    local summons = getCreatureSummons(cid)
    local hasClone = false

    if #summons > 0 then
        for _, summon in ipairs(summons) do
            if getCreatureName(summon) == playerName then
                hasClone = true
                doTeleportThing(summon, targetPos)
                doSendMagicEffect(targetPos, 2)
                break -- encontrou o clone, pode parar o loop
            end
        end
    end

    if not hasClone then
        doPlayerSendCancel(cid, "You need an active Bunshin.")
        return false
    end

    -- cxecucao do dano e efeito
    local effectPos = {x = targetPos.x + 1, y = targetPos.y, z = targetPos.z}
    doSendMagicEffect(effectPos, 80)

    -- Formula de dano baseada no taijutsu
    local min = (getSkill * 1.0) + 45
    local max = (getSkill * 1.7) + 60
    doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -min, -max, 1)
    -- define o cooldown
    setPlayerStorageValue(cid, cooldownStorage, os.time() + cooldownTime)

    return true
end