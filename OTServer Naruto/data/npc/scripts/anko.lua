local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

-- funcao que controla a saudacao inicial
function onGreet(cid)
    local storage = 11125 
    if getPlayerStorageValue(cid, storage) >= 1 then
        npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo, " .. getCreatureName(cid) .. ". Esta é a Floresta da Morte. Você está pronto para o {exame}?")
    else
        npcHandler:setMessage(MESSAGE_GREET, "O que você está fazendo aqui, pirralho? Apenas ninjas autorizados podem entrar nesta área.")
    end
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local storage = 11125 
    local destination = {x=3139, y=2974, z=7}
    local orochimaruStorageSaga = 11000

    -- ogica da resposta
    if msgcontains(msg, 'exame') or msgcontains(msg, 'sim') or msgcontains(msg, 'yes') then
        if getPlayerStorageValue(cid, storage) >= 1 then
            selfSay('Muito bem. Saiba que metade de vocês não sairá daqui vivo... Boa sorte!', cid)
            -- storage adicionada para permitir enfrentar orochimaru
            setPlayerStorageValue(cid, orochimaruStorageSaga, 1)
            -- efeitos
            doSendMagicEffect(getThingPos(cid), 2) -- fumaca ao sair
            doTeleportThing(cid, destination)
            doSendMagicEffect(destination, 10) -- efeito do destino
            
            npcHandler:releaseFocus(cid)
        else
            selfSay('Você ainda não está preparado. Volte quando tiver a autorização.', cid)
        end
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())