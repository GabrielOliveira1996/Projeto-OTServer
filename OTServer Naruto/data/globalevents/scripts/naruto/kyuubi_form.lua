local CONFIG = {
    [5] = {control = 10, damage = 10}, -- uma calda.
    [6] = {control = 15, damage = 15}, -- duas caldas.
    [7] = {control = 20, damage = 20}, -- tres caldas.
    [8] = {control = 20, damage = 20}, -- shippuden tres caldas.
    [9] = {control = 25, damage = 30}, -- shippuden quatro caldas.
}

function onThink(interval)
    for _, cid in ipairs(getPlayersOnline()) do
        if getPlayerStorageValue(cid, STORAGE_KYUUBI_FORM) == 1 then
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