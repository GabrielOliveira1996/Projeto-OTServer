function onThink(interval, lastExecution, thinkInterval)
    local maxDistance = 8
    
    for _, pid in pairs(getPlayersOnline()) do
        local summons = getCreatureSummons(pid)
        if #summons ~= 0 then
            for _, sid in pairs(summons) do
                
                -- A EXCEÇÃO AGORA É A VELOCIDADE:
                -- Se o clone tem velocidade > 0, ele deve ser puxado.
                -- Se a velocidade é 0 (ou seja, ele está meditando), nós ignoramos.
                if getCreatureSpeed(sid) > 0 then
                    
                    if getThingPos(sid).z ~= getThingPos(pid).z or getDistanceBetween(getThingPos(sid), getThingPos(pid)) > maxDistance then
                        doTeleportThing(sid, getThingPos(pid), false)
                        doSendMagicEffect(getThingPos(sid), 2)
                    end
                    
                end
                
            end
        end
    end
    return true
end