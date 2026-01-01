    function onCastSpell(cid, var)
     
    local T = {
    {level = {from = 120, to = 125}, mana = 400, monster = "sanshouou"},
    {level = {from = 126, to = 130}, mana = 410, monster = "sanshouou"},
    {level = {from = 131, to = 135}, mana = 420, monster = "sanshouou"},
    {level = {from = 136, to = 140}, mana = 430, monster = "sanshouou"},
    {level = {from = 141, to = 145}, mana = 440, monster = "sanshouou"},
    {level = {from = 146, to = 150}, mana = 450, monster = "sanshouou"},
    {level = {from = 151, to = 155}, mana = 460, monster = "sanshouou"},
    {level = {from = 156, to = 160}, mana = 470, monster = "sanshouou"},
    {level = {from = 161, to = 165}, mana = 480, monster = "sanshouou"},
    {level = {from = 166, to = 170}, mana = 490, monster = "sanshouou"},
    {level = {from = 171, to = 175}, mana = 500, monster = "sanshouou"},
    {level = {from = 176, to = 180}, mana = 510, monster = "sanshouou"},
    {level = {from = 181, to = 185}, mana = 520, monster = "sanshouou"},
    {level = {from = 186, to = 190}, mana = 530, monster = "sanshouou"},
    {level = {from = 191, to = 195}, mana = 540, monster = "sanshouou"},
    {level = {from = 196, to = 200}, mana = 550, monster = "sanshouou"},
    {level = {from = 201, to = 205}, mana = 560, monster = "sanshouou"},
    {level = {from = 206, to = 210}, mana = 570, monster = "sanshouou"},
    {level = {from = 211, to = 215}, mana = 580, monster = "sanshouou"},
    {level = {from = 216, to = 1000}, mana = 590, monster = "sanshouou"},
    }
     
    local monster = nil
     
        for _, V in pairs(T) do
            if(#getCreatureSummons(cid) < 1) then
                if(getPlayerLevel(cid) >= V.level.from and getPlayerLevel(cid) <= V.level.to) then
                    if(getCreatureMana(cid) >= V.mana) then
                        monster = doCreateMonster(V.monster .. "[" .. _ .. "]", getThingPos(cid))
                        doCreatureAddMana(cid, V.mana)
                        doConvinceCreature(cid, monster)
                        registerCreatureEvent(monster, "summon3")
                    end
                end
            end
        end
     
        return true
    end