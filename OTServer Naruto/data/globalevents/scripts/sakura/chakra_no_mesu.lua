local CONFIG = {
    [16] = {mana = 10, look = 387, backVoc = 13}, 
    [17] = {mana = 15, look = 69,  backVoc = 14}, 
    [18] = {mana = 20, look = 69,  backVoc = 15}, -- looktype deve ser corrigido, pois ainda não foi adicionado no data
}

function onThink(interval)
    for _, cid in ipairs(getPlayersOnline()) do
        if getPlayerStorageValue(cid, 99126) == 1 then
            local voc = getPlayerVocation(cid)
            local check = CONFIG[voc]
            
            if check then
                -- verifica se o player tem chakra para o proximo
                if getCreatureMana(cid) >= check.mana then
                    doPlayerRemoveMana(cid, -check.mana) --
                    doSendMagicEffect(getThingPos(cid), 43)
                else
                    -- se nao tiver chakra
                    setPlayerStorageValue(cid, 99126, -1)
                    doPlayerSetVocation(cid, check.backVoc)
                    doSetCreatureOutfit(cid, {lookType = check.look}, -1)
                    doSendMagicEffect(getThingPos(cid), 12)
                    doPlayerSendTextMessage(cid, MSG_STATUS_WARNING, "Your chakra has been exhausted, Chakra no Mesu deactivated.")
                end
            end
        end
    end
    return true
end