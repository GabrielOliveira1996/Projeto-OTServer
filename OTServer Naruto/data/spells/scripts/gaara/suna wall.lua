function onCastSpell(cid, var)
doPlayerAddItem(cid, 2295, 5, false)
doSendMagicEffect(getCreaturePosition(cid), 95)

return TRUE
end