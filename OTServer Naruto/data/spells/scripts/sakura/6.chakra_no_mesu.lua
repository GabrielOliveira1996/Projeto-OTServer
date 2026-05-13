--local STORAGE_TRANSFORM = 99126

-- lista de vocacoes transformadas para o script reverter
local transformVocs = {29, 30, 31, 32}

function onCastSpell(cid, var)
    local playerLevel = getPlayerLevel(cid) 
    local control = getPlayerSkillLevel(cid, SKILL_CONTROL)
    local vocation = getPlayerVocation(cid)
    
    -- transformacao classico
    if vocation == SAKURA_KUNOICHI_VOCATION then
        if playerLevel >= 50 and playerLevel <= 89 then
            return chakraNoMesu(cid, SAKURA_KUNOICHI_CHAKRA_NO_MESU_OUTFIT, SAKURA_KUNOICHI_CHAKRA_NO_MESU_VOCATION, CONTROL_NECESSARY_TO_KUNOICHI_CHAKRA_NO_MESU, control)
        else
            doPlayerSendCancel(cid, "Você precisa estar no nível 50 para começar a usar o Chakra no Mesu.")
            return false
        end

    -- transformacao shippuden
    elseif vocation == SAKURA_SHIPPUDEN_VOCATION then
        if playerLevel >= 100 and playerLevel <= 169 then
            return chakraNoMesu(cid, SAKURA_SHIPPUDEN_CHAKRA_NO_MESU_OUTFIT, SAKURA_SHIPPUDEN_CHAKRA_NO_MESU_VOCATION, CONTROL_NECESSARY_TO_SHIPPUDEN_CHAKRA_NO_MESU, control)
        else
            doPlayerSendCancel(cid, "Você precisa estar no nível 100 para usar o Chakra no Mesu na forma Shippuden.")
            return false
        end
    
    -- transformacao war
    elseif vocation == SAKURA_WAR_VOCATION then
        if playerLevel >= 180 and playerLevel <= 249 then
            return chakraNoMesu(cid, SAKURA_WAR_CHAKRA_NO_MESU_OUTFIT, SAKURA_WAR_CHAKRA_NO_MESU_VOCATION, CONTROL_NECESSARY_TO_WAR_CHAKRA_NO_MESU, control)
        else
            doPlayerSendCancel(cid, "Você precisa estar no nível 180 para usar o Chakra no Mesu na forma de Guerra.")
            return false
        end

    -- transformacao shinsu
    elseif vocation == SAKURA_SHINSU_VOCATION then
        if playerLevel >= 260 then
            return chakraNoMesu(cid, SAKURA_SHINSU_CHAKRA_NO_MESU_OUTFIT, SAKURA_SHINSU_CHAKRA_NO_MESU_VOCATION, CONTROL_NECESSARY_TO_SHINSU_CHAKRA_NO_MESU, control)
        else
            doPlayerSendCancel(cid, "Você precisa estar no nível 260 para usar o Chakra no Mesu na forma Shinsu.")
            return false
        end

    -- reverter
    elseif isInArray(transformVocs, vocation) then
        -- se o level for maior ou igual a 90, ele não é shippuden
        if playerLevel >= 260 then
            chakraNoMesuRevert(cid, SAKURA_SHINSU_OUTFIT, SAKURA_SHINSU_VOCATION)
        elseif playerLevel >= 180 then
            chakraNoMesuRevert(cid, SAKURA_WAR_OUTFIT, SAKURA_WAR_VOCATION)
        elseif playerLevel >= 100 then
            chakraNoMesuRevert(cid, SAKURA_SHIPPUDEN_OUTFIT, SAKURA_SHIPPUDEN_VOCATION)
        else
            chakraNoMesuRevert(cid, SAKURA_KUNOICHI_OUTFIT, SAKURA_KUNOICHI_VOCATION)
        end
        return true
    end

    return true
end

function chakraNoMesu(cid, lookType, vocation, reqControl, currentControl)
    if currentControl < reqControl then
        doSendMagicEffect(getCreaturePosition(cid), 2)
        doPlayerSendCancel(cid, "Seu controle de chakra é apenas " .. currentControl .. ". Você precisa de " .. reqControl .. " para poder usar Chakra no Mesu.") 
        return false
    end
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 12)
    --setPlayerStorageValue(cid, STORAGE_TRANSFORM, 1) 
    return true
end

function chakraNoMesuRevert(cid, lookType, vocation)
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 12)
    --setPlayerStorageValue(cid, STORAGE_TRANSFORM, -1) 
end