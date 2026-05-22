
local SPEED_ADDITION = 50 
local SPEED_REDUCTION = -50 

function onCastSpell(cid, var)
    local playerLevel = getPlayerLevel(cid) 
    local control = getPlayerSkillLevel(cid, SKILL_CONTROL)
    local vocation = getPlayerVocation(cid)

    if vocation == NARUTO_CLASSIC_VOCATION then
        if playerLevel >= 30 and playerLevel <= 49 then
            kyuubiTransform(cid, 354, 5, 15, control) -- 1 calda classic
            return true
        elseif playerLevel >= 50 and playerLevel <= 69 then
            kyuubiTransform(cid, 355, 6, 20, control) -- 2 caldas classic
            return true
        elseif playerLevel >= 70 and playerLevel <= 89 then
            kyuubiTransform(cid, 356, 7, 25, control) -- 3 caldas classic
            return true
        end
    elseif vocation == NARUTO_SHIPPUDEN_VOCATION then
        if playerLevel >= 100 and playerLevel <= 139 then
            kyuubiTransform(cid, 357, 8, 25, control) -- 3 caldas shippuden
            return true
        elseif playerLevel >= 140 and playerLevel <= 169 then 
            kyuubiTransform(cid, 351, 9, 30, control) -- 4 caldas shippuden
            return true
        elseif playerLevel >= 180 then
            kyuubiTransform(cid, 383, 10, 0, control) -- forma máxima da kyuubi
            return true
        end
    elseif vocation >= 5 and vocation <= 10 then -- toggle para destransformar a kyuubi
        -- se o level for menor que 90, ele volta para o classic
        if playerLevel < 90 then
            kyuubiRevert(cid, NARUTO_CLASSIC_OUTFIT, NARUTO_CLASSIC_VOCATION)
        elseif playerLevel >= 90 and playerLevel < 170 then
            kyuubiRevert(cid, NARUTO_SHIPPUDEN_OUTFIT, NARUTO_SHIPPUDEN_VOCATION)
        else
            kyuubiRevert(cid, NARUTO_SHIPPUDEN_OUTFIT, NARUTO_WAR_VOCATION)
        end
        return true
    end
    doPlayerSendCancel(cid, "Nesse momento você não pode se transformar na Kyuubi.")
    return false
end

function kyuubiTransform(cid, lookType, vocation, reqControl, currentControl)
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 73)
    doChangeSpeed(cid, SPEED_ADDITION)
    setPlayerStorageValue(cid, STORAGE_KYUUBI_FORM, 1) 

    -- se o controle for menor que o necessário, limpa os bunshins.
    if currentControl < reqControl then
        doPlayerSendTextMessage(cid, MSG_STATUS_WARNING, "Seu controle de chakra está abaixo " .. reqControl .. ". O chakra da Kyuubi vai te machucar!") 
        
        local summons = getCreatureSummons(cid)
        local playerName = getCreatureName(cid)
        
        if summons and #summons > 0 then
            for _, summon in pairs(summons) do
                if getCreatureName(summon) == playerName then
                    doSendMagicEffect(getThingPos(summon), 73)
                    doRemoveCreature(summon)
                    doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, "O chakra instável destruiu seus clones.")
                end
            end
        end
    end
end

function kyuubiRevert(cid, lookType, vocation)
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 73)
    doChangeSpeed(cid, SPEED_REDUCTION) 
    setPlayerStorageValue(cid, STORAGE_KYUUBI_FORM, -1) 
end