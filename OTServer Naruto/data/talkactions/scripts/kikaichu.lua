function onSay(cid, words, param, itemEx, params)

if isCreature(cid) then
if words == "!backkikaichu" then
doRemoveCreature(x)
return True
end 
end


local summons = getCreatureSummons(cid)

local monster = {

["kikaichu[1]"] = { Level = 10, Levelmax = 14, Voc = 13, Vocp = 14 },

["kikaichu[2]"] = { Level = 15, Levelmax = 19, Voc = 13, Vocp = 14 },

["kikaichu[3]"] = { Level = 20, Levelmax = 24, Voc = 13, Vocp = 14 },

["kikaichu[4]"] = { Level = 25, Levelmax = 29, Voc = 13, Vocp = 14 },

["kikaichu[5]"] = { Level = 30, Levelmax = 34, Voc = 13, Vocp = 14 },

["kikaichu[6]"] = { Level = 35, Levelmax = 39, Voc = 13, Vocp = 14 },

["kikaichu[7]"] = { Level = 40, Levelmax = 44, Voc = 13, Vocp = 14 },

["kikaichu[8]"] = { Level = 45, Levelmax = 49, Voc = 13, Vocp = 14 },

["kikaichu[9]"] = { Level = 50, Levelmax = 54, Voc = 13, Vocp = 14 },

["kikaichu[10]"] = { Level = 55, Levelmax = 59, Voc = 13, Vocp = 14 },

["kikaichu[11]"] = { Level = 60, Levelmax = 64, Voc = 13, Vocp = 14 },

["kikaichu[12]"] = { Level = 65, Levelmax = 69, Voc = 13, Vocp = 14 },

["kikaichu[13]"] = { Level = 70, Levelmax = 74, Voc = 13, Vocp = 14 },

["kikaichu[14]"] = { Level = 75, Levelmax = 79, Voc = 13, Vocp = 14 },

["kikaichu[15]"] = { Level = 80, Levelmax = 84, Voc = 13, Vocp = 14 },

["kikaichu[16]"] = { Level = 85, Levelmax = 89, Voc = 13, Vocp = 14 },

["kikaichu[17]"] = { Level = 90, Levelmax = 94, Voc = 13, Vocp = 14 },

["kikaichu[18]"] = { Level = 95, Levelmax = 99, Voc = 13, Vocp = 14 },

["kikaichu[19]"] = { Level = 100, Levelmax = 104, Voc = 13, Vocp = 14 },

["kikaichu[20]"] = { Level = 105, Levelmax = 109, Voc = 13, Vocp = 14 },

["kikaichu[21]"] = { Level = 110, Levelmax = 114, Voc = 13, Vocp = 14 },

["kikaichu[22]"] = { Level = 115, Levelmax = 119, Voc = 13, Vocp = 14 },

["kikaichu[23]"] = { Level = 120, Levelmax = 124, Voc = 13, Vocp = 14 },

["kikaichu[24]"] = { Level = 125, Levelmax = 129, Voc = 13, Vocp = 14 },

["kikaichu[25]"] = { Level = 130, Levelmax = 134, Voc = 13, Vocp = 14 },

["kikaichu[26]"] = { Level = 135, Levelmax = 139, Voc = 13, Vocp = 14 },

["kikaichu[27]"] = { Level = 140, Levelmax = 144, Voc = 13, Vocp = 14 },

["kikaichu[28]"] = { Level = 145, Levelmax = 149, Voc = 13, Vocp = 14 },

["kikaichu[29]"] = { Level = 150, Levelmax = 154, Voc = 13, Vocp = 14 },

["kikaichu[30]"] = { Level = 155, Levelmax = 100000, Voc = 13, Vocp = 14 },
}



for k,v in pairs(monster) do

   if getPlayerVocation(cid) == v.Voc or getPlayerVocation(cid) == v.Vocp then 

      if getPlayerLevel(cid) >= v.Level and getPlayerLevel(cid) <= v.Levelmax then

          if (table.maxn(summons) < 4)then

            if getTilePzInfo(getCreaturePosition(cid)) == false then

            x = doSummonCreature(k, getCreaturePosition(cid))
            doConvinceCreature(cid, x)
            doCreatureSay(cid, "Help me,".. k,1)

            else
            doPlayerSendCancel(cid, "Voce nao pode envocar os insetos em area pz.")
            end

         else
         doPlayerSendCancel(cid, "Voce nao pode envocar mais de quatro insetos.")
         end

      else
      doPlayerSendCancel(cid, "Voce nao tem level para envocar os insetos.")
      end

   end

end
return true
end