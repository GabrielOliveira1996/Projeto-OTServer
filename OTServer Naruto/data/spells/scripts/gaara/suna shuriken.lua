function onCastSpell(cid, var)
doPlayerAddItem(cid, 7366, 10, false)
doSendMagicEffect(getCreaturePosition(cid), 95)

return TRUE
end