function onCastSpell(cid, var)
    local cloth = getCreatureOutfit(cid)
    local MaxSummon = 4 
    local summons = getCreatureSummons(cid)
    local getSkill = getPlayerSkillLevel(cid, 6)
    local getMana = getCreatureMana(cid)
    local totalManaExpenditure = 120
    local calc = math.min(totalManaExpenditure / 2, -totalManaExpenditure + getSkill)
    local playerpos = getPlayerPosition(cid)

    if getPlayerVocation(cid) == 37 or getPlayerVocation(cid) == 39 or getPlayerVocation(cid) == 40 then
        if (table.maxn(summons) < MaxSummon) then
            if (getMana >= (totalManaExpenditure - getSkill)) then  
                for i = 1, MaxSummon do
                    local clone1 = doCreateMonster("tajuu bunshin", playerpos)
                    doConvinceCreature(cid, clone1)
                    doSetCreatureOutfit(clone1, cloth, -1)
                end
                doPlayerAddMana(cid, calc);
                doSendMagicEffect(playerpos, 2)
                return true
            else
                doPlayerSendCancel(cid, "You need " .. totalManaExpenditure - getSkill .. " chakra to use this jutsu.")
            end
        else
            doPlayerSendCancel(cid,"You can't summon more than four Bunshins.")
        end
    else
        doPlayerSendCancel(cid, "You cannot use Bunshins in Kyuubi form.")
    end
end