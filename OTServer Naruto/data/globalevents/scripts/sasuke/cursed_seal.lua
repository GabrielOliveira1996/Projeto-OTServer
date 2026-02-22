local CONFIG = {
    [92] = {control = 20, damage = 20}, -- vocacao 64 primeiro selo.
    [61] = {control = 30, damage = 25}, -- vocacao 65 segundo selo.
    [62] = {control = 40, damage = 30},  -- vocacao 66 terceiro selo.
    [63] = {control = 50, damage = 35}  -- vocacao 66 terceiro selo shippuden.
}

function onThink(interval)
    for _, cid in ipairs(getPlayersOnline()) do
        if getPlayerStorageValue(cid, 99124) == 1 then
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