function onDeath(cid, corpse, deathList)
    local monstName = "Ebisu"
    local experience = 30000
    local konohamaruShirt = 2655
    local tunicaChance = 10
    local players = {}

    if isMonster(cid) and getCreatureName(cid):lower() == monstName:lower() then
        
        -- Identifica os jogadores/mestres no deathList
        for _, check in ipairs(deathList) do
            local master = getCreatureMaster(check)
            local target = (master ~= nil and master ~= check) and master or check
            
            if isPlayer(target) then
                -- Evita duplicar o mesmo jogador na tabela caso ele e o pet batam
                local jaExiste = false
                for _, p in ipairs(players) do
                    if p == target then jaExiste = true break end
                end
                
                if not jaExiste then
                    table.insert(players, target)
                end
            end
        end

        for _, player in ipairs(players) do
            if isPlayer(player) then
                -- Seta a storage para a próxima etapa: Encontrar o Jounin
                setPlayerStorageValue(player, SAGA_STORAGE, SAGA_STAGE_MEET_JOUNIN)
                doPlayerAddExp(player, experience)
                doPlayerSendTextMessage(player, 22, "Voce derrotou o Ebisu! Va para a floresta encontrar seu Jounin responsavel.")
                doSendMagicEffect(getThingPos(player), 12) 
                
                -- Chance de drop direto no inventário (Caminho da Força)
                if math.random(1, 100) <= tunicaChance then
                    doPlayerAddItem(player, konohamaruShirt, 1)
                    doPlayerSendTextMessage(player, MESSAGE_EVENT_ORANGE, "Voce ganhou a Camisa do Konohamaru.")
                end

                -- [LOGICA DO KONOHAMARU SUMIR]
                local summons = getCreatureSummons(player)
                if summons and #summons > 0 then
                    for _, summon in ipairs(summons) do
                        if getCreatureName(summon):lower() == "konohamaru" then
                            doCreatureSay(summon, "Incrivel, Chefe! Voce derrotou o Ebisu! Eu vou continuar meu treinamento sozinho por enquanto. Se precisar de mim, estarei na sala do vovo! Ate logo!", TALKTYPE_SAY)
                            addEvent(function() 
                                if isCreature(summon) then 
                                    doSendMagicEffect(getThingPos(summon), 10)
                                    doRemoveCreature(summon) 
                                end 
                            end, 3000)
                        end
                    end
                end
            end
        end
    end 
    return true
end