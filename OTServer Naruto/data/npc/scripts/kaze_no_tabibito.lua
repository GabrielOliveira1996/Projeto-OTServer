local focus = 0
local talk_start = 0

-- CONFIGURAÇÃO
local destination = {x = 3335, y = 3072, z = 7} -- Vila das Ondas
local cost = 100 

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

    -- INICIAR CONVERSA
    if (msgcontains(msg, 'hi') or msgcontains(msg, 'ola')) and (focus == 0) and getDistanceToCreature(cid) < 4 then
        -- Adicionado 'cid' no final para falar no canal correto
        selfSay('Seja bem-vindo, jovem ninja. O vento sopra para a Vila das Ondas. Voce deseja seguir o fluxo por ' .. cost .. ' gold coins? {sim} / {nao}', cid)
        focus = cid
        talk_start = os.clock()
        -- Faz o NPC parar e olhar para o player
        doNpcSetCreatureFocus(focus)

    elseif focus == cid then
        talk_start = os.clock()

        -- ACEITAR VIAGEM
        if msgcontains(msg, 'sim') or msgcontains(msg, 'yes') then
            if doPlayerRemoveMoney(cid, cost) then
                selfSay('Siga o seu caminho ninja. Que o vento o proteja!', cid)
                
                -- SALVA A POSIÇÃO ATUAL ANTES DE IR
                local pPos = getThingPos(cid)
                setPlayerStorageValue(cid, STO_X, pPos.x)
                setPlayerStorageValue(cid, STO_Y, pPos.y)
                setPlayerStorageValue(cid, STO_Z, pPos.z)

                -- TELEPORTE E EFEITOS
                doSendMagicEffect(pPos, 2)
                doTeleportThing(cid, destination)
                doSendMagicEffect(destination, 10)
                
                focus = 0
                talk_start = 0
                doNpcSetCreatureFocus(0)
            else
                selfSay('Suas moedas nao sao suficientes.', cid)
            end

        -- RECUSAR
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
        -- Tempo de espera (30 segundos)
        if (os.clock() - talk_start) > 30 then
            selfSay('Proximo...', focus)
            focus = 0
            doNpcSetCreatureFocus(0)
        -- Se o player se afastar
        elseif getDistanceToCreature(focus) > 5 then
            selfSay('Ate logo.', focus)
            focus = 0
            doNpcSetCreatureFocus(0)
        end
    end
end