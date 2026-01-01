function onCombat(cid, target)
if isPlayer(cid) and isSummon(cid, target) then
doPlayerSendCancel(cid, "Você não pode atacar seu summon.")
return false
end
return true
end