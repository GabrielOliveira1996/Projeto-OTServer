local outfit_feminina = 77 -- 
local duration = 10 -- Tempo em segundos que o Naruto fica transformado

function onCastSpell(cid, var)
    if not isPlayer(cid) then return false end

    -- 1. Efeito e Transformação do Naruto
    local myOutfit = getCreatureOutfit(cid)
    local sexyOutfit = {lookType = outfit_feminina, lookHead = myOutfit.lookHead, lookBody = myOutfit.lookBody, lookLegs = myOutfit.lookLegs, lookFeet = myOutfit.lookFeet}
    
    doSetCreatureOutfit(cid, sexyOutfit, duration * 1000)
    doSendMagicEffect(getThingPos(cid), 10) -- Fumaça do Jutsu
    doCreatureSay(cid, "OIROKE NO JUTSU!", TALKTYPE_SAY)

    -- 2. Busca pelo Ebisu em volta do jogador (Raio de 3 SQMs)
    local target = 0
    local spectators = getSpectators(getThingPos(cid), 3, 3, false)
    if spectators then
        for _, spec in ipairs(spectators) do
            if isMonster(spec) and getCreatureName(spec):lower() == "ebisu" then
                target = spec
                break
            end
        end
    end

    -- 3. Lógica Especial caso o Ebisu esteja por perto
    if isCreature(target) then
        -- Ebisu trava de choque
        doCreatureSay(target, "O-O-O QUE E ISSO?! QUE TECNICA VULGAR E ESSA... MEU NARIZ!!!", TALKTYPE_SAY)
        doSendMagicEffect(getThingPos(target), 0) -- Efeito 0 (geralmente exclamação ou choque)
        
        -- Paraliza o Ebisu (tira a velocidade)
        doChangeSpeed(target, -getCreatureSpeed(target)) 
        
        -- Evento após 2 segundos (Ebisu desmaia e a saga avança)
        addEvent(function()
            if isCreature(target) then
                doSendMagicEffect(getThingPos(target), 14) -- Sangue pelo nariz / Fumaça
                doRemoveCreature(target) 
                
                -- Recompensa Lore
                if isPlayer(cid) then
                    setPlayerStorageValue(cid, SAGA_STORAGE, SAGA_STAGE_MEET_JOUNIN)
                    doPlayerAddExp(cid, 45000)
                    doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "GENIAL! Voce usou a fraqueza do Ebisu contra ele mesmo! Voce recebeu um bonus de " .. expBonus .. " de experiencia!")
                    doSendMagicEffect(getThingPos(cid), 12) -- Efeito de Level Up/Sucesso
                    
                    -- Konohamaru também se despede e some
                    local summons = getCreatureSummons(cid)
                    if summons and #summons > 0 then
                        for _, summon in ipairs(summons) do
                            if getCreatureName(summon):lower() == "konohamaru" then
                                doCreatureSay(summon, "CHEFE!! VOCE E REALMENTE O MELHOR! VOU PRATICAR ISSO AGORA MESMO!!", TALKTYPE_SAY)
                                addEvent(function() 
                                    if isCreature(summon) then 
                                        doSendMagicEffect(getThingPos(summon), 10)
                                        doRemoveCreature(summon) 
                                    end 
                                end, 2000)
                            end
                        end
                    end
                end
            end
        end, 2000)
    end

    return true
end