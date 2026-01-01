    function onCastSpell(cid, var)
     
    local T = {
    {level = {from = 30, to = 35}, mana = 30, monster = "kuroari"},
    {level = {from = 36, to = 40}, mana = 40, monster = "kuroari"},
    {level = {from = 41, to = 45}, mana = 50, monster = "kuroari"},
    {level = {from = 46, to = 50}, mana = 60, monster = "kuroari"},
    {level = {from = 51, to = 55}, mana = 70, monster = "kuroari"},
    {level = {from = 56, to = 60}, mana = 80, monster = "kuroari"},
    {level = {from = 61, to = 65}, mana = 90, monster = "kuroari"},
    {level = {from = 66, to = 70}, mana = 100, monster = "kuroari"},
    {level = {from = 71, to = 75}, mana = 110, monster = "kuroari"},
    {level = {from = 76, to = 80}, mana = 120, monster = "kuroari"},
    {level = {from = 81, to = 85}, mana = 130, monster = "kuroari"},
    {level = {from = 86, to = 90}, mana = 140, monster = "kuroari"},
    {level = {from = 91, to = 95}, mana = 150, monster = "kuroari"},
    {level = {from = 96, to = 100}, mana = 160, monster = "kuroari"},
    {level = {from = 101, to = 105}, mana = 170, monster = "kuroari"},
    {level = {from = 106, to = 110}, mana = 180, monster = "kuroari"},
    {level = {from = 111, to = 115}, mana = 190, monster = "kuroari"},
    {level = {from = 116, to = 120}, mana = 200, monster = "kuroari"},
    {level = {from = 121, to = 125}, mana = 210, monster = "kuroari"},
    {level = {from = 126, to = 130}, mana = 220, monster = "kuroari"},
    {level = {from = 131, to = 135}, mana = 230, monster = "kuroari"},
    {level = {from = 136, to = 140}, mana = 240, monster = "kuroari"},
    {level = {from = 141, to = 145}, mana = 250, monster = "kuroari"},
    {level = {from = 146, to = 150}, mana = 260, monster = "kuroari"},
    {level = {from = 151, to = 155}, mana = 270, monster = "kuroari"},
    {level = {from = 156, to = 160}, mana = 280, monster = "kuroari"},
    {level = {from = 161, to = 165}, mana = 290, monster = "kuroari"},
    {level = {from = 166, to = 170}, mana = 300, monster = "kuroari"},
    {level = {from = 171, to = 175}, mana = 310, monster = "kuroari"},
    {level = {from = 176, to = 180}, mana = 320, monster = "kuroari"},
    {level = {from = 181, to = 185}, mana = 330, monster = "kuroari"},
    {level = {from = 186, to = 190}, mana = 340, monster = "kuroari"},
    {level = {from = 191, to = 195}, mana = 350, monster = "kuroari"},
    {level = {from = 196, to = 1000}, mana = 360, monster = "kuroari"},
    }
     
    local monster = nil
     
        for _, V in pairs(T) do
            if(#getCreatureSummons(cid) < 1) then
                if(getPlayerLevel(cid) >= V.level.from and getPlayerLevel(cid) <= V.level.to) then
                    if(getCreatureMana(cid) >= V.mana) then
                        monster = doCreateMonster(V.monster .. "[" .. _ .. "]", getThingPos(cid))
                        doCreatureAddMana(cid, V.mana)
                        doConvinceCreature(cid, monster)
                        registerCreatureEvent(monster, "summon2")
                    end
                end
            end
        end
     
        return true
    end