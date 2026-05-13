local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onThink() npcHandler:onThink() end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

-- Variáveis de efeito e falas
local last_talk = 0
local last_effect = 0

function onThink()
    local myPos = getNpcPos()
    
    -- Efeito de fumaça na panela
    if os.time() - last_effect > 3 then
        doSendMagicEffect({x=myPos.x, y=myPos.y, z=myPos.z}, 2) 
        last_effect = os.time()
    end

    -- Falas automáticas da Mei
    if os.time() - last_talk > 40 then
        local falas = {
            "Sinto o cheirinho de tempero fresco no ar!",
            "O restaurante está sempre aberto para quem tem fome e boas histórias.",
            "Um dia ele voltará e encontrará a mesa posta...",
            "*Ela olha para o horizonte por um momento antes de voltar a mexer a panela*"
        }
        selfSay(falas[math.random(#falas)])
        last_talk = os.time()
    end
    
    npcHandler:onThink()
end

-- --- CONFIGURAÇÃO DA LOJA ---
local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'onigiri'}, 2666, 5, 'carne')
shopModule:addBuyableItem({'ramen'}, 2672, 20, 'ramen')
shopModule:addBuyableItem({'cha verde'}, 2006, 10, 7, 'cha verde fresco')

-- --- DIÁLOGOS DE LORE ---
keywordHandler:addKeyword({'historia'}, StdModule.say, {npcHandler = npcHandler, text = "Eu vivia em uma vila minúscula nas montanhas acima de Konoha. Minha vida era simples, até que um viajante de Shizuka passou por lá... Foi amor à primeira vista. Eu deixei tudo para trás para construir um lar com ele aqui."})
keywordHandler:addKeyword({'marido'}, StdModule.say, {npcHandler = npcHandler, text = "Ele era um homem bondoso, mas quando a guerra estourou, ele não pôde ignorar o chamado do campo de batalha. Ele partiu há muitos anos e nunca mais voltou..."})
keywordHandler:addKeyword({'viagem'}, StdModule.say, {npcHandler = npcHandler, text = "Foi o destino, eu acho. Ele estava apenas de passagem, mas levou meu coração com ele para Shizuka."})

-- --- SISTEMA DE DIÁLOGO MANUAL (PRATO DO DIA) ---
function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local talkUser = cid

    if msgcontains(msg, 'prato') or msgcontains(msg, 'especial') then
        selfSay("Preparei um Gyoza especial hoje, custa apenas 50 moedas. Você aceita um pouco, querido?", cid)
        talkState[talkUser] = 1
    elseif talkState[talkUser] == 1 then
        if msgcontains(msg, 'yes') or msgcontains(msg, 'sim') then
            if doPlayerRemoveMoney(cid, 50) then
                doPlayerAddItem(cid, 2671, 1) 
                selfSay("Aqui está, coma enquanto está quente!", cid)
                doSendMagicEffect(getCreaturePosition(cid), 15)
            else
                selfSay("Oh, parece que você não tem moedas suficientes...", cid)
            end
        else
            selfSay("Tudo bem, querido. O menu tradicional também é reconfortante.", cid)
        end
        talkState[talkUser] = 0
    end

    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())