local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

function onCastSpell(cid, var)
    local getSkill = getPlayerSkillLevel(cid, 6) -- Skill de Fist/Taijutsu
    local getMana = getCreatureMana(cid)
    local baseManaCost = 80 
    
    -- LOGICA DE MANA: O bonus (reducao) e baseado no skill, 
    -- mas o math.min garante que nunca reduza mais que a metade (40)
    local manaBonus = math.min(baseManaCost / 2, getSkill)
    local finalCost = baseManaCost - manaBonus
    
    local target = getCreatureTarget(cid)
    local playerName = getCreatureName(cid)
    local narutoVocations = {37, 39, 40}
    local cooldownStorage = 23001
    local cooldownTime = 2 -- Tempo em segundos

    -- Verifica alvo
    if target == 0 then
        doPlayerSendCancel(cid, "Voce precisa de um alvo.")
        return false
    end

    -- Verifica vocacao
    if not isInArray(narutoVocations, getPlayerVocation(cid)) then
        doPlayerSendCancel(cid, "You cannot use this jutsu in Kyuubi form.")
        return false
    end

    -- Verificacao de Cooldown (Sistema os.time e mais estavel que exhaustion)
    if getPlayerStorageValue(cid, cooldownStorage) > os.time() then
        local remaining = getPlayerStorageValue(cid, cooldownStorage) - os.time()
        doPlayerSendCancel(cid, "Aguarde " .. remaining .. " segundos.")
        return false
    end

    -- Verifica mana (Usa o custo final ja calculado)
    if getMana < finalCost then
        doPlayerSendCancel(cid, "Voce precisa de " .. finalCost .. " de chakra.")
        return false
    end

    -- Busca a validacao dos clones
    local targetPos = getCreaturePosition(target)
    local summons = getCreatureSummons(cid)
    local hasClone = false

    if #summons > 0 then
        for _, summon in ipairs(summons) do
            if getCreatureName(summon) == playerName then
                hasClone = true
                doTeleportThing(summon, targetPos)
                doSendMagicEffect(targetPos, 2)
                break -- Encontrou o clone, pode parar o loop
            end
        end
    end

    if not hasClone then
        doPlayerSendCancel(cid, "Voce precisa de um clone ativo.")
        return false
    end

    -- Execucao do dano e efeito
    local effectPos = {x = targetPos.x + 1, y = targetPos.y, z = targetPos.z}
    doSendMagicEffect(effectPos, 80)

    -- Formula de dano baseada no Taijutsu
    local min = (getSkill * 1.0) + 45
    local max = (getSkill * 1.7) + 60
    doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -min, -max, 1)

    -- Finalizacao: Remove mana e define cooldown
    doCreatureAddMana(cid, -finalCost)
    setPlayerStorageValue(cid, cooldownStorage, os.time() + cooldownTime)

    return true
end