local protection = {}
local monster = "Gamakichi"

function onEquip (cid, item, slot)

        if protection[cid] then
                protection[cid] = nil
                return true
        end
        
        protection[cid] = true
        local mid = 0
        
        if type(doSummonMonster) then
                local func_ret = doSummonMonster(cid, monster)
                if func_ret == 3 then
                        return doPlayerSendCancel(cid, "There is not enough room to summon your monster.")
                end
                local s = getCreatureSummons(cid)
                mid = s[#s]             
        else
                mid = doCreateMonster(monster, getThingPos(cid), false)
                if mid == true then
                        return doPlayerSendCancel(cid, "There is not enough room to summon your monster.")
                end
                doConvinceCreature(cid, mid)
        end
        
       if not isCreature(mid) then return true end

        if getCreatureMaster(mid) ~= cid then
                doRemoveCreature(mid)
        else
                doSendMagicEffect(getThingPos(mid), CONST_ME_TELEPORT)
        end
        
return true
end