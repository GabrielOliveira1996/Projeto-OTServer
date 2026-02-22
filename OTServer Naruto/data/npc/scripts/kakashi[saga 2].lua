local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

function onGreet(cid)
    local playerName = getCreatureName(cid)
    -- Saudacao mais caracteristica do Kakashi
    npcHandler:setMessage(MESSAGE_GREET, "Ola, " .. playerName .. ". Vejo que sobreviveu ao Pais das Ondas. Veio falar sobre a recomendacao para o {Exame Chunin}?")
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local storagelose = 11123 -- storage da derrota de Zabuza/Haku
    local storageGain = 11124 -- storage da inscricao aceita
    local expReward = 10000

    if msgcontains(msg, 'exame chunin') or msgcontains(msg, 'exame chunnin') then
        -- Caso o jogador ja tenha se inscrito
        if getPlayerStorageValue(cid, storageGain) >= 1 then
            selfSay('Eu ja entreguei sua ficha de inscricao aos examinadores. Va para o segundo andar da Academia Ninja e nao se atrase.', cid)
            return true
        end

        -- Verificacao de progresso na historia
        if getPlayerStorageValue(cid, storagelose) >= 1 then
            selfSay('Apos enfrentarem Zabuza Momochi, acredito que voces estao prontos. Eu ja fiz a recomendacao oficial. Agora, va para a Academia Ninja!', cid)
            
            setPlayerStorageValue(cid, storagelose, -1)
            setPlayerStorageValue(cid, storageGain, 1)
            doPlayerAddExp(cid, expReward)
            doSendMagicEffect(getThingPos(cid), 2)
        else
            -- Caso o jogador tente pular a historia
            selfSay('Um ninja nao deve pular etapas. Primeiro, termine suas pendencias no Pais das Ondas com o construtor de pontes.', cid)
        end
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())