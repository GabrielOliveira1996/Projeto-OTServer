local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

-- Garante que ela sempre olhe para a DIREITA (1) e processa o handler
function onThink() 
    doCreatureSetLookDir(getNpcId(), 1)
    npcHandler:onThink() 
end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end

    local msg = msg:lower()
    local dia = os.date("%A")
    local questStatus = getPlayerStorageValue(cid, STORAGE_MISSION_ISAC)
    local hasRead = getPlayerStorageValue(cid, STORAGE_NPC_YOMOGI_READ)

    -- [INTERAÇÃO: ISAC OU UTAKA]
    if msgcontains(msg, 'isac') or msgcontains(msg, 'utaka') then
        
        if questStatus < ISAC_STATUS_START then
            npcHandler:say("Voce fala de um nome que ainda nao parece carregar no peito. O Isac e um dos meus hospedes mais antigos, ja falou com ele hoje?", cid)
            return true
        end

        -- [CENÁRIO 1: AMBOS SOBREVIVERAM]
        if questStatus == ISAC_STATUS_HERO or questStatus == ISAC_STATUS_COMPLETE then
            if hasRead < 1 then
                npcHandler:say("Ah, entao voce e o shinobi de quem todos falam! Gracas a voce, o Isac parece bem mais feliz. Cuidar do pequeno Utaka aqui na pousada fez eles criarem um laco muito forte... parecem pai e filho.", cid)
                setPlayerStorageValue(cid, STORAGE_NPC_YOMOGI_READ, 1)
            else
                npcHandler:say("E muito bom ver o Isac e o Utaka treinando juntos no patio da pousada. Eles finalmente encontraram a paz que tanto buscavam desde que sairam de Konoha.", cid)
            end

        -- [CENÁRIO 2: APENAS ISAC MORREU]
        elseif questStatus == ISAC_STATUS_ISAC_DEAD then
            npcHandler:say("O pequeno Utaka... meu coraçao se aperta toda vez que o vejo sentado na varanda da pousada. O Isac deu a vida por aquele menino, e agora o quarto dele permanece em um silencio doloroso.", cid)

        -- [CENÁRIO 3: APENAS UTAKA MORREU]
        elseif questStatus == ISAC_STATUS_UTAKA_DEAD then
            npcHandler:say("Olhe so para ele... O Isac voltou a ser uma sombra silenciosa pelos corredores da pousada. Ele limpa aquele pergaminho de poeira horas a fio, olhando para o vazio.", cid)

        -- [CENÁRIO 4: AMBOS MORRERAM]
        elseif questStatus == ISAC_STATUS_BOTH_DEAD then
            npcHandler:say("A pousada parece tao vazia agora. Sem o Isac e sem o riso do Utaka, resta apenas o silencio nos quartos e o cheiro de cha frio.", cid)
        
        else
            npcHandler:say("O Isac e um homem teimoso, mas o Utaka trouxe uma luz nova para os dias dele aqui na pousada. Espero que o destino seja gentil com aqueles dois.", cid)
        end

    -- [INTERAÇÃO: CULTIVO / ITENS MEDICINAIS]
    elseif msgcontains(msg, 'cultivo') or msgcontains(msg, 'planta') or msgcontains(msg, 'medicina') then
        npcHandler:say("Se voce busca ervas, veio ao lugar certo. Saindo da vila e seguindo para o norte, as terras sao muito ricas em itens medicinais. Voce pode encontrar {strawberrys}, {mushrooms} e ate mesmo a rara {tulip}.", cid)

    elseif msgcontains(msg, 'strawberry') then
        npcHandler:say("As moranguinhas sao faceis de ver! Elas crescem em pequenas arvores frutiferas. Se quiser colher muitas, procure em campos abertos, pois elas gostam de ficar bem afastadas das montanhas.", cid)

    elseif msgcontains(msg, 'mushroom') then
        npcHandler:say("Os cogumelos gostam de sombra e umidade. Eles sao encontrados sempre encostados nas paredes das montanhas. Se der sorte, pode encontrar ate 3 deles crescendo bem juntinhos no mesmo lugar!", cid)

    elseif msgcontains(msg, 'tulip') then
        npcHandler:say("Ah, as tulipas... sao flores muito raras e valiosas. Elas existem em maior abundancia la para o Pais do Som. Aqui na nossa regiao elas sao escassas, mas se procurar bem no meio das florestas fechadas, podera encontrar algumas.", cid)

    -- [OUTROS DIÁLOGOS DE DIA DA SEMANA]
    elseif msgcontains(msg, 'conversa') or msgcontains(msg, 'talk') then
        if dia == "Monday" then
            npcHandler:say("Segundas-feiras sao sempre barulhentas aqui na pousada. E o dia de organizar os mantimentos, e o Utaka insiste em ajudar com as malas dos viajantes. Haha.", cid)
        elseif dia == "Wednesday" then
            npcHandler:say("As quartas o pequeno Utaka costumava subir aqui para me ajudar com o jardim. Ele diz que o Isac o ensinou que ninjas tambem precisam apreciar a beleza das coisas.", cid)
        elseif dia == "Sunday" then
            if questStatus == ISAC_STATUS_HERO or questStatus == ISAC_STATUS_COMPLETE then
                npcHandler:say("Domingos sao dias de calmaria. Geralmente o Isac e o Utaka ficam na sala comum da pousada e ele conta historias de guerra para o pequeno... espero que ele pule as partes mais sombrias.", cid)
            elseif questStatus == ISAC_STATUS_BOTH_DEAD then
                npcHandler:say("Domingos costumam ser dias de historias e risadas na sala de estar... agora, o silencio da pousada parece pesar mais do que o normal. Sinto falta deles.", cid)
            elseif questStatus == ISAC_STATUS_ISAC_DEAD then
                npcHandler:say("Os domingos na pousada ficaram tristes. Eu vejo o pequeno Utaka sentado sozinho na varanda, esperando por historias que o Isac nao podera mais contar.", cid)
            elseif questStatus == ISAC_STATUS_UTAKA_DEAD then
                npcHandler:say("O Isac ja nao sai do quarto aos domingos. Antigamente ele tomava cha aqui fora com o menino... agora ele apenas observa a estrada em silencio.", cid)
            else
                npcHandler:say("Domingos costumam ser quietos aqui na pousada, mas sinto que uma tempestade ronda o destino dos meus hospedes. Espero que fiquem bem.", cid)
            end
        else
            npcHandler:say("Apenas o vento soprando pelos quartos. As vezes o silencio diz mais do que qualquer fofoca. Hihi.", cid)
        end
    end

    return true
end

-- Mensagens padrão de saída (seguras para logout)
npcHandler:setMessage(MESSAGE_FAREWELL, "Ate logo, Shinobi. Se cuida.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Va com cuidado, as estradas estao perigosas para os viajantes...")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())