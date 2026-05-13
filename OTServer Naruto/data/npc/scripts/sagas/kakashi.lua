local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

npcHandler.topic = {} 

-- SILENCE DEFAULT MESSAGES
npcHandler.messages[MESSAGE_WALKAWAY] = nil
npcHandler.messages[MESSAGE_FAREWELL] = nil

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

-- [CALLBACK] DYNAMIC GREET
local function greetCallback(cid)
    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    local playerName = getCreatureName(cid)

    -- 1. ETAPA: TESTE DOS GUIZOS
    if status == SAGA_STAGE_MEET_JOUNIN then
        npcHandler:setMessage(MESSAGE_GREET, "Ola, " .. playerName .. "! Desculpe o atraso, um gato preto cruzou meu caminho... Enfim, vamos ao que interessa. Quer {iniciar} o seu teste?")
    
    -- 2. ETAPA: TREINAMENTO NA FLORESTA (SAGA 13)
    elseif status == SAGA_STAGE_CHAKRA_CONTROL_TRAINING then
        npcHandler:setMessage(MESSAGE_GREET, "Ola, " .. playerName .. ". Tazuna me contou sobre o Inari... A batalha anterior me deixou exausto, e algo naquela morte do Zabuza me cheira mal. Voce esta pronto para aprender a {controlar} seu chakra?")
    
    -- 3. ETAPA: JÁ APRENDEU MAS NÃO TERMINOU (SAGA 14)
    elseif status == SAGA_STAGE_CLIMP_THE_TREE then
        npcHandler:setMessage(MESSAGE_GREET, "Voce ainda nao dominou a subida. Use o {kinobori} em frente as arvores ate que seu controle seja perfeito.")
    
    -- 4. ETAPA: PÓS-TREINO / PONTE (SAGA 15+)
    elseif status == SAGA_STAGE_PROTECT_THE_TAZUNA_ON_THE_BRIDGE then
        --selfSay("Nao temos tempo a perder. Va para a ponte e proteja o Tazuna!", cid)
        return false -- Ignora o foco
    else
        return false -- Ignora completamente se não estiver em nenhuma etapa
    end

    npcHandler:addFocus(cid)
    return true
end

-- [CALLBACK] DIALOGUES
function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    local npcId = getNpcCid()
    local msg = msg:lower()

    -- ETAPA: CONTROLAR CHAKRA (KINOBORI)
    if msgcontains(msg, 'controlar') or msgcontains(msg, 'sim') then
        if status == SAGA_STAGE_CHAKRA_CONTROL_TRAINING then
            npcHandler:say('A batalha anterior me deixou exausto, e algo naquela morte do Zabuza me cheira mal... Precisamos estar prontos para o pior.', cid)
            
            addEvent(function()
                if isPlayer(cid) and isCreature(npcId) then
                    doSendMagicEffect(getThingPos(cid), 12) 
                    doCreatureSay(npcId, 'Vou te ensinar o Kinobori. Foque uma quantidade precisa de chakra na sola dos pes para aderir ao tronco. Se falhar, voce caira. Comece o treinamento!', TALKTYPE_SAY)
                    setPlayerStorageValue(cid, SAGA_STORAGE, SAGA_STAGE_CLIMP_THE_TREE)
                end
            end, 3000)
        end

    -- ETAPA: INICIAR TESTE DOS GUIZOS
    elseif msgcontains(msg, 'iniciar') then
        if status == SAGA_STAGE_MEET_JOUNIN then
            setPlayerStorageValue(cid, 11002, 1) 
            npcHandler:say('Este e um teste simples. Voce so precisa pegar um dos meus guizos.', cid)
            
            addEvent(function()
                if isPlayer(cid) and isCreature(npcId) then
                    doCreatureSay(npcId, 'Eu espalhei varios deles pela floresta ao Leste. Voce tem ate o meio-dia para encontrar o verdadeiro.', TALKTYPE_SAY)
                end
            end, 3000)

            addEvent(function()
                if isPlayer(cid) and isCreature(npcId) then
                    doCreatureSay(npcId, 'Podem começar!', TALKTYPE_SAY)
                    doSendMagicEffect(getThingPos(npcId), 10) 
                end
            end, 6000)
        end
    end

    return true
end

-- [CALLBACK] CUSTOM FAREWELLS
function npcHandler:onWalkAway(cid)
    if not self:isFocused(cid) then return false end
    
    self:say("Ate mais.", cid)
    self:releaseFocus(cid)
    return true
end

function npcHandler:onFarewell(cid)
    if not self:isFocused(cid) then return false end

    self:say("Ate mais. Nao se atrase para o treino... como eu fiz.", cid)
    self:releaseFocus(cid)
    return true
end

-- [THINK] DIRECTION LOCK (KAKASHI OLHA PARA O NORTE - 0 OU SUL - 2?)
function onThink()
    local npcDir = 2 -- Ajuste para a direção que o Kakashi deve ficar parado
    if npcHandler.focus == 0 then
        if getCreatureLookDirection(getNpcId()) ~= npcDir then
            doCreatureSetLookDirection(getNpcId(), npcDir)
        end
    end
    npcHandler:onThink()
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())