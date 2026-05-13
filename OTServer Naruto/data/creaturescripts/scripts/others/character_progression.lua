local EVOLUTION_CONFIG = {
    -- Naruto
    {level = 90, fromVoc = 1, toVoc = 2}, -- naruto classic to shippuden
    {level = 170, fromVoc = 2, toVoc = 3}, -- naruto shippuden to war
    {level = 250, fromVoc = 3, toVoc = 4}, -- naruto war to hokage
    -- Sasuke
    {level = 90, fromVoc = 15, toVoc = 16}, -- sasuke classic to shippuden
    {level = 130, fromVoc = 16, toVoc = 17}, -- sasuke shippuden to sasuke taka member
    {level = 170, fromVoc = 17, toVoc = 18}, -- sasuke taka member to war
    {level = 250, fromVoc = 18, toVoc = 19}, -- sasuke war to sasayaki
    -- Sakura
    {level = 30, fromVoc = 24, toVoc = 25}, -- sakura classic to kunoichi
    {level = 90, fromVoc = 25, toVoc = 26}, -- sakura kunoichi to sakura shippuden
    {level = 170, fromVoc = 26, toVoc = 27}, -- sakura shippuden to war
    {level = 250, fromVoc = 27, toVoc = 28}, -- sakura war to shinsu
    -- Kiba
    {level = 30, fromVoc = 33, toVoc = 34}, -- Kiba classic to tracker
    {level = 90, fromVoc = 34, toVoc = 35}, -- Kiba tracker to shippuden
    {level = 170, fromVoc = 35, toVoc = 36}, -- Kiba shippuden to war
    {level = 250, fromVoc = 36, toVoc = 37}, -- Kiba war to veteran
}

local VOCATION_OUTFITS = {
    [0] = 14, -- game master
    -- naruto
    [1] = 352, -- naruto classic
    [2] = 353, -- naruto shippuden
    [3] = 353, -- naruto war
    [4] = 349, -- naruto hokage
    -- sasuke
    [15] = 358, -- sasuke classic
    [16] = 359, -- sasuke shippuden
    [17] = 172, -- sasuke taka member
    [18] = 359, -- sasuke war
    [19] = 347, -- sasuke sasayaki
    -- sakura
    [24] = 387, -- sakura classic
    [25] = 50, -- sakura kunoichi
    [26] = 69, -- sakura shippuden
    [27] = 346, -- sakura war
    [28] = 344, -- sakura shinsu
    -- kiba
    [33] = 18, -- kiba classic
    [34] = 386, -- kiba classic
    [35] = 25, -- kiba shippuden
    [36] = 25, -- kiba war
    [37] = 92, -- kiba veteran
}

local VOCATION_BONUS = {
    -- naruto
    ["Naruto Shippuden"]    = {hp = 150, mp = 150, storage = EVOLUTION_LEVEL_90},
    ["Naruto War"]          = {hp = 250, mp = 250, storage = EVOLUTION_LEVEL_170},
    ["Naruto Hokage"]       = {hp = 1000, mp = 1000, storage = EVOLUTION_LEVEL_250},
    -- sasuke
    ["Sasuke Shippuden"]    = {hp = 75, mp = 75, storage = EVOLUTION_LEVEL_90},
    ["Sasuke Taka Member"]  = {hp = 150, mp = 150, storage = EVOLUTION_LEVEL_130},
    ["Sasuke War"]          = {hp = 175, mp = 175, storage = EVOLUTION_LEVEL_170},
    ["Sasuke Sasayaki"]     = {hp = 500, mp = 500, storage = EVOLUTION_LEVEL_250},
    -- sakura
    ["Sakura Kunoichi"]     = {hp = 75, mp = 75, storage = EVOLUTION_LEVEL_30},
    ["Sakura Shippuden"]    = {hp = 150, mp = 150, storage = EVOLUTION_LEVEL_90},
    ["Sakura War"]          = {hp = 175, mp = 175, storage = EVOLUTION_LEVEL_170},
    ["Sakura Shinsu"]       = {hp = 500, mp = 500, storage = EVOLUTION_LEVEL_250},
    -- kiba
    ["Kiba Tracker"]        = {hp = 75, mp = 75, storage = EVOLUTION_LEVEL_30},
    ["Kiba Shippuden"]      = {hp = 150, mp = 150, storage = EVOLUTION_LEVEL_90},
    ["Kiba War"]            = {hp = 175, mp = 175, storage = EVOLUTION_LEVEL_170},
    ["Kiba Veteran"]        = {hp = 500, mp = 500, storage = EVOLUTION_LEVEL_250},
}

function onAdvance(cid, skill, oldLevel, newLevel)
    if skill ~= SKILL__LEVEL then return true end

    local evolved = false
    local currentVoc = getPlayerVocation(cid)

    -- loop to check all evolutions
    for _, evo in ipairs(EVOLUTION_CONFIG) do
        if newLevel >= evo.level and getPlayerVocation(cid) == evo.fromVoc then
            
            -- vocation
            doPlayerSetVocation(cid, evo.toVoc)
            local newVocName = getPlayerVocationName(cid)
            
            -- outfit
            local newLookType = VOCATION_OUTFITS[evo.toVoc]
            if newLookType then
                local currentOutfit = getCreatureOutfit(cid)
                currentOutfit.lookType = newLookType
                doCreatureChangeOutfit(cid, currentOutfit)
            end

            -- apply bonus
            local bonus = VOCATION_BONUS[newVocName]
            if bonus and getPlayerStorageValue(cid, bonus.storage) < 1 then
                setCreatureMaxHealth(cid, getCreatureMaxHealth(cid) + bonus.hp)
                setCreatureMaxMana(cid, getCreatureMaxMana(cid) + bonus.mp)
                doCreatureAddHealth(cid, bonus.hp)
                doCreatureAddMana(cid, bonus.mp)
                setPlayerStorageValue(cid, bonus.storage, 1)
            end

            -- visual effects
            doSendMagicEffect(getThingPos(cid), 13)
            doCreatureSay(cid, newVocName .. "!", TALKTYPE_ORANGE_1)
            doPlayerSendTextMessage(cid, MESSAGE_EVENT_ADVANCE, "Você evoluiu para " .. newVocName .. "!")
            
            evolved = true
        end
    end

    return true
end