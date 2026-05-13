local CONFIG = {
    storage = 305,
    heal = 200,
    mana_drain = 200,
    effect = 12,
    min_mana_percent = 0.05 -- 5% 
}

function onThink(interval)
    for _, cid in ipairs(getPlayersOnline()) do
        if getPlayerStorageValue(cid, CONFIG.storage) == 1 then
            local currentMana = getCreatureMana(cid)
            local maxMana = getCreatureMaxMana(cid)

            -- desconto máximo de 50%
            local fishing = getPlayerSkillLevel(cid, 6)
            local minManaAllowed = math.ceil(CONFIG.mana_drain / 2) 
            local finalManaDrain = math.max(minManaAllowed, CONFIG.mana_drain - fishing)

            if currentMana < (maxMana * CONFIG.min_mana_percent) then
                setPlayerStorageValue(cid, CONFIG.storage, -1)
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_WARNING, "Sozo Saisei deactivated due to low mana.")
                doSendMagicEffect(getThingPos(cid), 2)
            else
                doPlayerRemoveMana(cid, finalManaDrain)
                doCreatureAddHealth(cid, CONFIG.heal)
                doSendMagicEffect(getThingPos(cid), CONFIG.effect)
            end
        end
    end
    return true
end