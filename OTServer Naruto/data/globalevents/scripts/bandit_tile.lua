local tiles = {
    {pos = {x = 3081, y = 3176, z = 7}, storage = 33001},
}

-- Frases curtas (máximo 10 caracteres para não bugar no motor 0.3.6)
local falas = {
    "Ei, voce ai, venha ate aqui!",
    "Eii, nao finja que nao me escuta.",
    "Amigo, venha ate aqui, preciso de sua ajuda!"
}

function onThink(interval, lastExecution)
    local tempoAtual = os.time()

    for i = 1, #tiles do
        local t = tiles[i]
        local cooldown = getGlobalStorageValue(t.storage)
        
        if cooldown < 0 then cooldown = 0 end

        -- Só executa se o cooldown (1 minuto) já tiver passado
        if tempoAtual >= cooldown then
            local specs = getSpectators(t.pos, 7, 7, false)
            
            if specs and #specs > 0 then
                local msg = falas[math.random(#falas)]
                doSendAnimatedText(t.pos, msg, 144)
            end
        end
    end
    return true
end