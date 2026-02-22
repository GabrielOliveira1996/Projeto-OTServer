local SKILL_CONTROL = 6 
local STORAGE_TRANSFORM = 99126

-- lista de vocacoes transformadas para o script reverter
local transformVocs = {16, 17, 18}

function onCastSpell(cid, var)
    local playerLevel = getPlayerLevel(cid) 
    local control = getPlayerSkillLevel(cid, SKILL_CONTROL)
    local vocation = getPlayerVocation(cid)
    
    -- configuracoes de looktype e vocacao classic
    local lookClassic = 387
    local vocClassic = 13
    -- configuracoes de looktype e vocacao shippuden
    local lookShippuden = 69
    local vocShippuden = 14 

    -- transformacao classico
    if vocation == vocClassic then
        if playerLevel >= 50 and playerLevel <= 89 then
            return chakraNoMesu(cid, 2, 16, 40, control)
        else
            doPlayerSendCancel(cid, "You need level 30 to start using the Chakra no Mesu.")
            return false
        end

    -- transformacao shippuden
    elseif vocation == vocShippuden then
        if playerLevel >= 90 then
            return chakraNoMesu(cid, 168, 17, 60, control)
        else
            doPlayerSendCancel(cid, "You need level 90 to use the Chakra no Mesu in Shippuden form.")
            return false
        end

    -- reverter
    elseif isInArray(transformVocs, vocation) then -- necessario adicionar a ultima voc nivel 180
        -- se o level for maior ou igual a 90, ele é shippuden
        if playerLevel >= 90 then
            chakraNoMesuRevert(cid, lookShippuden, vocShippuden)
        else
            chakraNoMesuRevert(cid, lookClassic, vocClassic)
        end
        return true
    end

    return true
end

function chakraNoMesu(cid, lookType, vocation, reqControl, currentControl)
    if currentControl < reqControl then
        doPlayerSendTextMessage(cid, MSG_STATUS_WARNING, "Your chakra control is only " .. currentControl .. ". You need " .. reqControl .. "to be able to use Chakra no Mesu.") 
        return false
    end
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 12)
    setPlayerStorageValue(cid, STORAGE_TRANSFORM, 1) 
    return true
end

function chakraNoMesuRevert(cid, lookType, vocation)
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 12)
    setPlayerStorageValue(cid, STORAGE_TRANSFORM, -1) 
end