function onDeath(cid, corpse, killer)
    doSendMagicEffect(getThingPos(cid), 2)
    return true
end