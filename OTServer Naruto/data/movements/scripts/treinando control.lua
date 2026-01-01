function onStepIn(cid, item, pos)

if (item.actionid == 60000) then

if getCreatureMana(cid) >= 10 then
doPlayerAddSkillTry(cid, 6, 1)
doCreatureAddMana(cid, -5)
doSendMagicEffect(getCreaturePosition(cid), 1)
return TRUE
end
end
end
