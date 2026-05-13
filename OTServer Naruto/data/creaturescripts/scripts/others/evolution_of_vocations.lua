local vocacoes_bonus = {

    -- ========================
    -- TIME 1: TRAIN (Level 30)
    -- ========================
    --["Shikamaru Train"] = {vida = 200, mana = 300, storage = 65497},
    --["Kiba Train"]      = {vida = 250, mana = 250, storage = 65497},
    --["Sakura Train"]    = {vida = 100, mana = 400, storage = 65497},
    --["Shino Train"]     = {vida = 200, mana = 300, storage = 65497},
    --["Kankurou Train"]  = {vida = 200, mana = 300, storage = 65497},
    --["Temari Train"]    = {vida = 300, mana = 200, storage = 65497},
    --["Hinata Train"]    = {vida = 250, mana = 250, storage = 65497},
    --["Tenten Train"]    = {vida = 200, mana = 400, storage = 65497},
    --["Minato Train"]    = {vida = 300, mana = 300, storage = 65497},

    -- ========================
    -- SHIPPUDEN (Level 90)
    -- ========================
    ["Naruto Shippuden"]    = {vida = 500, mana = 500, storage = 65498},
    ["Sasuke Shippuden"]    = {vida = 250, mana = 750, storage = 65498},
    ["Sakura Shippuden"]    = {vida = 250,  mana = 750, storage = 65498},
    --["Shikamaru Shippuden"] = {vida = 1000, mana = 2000, storage = 65498},
    --["Gaara Shippuden"]     = {vida = 500,  mana = 2500, storage = 65498},
    --["Kiba Shippuden"]      = {vida = 1500, mana = 1500, storage = 65498},
    ["Shino Shippuden"]     = {vida = 500, mana = 500, storage = 65498},
    --["Kankurou Shippuden"]  = {vida = 1000, mana = 2000, storage = 65498},
    --["Temari Shippuden"]    = {vida = 2000, mana = 1000, storage = 65498},
    --["Neji Shippuden"]      = {vida = 1500, mana = 1500, storage = 65498},
    --["Rock Lee Shippuden"]  = {vida = 2500, mana = 500,  storage = 65498},
    --["Ino Shippuden"]       = {vida = 500,  mana = 2500, storage = 65498},
    --["Chouji Shippuden"]    = {vida = 2000, mana = 1000, storage = 65498},
    ["Hinata Shippuden"]    = {vida = 500, mana = 500, storage = 65498},
    --["Sai Shippuden"]       = {vida = 1000, mana = 2000, storage = 65498},
    --["Tenten Shippuden"]    = {vida = 1000, mana = 2000, storage = 65498},
    --["Minato Shippuden"]    = {vida = 1500, mana = 1500, storage = 65498},

    -- ========================
    -- STRONGER / MASTER (Level 180)
    -- ========================
    ["Naruto Sannin"]                = {vida = 500, mana = 500, storage = 65499},
    ["Sasuke Akatsuki Member"]       = {vida = 250, mana = 750, storage = 65499},
    ["Sakura Stronger"]              = {vida = 250, mana = 750, storage = 65499},
    --["Shikamaru Master of shadowns"] = {vida = 2000, mana = 3000, storage = 65499},
    --["Gaara Kazekage"]               = {vida = 1500, mana = 3500, storage = 65499},
    --["Kiba Stronger"]                = {vida = 2500, mana = 2500, storage = 65499},
    ["Shino Master Of Insects"]      = {vida = 500, mana = 500, storage = 65499},
    --["Kankurou Master Of Puppets"]   = {vida = 2000, mana = 3000, storage = 65499},
    --["Temari Stronger"]              = {vida = 3000, mana = 2000, storage = 65499},
    --["Neji Stronger"]                = {vida = 2500, mana = 2500, storage = 65499},
    --["Rock Lee Stonger"]             = {vida = 4000, mana = 1000, storage = 65499},
    --["Ino Stronger"]                 = {vida = 1000, mana = 4000, storage = 65499},
    --["Chouji Stronger"]              = {vida = 3000, mana = 2000, storage = 65499},
    ["Hinata Stronger"]              = {vida = 500, mana = 500, storage = 65499},
    --["Sai Stronger"]                 = {vida = 2000, mana = 3000, storage = 65499},
    --["Tenten Master Of Weapons"]     = {vida = 2000, mana = 3000, storage = 65499},
    --["Minato Yondaime"]              = {vida = 2500, mana = 2500, storage = 65499}
}

function onLogin(cid)
    local vocName = getPlayerVocationName(cid)
    local config = vocacoes_bonus[vocName]

    if config then
        if getPlayerStorageValue(cid, config.storage) < 1 then
            setCreatureMaxHealth(cid, getCreatureMaxHealth(cid) + config.vida)
            setCreatureMaxMana(cid, getCreatureMaxMana(cid) + config.mana)
            setPlayerStorageValue(cid, config.storage, 1)
            
            doCreatureAddHealth(cid, config.vida)
            doCreatureAddMana(cid, config.mana)
            
            doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Voce recebeu bonus de vida e mana por sua nova evolucao!")
        end
    end

    return true
end