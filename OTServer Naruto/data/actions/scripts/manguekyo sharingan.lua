function onUse(cid, item, fromPosition, itemEx, toPosition)
        if getPlayerLevel(cid) > 299 then
                doCreatureAddHealth(cid, -500)
                doCreatureAddMana(cid, -500)
                doCreatureSetStorage(cid, 11112, 1)
                local player_id = getPlayerGUID(cid)
                addEvent(function()
                        if isCreature(cid) then
                                doCreatureSetStorage(cid, 301, -1)
                        else
                                db.executeQuery("UPDATE player_storage SET value = -1 WHERE key = 3001 AND player_id = ".. player_id ..";")
                        end
                end, 1 * 1000)
        end
        return true
end