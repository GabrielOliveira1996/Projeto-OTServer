local CONFIG = {
    [20] = {control = 10, damage = 10}, -- primeiro selo.
    [21] = {control = 15, damage = 15}, -- segundo selo.
    [22] = {control = 20, damage = 20}, -- terceiro selo.
    [23] = {control = 20, damage = 20}  -- terceiro selo shippuden.
}

function onThink(interval)
    for _, cid in ipairs(getPlayersOnline()) do
        if getPlayerStorageValue(cid, STORAGE_CURSED_FORM) == 1 then
            local voc = getPlayerVocation(cid)
            local check = CONFIG[voc]
            
            if check then
                if getPlayerSkillLevel(cid, 6) < check.control then
                    doCreatureAddHealth(cid, -check.damage)
                    doSendMagicEffect(getThingPos(cid), 76) -- efeito constante do cursed seal.
                    doSendAnimatedText(getThingPos(cid), "DAMAGE", 180)
                end
            end
        end
    end
    return true
end