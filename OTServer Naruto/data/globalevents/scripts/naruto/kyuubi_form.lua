local CONFIG = {
    [64] = {control = 20, damage = 20}, -- vocacao 64 uma calda.
    [65] = {control = 30, damage = 25}, -- vocacao 65 duas caldas.
    [66] = {control = 40, damage = 30},  -- vocacao 66 tres caldas.
    [67] = {control = 50, damage = 35}  -- vocacao 66 tres caldas.
}

function onThink(interval)
    for _, cid in ipairs(getPlayersOnline()) do
        if getPlayerStorageValue(cid, 99123) == 1 then
            local voc = getPlayerVocation(cid)
            local check = CONFIG[voc]
            
            if check then
                if getPlayerSkillLevel(cid, 6) < check.control then
                    doCreatureAddHealth(cid, -check.damage)
                    doSendMagicEffect(getThingPos(cid), 73) -- efeito constante da kyuubi.
                    doSendAnimatedText(getThingPos(cid), "CORROSION", 180)
                end
            end
        end
    end
    return true
end