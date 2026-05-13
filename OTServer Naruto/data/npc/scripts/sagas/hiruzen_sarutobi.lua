local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

-- Função para o Tazuna falar (summon)
local function summonTazuna(cid, npcId)
    if not isPlayer(cid) then return nil end
    local summons = getCreatureSummons(cid)
    for _, summon in ipairs(summons) do
        if getCreatureName(summon):lower() == "tazuna" then doRemoveCreature(summon) end
    end
    local pos = getThingPos(npcId)
    local tazuna = doCreateMonster("Tazuna", pos)
    if isCreature(tazuna) then
        doConvinceCreature(cid, tazuna)
        doSendMagicEffect(pos, 2)
        return tazuna
    end
    return nil
end

-- GREET: Bloqueia quem não tem saga
function onGreet(cid)
    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    if status <= 0 then return false end -- Ignora player sem saga

    local playerName = getCreatureName(cid)
    if status <= 5 then
        npcHandler:setMessage(MESSAGE_GREET, "Ola " .. playerName .. ". Va tirar sua {foto} na camera ao lado agora mesmo!")
    elseif status == 6 then
        npcHandler:setMessage(MESSAGE_GREET, "Mas o que significa isso, " .. playerName .. "?! Esta foto e uma afronta! Va {refazer} isso!")
    elseif status >= 7 and status < 9 then
        npcHandler:setMessage(MESSAGE_GREET, "Sua foto ja foi registrada. Va treinar com seus novos instrutores.")
    elseif status == 9 then
        npcHandler:setMessage(MESSAGE_GREET, "Ola " .. playerName .. ". Estao prontos para a {primeira missao} real?")
    elseif status == 10 or status == 11 then
        npcHandler:setMessage(MESSAGE_GREET, "Onde esta o Tazuna? Se o perdeu, podemos {trazer} ele de volta.")
    elseif status == SAGA_STAGE_FIRST_REAL_MISSION_COMPLETED then
        npcHandler:setMessage(MESSAGE_GREET, "Excelente trabalho na escolta do construtor. Agora, me entregue o {relatorio} para que eu possa oficializar o sucesso da missao.")
    else
        npcHandler:setMessage(MESSAGE_GREET, "Estou ocupado agora.")
    end
    return true
end

-- DESPEDIDA PERSONALIZADA (Consertando o "How Rude" e Erros de Console)
function onFarewell(cid)
    if not isPlayer(cid) then return end
    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    
    local msg = "Trabalhe duro pelo bem da Folha. Ate logo."
    if status == 6 then
        msg = "E nao volte aqui com essa cara pintada!"
    elseif status == 10 then
        msg = "Proteja o construtor com sua vida. Boa sorte."
    end
    
    npcHandler:say(msg, cid)
    npcHandler:releaseFocus(cid)
end

