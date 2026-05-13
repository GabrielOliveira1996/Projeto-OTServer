local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

npcHandler.topic = {} 

-- 1. SILENCIA AS MENSAGENS INTERNAS PARA EVITAR HOW RUDE / DUPLICIDADE
npcHandler.messages[MESSAGE_WALKAWAY] = nil
npcHandler.messages[MESSAGE_FAREWELL] = nil

-- 2. MECANISMO DE DESPEDIDA CUSTOMIZADO (SOBRESCREVENDO A LIB)
function npcHandler:onWalkAway(cid)
    if not self:isFocused(cid) then return false end
    
    local status = getPlayerStorageValue(cid, 34095)
    local msg = ""
    
    if status < 5 then
        msg = "Nao baixe a guarda... eles ainda podem estar la fora."
    else
        msg = "Vá com cuidado, amigo. Eu manterei meus olhos abertos."
    end
    
    selfSay(msg) -- Fala diretamente no chat global ao se afastar
    self:setMessage(MESSAGE_GREET, nil) -- Limpa o buffer para não repetir o Greet
    self.topic[cid] = 0
    self:releaseFocus(cid)
    return true
end

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function hasJhonLee(cid)
    local summons = getCreatureSummons(cid)
    for _, summon in ipairs(summons) do
        if getCreatureName(summon) == "Jhon Lee" then return true end
    end
    return false
end

function greetCallback(cid)
    local status = getPlayerStorageValue(cid, 34095)
    
    if status <= 0 then
        npcHandler:setMessage(MESSAGE_GREET, "Argh... Fique longe da porta! Se voce nao e um daqueles assassinos... Eu preciso de {ajuda}!")
    elseif status == 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Nao perca o foco! Mais mercenarios estao se aproximando!")
    elseif status == 2 then
        npcHandler:setMessage(MESSAGE_GREET, "Sobrevivemos... mas Natalia foi levada. Voce tem um {momento}?")
        npcHandler.topic[cid] = 2
    elseif status == 3 or status == 4 then 
        if not hasJhonLee(cid) then
            npcHandler:setMessage(MESSAGE_GREET, "Onde voce o deixou? Posso chama-lo de {volta}?")
            npcHandler.topic[cid] = 4
        else
            npcHandler:setMessage(MESSAGE_GREET, "Nao temos tempo a perder aqui na cabana! Natalia corre perigo!")
        end
    elseif status == 5 then 
        npcHandler:setMessage(MESSAGE_GREET, "Voce voltou... Minha cabeca ainda nao processou que era uma armadilha. Meu coracao esta em pedacos, mas voce... voce foi um verdadeiro aliado. Me deixe {agradecer} por tudo.")
        npcHandler.topic[cid] = 5
    elseif status >= 6 then 
        local quotes = {
            "Estou estudando possiveis locais no qual ela pode estar... os rastros sao confusos.",
            "Preciso me preparar... sinto que eles ainda estao atras de mim.",
            "Existe uma grande possibilidade dela estar ao sul em uma base subterranea secreta..."
        }
        npcHandler:setMessage(MESSAGE_GREET, quotes[math.random(1, #quotes)])
    end
    
    npcHandler:addFocus(cid)
    return true -- Retorna true para que a mensagem apareça na aba de NPC
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end
    local status = getPlayerStorageValue(cid, 34095) 

    -- Iniciar Quest
    if msgcontains(msg, 'ajuda') and status <= 0 then
        npcHandler:say("Eles estao me cercando. Voce me ajudaria?", cid)
        npcHandler.topic[cid] = 1

    elseif (msgcontains(msg, 'sim') or msgcontains(msg, 'yes')) and npcHandler.topic[cid] == 1 then
        npcHandler:say("Entao prepare-se!", cid)
        setPlayerStorageValue(cid, 34095, 1) 
        if spawnWaveKuroi then spawnWaveKuroi(cid, 1) end
        npcHandler:releaseFocus(cid)

    -- Pedir para resgatar Natalia
    elseif (msgcontains(msg, 'sim') or msgcontains(msg, 'yes') or msgcontains(msg, 'momento')) and npcHandler.topic[cid] == 2 then
        npcHandler:say("Minha esposa, Natalia... Eles a levaram. Voce aceita ir comigo ate a Estrada das Lamentações e resgatá-la?", cid)
        npcHandler.topic[cid] = 3

    -- trans
    elseif (msgcontains(msg, 'sim') or msgcontains(msg, 'yes') or msgcontains(msg, 'volta')) and (npcHandler.topic[cid] == 3 or npcHandler.topic[cid] == 4) then
        if hasJhonLee(cid) then
            npcHandler:say("Eu ja estou com voce! Vamos!", cid)
        else
            npcHandler:say("Meus ferimentos nao vao me parar! Vamos, antes que a levem embora!", cid)
            local monster = doSummonCreature("Jhon Lee", getThingPos(cid)) 
            doConvinceCreature(cid, monster) 
            
            if status == 2 then setPlayerStorageValue(cid, 34095, 3) end
            
            local npcName = getCreatureName(getNpcCid())
            local npcPos = getThingPos(getNpcCid())
            doRemoveCreature(getNpcCid())
            addEvent(function() doCreateNpc(npcName, npcPos) end, 60000) 
        end
        npcHandler:releaseFocus(cid)

    -- finaliza essa etapa
    elseif (msgcontains(msg, 'agradecer') or msgcontains(msg, 'sim')) and npcHandler.topic[cid] == 5 then
        npcHandler:say("Obrigado por tudo. Natalia ainda esta por ai, e eu a encontrarei... sozinho. Tome isto como prova da minha gratidao.", cid)
        doPlayerAddItem(cid, 2160, 5) 
        setPlayerStorageValue(cid, 34095, 6) 
        npcHandler.topic[cid] = 0
        npcHandler:releaseFocus(cid)
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())