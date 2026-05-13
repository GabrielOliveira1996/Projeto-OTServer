local configs = {
    [1001] = {msg = "Ei, %s... voces shinobis sao sempre tao calados assim? Isso me deixa nervoso.", step = 0, talker = "tazuna"},
    [1002] = {msg = "Apenas mantenha o passo, Tazuna-san. Eu ficarei de olho na retaguarda.", step = 1, talker = "player"},
    [1003] = {msg = "Nao sei por que gastei meu dinheiro com pirralhos... espero chegar inteiro.", step = 2, talker = "tazuna"},
    
    -- ActionID 1004: Agora cria a poça d'água na posição indicada
    [1004] = {
        msg = "Espere... voce notou aquela poca de agua logo a frente?", 
        step = 3, 
        talker = "player", 
        blockAfterEvent = 2,
        createItem = {id = 2016, pos = {x = 3063, y = 3172, z = 7}} -- Configuração da poça
    },

    [1011] = {msg = "%s, voce percebeu? Aqueles ninjas eram de elite... Tazuna-san, voce nao nos contou tudo.", step = 4, reqEventStatus = 2, talker = "player"},
    [1012] = {msg = "Eu... eu não tive escolha! O Gatō dominou nosso comércio e isolou nosso povo. O País das Ondas é pobre e não tínhamos dinheiro para uma missão Rank A! Aquela ponte é nossa única chance de liberdade... por favor, não nos abandonem agora!", step = 5, reqEventStatus = 2, talker = "tazuna"},
    [1013] = {msg = "Isso muda tudo. Agora estamos na mira de assassinos profissionais. O proximo sera pior.", step = 6, reqEventStatus = 2, talker = "player"}
}

-- Storages auxiliares (Certifique-se de que esses IDs não conflitem com outros sistemas)
local STORAGE_SPAWN_LOCK = 11010 -- Trava para evitar múltiplos summons rápidos

local function getTazunaId(cid)
    local summons = getCreatureSummons(cid)
    if summons and #summons > 0 then
        for _, summon in ipairs(summons) do
            if getCreatureName(summon):lower() == "tazuna" then return summon end
        end
    end
    return nil
end

local function isAreaBusy(pos, radius)
    local spectators = getSpectators(pos, radius, radius, false)
    if spectators then
        for _, s in ipairs(spectators) do
            if isMonster(s) then
                local name = getCreatureName(s):lower()
                if name == "gozu" or name == "meizu" then return true end
            end
        end
    end
    return false
end

function onStepIn(cid, item, position, fromPosition)
    if not isPlayer(cid) then return true end
    
    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    local playerName = getCreatureName(cid)
    local talkStep = math.max(0, getPlayerStorageValue(cid, SAGA_AUX_WAVES_ROAD_TALKSTATE))
    local demonBrosStatus = getPlayerStorageValue(cid, SAGA_AUX_DEMON_BROS_EVENT)

    if status ~= 10 then return true end

    -- 1. LÓGICA DE DIÁLOGOS E POÇA (configs)
    local config = configs[item.actionid]
    if config then
        if config.blockAfterEvent and demonBrosStatus >= config.blockAfterEvent then
            return true
        end

        if talkStep == config.step then
            local tazuna = getTazunaId(cid)
            if not tazuna or getDistanceBetween(getThingPos(cid), getThingPos(tazuna)) > 7 then
                doPlayerSendCancel(cid, "Voce precisa estar acompanhado de Tazuna para prosseguir.")
                return true
            end

            if config.reqEventStatus and demonBrosStatus < config.reqEventStatus then
                return true
            end

            if config.createItem then
                local puddle = getTileItemById(config.createItem.pos, config.createItem.id)
                if puddle.uid == 0 then 
                    doCreateItem(config.createItem.id, 1, config.createItem.pos)
                    doSendMagicEffect(config.createItem.pos, 2) 
                end
            end

            local talkerObj = (config.talker == "tazuna") and tazuna or cid
            doCreatureSay(talkerObj, string.format(config.msg, playerName), TALKTYPE_SAY)
            setPlayerStorageValue(cid, SAGA_AUX_WAVES_ROAD_TALKSTATE, talkStep + 1)
        end
        return true
    end

    -- 2. BATALHA 1: DEMON BROTHERS (ActionID 1010)
    if item.actionid == 1010 then
        local killCount = getPlayerStorageValue(cid, SAGA_AUX_DEMON_BROS_KILLCOUNT)
        
        -- Trava Anti-Spam (Evita que o addEvent dispare várias vezes se o player andar rápido)
        if getPlayerStorageValue(cid, STORAGE_SPAWN_LOCK) == 1 then
            return true
        end

        if demonBrosStatus >= 2 or killCount >= 2 then 
            return true 
        end

        if demonBrosStatus == 1 then
            if isAreaBusy(position, 10) then 
                return true 
            end
            doPlayerSendTextMessage(cid, 22, "Eles fugiram para as sombras... mas estao voltando!")
        end

        local tazuna = getTazunaId(cid)
        if not tazuna or getDistanceBetween(getThingPos(cid), getThingPos(tazuna)) > 7 then
             doPlayerSendCancel(cid, "Traga Tazuna com voce para prosseguir.")
             return true 
        end

        -- ATIVA A TRAVA IMEDIATAMENTE
        setPlayerStorageValue(cid, STORAGE_SPAWN_LOCK, 1)

        -- Remove a poça
        local puddlePos = {x = 3063, y = 3172, z = 7}
        local puddleItem = getTileItemById(puddlePos, 2016)
        if puddleItem.uid > 0 then doRemoveItem(puddleItem.uid) end

        setPlayerStorageValue(cid, SAGA_AUX_DEMON_BROS_EVENT, 1)
        setPlayerStorageValue(cid, SAGA_AUX_DEMON_BROS_KILLCOUNT, 0)
        doPlayerSendTextMessage(cid, 22, "O que?! Uma corrente vindo do chao?!")
        
        addEvent(function()
            if isPlayer(cid) then
                -- Libera a trava após o spawn acontecer
                setPlayerStorageValue(cid, STORAGE_SPAWN_LOCK, -1)
                
                doCreatureSay(cid, "PROTEJA O TAZUNA!", TALKTYPE_SAY)
                
                local pos1 = {x=position.x+1, y=position.y+1, z=position.z}
                local pos2 = {x=position.x-1, y=position.y-1, z=position.z}
                
                local m1 = doCreateMonster("Gozu", pos1)
                local m2 = doCreateMonster("Meizu", pos2)
                
                doSendMagicEffect(pos1, 10)
                doSendMagicEffect(pos2, 10)

                local function autoRemove(m)
                    if isCreature(m) then doRemoveCreature(m) end
                end

                if isCreature(m1) then 
                    doMonsterSetTarget(m1, cid) 
                    addEvent(autoRemove, 3 * 60 * 1000, m1)
                end
                if isCreature(m2) then 
                    doMonsterSetTarget(m2, cid) 
                    addEvent(autoRemove, 3 * 60 * 1000, m2)
                end
            end
        end, 1500)
    end

    return true
end