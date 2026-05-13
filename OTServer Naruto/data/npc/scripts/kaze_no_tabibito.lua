local focus = 0
local talk_start = 0

-- CONFIGURACAO DE DESTINO
local destination = {x = 3335, y = 3072, z = 7} -- Vila das Ondas
local cost = 20 

-- STORAGES PARA O RETORNO
local STO_X, STO_Y, STO_Z = 15001, 15002, 15003

function onCreatureDisappear(cid, pos)
    if focus == cid then
        selfSay('Ate logo.', cid)
        focus = 0
        talk_start = 0
        doNpcSetCreatureFocus(0)
    end
end

function onCreatureSay(cid, type, msg)
    local msg = string.lower(msg)
    
    -- Forca a leitura como numero para evitar erros de comparacao
    local playerStorage = tonumber(getPlayerStorageValue(cid, SAGA_STORAGE)) or -1

    -- INICIAR CONVERSA
    if (msgcontains(msg, 'hi') or msgcontains(msg, 'ola')) and (focus == 0) and getDistanceToCreature(cid) < 4 then
        
        -- 1. BLOQUEIO (Se a storage for menor que o valor definido)
        if playerStorage < SAGA_STAGE_FINALLY_A_BREAK then
            selfSay('Eu sinto muito... as aguas para a Vila das Ondas estao tomadas por uma nevoa assassina. Dizem que o Demonio da Nevoa esta cacando quem tenta cruzar o mar. E perigoso demais para voce agora.', cid)
            return true
        end

        -- 2. VIAGEM GRATUITA (Se for exatamente o valor)
        if playerStorage == SAGA_STAGE_FINALLY_A_BREAK then
            selfSay('Seja bem-vindo. Como voce enfrentou grandes perigos, eu o levarei a Vila das Ondas de graca desta vez. Deseja partir? {sim} / {nao}', cid)
        
        -- 3. VIAGEM PAGA (Se for maior que o valor)
        else
            selfSay('Seja bem-vindo. O vento sopra em direcao a {Vila das Ondas}. Voce deseja seguir o fluxo por ' .. cost .. ' moedas? {sim} / {nao}', cid)
        end

        focus = cid
        talk_start = os.clock()
        doNpcSetCreatureFocus(focus)

    elseif focus == cid then
        talk_start = os.clock()

        if msgcontains(msg, 'sim') or msgcontains(msg, 'yes') then
            local isFree = (playerStorage == SAGA_STAGE_FINALLY_A_BREAK)
            
            if isFree or doPlayerRemoveMoney(cid, cost) then
                selfSay('Siga o seu caminho ninja. Que o vento o proteja!', cid)
                
                local pPos = getThingPos(cid)
                setPlayerStorageValue(cid, STO_X, pPos.x)
                setPlayerStorageValue(cid, STO_Y, pPos.y)
                setPlayerStorageValue(cid, STO_Z, pPos.z)

                doSendMagicEffect(pPos, 2)
                doTeleportThing(cid, destination)
                doSendMagicEffect(destination, 10)
                
                focus = 0
                talk_start = 0
                doNpcSetCreatureFocus(0)
            else
                selfSay('Suas moedas nao sao suficientes para a travessia.', cid)
            end

        elseif msgcontains(msg, 'nao') or msgcontains(msg, 'no') then
            selfSay('Entendo. As raizes as vezes sao mais fortes que as asas.', cid)
            focus = 0
            talk_start = 0
            doNpcSetCreatureFocus(0)
        end
    end
end

function onThink()
    if focus ~= 0 then
        if (os.clock() - talk_start) > 30 then
            selfSay('Proximo...', focus)
            focus = 0
            doNpcSetCreatureFocus(0)
        elseif getDistanceToCreature(focus) > 5 then
            selfSay('Ate logo.', focus)
            focus = 0
            doNpcSetCreatureFocus(0)
        end
    end
end