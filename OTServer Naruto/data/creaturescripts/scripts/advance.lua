local config = {

    [0] = { "Fist skill"},

    [1] = { "Club skill"},

    [2] = { "Sword skill"},

    [3] = { "Axe skill"},

    [4] = { "Distance skill"},

    [5] = { "Shield skill"},

    [6] = { "Fishing skill"},

    [7] = { "Magic level"},

    [8] = { "Level Advanced"}

}



function onAdvance(cid, skill, oldlevel, newlevel)          

    for type, variable in pairs(config) do

        if skill == type then

            doPlayerBroadcastMessage(cid, 21,""..variable[1].." ["..newlevel.."]")                       

        end

    end    

return TRUE

end
