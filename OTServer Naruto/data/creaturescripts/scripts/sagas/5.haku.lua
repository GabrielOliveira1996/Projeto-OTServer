-- [CONFIGURAÇÃO LOCAL PARA O SPAWN]
local cfg = {
    zabuza_fight_time = 300,
    bridge_center = {x = 3431, y = 3063, z = 6}, -- COLOQUE AQUI A COORDENADA CENTRAL DA PONTE
}

-- Função para limpar a arena de forma GLOBAL e GARANTIDA
local function clearHakuStageGlobal()
    -- 1. Limpeza por Tabela (Segurança para monstros específicos registrados)
    if BridgeMonsters then
        for _, mid in ipairs(BridgeMonsters) do
            if isCreature(mid) then 
                doRemoveCreature(mid) 
            end
        end
    end
    BridgeMonsters = {}

    -- 2. Limpeza por área Massiva (Substitui o getMonsters)
    -- Varre um raio de 150 SQMs (praticamente a ponte toda e arredores)
    local spectators = getSpectators(cfg.bridge_center, 150, 150, false)
    if spectators then
        for _, spec in ipairs(spectators) do
            if isMonster(spec) then
                local mName = getCreatureName(spec):lower()
                if mName == "haku glass" or mName == "haku" then
                    doRemoveCreature(spec)
                end
            end
        end
    end
end

-- Função para spawnar o Zabuza
local function spawnZabuza(cid)
    if not isPlayer(cid) then return end
    
    -- Limpeza Global antes de nascer o Zabuza
    clearHakuStageGlobal() 
    
    setGlobalStorageValue(SAGA_AUX_BRIDGE_LOCK_STORAGE, os.time() + cfg.zabuza_fight_time)
    doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Haku recua... A nevoa se dissipa e Zabuza aparece!")
    
    local pPos = getThingPos(cid)
    local zabuzaPos = {x = pPos.x + 2, y = pPos.y, z = pPos.z}
    local zabuza = doCreateMonster("Zabuza Momochi [The Final Mist]", zabuzaPos)
    
    if zabuza then
        if not BridgeMonsters then BridgeMonsters = {} end
        table.insert(BridgeMonsters, zabuza)
        doSendMagicEffect(zabuzaPos, 2)
        doCreatureSay(zabuza, "Parece que voce se divertiu com meu subordinado. Agora o assunto e comigo!", TALKTYPE_MONSTER_SAY)
        
        --registerCreatureEvent(zabuza, "ZabuzaDeath")

        addEvent(function()
            if isCreature(zabuza) then
                doRemoveCreature(zabuza)
                setGlobalStorageValue(SAGA_AUX_BRIDGE_LOCK_STORAGE, 0)
                BridgeMonsters = {}
                if isPlayer(cid) then
                    doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_ORANGE, "Zabuza fugiu na nevoa. Voce falhou!")
                end
            end
        end, cfg.zabuza_fight_time * 1000)
    end
end

function onDeath(cid, corpse, killer)
    if not isMonster(cid) then return true end
    local name = getCreatureName(cid):lower()

    if name == "haku" then
        local eventTriggered = false 
        
        for i = 1, #killer do
            local targetPlayer = killer[i]
            if isPlayer(targetPlayer) then
                if not eventTriggered then
                    spawnZabuza(targetPlayer) 
                    eventTriggered = true 
                end
                doPlayerSendTextMessage(targetPlayer, MESSAGE_EVENT_ADVANCE, "Sua equipe derrotou Haku! Preparem-se para o Zabuza!")
            end
        end

        -- Remove o Haku que morreu imediatamente para não dar erro de "Creature not found"
        if isCreature(cid) then
            doRemoveCreature(cid)
        end
        return false -- Retorna false para o Haku não deixar corpo no chão
    end

    return true 
end