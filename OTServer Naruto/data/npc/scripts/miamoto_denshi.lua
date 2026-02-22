local focus = 0
local talk_start = 0

-- CONFIGURAÇÃO
local destination = {x=3302, y=3057, z=7} -- Destino Principal
local cost = 100 

-- STORAGES PARA O RETORNO (X, Y, Z)
local STO_X = 15001
local STO_Y = 15002
local STO_Z = 15003

function onCreatureDisappear(cid, pos)
    if focus == cid then
        selfSay('Ate logo.', cid)
        focus = 0
        talk_start = 0
    end
end

function onCreatureSay(cid, type, msg)
    local msg = string.lower(msg)

    -- INICIAR CONVERSA
    if (msgcontains(msg, 'hi') or msgcontains(msg, 'ola')) and (focus == 0) and getDistanceToCreature(cid) < 4 then
        -- O SEGUNDO PARÂMETRO 'cid' FAZ ELE FALAR NO CANAL DO NPC
        selfSay('Seja bem-vindo. O vento sopra para o Pais da Folha. Voce deseja ir por ' .. cost .. ' moedas? {sim} / {nao}', cid)
        
        focus = cid
        talk_start = os.clock()
        -- TRAVA O NPC PARA OLHAR PARA O PLAYER
        doNpcSetCreatureFocus(focus)

    elseif focus == cid then
        talk_start = os.clock()

        -- ACEITAR VIAGEM
        if msgcontains(msg, 'sim') or msgcontains(msg, 'yes') then
            if doPlayerRemoveMoney(cid, cost) then
                selfSay('Siga o seu caminho ninja. Que o vento o proteja!', cid)
                
                -- SALVA A POSIÇÃO ATUAL ANTES DE IR (Para poder voltar depois)
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

        -- RECUSAR OU VOLTAR
        elseif msgcontains(msg, 'nao') or msgcontains(msg, 'no') then
            selfSay('Entendo. Estarei aqui se mudar de ideia.', cid)
            focus = 0
            talk_start = 0
            doNpcSetCreatureFocus(0)
        end
    end
end

function onThink()
    -- LIMITE DE TEMPO POR FALTA DE RESPOSTA
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