    function onCastSpell(cid, var)
     
    local T = {
    {level = {from = 200, to = 205}, mana = 800, monster = "sasori"},
    {level = {from = 206, to = 1000}, mana = 810, monster = "sasori"},
    }
     
    local monster = nil
     
        for _, V in pairs(T) do
            if(#getCreatureSummons(cid) < 1) then
                if(getPlayerLevel(cid) >= V.level.from and getPlayerLevel(cid) <= V.level.to) then
                    if(getCreatureMana(cid) >= V.mana) then
                        monster = doCreateMonster(V.monster .. "[" .. _ .. "]", getThingPos(cid))
                        doCreatureAddMana(cid, V.mana)
                        doConvinceCreature(cid, monster)
                        registerCreatureEvent(monster, "summon1")
                    end
                end
            end
        end
     
        return true
    end