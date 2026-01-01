function onCastSpell(cid, var)
local summons = getCreatureSummons(cid)
local MaximoSummon = 1

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 10 and getPlayerLevel(cid) >= 30 and getPlayerLevel(cid) <= 34 then
local creature = doCreateMonster("kuroari[1]", getPlayerPosition(cid))
doCreatureAddMana(cid, -10)
doConvinceCreature(cid, creature)
registerCreatureEvent(creature, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 12 and getPlayerLevel(cid) >= 35 and getPlayerLevel(cid) <= 39 then
local creature1 = doCreateMonster("kuroari[2]", getPlayerPosition(cid))
doCreatureAddMana(cid, -12)
doConvinceCreature(cid, creature1)
registerCreatureEvent(creature1, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 14 and getPlayerLevel(cid) >= 40 and getPlayerLevel(cid) <= 44 then
local creature2 = doCreateMonster("kuroari[3]", getPlayerPosition(cid))
doCreatureAddMana(cid, -14)
doConvinceCreature(cid, creature2)
registerCreatureEvent(creature2, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 16 and getPlayerLevel(cid) >= 45 and getPlayerLevel(cid) <= 49 then
local creature3 = doCreateMonster("kuroari[4]", getPlayerPosition(cid))
doCreatureAddMana(cid, -16)
doConvinceCreature(cid, creature3)
registerCreatureEvent(creature3, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 18 and getPlayerLevel(cid) >= 50 and getPlayerLevel(cid) <= 54 then
local creature4 = doCreateMonster("kuroari[5]", getPlayerPosition(cid))
doCreatureAddMana(cid, -18)
doConvinceCreature(cid, creature4)
registerCreatureEvent(creature4, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 20 and getPlayerLevel(cid) >= 55 and getPlayerLevel(cid) <= 59 then
local creature5 = doCreateMonster("kuroari[6]", getPlayerPosition(cid))
doCreatureAddMana(cid, -20)
doConvinceCreature(cid, creature5)
registerCreatureEvent(creature5, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 22 and getPlayerLevel(cid) >= 60 and getPlayerLevel(cid) <= 64 then
local creature6 = doCreateMonster("kuroari[7]", getPlayerPosition(cid))
doCreatureAddMana(cid, -22)
doConvinceCreature(cid, creature6)
registerCreatureEvent(creature6, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 24 and getPlayerLevel(cid) >= 65 and getPlayerLevel(cid) <= 69 then
local creature7 = doCreateMonster("kuroari[8]", getPlayerPosition(cid))
doCreatureAddMana(cid, -24)
doConvinceCreature(cid, creature7)
registerCreatureEvent(creature7, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 26 and getPlayerLevel(cid) >= 70 and getPlayerLevel(cid) <= 74 then
local creature8 = doCreateMonster("kuroari[9]", getPlayerPosition(cid))
doCreatureAddMana(cid, -26)
doConvinceCreature(cid, creature8)
registerCreatureEvent(creature8, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 28 and getPlayerLevel(cid) >= 75 and getPlayerLevel(cid) <= 79 then
local creature9 = doCreateMonster("kuroari[10]", getPlayerPosition(cid))
doCreatureAddMana(cid, -28)
doConvinceCreature(cid, creature9)
registerCreatureEvent(creature9, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 30 and getPlayerLevel(cid) >= 80 and getPlayerLevel(cid) <= 84 then
local creature10 = doCreateMonster("kuroari[11]", getPlayerPosition(cid))
doCreatureAddMana(cid, -30)
doConvinceCreature(cid, creature10)
registerCreatureEvent(creature10, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 32 and getPlayerLevel(cid) >= 85 and getPlayerLevel(cid) <= 89 then
local creature11 = doCreateMonster("kuroari[12]", getPlayerPosition(cid))
doCreatureAddMana(cid, -32)
doConvinceCreature(cid, creature11)
registerCreatureEvent(creature11, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 34 and getPlayerLevel(cid) >= 90 and getPlayerLevel(cid) <= 94 then
local creature12 = doCreateMonster("kuroari[13]", getPlayerPosition(cid))
doCreatureAddMana(cid, -34)
doConvinceCreature(cid, creature12)
registerCreatureEvent(creature12, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 36 and getPlayerLevel(cid) >= 95 and getPlayerLevel(cid) <= 99 then
local creature13 = doCreateMonster("kuroari[14]", getPlayerPosition(cid))
doCreatureAddMana(cid, -36)
doConvinceCreature(cid, creature13)
registerCreatureEvent(creature13, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 38 and getPlayerLevel(cid) >= 100 and getPlayerLevel(cid) <= 104 then
local creature14 = doCreateMonster("kuroari[15]", getPlayerPosition(cid))
doCreatureAddMana(cid, -38)
doConvinceCreature(cid, creature14)
registerCreatureEvent(creature14, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 40 and getPlayerLevel(cid) >= 105 and getPlayerLevel(cid) <= 109 then
local creature15 = doCreateMonster("kuroari[16]", getPlayerPosition(cid))
doCreatureAddMana(cid, -40)
doConvinceCreature(cid, creature15)
registerCreatureEvent(creature15, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 42 and getPlayerLevel(cid) >= 110 and getPlayerLevel(cid) <= 114 then
local creature16 = doCreateMonster("kuroari[17]", getPlayerPosition(cid))
doCreatureAddMana(cid, -42)
doConvinceCreature(cid, creature16)
registerCreatureEvent(creature16, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 44 and getPlayerLevel(cid) >= 115 and getPlayerLevel(cid) <= 119 then
local creature17 = doCreateMonster("kuroari[18]", getPlayerPosition(cid))
doCreatureAddMana(cid, -44)
doConvinceCreature(cid, creature17)
registerCreatureEvent(creature17, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 46 and getPlayerLevel(cid) >= 120 and getPlayerLevel(cid) <= 124 then
local creature18 = doCreateMonster("kuroari[19]", getPlayerPosition(cid))
doCreatureAddMana(cid, -46)
doConvinceCreature(cid, creature18)
registerCreatureEvent(creature18, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 48 and getPlayerLevel(cid) >= 125 and getPlayerLevel(cid) <= 129 then
local creature19 = doCreateMonster("kuroari[20]", getPlayerPosition(cid))
doCreatureAddMana(cid, -48)
doConvinceCreature(cid, creature19)
registerCreatureEvent(creature19, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 50 and getPlayerLevel(cid) >= 130 and getPlayerLevel(cid) <= 134 then
local creature20 = doCreateMonster("kuroari[21]", getPlayerPosition(cid))
doCreatureAddMana(cid, -50)
doConvinceCreature(cid, creature20)
registerCreatureEvent(creature20, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 52 and getPlayerLevel(cid) >= 135 and getPlayerLevel(cid) <= 139 then
local creature21 = doCreateMonster("kuroari[22]", getPlayerPosition(cid))
doCreatureAddMana(cid, -52)
doConvinceCreature(cid, creature21)
registerCreatureEvent(creature21, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 54 and getPlayerLevel(cid) >= 140 and getPlayerLevel(cid) <= 144 then
local creature22 = doCreateMonster("kuroari[23]", getPlayerPosition(cid))
doCreatureAddMana(cid, -54)
doConvinceCreature(cid, creature22)
registerCreatureEvent(creature22, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 56 and getPlayerLevel(cid) >= 145 and getPlayerLevel(cid) <= 149 then
local creature23 = doCreateMonster("kuroari[24]", getPlayerPosition(cid))
doCreatureAddMana(cid, -56)
doConvinceCreature(cid, creature23)
registerCreatureEvent(creature23, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 58 and getPlayerLevel(cid) >= 150 and getPlayerLevel(cid) <= 154 then
local creature24 = doCreateMonster("kuroari[25]", getPlayerPosition(cid))
doCreatureAddMana(cid, -58)
doConvinceCreature(cid, creature24)
registerCreatureEvent(creature24, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 60 and getPlayerLevel(cid) >= 155 and getPlayerLevel(cid) <= 159 then
local creature25 = doCreateMonster("kuroari[26]", getPlayerPosition(cid))
doCreatureAddMana(cid, -60)
doConvinceCreature(cid, creature25)
registerCreatureEvent(creature25, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 62 and getPlayerLevel(cid) >= 160 and getPlayerLevel(cid) <= 164 then
local creature26 = doCreateMonster("kuroari[27]", getPlayerPosition(cid))
doCreatureAddMana(cid, -62)
doConvinceCreature(cid, creature26)
registerCreatureEvent(creature26, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 64 and getPlayerLevel(cid) >= 165 and getPlayerLevel(cid) <= 169 then
local creature27 = doCreateMonster("kuroari[28]", getPlayerPosition(cid))
doCreatureAddMana(cid, -64)
doConvinceCreature(cid, creature27)
registerCreatureEvent(creature27, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 66 and getPlayerLevel(cid) >= 170 and getPlayerLevel(cid) <= 174 then
local creature28 = doCreateMonster("kuroari[29]", getPlayerPosition(cid))
doCreatureAddMana(cid, -66)
doConvinceCreature(cid, creature28)
registerCreatureEvent(creature28, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 68 and getPlayerLevel(cid) >= 175 and getPlayerLevel(cid) <= 179 then
local creature29 = doCreateMonster("kuroari[30]", getPlayerPosition(cid))
doCreatureAddMana(cid, -68)
doConvinceCreature(cid, creature29)
registerCreatureEvent(creature29, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 70 and getPlayerLevel(cid) >= 180 and getPlayerLevel(cid) <= 184 then
local creature30 = doCreateMonster("kuroari[31]", getPlayerPosition(cid))
doCreatureAddMana(cid, -70)
doConvinceCreature(cid, creature30)
registerCreatureEvent(creature30, "summon1")	
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 72 and getPlayerLevel(cid) >= 185 and getPlayerLevel(cid) <= 189 then
local creature31 = doCreateMonster("kuroari[32]", getPlayerPosition(cid))
doCreatureAddMana(cid, -72)
doConvinceCreature(cid, creature31)
registerCreatureEvent(creature31, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 74 and getPlayerLevel(cid) >= 190 and getPlayerLevel(cid) <= 194 then
local creature32 = doCreateMonster("kuroari[33]", getPlayerPosition(cid))
doCreatureAddMana(cid, -74)
doConvinceCreature(cid, creature32)
registerCreatureEvent(creature32, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getCreatureMana(cid) >= 76 and getPlayerLevel(cid) >= 195 and getPlayerLevel(cid) <= 1000 then
local creature33 = doCreateMonster("kuroari[34]", getPlayerPosition(cid))
doCreatureAddMana(cid, -76)
doConvinceCreature(cid, creature33)
registerCreatureEvent(creature33, "summon1")
return TRUE
end
end