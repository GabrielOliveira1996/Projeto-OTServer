function onCastSpell(cid, var)
    local summons = getCreatureSummons(cid)
    local position = getThingPos(cid)
    local akamaruFound = nil
    local bunshinFound = nil
    local akamaruName = ""

    for _, summon in ipairs(summons) do
        local name = getCreatureName(summon)
        local nameLower = name:lower()
        
        if nameLower:find("akamaru") then
            akamaruFound = summon
            akamaruName = name
        elseif name == getPlayerName(cid) then
            bunshinFound = summon
        end
    end

    if akamaruFound then
        local pos = getThingPos(akamaruFound)
        setPlayerStorageValue(cid, 98765, akamaruName) 
        
        doRemoveCreature(akamaruFound)
        doSendMagicEffect(pos, 2)
        
        local newBunshin = createBunshin(akamaruName, pos, cid) 
        
        if newBunshin then
            doConvinceCreature(cid, newBunshin)
            -- A velocidade do Bunshin geralmente já vem da source, 
            -- mas se precisar forçar, adicione doChangeSpeed aqui.
        end
        return true

    elseif bunshinFound then
        local pos = getThingPos(bunshinFound)
        local originalName = getPlayerStorageValue(cid, 98765)
        local pSpeed = getCreatureSpeed(cid) -- Captura a velocidade atual do Player
        
        if originalName == -1 or originalName == "" then originalName = "Akamaru" end
        
        doRemoveCreature(bunshinFound)
        doSendMagicEffect(pos, 2)
        
        local akamaru = doSummonCreature(originalName, pos)
        if akamaru then
            doConvinceCreature(cid, akamaru)
            -- CORREÇÃO DA VELOCIDADE:
            -- Aplica a diferença para que a velocidade final seja igual à do Player
            doChangeSpeed(akamaru, pSpeed - getCreatureSpeed(akamaru))
        end
        return true
    else
        doPlayerSendCancel(cid, "Voce precisa ter o Akamaru invocado.")
        return false
    end
end