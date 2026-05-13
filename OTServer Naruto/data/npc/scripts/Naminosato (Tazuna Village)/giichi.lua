local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

-- Variáveis de controle de fala aleatória (Gritos continuam no Local/White)
local talk_interval = 30 
local last_talk = 0

function onThink()
    npcHandler:onThink()
    
    if os.time() - last_talk >= talk_interval then
        last_talk = os.time()
        if npcHandler.focus == 0 then
            local gritos = {
                "Essas aguas estao ficando perigosas... o [trabalho] de pesca anda muito fraco pro aqui.",
                "Onde estara o [Tazuna]? Aquele velho nao deveria demorar tanto.",
                "A movimentacao esta estranha hoje... acho que o [Gato] esta tramando algo."
            }
            selfSay(gritos[math.random(#gritos)])
        end
    end
end

-- Função de saudação (Vai para a aba NPC)
function onGreet(cid)
    local saudacoes = {
        "Ora, ora... um rosto novo. O que te traz a este lugar esquecido? Quer saber sobre o [trabalho]?",
        "Shhh! Fale baixo, forasteiro. As paredes têm ouvidos por aqui. Veio atras do [Tazuna]?",
        "Voce nao parece um dos homens do Gato. Esta perdido ou veio ajudar com a [ponte]?"
    }
    
    -- Adiciona o foco primeiro
    npcHandler:addFocus(cid)
    
    -- npcHandler:say com o cid envia a mensagem para o canal NPC
    npcHandler:say(saudacoes[math.random(#saudacoes)], cid)
    
    return false -- False evita que o sistema envie o "Hi" padrão do XML/Lib
end

-- Função de despedida (Vai para a aba NPC)
function onFarewell(cid)
    local despedidas = {
        "Va com cuidado... a nevoa esconde muitos perigos.",
        "Mantenha a cabeça baixa, ou os homens do Gato vao te notar.",
        "Espero que na proxima vez que nos virmos, a ponte esteja pronta.",
        "Adeus, shinobi. Que a sorte te acompanhe."
    }
    npcHandler:say(despedidas[math.random(#despedidas)], cid)
    npcHandler:releaseFocus(cid)
    return true
end

-- Registrar as funções
npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_FAREWELL, onFarewell)

-- --- ASSUNTOS (KeywordHandler já envia para a aba NPC por padrão) ---
keywordHandler:addKeyword({'trabalho'}, StdModule.say, {npcHandler = npcHandler, text = "Antigamente o mar nos sustentava. Hoje, se jogamos uma rede, o Gato cobra um imposto abusivo."})
keywordHandler:addKeyword({'tazuna'}, StdModule.say, {npcHandler = npcHandler, text = "O Tazuna e um teimoso. Construir aquela ponte e o mesmo que desenhar um alvo nas costas."})
keywordHandler:addKeyword({'gato'}, StdModule.say, {npcHandler = npcHandler, text = "Fale baixo! Se algum capanga dele ouve voce citando o nome dele... voce esta frito."})
keywordHandler:addKeyword({'ponte'}, StdModule.say, {npcHandler = npcHandler, text = "A Grande Ponte Naruto... se ela for terminada, o Gato perdera o controle sobre nos."})

npcHandler:addModule(FocusModule:new())