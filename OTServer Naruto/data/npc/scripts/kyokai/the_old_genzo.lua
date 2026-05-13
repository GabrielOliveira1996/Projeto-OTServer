local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

local lastGreet = 0
function onThink()
    local npc = getNpcId()
    local pos = getCreaturePosition(npc)
    local players = getSpectators(pos, 4, 4, false)
    
    if players then
        for _, cid in ipairs(players) do
            -- Safe Check: Verifica se a criatura ainda existe antes de medir distância
            if isPlayer(cid) and isCreature(cid) then
                if not npcHandler:isFocused(cid) then
                    local playerPos = getCreaturePosition(cid)
                    if playerPos then -- Garante que a posição é válida
                        local dist = getDistanceBetween(playerPos, pos)
                        if dist >= 3 and os.time() > lastGreet + 10 then
                            selfSay("Eii! Quem e voce? Pare ai mesmo!")
                            lastGreet = os.time()
                        elseif dist <= 1 and os.time() > lastGreet + 5 then
                            selfSay("Oh... mil perdoes. Minha vista ja nao e a mesma. Chegue mais perto.")
                            lastGreet = os.time() + 10
                        end
                    end
                end
            end
        end
    end
    npcHandler:onThink()
end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local msg = msg:lower()
    local dia = os.date("%A")
    local questStatus = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)

    if msgcontains(msg, 'isac') or msgcontains(msg, 'hospede') then
        if questStatus < ISAC_STATUS_START then
            npcHandler:say("Um tal de Isac? Acho que vi um sujeito de cabelo esquisito entrando na pousada da Yomogi meses atras.", cid)
        elseif questStatus == ISAC_STATUS_HERO or questStatus == ISAC_STATUS_COMPLETE then
            npcHandler:say("Aquele Isac... vi ele passando com o garoto ontem. Sabia que uma vez eu vi o Isac derrubar uma arvore com o olhar?", cid)
        elseif questStatus == ISAC_STATUS_ISAC_DEAD then
            npcHandler:say("O Isac se foi, nao e? Uma pena. Agora so vejo o pequeno Utaka andando por ai com os olhos fundos.", cid)
        elseif questStatus == ISAC_STATUS_UTAKA_DEAD then
            npcHandler:say("Pobre Isac. Perder o garoto foi como tirar o sol do dia dele.", cid)
        elseif questStatus == ISAC_STATUS_BOTH_DEAD then
            npcHandler:say("A pousada ficou silenciosa... Sabe, shinobi, a morte e como um nevoeiro que nunca dissipa.", cid)
        end
    elseif msgcontains(msg, 'historia') or msgcontains(msg, 'rumor') then
        if dia == "Monday" then
            npcHandler:say("Sabia que nas segundas as rochas ao norte da vila criam pernas e caminham?", cid)
        elseif dia == "Wednesday" then
            npcHandler:say("Dizem que no topo da montanha leste vive um dragao que so come rabanetes!", cid)
        elseif dia == "Friday" then
            npcHandler:say("Escute bem... as sextas o vento sopra diferente. Procure nas raizes da arvore solitaria ao Norte!", cid)
        else
            npcHandler:say("Uma vez eu peguei um peixe tao grande que tive que usar a vila inteira como isca!", cid)
        end
    end
    return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hm? Quem... quem esta ai? *aperta os olhos* Ah! Um shinobi! O que traz voce ate Kyokai?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Va com cuidado. E se vir um coelho de duas cabecas, nao aceite conselhos dele!")
-- Mensagem nativa para quando o player desloga ou se afasta
npcHandler:setMessage(MESSAGE_WALKAWAY, "Ue? Ja foi? Ei! Voce ainda esta ai? Jovens somem como fumaca...")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())