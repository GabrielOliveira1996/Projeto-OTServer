local SPEED_ADDITION = 50 
local SPEED_REDUCTION = -50 

function onCastSpell(cid, var)
    local playerLevel = getPlayerLevel(cid) 
    local control = getPlayerSkillLevel(cid, SKILL_CONTROL)
    local vocation = getPlayerVocation(cid)

    -- transformacao classico
    if vocation == SASUKE_CLASSIC_VOCATION then
        if playerLevel >= 30 and playerLevel <= 49 then
            cursedSeal(cid, 117, 20, 10, control)
        elseif playerLevel >= 50 and playerLevel <= 69 then
            cursedSeal(cid, 118, 21, 15, control)
        elseif playerLevel >= 70 and playerLevel <= 89 then
            cursedSeal(cid, 118, 22, 20, control)
        else
            doPlayerSendCancel(cid, "Você precisa estar no nível 30 para começar a usar o Selo Amaldiçoado.")
        end

    -- transformacao shippuden
    elseif vocation == SASUKE_SHIPPUDEN_VOCATION then
        if playerLevel >= 100 and playerLevel <= 129 then
            cursedSeal(cid, 166, 23, 20, control)
        else
            doPlayerSendCancel(cid, "Você precisa estar no nível 100 para usar o Selo Amaldiçoado na forma Shippuden.")
        end

    -- reverter
    elseif isInArray(SASUKE_LIST_OF_CURSED_VOCATIONS, vocation) then
        -- se o level for maior ou igual a 90, ele Ã© shippuden
        if playerLevel >= 90 then
            cursedSealRevert(cid, SASUKE_SHIPPUDEN_OUTFIT, SASUKE_SHIPPUDEN_VOCATION)
        else
            cursedSealRevert(cid, SASUKE_CLASSIC_OUTFIT, SASUKE_CLASSIC_VOCATION)
        end
    end

    return true
end

function cursedSeal(cid, lookType, vocation, reqControl, currentControl)
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 76)
    doChangeSpeed(cid, SPEED_ADDITION)
    setPlayerStorageValue(cid, STORAGE_CURSED_FORM, 1) 
    if currentControl < reqControl then
        doPlayerSendTextMessage(cid, MSG_STATUS_WARNING, "Seu controle de chakra é apenas " .. currentControl .. ". O selo está consumindo seu corpo!") 
    end
end

function cursedSealRevert(cid, lookType, vocation)
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 76)
    doChangeSpeed(cid, SPEED_REDUCTION) 
    setPlayerStorageValue(cid, STORAGE_CURSED_FORM, -1) 
end