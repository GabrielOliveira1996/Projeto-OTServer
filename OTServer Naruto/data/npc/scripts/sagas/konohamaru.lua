local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

function onThink() 
    npcHandler:onThink() 
end

function onGreet(cid)
    local playerName = getCreatureName(cid)
    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    if status == -1 or not status then status = 0 end
    
    -- Verifica se já possui o summon Konohamaru
    local hasSummon = false
    local summons = getCreatureSummons(cid)
    if summons and #summons > 0 then
        for _, summon in ipairs(summons) do
            if getCreatureName(summon):lower() == "konohamaru" then
                hasSummon = true
                break
            end
        end
    end

    if status == (SAGA_STAGE_HOKAGE_GRANDSON or 7) then
        if hasSummon then
            npcHandler:setMessage(MESSAGE_GREET, "O que foi, Chefe? Ja estou te seguindo! Vamos logo para a {sauna}, o material de referencia nao vai se olhar sozinho!")
        else
            npcHandler:setMessage(MESSAGE_GREET, "Ai, ai, ai... meu nariz! Ei, voce! Foi voce que colocou esse {tropeco} no meu caminho para eu nao derrotar o vovo?!")
        end
    elseif status >= (SAGA_STAGE_EBISU_CHALLENGE or 8) then
        npcHandler:setMessage(MESSAGE_GREET, "Ei Chefe! Algum dia eu vou te superar! O Ebisu ja aprendeu a licao dele.")
    else
        npcHandler:setMessage(MESSAGE_GREET, "Saia da frente! Eu sou o neto do Honoravel Terceiro!")
    end

    npcHandler:addFocus(cid)
    return true
end

function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then return false end

    local message = msg:lower()
    local status = getPlayerStorageValue(cid, SAGA_STORAGE)
    if status == -1 or not status then status = 0 end

    -- [ ETAPA: CONHECENDO O NARUTO ]
    if msgcontains(message, 'tropeco') or msgcontains(message, 'caiu') then
        if status == (SAGA_STAGE_HOKAGE_GRANDSON or 7) then
            doCreatureSay(getNpcCid(), "Nao tente negar! Eu ia derrotar o Velho hoje... mas aquele seu {jutsu} ou sua presenca me atrapalhou!", TALKTYPE_SAY)
            return true
        end

    -- [ ETAPA: PEDINDO TREINO ]
    elseif msgcontains(message, 'jutsu') or msgcontains(message, 'treinar') then
        if status == (SAGA_STAGE_HOKAGE_GRANDSON or 7) then
            doCreatureSay(getNpcCid(), "Aquela tecnica que voce usou no vovo... foi a coisa mais incrivel e sacana que eu ja vi! Por favor, voce TEM que me ensinar! Seja o meu {sensei}, por favor!", TALKTYPE_SAY)
            return true
        end

    -- [ ETAPA: ACEITANDO O TREINO (SUMMON) ]
    elseif msgcontains(message, 'sensei') or msgcontains(message, 'sim') or msgcontains(message, 'sauna') then
        if status == (SAGA_STAGE_HOKAGE_GRANDSON or 7) then
            
            -- Verifica se já possui o summon Konohamaru ANTES de tentar criar
            local hasSummon = false
            local summons = getCreatureSummons(cid)
            if summons and #summons > 0 then
                for _, summon in ipairs(summons) do
                    if getCreatureName(summon):lower() == "konohamaru" then
                        hasSummon = true
                        break
                    end
                end
            end

            -- Se já tiver o summon, apenas orienta e não faz nada
            if hasSummon then
                doCreatureSay(getNpcCid(), "Eu ja estou com voce, Chefe! Pare de enrolar e vamos para a {sauna} logo!", TALKTYPE_SAY)
                npcHandler:releaseFocus(cid)
                return true
            end

            -- Se NÃO tiver o summon, cria um novo
            doCreatureSay(getNpcCid(), "ISSOOO! Voce e demais, Chefe! Vamos para a {sauna} ao sul para eu coletar material de pesquisa! Eu vou logo atras de voce!", TALKTYPE_SAY)
            
            local spawnPos = getClosestFreeTile(cid, getCreaturePosition(cid))
            local konoSummon = doCreateMonster("Konohamaru", spawnPos)
            
            if isCreature(konoSummon) then
                doConvinceCreature(cid, konoSummon)
                doSendMagicEffect(spawnPos, 10) 
                doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Konohamaru agora e seu discipulo! Leve-o ate a entrada da sauna ao sul da vila.")
            else
                doPlayerSendTextMessage(cid, 22, "Erro: O monstro 'Konohamaru' nao foi encontrado no servidor.")
            end

            npcHandler:releaseFocus(cid)
            return true
        end
    end

    return true
end

npcHandler:setCallback(CALLBACK_GREET, onGreet)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())