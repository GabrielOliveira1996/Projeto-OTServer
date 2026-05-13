local bonus = 1.05 -- bonus de 5%

function onEquip(cid, item, slot)
    doPlayerSetExperienceRate(cid, bonus)
    doPlayerSendTextMessage(cid, 22, "You feel more inspired. Experience gain increased by 5%.")
    return true
end

function onDeEquip(cid, item, slot)
    doPlayerSetExperienceRate(cid, 1.0) -- experiencia volta ao normal
    doPlayerSendTextMessage(cid, 22, "Your 5% XP bonus has expired.")
    return true
end