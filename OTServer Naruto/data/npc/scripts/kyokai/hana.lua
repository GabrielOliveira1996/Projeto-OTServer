local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) 
    if cid and talkState[cid] then talkState[cid] = nil end
    npcHandler:onCreatureDisappear(cid) 
end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

function onThink()
    npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local msg = msg:lower()
    local questStatus = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)
    
    -- Inicializa o estado se não existir
    if not talkState[cid] then talkState[cid] = 0 end

    -- [SITUAÇÃO: UTAKA ESTÁ MORTO]
    if questStatus == ISAC_STATUS_UTAKA_DEAD or questStatus == ISAC_STATUS_BOTH_DEAD then
        if msgcontains(msg, 'utaka') or msgcontains(msg, 'brincar') then
            npcHandler:say("O Utaka nao vem mais brincar... a Tia Yomogi disse que ele virou uma estrelinha, mas eu nao queria que ele estivesse tao longe. *ela limpa as lagrimas*", cid)
        else
            npcHandler:say("... *ela esta desenhando um circulo no chao com um graveto e nao parece querer conversar* ...", cid)
        end
        return true
    end

    -- [TRANSICAO: ENTREGAR A FLOR]
    if msgcontains(msg, 'sim') or msgcontains(msg, 'yes') or msgcontains(msg, 'entrega') or msgcontains(msg, 'dar') then
        if talkState[cid] == 1 then
            if getPlayerItemCount(cid, 2668) >= 1 then 
                doPlayerRemoveItem(cid, 2668, 1)
                npcHandler:say("Uau! Que linda! Voce e muito legal! O meu segredo e este: atras daquela grande arvore morta ao Norte, se voce caminhar entre as pedras cinzentas, ha um esconderijo onde os bandidos guardam as ervas que roubam. Quase ninguem sabe disso! Tome esses moranguinhos que a Tia Yomogi me deu, voce merece!", cid)
                doPlayerAddItem(cid, 2677, 3) 
                talkState[cid] = 0
            else
                npcHandler:say("Ue? Voce disse que tinha mas nao tem nada ai! Nao brinque com os meus sentimentos!", cid)
                talkState[cid] = 0
            end
        else
            npcHandler:say("Sim o que? Voce esta falando sozinho igual ao vovo Genzo? Hihi!", cid)
        end

    elseif msgcontains(msg, 'tulip') or msgcontains(msg, 'flor') then
        npcHandler:say("As tulipas sao as minhas favoritas! Mas elas sao dificeis de achar, ficam escondidas no meio das florestas escuras. Voce por acaso tem uma para me dar?", cid)
        talkState[cid] = 1 

    elseif msgcontains(msg, 'utaka') then
        if questStatus == ISAC_STATUS_HERO or questStatus == ISAC_STATUS_COMPLETE then
            npcHandler:say("O Utaka me contou que voce foi um heroi! Ele disse que voce derrotou monstros gigantes para salva-lo. Agora ele quer treinar ainda mais para ser forte como voce!", cid)
        else
            npcHandler:say("Ele e o meu amigo! O vovo Genzo diz que ele vai ser um ninja forte, mas por enquanto ele so e bom em esconder as minhas sandalias. Voce viu ele por ai?", cid)
        end

    elseif msgcontains(msg, 'isac') then
        npcHandler:say("Ele mora na pousada com o Utaka. Ele tem cara de bravo e as maos cheias de calos, mas ele faz bonecos de madeira lindos para a gente!", cid)

    elseif msgcontains(msg, 'brincar') or msgcontains(msg, 'floresta') then
        npcHandler:say("Eu gosto de brincar perto das arvores de {strawberry}, elas sao docinhas! Mas a mamae diz para eu nao chegar perto das montanhas por causa dos bichos.", cid)
    else
        talkState[cid] = 0 
    end

    return true
end

-- Saudação simples sem lógica complexa
npcHandler:setCallback(CALLBACK_GREET, function(cid)
    local questStatus = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)
    if questStatus == ISAC_STATUS_UTAKA_DEAD or questStatus == ISAC_STATUS_BOTH_DEAD then
        npcHandler:setMessage(MESSAGE_GREET, "... Oi. *ela fala baixinho sem olhar para voce*")
    else
        npcHandler:setMessage(MESSAGE_GREET, "Oii! Voce e um viajante? Sabia que eu conheço todos os esconderijos dessa vila?")
    end
    return true
end)

-- Removemos os outros CALLBACKS (Disappear e Farewell) que tentavam usar o cid no logout
-- O NpcHandler já lida com as mensagens padrão definidas abaixo:
npcHandler:setMessage(MESSAGE_FAREWELL, "Tchauzinho! Se achar alguma {Tulip}, me traga, ta bom?")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ei! Nao corre! Eu ainda tinha tanta coisa para contar!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())