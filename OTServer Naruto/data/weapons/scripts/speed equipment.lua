function onUseWeapon(cid, var)
    local target = getThingPosition(getCreatureTarget(cid))
    if getCreatureMana(cid) >= 25 then
        doPlayerAddSkillTry(cid, 1, 1)
        doSendMagicEffect(target, 1)
        return true
    end
end