function onSay(cid, words, param, itemEx, params)

if isCreature(cid) then
if words == "!back" then
doRemoveCreature(x)
return True
end 
end


local summons = getCreatureSummons(cid)

local monster = {

["karasu[1]"] = { Level = 10, Levelmax = 14, Voc = 11, Vocp = 12 },

["karasu[2]"] = { Level = 15, Levelmax = 19, Voc = 11, Vocp = 12 },

["karasu[3]"] = { Level = 20, Levelmax = 24, Voc = 11, Vocp = 12 },

["karasu[4]"] = { Level = 25, Levelmax = 29, Voc = 11, Vocp = 12 },

["kuroari[1]"] = { Level = 30, Levelmax = 34, Voc = 11, Vocp = 12 },

["kuroari[2]"] = { Level = 35, Levelmax = 39, Voc = 11, Vocp = 12 },

["kuroari[3]"] = { Level = 40, Levelmax = 44, Voc = 11, Vocp = 12 },

["kuroari[4]"] = { Level = 45, Levelmax = 49, Voc = 11, Vocp = 12 },

["kuroari[5]"] = { Level = 50, Levelmax = 54, Voc = 11, Vocp = 12 },

["kuroari[6]"] = { Level = 55, Levelmax = 59, Voc = 11, Vocp = 12 },

}



for k,v in pairs(monster) do

   if getPlayerVocation(cid) == v.Voc or getPlayerVocation(cid) == v.Vocp then 

      if getPlayerLevel(cid) >= v.Level and getPlayerLevel(cid) <= v.Levelmax then

          if (table.maxn(summons) < 1)then

            if getTilePzInfo(getCreaturePosition(cid)) == false then

            x = doSummonCreature(k, getCreaturePosition(cid))
            doConvinceCreature(cid, x)
            doCreatureSay(cid, "Go to me ,".. k,1)

            else
            doPlayerSendCancel(cid, "Voce nao pode envocar o karasu em area pz.")
            end

         else
         doPlayerSendCancel(cid, "Voce nao pode envocar mais de um karasu.")
         end

      else
      doPlayerSendCancel(cid, "Voce nao tem level para envocar o karasu.")
      end

   end

end
return true
end