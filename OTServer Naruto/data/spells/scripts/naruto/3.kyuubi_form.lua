local SKILL_CONTROL = 6 
local STORAGE_KYUUBI = 99123 

function onCastSpell(cid, var)
    local playerLevel = getPlayerLevel(cid) 
    local control = getPlayerSkillLevel(cid, SKILL_CONTROL)
    local vocation = getPlayerVocation(cid)
    
    -- configuracoes de vocacao e looktype
    local vocClassic = 37
    local lookClassic = 352
    
    local vocShippuden = 39
    local lookShippuden = 353

    -- [trasnformacao] se o player for classic (37)
    if vocation == vocClassic then
        if playerLevel >= 30 and playerLevel <= 49 then
            kyuubiTransform(cid, 354, 64, 30, control)
        elseif playerLevel >= 50 and playerLevel <= 69 then
            kyuubiTransform(cid, 354, 65, 40, control)
        elseif playerLevel >= 70 then
            kyuubiTransform(cid, 354, 66, 60, control)
        end

    -- [transformacao] se o player for shippuden (39)
    elseif vocation == vocShippuden then
        if playerLevel >= 100 then
            kyuubiTransform(cid, 357, 67, 80, control) -- exemplo de transformação shippuden
        end

    -- [reversao] se ele já estiver transformado (Vocs 64, 65, 66, 67 ou 81)
    elseif vocation >= 64 and vocation <= 67 or vocation == 81 then
        -- se o level for menor que 90, ele volta para o classic
        if playerLevel < 90 then
            kyuubiRevert(cid, lookClassic, vocClassic)
        else
            kyuubiRevert(cid, lookShippuden, vocShippuden)
        end
    end

    return true
end

function kyuubiTransform(cid, lookType, vocation, reqControl, currentControl)
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 73)
    doChangeSpeed(cid, 100)
    setPlayerStorageValue(cid, STORAGE_KYUUBI, 1) 

    -- se o controle for menor que o necessário, limpa os bunshins.
    if currentControl < reqControl then
        doPlayerSendTextMessage(cid, MSG_STATUS_WARNING, "Your chakra control is below " .. reqControl .. ". The Kyuubi's chakra will hurt you!") 
        
        local summons = getCreatureSummons(cid)
        local playerName = getCreatureName(cid)
        
        if summons and #summons > 0 then
            for _, summon in pairs(summons) do
                -- verifica se o nome do summon é igual ao do player.
                if getCreatureName(summon) == playerName then
                    doSendMagicEffect(getThingPos(summon), 73)
                    doRemoveCreature(summon)
                    doPlayerSendTextMessage(cid, MESSAGE_STATUS_DEFAULT, "The unstable chakra destroyed your clones.")
                end
            end
        end
    end
end

function kyuubiRevert(cid, lookType, vocation)
    doSetCreatureOutfit(cid, {lookType = lookType}, -1)
    doPlayerSetVocation(cid, vocation)
    doSendMagicEffect(getCreaturePosition(cid), 73)
    doChangeSpeed(cid, -100) 
    setPlayerStorageValue(cid, STORAGE_KYUUBI, -1) 
end