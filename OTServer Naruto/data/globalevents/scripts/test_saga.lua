function onThink(interval, lastExecution)
    local config = {
        pos_examinador = {x=3068, y=3016, z=5},
        storage_perigo = 120923
    }

    -- inicio: livre para colar.
    setGlobalStorageValue(config.storage_perigo, 0)
    doSendMagicEffect(config.pos_examinador, 3) -- efeito visual para sinalizar que pode colar.

    -- contagem regressiva.
    -- Usamos doSendAnimatedText para mostrar os números.
    addEvent(function() 
        doSendAnimatedText(config.pos_examinador, "1...", 144)
    end, 0)
    
    addEvent(function() 
        doSendAnimatedText(config.pos_examinador, "2...", 144) 
    end, 1000)
    
    addEvent(function() 
        doSendAnimatedText(config.pos_examinador, "3...", 144) 
    end, 2000)
    
    addEvent(function() 
        doSendAnimatedText(config.pos_examinador, "4...", 144) 
    end, 3000)

    -- MOMENTO DO PERIGO (Aos 4 segundos)
    addEvent(function()
        setGlobalStorageValue(config.storage_perigo, 1)
        doSendMagicEffect(config.pos_examinador, 26) -- efeito de olho abrindo.
        doSendAnimatedText(config.pos_examinador, "OLHANDO!", 180) -- 180 é a cor vermelha.
        
        -- O examinador fica olhando por 2 segundos
        addEvent(function()
            setGlobalStorageValue(config.storage_perigo, 0)
            doSendAnimatedText(config.pos_examinador, "DISTRAIDO!", 30) -- 30 é a cor verde.
        end, 2000)
    end, 4000)

    return true
end