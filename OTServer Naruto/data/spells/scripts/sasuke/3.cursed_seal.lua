local SKILL_CONTROL = 6 
local STORAGE_TRANSFORM = 99124 

-- lista de vocacoes transformadas para o script reverter
local transformVocs = {92, 61, 62, 63}

function onCastSpell(cid, var)
    local playerLevel = getPlayerLevel(cid) 
    local control = getPlayerSkillLevel(cid, SKILL_CONTROL)
    local vocation = getPlayerVocation(cid)
    
    -- configuracoes de looktype e vocacao base
    local lookClassic = 358
    local lookShippuden = 359
    local vocClassic = 33
    local vocShippuden = 35

    -- transformacao classico
    if vocation == vocClassic then
        if playerLevel >= 30 and playerLevel <= 49 then
            cursedSeal(cid, 117, 92, 20, control)
        elseif playerLevel >= 50 and playerLevel <= 69 then
            cursedSeal(cid, 118, 61, 40, control)
        elseif playerLevel >= 70 then
            cursedSeal(cid, 118, 62, 60, control)
        else
            doPlayerSendCancel(cid, "You need level 30 to start using the Cursed Seal.")
        end

    -- transformacao shippuden
    elseif vocation == vocShippuden then
        if playerLevel >= 100 then
            cursedSeal(cid, 166, 63, 80, control)
        else
            doPlayerSendCancel(cid, "You need level 100 to use the Cursed Seal in Shippuden form.")
        end

    -- reverter
    elseif isInArray(transformVocs, vocation) then
        -- se o level for maior ou igual a 90, ele é shippuden
        if playerLevel >= 90 then
            cursedSealRevert(cid, lookShippuden, vocShippuden)
        else
            cursedSealRevert(cid, lookClassic, vocClassic)
        end
    end

    return true
end

function cursedSeal(cid, lookType, vocation, reqControl, currentControl)
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 76)
    setPlayerStorageValue(cid, STORAGE_TRANSFORM, 1) 
    if currentControl < reqControl then
        doPlayerSendTextMessage(cid, MSG_STATUS_WARNING, "Your chakra control is only " .. currentControl .. ". The Seal is consuming your body!") 
    end
end

function cursedSealRevert(cid, lookType, vocation)
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 76)
    setPlayerStorageValue(cid, STORAGE_TRANSFORM, -1) 
end