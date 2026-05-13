local CONFIG = {
    [29] = {mana = 25, heal = 25, look = 387, backVocation = 25}, 
    [30] = {mana = 50, heal = 50, look = 69,  backVocation = 26}, 
    [31] = {mana = 75, heal = 75, look = 346, backVocation = 27}, 
    [32] = {mana = 100, heal = 100, look = 344, backVocation = 28},
}

function onThink(interval)
    for _, cid in ipairs(getPlayersOnline()) do
        if getPlayerStorageValue(cid, 99126) == 1 then
            local voc = getPlayerVocation(cid)
            local check = CONFIG[voc]
            
            if check then
                -- desconto máximo de 50%
                local fishing = getPlayerSkillLevel(cid, 6)
                local minManaAllowed = math.ceil(check.mana / 2)
                local finalManaDrain = math.max(minManaAllowed, check.mana - fishing)
                
                if getCreatureMana(cid) >= finalManaDrain then
                    doPlayerRemoveMana(cid, finalManaDrain) 
                    
                    if getCreatureHealth(cid) < getCreatureMaxHealth(cid) then
                        doCreatureAddHealth(cid, check.heal)
                        doSendMagicEffect(getThingPos(cid), 43)
                    end
                else
                    setPlayerStorageValue(cid, 99126, -1)
                    doPlayerSetVocation(cid, check.backVocation)
                    doSetCreatureOutfit(cid, {lookType = check.look}, -1)
                    doSendMagicEffect(getThingPos(cid), 12)
                    doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Seu chakra se esgotou, Chakra no Mesu desativado.")
                end
            end
        end
    end
    return true
end