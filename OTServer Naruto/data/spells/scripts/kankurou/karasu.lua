    function onCastSpell(cid, var) 



    local T = {
    {level = {from = 10, to = 15}, mana = 30, monster = "karasu"},
    {level = {from = 16, to = 20}, mana = 40, monster = "karasu"},
    {level = {from = 21, to = 25}, mana = 50, monster = "karasu"},
    {level = {from = 26, to = 30}, mana = 60, monster = "karasu"},
    {level = {from = 31, to = 35}, mana = 70, monster = "karasu"},
    {level = {from = 36, to = 40}, mana = 80, monster = "karasu"},
    {level = {from = 41, to = 45}, mana = 90, monster = "karasu"},
    {level = {from = 46, to = 50}, mana = 100, monster = "karasu"},
    {level = {from = 51, to = 55}, mana = 110, monster = "karasu"},
    {level = {from = 56, to = 60}, mana = 120, monster = "karasu"},
    {level = {from = 61, to = 65}, mana = 130, monster = "karasu"},
    {level = {from = 66, to = 70}, mana = 140, monster = "karasu"},
    {level = {from = 71, to = 75}, mana = 150, monster = "karasu"},
    {level = {from = 76, to = 80}, mana = 160, monster = "karasu"},
    {level = {from = 81, to = 85}, mana = 170, monster = "karasu"},
    {level = {from = 86, to = 90}, mana = 180, monster = "karasu"},
    {level = {from = 91, to = 95}, mana = 190, monster = "karasu"},
    {level = {from = 96, to = 100}, mana = 200, monster = "karasu"},
    {level = {from = 101, to = 105}, mana = 210, monster = "karasu"},
    {level = {from = 106, to = 110}, mana = 220, monster = "karasu"},
    {level = {from = 111, to = 115}, mana = 230, monster = "karasu"},
    {level = {from = 116, to = 120}, mana = 240, monster = "karasu"},
    {level = {from = 121, to = 125}, mana = 250, monster = "karasu"},
    {level = {from = 126, to = 130}, mana = 260, monster = "karasu"},
    {level = {from = 131, to = 135}, mana = 270, monster = "karasu"},
    {level = {from = 136, to = 140}, mana = 280, monster = "karasu"},
    {level = {from = 141, to = 145}, mana = 290, monster = "karasu"},
    {level = {from = 146, to = 150}, mana = 300, monster = "karasu"},
    {level = {from = 151, to = 155}, mana = 310, monster = "karasu"},
    {level = {from = 156, to = 160}, mana = 320, monster = "karasu"},
    {level = {from = 161, to = 165}, mana = 330, monster = "karasu"},
    {level = {from = 166, to = 170}, mana = 340, monster = "karasu"},
    {level = {from = 171, to = 175}, mana = 350, monster = "karasu"},
    {level = {from = 176, to = 180}, mana = 360, monster = "karasu"},
    {level = {from = 181, to = 185}, mana = 370, monster = "karasu"},
    {level = {from = 186, to = 190}, mana = 380, monster = "karasu"},
    {level = {from = 191, to = 195}, mana = 390, monster = "karasu"},
    {level = {from = 196, to = 200}, mana = 400, monster = "karasu"},
    {level = {from = 201, to = 205}, mana = 400, monster = "karasu"},
    {level = {from = 206, to = 1000}, mana = 400, monster = "karasu", nosummon = "karasu"},
    }
     
    local monster = nil    
    
        for _, V in pairs(T) do
            if(#getCreatureSummons(cid) < 3) then
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

if getCreatureName(getCreatureSummons(cid)) == "V.nosummon" then
doPlayerSendCancel(cid,"Você não pode invocar dois ou mais karasu.")
return false
end


  
     
        return true
    end