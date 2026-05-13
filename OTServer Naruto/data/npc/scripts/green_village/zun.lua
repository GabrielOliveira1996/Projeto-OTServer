local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end

local function greetCallback(cid)
    -- Configuração das mensagens de saída
    npcHandler:setMessage(MESSAGE_FAREWELL, "Va em paz. E tente... tente nao tirar vidas desnecessariamente no caminho de volta.")
    npcHandler:setMessage(MESSAGE_WALKAWAY, "Tao apressado... a natureza nao tem pressa, jovem.")
    
    npcHandler:setMessage(MESSAGE_GREET, "Shhh... Olhe para estes fardos. Cada {tecido verde} desses foi o que restou de uma criatura que voce abateu. Eu os recolho para que a vida dessas criaturas nao sejam tiradas por nada. Voce trouxe materiais para {fabricar} algo?")
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    -- Diálogo sobre o Propósito
    if msgcontains(msg, 'proposito') or msgcontains(msg, 'historia') then
        selfSay("Ninjas costumam ver apenas o inimigo, mas eu vejo a vida. Quando voce luta contra os insetos da vila, as fibras deles ficam impregnadas de chakra.", cid)
        addEvent(selfSay, 3000, "Eu recolho esses retalhos do chao para dar a eles um novo uso. Se voce tiver tecidos, posso costurar pecas que vibram com a energia da natureza.", cid)
    
    -- Menu de Fabricação
    elseif msgcontains(msg, 'fabricar') or msgcontains(msg, 'fazer') or msgcontains(msg, 'itens') then
        selfSay("Minhas agulhas estao prontas. Posso fazer uma {Nature Trousers} por 100 tecidos verdes, ou uma {Nature Gloves} por 80 tecidos. O que deseja que eu costure?", cid)

    -- Nature Trousers
    elseif msgcontains(msg, 'nature trousers') or msgcontains(msg, 'trousers') or msgcontains(msg, 'calça') then
        if getPlayerItemCount(cid, 5910) >= 100 then
            doPlayerRemoveItem(cid, 5910, 100)
            doPlayerAddItem(cid, 2488, 1)
            selfSay("Uma escolha sabia. Esta calca mantem alem da protecao, ela tambem acelera sua recuperacao de chakra. Aqui esta sua Nature Trousers. Honre esse sacrificio.", cid)
            doSendMagicEffect(getCreaturePosition(cid), 10)
        else
            selfSay("Voce nao tem tecidos suficientes. Para a Nature Trousers, eu preciso de exatamente 100 pedacos.", cid)
        end

    elseif msgcontains(msg, 'nature gloves') or msgcontains(msg, 'gloves') or msgcontains(msg, 'luva') then
        if getPlayerItemCount(cid, 5910) >= 80 then
            doPlayerRemoveItem(cid, 5910, 80)
            doPlayerAddItem(cid, 2422, 1)
            selfSay("Sinta a textura... estas luvas ajudarao seus golpes a fluirem como o vento na floresta e vai acelerar sua recuperacao de chakra. Use-as bem, jovem.", cid)
            doSendMagicEffect(getCreaturePosition(cid), 34)
        else
            selfSay("Faltam tecidos. Me traga 80 unidades e eu farei as Nature Gloves para voce.", cid)
        end
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())