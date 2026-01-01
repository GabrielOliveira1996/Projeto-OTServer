function onSay(cid, words, param, itemEx, params)

if isCreature(cid) then
if words == "!back" then
doRemoveCreature(x)
return True
end 
end


local summons = getCreatureSummons(cid)

local monster = {

["karasu[1]"] = { Level = 10, Levelmax = 14, Voc = 21, Vocp = 22 },

["karasu[2]"] = { Level = 15, Levelmax = 19, Voc = 21, Vocp = 22 },

["karasu[3]"] = { Level = 20, Levelmax = 24, Voc = 21, Vocp = 22 },

["karasu[4]"] = { Level = 25, Levelmax = 29, Voc = 21, Vocp = 22 },

["kuroari[1]"] = { Level = 30, Levelmax = 34, Voc = 21, Vocp = 22 },

["karasu[5]"] = { Level = 30, Levelmax = 34, Voc = 21, Vocp = 22 },

["kuroari[2]"] = { Level = 35, Levelmax = 39, Voc = 21, Vocp = 22 },

["karasu[6]"] = { Level = 35, Levelmax = 39, Voc = 21, Vocp = 22 },

["kuroari[3]"] = { Level = 40, Levelmax = 44, Voc = 21, Vocp = 22 },

["karasu[7"] = { Level = 40, Levelmax = 44, Voc = 21, Vocp = 22 },

["kuroari[4]"] = { Level = 45, Levelmax = 49, Voc = 21, Vocp = 22 },

["karasu[8]"] = { Level = 45, Levelmax = 49, Voc = 21, Vocp = 22 },

["kuroari[5]"] = { Level = 50, Levelmax = 54, Voc = 21, Vocp = 22 },

["karasu[9]"] = { Level = 50, Levelmax = 54, Voc = 21, Vocp = 22 },

["kuroari[6]"] = { Level = 55, Levelmax = 59, Voc = 21, Vocp = 22 },

["karasu[10]"] = { Level = 55, Levelmax = 59, Voc = 21, Vocp = 22 },

["kuroari[7]"] = { Level = 60, Levelmax = 64, Voc = 21, Vocp = 22 },

["karasu[11]"] = { Level = 60, Levelmax = 64, Voc = 21, Vocp = 22 },

["kuroari[8]"] = { Level = 65, Levelmax = 69, Voc = 21, Vocp = 22 },

["karasu[12]"] = { Level = 65, Levelmax = 69, Voc = 21, Vocp = 22 },

["kuroari[9]"] = { Level = 70, Levelmax = 74, Voc = 21, Vocp = 22 },

["karasu[13]"] = { Level = 70, Levelmax = 74, Voc = 21, Vocp = 22 },

["kuroari[10]"] = { Level = 75, Levelmax = 79, Voc = 21, Vocp = 22 },

["karasu[14]"] = { Level = 75, Levelmax = 79, Voc = 21, Vocp = 22 },

["kuroari[11]"] = { Level = 80, Levelmax = 84, Voc = 21, Vocp = 22 },

["karasu[15]"] = { Level = 80, Levelmax = 84, Voc = 21, Vocp = 22 },

["kuroari[12]"] = { Level = 85, Levelmax = 89, Voc = 21, Vocp = 22 },

["karasu[16]"] = { Level = 85, Levelmax = 89, Voc = 21, Vocp = 22 },

["kuroari[13]"] = { Level = 90, Levelmax = 94, Voc = 21, Vocp = 22 },

["karasu[17]"] = { Level = 90, Levelmax = 94, Voc = 21, Vocp = 22 },

["kuroari[14]"] = { Level = 95, Levelmax = 99, Voc = 21, Vocp = 22 },

["karasu[18]"] = { Level = 95, Levelmax = 99, Voc = 21, Vocp = 22 },

["kuroari[15]"] = { Level = 100, Levelmax = 104, Voc = 21, Vocp = 22 },

["karasu[19]"] = { Level = 100, Levelmax = 104, Voc = 21, Vocp = 22 },

["kuroari[16]"] = { Level = 105, Levelmax = 109, Voc = 21, Vocp = 22 },

["karasu[20]"] = { Level = 105, Levelmax = 109, Voc = 21, Vocp = 22 },

["kuroari[17]"] = { Level = 110, Levelmax = 114, Voc = 21, Vocp = 22 },

["karasu[21]"] = { Level = 110, Levelmax = 114, Voc = 21, Vocp = 22 },

["kuroari[18]"] = { Level = 115, Levelmax = 119, Voc = 21, Vocp = 22 },

["karasu[22]"] = { Level = 115, Levelmax = 119, Voc = 21, Vocp = 22 },

["sanshouou[1]"] = { Level = 120, Levelmax = 124, Voc = 21, Vocp = 22 },

["kuroari[19]"] = { Level = 120, Levelmax = 124, Voc = 21, Vocp = 22 },

["karasu[23]"] = { Level = 120, Levelmax = 124, Voc = 21, Vocp = 22 },

["sanshouou[2]"] = { Level = 125, Levelmax = 129, Voc = 21, Vocp = 22 },

["kuroari[20]"] = { Level = 125, Levelmax = 129, Voc = 21, Vocp = 22 },

["karasu[24]"] = { Level = 125, Levelmax = 129, Voc = 21, Vocp = 22 },

["sanshouou[3]"] = { Level = 130, Levelmax = 134, Voc = 21, Vocp = 22 },

["kuroari[21]"] = { Level = 130, Levelmax = 134, Voc = 21, Vocp = 22 },

["karasu[25]"] = { Level = 130, Levelmax = 134, Voc = 21, Vocp = 22 },

["sanshouou[4]"] = { Level = 135, Levelmax = 139, Voc = 21, Vocp = 22 },

["kuroari[22]"] = { Level = 135, Levelmax = 139, Voc = 21, Vocp = 22 },

["karasu[26]"] = { Level = 135, Levelmax = 139, Voc = 21, Vocp = 22 },

["sanshouou[5]"] = { Level = 140, Levelmax = 144, Voc = 21, Vocp = 22 },

["kuroari[23]"] = { Level = 140, Levelmax = 144, Voc = 21, Vocp = 22 },

["karasu[27]"] = { Level = 140, Levelmax = 144, Voc = 21, Vocp = 22 },

["sanshouou[6]"] = { Level = 145, Levelmax = 149, Voc = 21, Vocp = 22 },

["kuroari[24]"] = { Level = 145, Levelmax = 149, Voc = 21, Vocp = 22 },

["karasu[28]"] = { Level = 145, Levelmax = 149, Voc = 21, Vocp = 22 },

["sanshouou[7]"] = { Level = 150, Levelmax = 154, Voc = 22, Vocp = 23 },

["kuroari[25]"] = { Level = 150, Levelmax = 154, Voc = 22, Vocp = 23 },

["karasu[29]"] = { Level = 150, Levelmax = 154, Voc = 22, Vocp = 23 },

["sanshouou[8]"] = { Level = 155, Levelmax = 159, Voc = 22, Vocp = 23 },

["kuroari[26]"] = { Level = 155, Levelmax = 159, Voc = 22, Vocp = 23 },

["karasu[30]"] = { Level = 155, Levelmax = 159, Voc = 22, Vocp = 23 },

["sanshouou[9]"] = { Level = 160, Levelmax = 164, Voc = 22, Vocp = 23 },

["kuroari[27]"] = { Level = 160, Levelmax = 164, Voc = 22, Vocp = 23 },

["karasu[31]"] = { Level = 160, Levelmax = 164, Voc = 22, Vocp = 23 },

["sanshouou[10]"] = { Level = 165, Levelmax = 169, Voc = 22, Vocp = 23 },

["kuroari[28]"] = { Level = 165, Levelmax = 169, Voc = 22, Vocp = 23 },

["karasu[32]"] = { Level = 165, Levelmax = 169, Voc = 22, Vocp = 23 },

["sanshouou[11]"] = { Level = 170, Levelmax = 174, Voc = 22, Vocp = 23 },

["kuroari[29]"] = { Level = 170, Levelmax = 174, Voc = 22, Vocp = 23 },

["karasu[33]"] = { Level = 170, Levelmax = 174, Voc = 22, Vocp = 23 },

["sanshouou[12]"] = { Level = 175, Levelmax = 179, Voc = 22, Vocp = 23 },

["kuroari[30]"] = { Level = 175, Levelmax = 179, Voc = 22, Vocp = 23 },

["karasu[34]"] = { Level = 175, Levelmax = 179, Voc = 22, Vocp = 23 },

["sanshouou[13]"] = { Level = 180, Levelmax = 184, Voc = 22, Vocp = 23 },

["kuroari[31]"] = { Level = 180, Levelmax = 184, Voc = 22, Vocp = 23 },

["karasu[35]"] = { Level = 180, Levelmax = 184, Voc = 22, Vocp = 23 },

["sanshouou[14]"] = { Level = 185, Levelmax = 189, Voc = 22, Vocp = 23 },

["kuroari[32]"] = { Level = 185, Levelmax = 189, Voc = 22, Vocp = 23 },

["karasu[36]"] = { Level = 185, Levelmax = 189, Voc = 22, Vocp = 23 },

["sanshouou[15]"] = { Level = 190, Levelmax = 194, Voc = 22, Vocp = 23 },

["kuroari[33]"] = { Level = 190, Levelmax = 194, Voc = 22, Vocp = 23 },

["karasu[37]"] = { Level = 190, Levelmax = 194, Voc = 22, Vocp = 23 },

["sanshouou[16]"] = { Level = 195, Levelmax = 199, Voc = 22, Vocp = 23 },

["kuroari[34]"] = { Level = 195, Levelmax = 199, Voc = 22, Vocp = 23 },

["karasu[38]"] = { Level = 195, Levelmax = 199, Voc = 22, Vocp = 23 },

["sanshouou[17]"] = { Level = 200, Levelmax = 204, Voc = 22, Vocp = 23 },

["kuroari[35]"] = { Level = 200, Levelmax = 204, Voc = 22, Vocp = 23 },

["karasu[39]"] = { Level = 200, Levelmax = 204, Voc = 22, Vocp = 23 },

["sanshouou[18]"] = { Level = 205, Levelmax = 209, Voc = 22, Vocp = 23 },

["kuroari[36]"] = { Level = 205, Levelmax = 209, Voc = 22, Vocp = 23 },

["karasu[40]"] = { Level = 205, Levelmax = 209, Voc = 22, Vocp = 23 },

["sasori[1]"] = { Level = 210, Levelmax = 214, Voc = 22, Vocp = 23 },

["sanshouou[19]"] = { Level = 210, Levelmax = 214, Voc = 22, Vocp = 23 },

["kuroari[37]"] = { Level = 210, Levelmax = 214, Voc = 22, Vocp = 23 },

["karasu[41]"] = { Level = 210, Levelmax = 214, Voc = 22, Vocp = 23 },

["sasori[2]"] = { Level = 215, Levelmax = 219, Voc = 22, Vocp = 23 },

["sanshouou[20]"] = { Level = 215, Levelmax = 219, Voc = 22, Vocp = 23 },

["kuroari[38]"] = { Level = 215, Levelmax = 219, Voc = 22, Vocp = 23 },

["karasu[42]"] = { Level = 215, Levelmax = 219, Voc = 22, Vocp = 23 },

["sasori[2]"] = { Level = 300, Levelmax = 10000, Voc = 23, Vocp = 24 },

["sanshouou[21]"] = { Level = 300, Levelmax = 10000, Voc = 23, Vocp = 24 },

["kuroari[39]"] = { Level = 300, Levelmax = 10000, Voc = 23, Vocp = 24 },

["karasu[43]"] = { Level = 300, Levelmax = 10000, Voc = 23, Vocp = 24 },

}



for k,v in pairs(monster) do

   if getPlayerVocation(cid) == v.Voc or getPlayerVocation(cid) == v.Vocp then 

      if getPlayerLevel(cid) >= v.Level and getPlayerLevel(cid) <= v.Levelmax then

          if (table.maxn(summons) < 1)then

            if getTilePzInfo(getCreaturePosition(cid)) == false then

            x = doSummonCreature(k, getCreaturePosition(cid))
            doConvinceCreature(cid, x)
            doCreatureSay(cid, "Vamos la, ".. k,1)

            else
            doPlayerSendCancel(cid, "Voce nao pode envocar os bonecos em area pz.")
            end

         else
         doPlayerSendCancel(cid, "Voce nao pode envocar mais de um.")
         end

      else
      doPlayerSendCancel(cid, "Voce nao tem level para envocar os bonecos.")
      end

   end

end
return true
end