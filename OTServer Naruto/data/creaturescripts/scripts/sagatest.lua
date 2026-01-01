local name, storage = 'neji', 11112

function onAttack(cid, target) 
   if(isMonster(cid) and getCreatureName(cid):lower() == name)then 
      if(isPlayer(target) and getCreatureStorage(target, storage) < 0)then 
         doChangeSpeed(cid, -getCreatureSpeed(cid)) 
         return false 
      elseif(isPlayer(target) and getCreatureStorage(target, storage) > 0)then 
         if(getCreatureBaseSpeed(cid) > getCreatureSpeed(cid))then 
            doChangeSpeed(cid,getCreatureBaseSpeed(cid)) 
         end 
      end 
   end 
   return true 
end 
function onCombat(cid, target) 
   if isPlayer(cid) and getCreatureStorage(cid, storage) < 0 and isMonster(target) and getCreatureName(target):lower() == name then 
      return false 
   elseif isMonster(cid) and getCreatureName(cid):lower() == name and isPlayer(target) and getCreatureStorage(target, storage) < 0 then 
      return false 
   end 
   return true 
end 
function onKill(cid, target, lastHit) 
   if isMonster(target) and getCreatureName(target):lower() == name and isPlayer(cid) and getCreatureStorage(cid, storage) > 0 then 
      doCreatureSetStorage(cid, storage, -1) 
   end 
   return true 
end 
 