local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)

function onCastSpell(cid, var)
    local level = getPlayerLevel(cid)
    local taijutsu = getPlayerSkillLevel(cid, SKILL_TAIJUTSU) -- skill de fist/taijutsu
    local getMana = getCreatureMana(cid)
    
    local target = getCreatureTarget(cid)
    local playerName = getCreatureName(cid)
    local narutoVocations = {1,2,3,4,5,6,7,8,10,11,12,13,14}

    -- quarta calda nÃ£o permite usar esse jutsu
    local playerVoc = getPlayerVocation(cid)
    local fourthTailVocations = 9
    if playerVoc == fourthTailVocations then
        doPlayerSendCancel(cid, "Esta forma não permite o uso deste jutsu.")
        doSendMagicEffect(getThingPos(cid), 2)
        return false
    end

    -- verifica alvo
    if target == 0 then
        doPlayerSendCancel(cid, "Você precisa de um alvo.")
        return false
    end

    -- verifica vocacao
    if not isInArray(narutoVocations, getPlayerVocation(cid)) then
        doPlayerSendCancel(cid, "Você não pode usar este jutsu.")
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
        doPlayerSendCancel(cid, "Você precisa invocar um Bunshin.")
        return false
    end

    -- execução do dano e efeito
    local effectPos = {x = targetPos.x + 1, y = targetPos.y, z = targetPos.z}
    doSendMagicEffect(effectPos, 80)

    -- Formula de dano baseada no taijutsu
    local min = (level * 1.5) + (taijutsu * 3.0)
    local max = (level * 2.5) + (taijutsu * 4.5)
    doTargetCombatHealth(cid, target, COMBAT_PHYSICALDAMAGE, -min, -max, 1)

    return true
end