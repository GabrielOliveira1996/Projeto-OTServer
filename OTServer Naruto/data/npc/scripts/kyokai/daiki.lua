local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

-- Garante que o Nobu sempre olhe para a ESQUERDA (3)
function onThink()
    local npc = getNpcId()
    if isCreature(npc) then
        doCreatureSetLookDir(npc, 3) -- 0: Norte, 1: Leste, 2: Sul, 3: Oeste (Esquerda)
    end
    npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local msg = msg:lower()
    local questStatus = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)
    local dia = os.date("%A")

    -- [INTERAÇÃO: SOBRE A VILA]
    if msgcontains(msg, 'vila') or msgcontains(msg, 'kyokai') then
        npcHandler:say("Kyokai ja foi um lugar mais barulhento, shinobi. Hoje em dia, apenas o vento e os segredos caminham por estas ruas.", cid)

    -- [DIÁLOGOS SOBRE ISAC E UTAKA]
    elseif msgcontains(msg, 'isac') or msgcontains(msg, 'utaka') then
        if questStatus < ISAC_STATUS_START then
            npcHandler:say("Aquele Isac... ele carrega uma dor nos olhos que nem o melhor cha da Yomogi pode curar. E o garoto e muito esperto, esta sempre correndo por ai.", cid)
        elseif questStatus == ISAC_STATUS_HERO or questStatus == ISAC_STATUS_COMPLETE then
            npcHandler:say("Dizem que voce salvou o pequeno Utaka. Meus velhos olhos brilham ao ver os dois caminhando juntos novamente.", cid)
        elseif questStatus == ISAC_STATUS_ISAC_DEAD then
            npcHandler:say("Vi o garoto Utaka chorando perto do rio ontem. O mundo tirou dele a unica familia que ele conheceu.", cid)
        elseif questStatus == ISAC_STATUS_UTAKA_DEAD then
            npcHandler:say("O Isac passou por mim como uma sombra fria. Perder uma crianca e uma ferida que nao fecha nunca.", cid)
        elseif questStatus == ISAC_STATUS_BOTH_DEAD then
            npcHandler:say("O quarto deles na pousada esta vazio. Sinto um arrepio toda vez que passo por la agora.", cid)
        end

    -- [INTERAÇÃO: HISTÓRIAS DO PASSADO POR DIA DA SEMANA]
    elseif msgcontains(msg, 'historia') or msgcontains(msg, 'talk') or msgcontains(msg, 'passado') then
        if dia == "Monday" then
            npcHandler:say("Nas segundas eu me lembro de quando as caravanas de mercadores lotavam nossa entrada. O ouro fluia como a agua do rio.", cid)
        elseif dia == "Wednesday" then
            npcHandler:say("As quartas eram dias de treino. Eu ja fui um shinobi habilidoso como voce, mas o tempo pesou minhas pernas.", cid)
        elseif dia == "Friday" then
            npcHandler:say("Sextas-feiras me lembram das grandes festas de Kyokai. O cheiro da comida do Takeo se espalhava por toda a regiao.", cid)
        elseif dia == "Saturday" or dia == "Sunday" then
            npcHandler:say("Sabia que, ha muitos anos, as pedras ao Norte brilhavam com um azul intenso quando a lua estava cheia? Diziam que eram as lagrimas de um espirito da floresta que se apaixonou por um mortal. O brilho sumiu, mas o frio delas... continua la.", cid)
        else
            npcHandler:say("No meu tempo, as florestas ao Norte eram guardadas por espiritos. Hoje, apenas bandidos e feras vivem por la. Tome cuidado.", cid)
        end
    end

    return true
end

-- [MENSAGENS PADRÃO - GÊNERO MASCULINO]
npcHandler:setMessage(MESSAGE_GREET, "Oh, um rosto novo! Sente-se um pouco, shinobi. Gostaria de ouvir as fofocas de um velho senhor?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Va com calma. A pressa e a inimiga da longevidade.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ue? Minhas historias estao tao chatas assim?")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())