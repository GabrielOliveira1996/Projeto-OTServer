local OPCODE_JUTSUS = 198

local function sendVocationOnly(cid)
    if not isPlayer(cid) then return end

    local vocId = getPlayerVocation(cid)
    
    -- Enviamos apenas o ID da vocação como string
    doSendPlayerExtendedOpcode(cid, OPCODE_JUTSUS, tostring(vocId))
    
    print(">>> [DEBUG] Vocação " .. vocId .. " enviada via Opcode 198 para " .. getPlayerName(cid))
end

function onLogin(cid)
    -- Mantemos o delay de 2 segundos para garantir o recebimento
    addEvent(sendVocationOnly, 2000, cid)
    return true
end