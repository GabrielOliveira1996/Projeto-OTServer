function onCastSpell(cid, var)
    local playerName = getCreatureName(cid)
    local cloth = getCreatureOutfit(cid)
    local playerLevel = getPlayerLevel(cid)
    local summons = getCreatureSummons(cid)
    local getSkill = getPlayerSkillLevel(cid, 6)
    local getMana = getCreatureMana(cid)
    local playerSpeed = getCreatureSpeed(cid)
    
    -- controle de nivel.
    local MaxSummon = 1 
    if playerLevel >= 40 then
        MaxSummon = 4
    elseif playerLevel >= 30 then
        MaxSummon = 3
    elseif playerLevel >= 20 then
        MaxSummon = 2
    end

    local totalManaExpenditure = 80
    local calc = math.min(totalManaExpenditure / 2, -totalManaExpenditure + getSkill)

    if getPlayerVocation(cid) == 37 or getPlayerVocation(cid) == 39 or getPlayerVocation(cid) == 40 then
        if (table.maxn(summons) < MaxSummon) then
            if (getMana >= (totalManaExpenditure - getSkill)) then    
                
                -- verifica posição livre próximo ao player.
                local playerpos = getPlayerPosition(cid)
                local spawnPos = getClosestFreeTile(cid, playerpos)
                
                -- se não houver nenhum espaço em um 1 quadrado de distância da erro.
                if not spawnPos or (getTilePzInfo(spawnPos)) then
                    doPlayerSendCancel(cid, "There is not enough room to summon a Bunshin.")
                    doSendMagicEffect(playerpos, 2)
                    return false
                end

                local clone = doCreateMonster("bunshin", spawnPos, playerName)
                
                -- verifica se foi sumonado.
                if(isCreature(clone)) then
                    --doSetCreatureName(clone, playerName, "a " .. playerName);
                    doPlayerAddMana(cid, calc);
                    doConvinceCreature(cid, clone);
                    doSetCreatureOutfit(clone, cloth, -1);
                    -- aplicando velocidade do plater ao summon.
                    local currentCloneSpeed = getCreatureSpeed(clone)
                    doChangeSpeed(clone, -currentCloneSpeed + playerSpeed);
                    doSendMagicEffect(spawnPos, 2);
                    return true
                else
                    doPlayerSendCancel(cid, "There is not enough room to summon a Bunshin.")
                    return false
                end
            else
                doPlayerSendCancel(cid, "You need " .. totalManaExpenditure - getSkill .. " chakra to use this jutsu.")
            end
        else
            doPlayerSendCancel(cid, "Your current level only allows " .. MaxSummon .. " Bunshins.")
        end
    else
        doPlayerSendCancel(cid, "You cannot use Bunshins in Kyuubi form.")
    end
    return false
end