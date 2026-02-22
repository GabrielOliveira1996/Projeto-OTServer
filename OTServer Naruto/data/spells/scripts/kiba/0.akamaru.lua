function onCastSpell(cid, var)
    local summonName = "Akamaru"
    
    -- verifica se ja esta invocado
    local summons = getCreatureSummons(cid)
    for _, summon in ipairs(summons) do
        if getCreatureName(summon):lower() == summonName:lower() then
            doPlayerSendCancel(cid, "Seu Akamaru ja esta ao seu lado.")
            return false
        end
    end

    -- busca os dados
    local level = getPlayerAkamaruLevel(cid)
    local healthPts = getPlayerAkamaruHealthPts(cid)
    local agilityPts = getPlayerAkamaruAgility(cid)
    local baseSpeed = 200
    local baseHealth = 100
    local healthPerLevel = 50
    
    -- tenta criar o monstro
    local monster = doCreateMonster(summonName, getThingPos(cid))
    
    if monster then
        doConvinceCreature(cid, monster)
        
        -- calculo de hp
        local maxHealth = baseHealth + (healthPts * 50)
        
        setCreatureMaxHealth(monster, maxHealth)
        doCreatureAddHealth(monster, maxHealth)
        
        -- ajuste de velocidade
        local newSpeed = baseSpeed + (agilityPts * 10)
        doChangeSpeed(monster, newSpeed - getCreatureSpeed(monster))
        
        -- efeitos
        doSendMagicEffect(getThingPos(monster), 10) 
        doPlayerSendTextMessage(cid, MSG_STATUS_CONSOLE_BLUE, "Akamaru invocado! Nivel: " .. level)
        
        return true
    end

    return false
end