-- Configurações
local storage_amaterasu = 30002 -- Armazena se o Amaterasu está ativo
local storage_cooldown = 30001
local effect_eye = 31 -- Efeito no olho (Sharingan)
local effect_flame = 42 -- Efeito das chamas negras
local damage_user = 50 -- Dano que o usuário sofre por tick (consequência)

-- Função para o dano contínuo no ALVO (Queima até morrer ou o caster cancelar)
local function burnTarget(cid, target)
    if not isCreature(cid) or not isCreature(target) then return end
    if getPlayerStorageValue(cid, storage_amaterasu) <= 0 then return end -- Caster desativou

    local damage = math.random(300, 600) -- Dano das chamas negras
    doCreatureAddHealth(target, -damage)
    doSendMagicEffect(getThingPos(target), effect_flame)
    doSendAnimatedText(getThingPos(target), damage, 190) -- Cor Preta/Cinza
    
    -- Consequência para o Usuário: Dano e Sangramento
    doCreatureAddHealth(cid, -damage_user)
    doSendMagicEffect(getThingPos(cid), 3) -- Efeito de sangue/suor no caster
    
    addEvent(burnTarget, 1000, cid, target)
end

-- Função de Perseguição (Vai até o alvo)
local function goToTarget(cid, target, pos)
    if not isCreature(cid) or not isCreature(target) then 
        setPlayerStorageValue(cid, storage_amaterasu, -1)
        return false 
    end
    
    if getPlayerStorageValue(cid, storage_amaterasu) <= 0 then return end

    local tpos = getCreaturePosition(target)
    local nextPos = pos or getCreaturePosition(cid)

    -- Lógica de aproximação
    if nextPos.x ~= tpos.x or nextPos.y ~= tpos.y then
        nextPos = getPosByDir(nextPos, getDirectionTo(nextPos, tpos))
        doSendMagicEffect(nextPos, effect_flame)
        addEvent(goToTarget, 150, cid, target, nextPos)
    else
        -- CAPTUROU! Começa a queima infinita
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Amaterasu capturou o alvo!")
        burnTarget(cid, target)
    end
end

function onCastSpell(cid, var)
    -- Se já estiver ativo, o uso da magia CANCELA o Amaterasu
    if getPlayerStorageValue(cid, storage_amaterasu) > 0 then
        setPlayerStorageValue(cid, storage_amaterasu, -1)
        doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Você extinguiu as chamas do Amaterasu.")
        return true
    end

    local target = getCreatureTarget(cid)
    if not isCreature(target) then
        doPlayerSendCancel(cid, "Selecione um alvo primeiro.")
        return false
    end

    if exhaustion.check(cid, storage_cooldown) then
        doPlayerSendCancel(cid, "Aguarde " .. exhaustion.get(cid, storage_cooldown) .. "s.")
        return false
    end

    -- Ativação
    exhaustion.set(cid, storage_cooldown, 5)
    setPlayerStorageValue(cid, storage_amaterasu, 1)
    
    doSendMagicEffect(getCreaturePosition(cid), effect_eye)
    doCreatureSay(cid, "AMATERASU!", TALKTYPE_MONSTER)
    
    -- Inicia perseguição
    goToTarget(cid, target, getCreaturePosition(cid))
    
    return true
end