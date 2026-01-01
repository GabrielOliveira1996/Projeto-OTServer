    function onCastSpell(cid, var)
     
    local T = {
    {level = {from = 10, to = 15}, mana = 30, monster = "akamaru"},
    {level = {from = 16, to = 20}, mana = 40, monster = "akamaru"},
    {level = {from = 21, to = 25}, mana = 50, monster = "akamaru"},
    {level = {from = 26, to = 30}, mana = 60, monster = "akamaru"},
    {level = {from = 31, to = 35}, mana = 70, monster = "akamaru"},
    {level = {from = 36, to = 40}, mana = 80, monster = "akamaru"},
    {level = {from = 41, to = 45}, mana = 90, monster = "akamaru"},
    {level = {from = 46, to = 50}, mana = 100, monster = "akamaru"},
    {level = {from = 51, to = 55}, mana = 110, monster = "akamaru"},
    {level = {from = 56, to = 60}, mana = 120, monster = "akamaru"},
    {level = {from = 61, to = 65}, mana = 130, monster = "akamaru"},
    {level = {from = 66, to = 70}, mana = 140, monster = "akamaru"},
    {level = {from = 71, to = 75}, mana = 150, monster = "akamaru"},
    {level = {from = 76, to = 80}, mana = 160, monster = "akamaru"},
    {level = {from = 81, to = 85}, mana = 170, monster = "akamaru"},
    {level = {from = 86, to = 90}, mana = 180, monster = "akamaru"},
    {level = {from = 91, to = 95}, mana = 190, monster = "akamaru"},
    {level = {from = 96, to = 100}, mana = 200, monster = "akamaru"},
    {level = {from = 101, to = 105}, mana = 210, monster = "akamaru"},
    {level = {from = 106, to = 110}, mana = 220, monster = "akamaru"},
    {level = {from = 111, to = 115}, mana = 230, monster = "akamaru"},
    {level = {from = 116, to = 120}, mana = 240, monster = "akamaru"},
    {level = {from = 121, to = 125}, mana = 250, monster = "akamaru"},
    {level = {from = 126, to = 130}, mana = 260, monster = "akamaru"},
    {level = {from = 131, to = 135}, mana = 270, monster = "akamaru"},
    {level = {from = 136, to = 140}, mana = 280, monster = "akamaru"},
    {level = {from = 141, to = 145}, mana = 290, monster = "akamaru"},
    {level = {from = 146, to = 150}, mana = 300, monster = "akamaru"},
    {level = {from = 151, to = 155}, mana = 310, monster = "akamaru"},
    {level = {from = 156, to = 160}, mana = 320, monster = "akamaru"},
    {level = {from = 161, to = 165}, mana = 330, monster = "akamaru"},
    {level = {from = 166, to = 170}, mana = 340, monster = "akamaru"},
    {level = {from = 171, to = 175}, mana = 350, monster = "akamaru"},
    {level = {from = 176, to = 180}, mana = 360, monster = "akamaru"},
    {level = {from = 181, to = 185}, mana = 370, monster = "akamaru"},
    {level = {from = 186, to = 190}, mana = 380, monster = "akamaru"},
    {level = {from = 191, to = 195}, mana = 390, monster = "akamaru"},
    {level = {from = 196, to = 1000}, mana = 400, monster = "akamaru"},
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