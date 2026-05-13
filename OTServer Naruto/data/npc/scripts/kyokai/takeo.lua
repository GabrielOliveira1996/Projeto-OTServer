local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local msg = msg:lower()
    local questStatus = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)

    -- [DIÁLOGOS SOBRE ISAC E UTAKA]
    if msgcontains(msg, 'isac') or msgcontains(msg, 'utaka') then
        if questStatus < ISAC_STATUS_START then
            npcHandler:say("O Isac? Ele costuma pedir o prato mais simples do cardapio. Homem de habitos severos. Ja o pequeno Utaka adora meus doces de morango.", cid)
        elseif questStatus == ISAC_STATUS_HERO or questStatus == ISAC_STATUS_COMPLETE then
            npcHandler:say("Gracas aos ceus voce trouxe o menino de volta! Voce e um heroi!", cid)
        elseif questStatus == ISAC_STATUS_ISAC_DEAD then
            npcHandler:say("A cadeira do Isac esta vazia hoje. O Utaka veio buscar comida, mas nem tocou no tempero... triste.", cid)
        elseif questStatus == ISAC_STATUS_UTAKA_DEAD then
            npcHandler:say("O Isac passou por aqui hoje. Ele pediu apenas agua. Perder o apetite e o primeiro sinal de uma alma quebrada.", cid)
        elseif questStatus == ISAC_STATUS_BOTH_DEAD then
            npcHandler:say("Ninguem mais ocupa aquela mesa no canto. Kyokai ficou mais amarga sem eles.", cid)
        end
    end

    return true
end

-- [MENSAGENS PADRÃO (SEMPRE ABA NPC)]
npcHandler:setMessage(MESSAGE_GREET, "Bem-vindo ao Sabor de Kyokai! Esta com fome, shinobi? Tenho pratos que recuperariam ate um Kage cansado!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Bom apetite e tome cuidado com as estradas!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ei! Volte quando a fome apertar!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())