-- Sobrescrevendo a função interna para evitar o erro do gsub/Thing Not Found
npcHandler.onWalkAway = function(self, cid)
    if not self:isFocused(cid) then return end
    
    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    local msg = "Ate logo."
    if status == 6 then msg = "Que falta de educacao... refaca aquela foto!" 
    elseif status == 10 then msg = "Nao se perca no caminho, a missao e seria!" end
    
    self:say(msg, cid)
    self:releaseFocus(cid)
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local message = msg:lower()
    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    local npcId = getNpcCid()

    if msgcontains(message, 'oiroke') or msgcontains(message, 'sexy') then
        if status == 6 then
            doCreatureSay(npcId, "COMO E QUE E?! Voce vai me mostrar um... O QUE?!!", TALKTYPE_SAY)
            local kono = getCreatureByName("Konohamaru")
            if isCreature(kono) then
                doCreatureSay(kono, "VOVO! EU VIM TE DERRO... AAAHHH! QUE TECNICA E ESSA?!", TALKTYPE_SAY)
                doSendMagicEffect(getThingPos(kono), 10)
            end
            doSendMagicEffect(getThingPos(npcId), 0)
            doCreatureSay(npcId, "PUFT!! Sangue pelo nariz... Pare com isso agora! Vou registrar essa foto so para voce sair da minha sala!", TALKTYPE_SAY)
            setPlayerStorageValue(cid, SAGA_STORAGE, 7) 
            doPlayerAddExp(cid, 6000) 
            doSendMagicEffect(getThingPos(cid), 12)
            npcHandler:releaseFocus(cid)
        end
    elseif msgcontains(message, 'refazer') or msgcontains(message, 'foto') then
        if status <= 5 then
            doCreatureSay(npcId, "Va tirar a foto na camera primeiro!", TALKTYPE_SAY)
        elseif status == 6 then
            if getPlayerStorageValue(cid, SAGA_AUX_CLEAN_FACE) == 1 then 
                doCreatureSay(npcId, "Ah, muito melhor! Vou registrar sua graduacao.", TALKTYPE_SAY)
                setPlayerStorageValue(cid, SAGA_STORAGE, 7)
                setPlayerStorageValue(cid, SAGA_AUX_CLEAN_FACE, -1)
                doPlayerAddExp(cid, 500)
                doSendMagicEffect(getThingPos(cid), 12)
                npcHandler:releaseFocus(cid)
            else
                doCreatureSay(npcId, "Va tirar outra foto sem essas pinturas!", TALKTYPE_SAY)
            end
        end
    elseif msgcontains(message, 'primeira missao') or msgcontains(message, 'missao') or msgcontains(message, 'tazuna') then
        if status == 9 then
            doCreatureSay(npcId, "Muito bem. Sua missao e escoltar o mestre construtor de pontes, Tazuna, ate o Pais das Ondas.", TALKTYPE_SAY)
            addEvent(function()
                if isPlayer(cid) then
                    doCreatureSay(npcId, "Tazuna-san, pode entrar!", TALKTYPE_SAY)
                    local tazunaBot = summonTazuna(cid, npcId)
                    addEvent(function()
                        if isPlayer(cid) and isCreature(tazunaBot) then
                            doCreatureSay(tazunaBot, "Tazuna: O que?! Esse pirralho com cara de idiota vai me proteger? Espero que saiba usar essa kunai...", TALKTYPE_SAY)
                            setPlayerStorageValue(cid, SAGA_STORAGE, 10)
                        end
                    end, 3000)
                end
            end, 2000)
        end
    elseif msgcontains(message, 'trazer') then
        if status == 10 or status == 11 then
            doCreatureSay(npcId, "Tazuna-san esta de volta. Nao o perca novamente!", TALKTYPE_SAY)
            summonTazuna(cid, npcId)
            if getPlayerStorageValue(cid, 11003) < 2 then
                setPlayerStorageValue(cid, 11003, 0)
                setPlayerStorageValue(cid, 11004, 0)
                setPlayerStorageValue(cid, 11006, 0)
            else
                setPlayerStorageValue(cid, 11006, 4)
            end
        end
    elseif msgcontains(message, 'relatorio') then
        if status == SAGA_STAGE_FIRST_REAL_MISSION_COMPLETED then
            doCreatureSay(npcId, "Muito bem. Com isso, a missao esta oficialmente completa. Parabens por sua dedicacao e bravura. O Pais das Ondas agora esta em paz gracas a voce. Pegue isso como recompensa.", TALKTYPE_SAY)
            doPlayerAddItem(cid, 2160, 2) -- recompensa
            addEvent(function()
                doCreatureSay(npcId, "Aproveitando a oportunidade, a prova chunin esta chegando. Se tiver interesse e achar que esta preparado, fale com o Kakashi sobre isso.")
                setPlayerStorageValue(cid, SAGA_STORAGE, SAGA_STAGE_KAKASHI_INVITATION)
            end, 3000)
            addEvent(function()
                doCreatureSay(npcId, "Ah, outra coisa, sinto que voce esta pronto para enfrentar maiores desafios. Se quiser, voce pode pegar novas missoes com o Deizou no predio ao lado da entrada da vila.")
            end, 6000)
        end
    end
    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())