function onCastSpell(cid, var)
local summons = getCreatureSummons(cid)
local MaximoSummon = 4

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 10 and getPlayerLevel(cid) <= 14 then
local creature = doCreateMonster("kikaichu[1]", getPlayerPosition(cid))
doCreatureAddMana(cid, -10)
doConvinceCreature(cid, creature)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 15 and getPlayerLevel(cid) <= 19 then
local creature1 = doCreateMonster("kikaichu[2]", getPlayerPosition(cid))
doCreatureAddMana(cid, -12)
doConvinceCreature(cid, creature1)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 20 and getPlayerLevel(cid) <= 24 then
local creature2 = doCreateMonster("kikaichu[3]", getPlayerPosition(cid))
doCreatureAddMana(cid, -14)
doConvinceCreature(cid, creature2)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 25 and getPlayerLevel(cid) <= 29 then
local creature3 = doCreateMonster("kikaichu[4]", getPlayerPosition(cid))
doCreatureAddMana(cid, -16)
doConvinceCreature(cid, creature3)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 30 and getPlayerLevel(cid) <= 34 then
local creature4 = doCreateMonster("kikaichu[5]", getPlayerPosition(cid))
doCreatureAddMana(cid, -18)
doConvinceCreature(cid, creature4)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 35 and getPlayerLevel(cid) <= 39 then
local creature5 = doCreateMonster("kikaichu[6]", getPlayerPosition(cid))
doCreatureAddMana(cid, -20)
doConvinceCreature(cid, creature5)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 40 and getPlayerLevel(cid) <= 44 then
local creature6 = doCreateMonster("kikaichu[7]", getPlayerPosition(cid))
doCreatureAddMana(cid, -22)
doConvinceCreature(cid, creature6)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 45 and getPlayerLevel(cid) <= 49 then
local creature7 = doCreateMonster("kikaichu[8]", getPlayerPosition(cid))
doCreatureAddMana(cid, -24)
doConvinceCreature(cid, creature7)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 50 and getPlayerLevel(cid) <= 54 then
local creature8 = doCreateMonster("kikaichu[9]", getPlayerPosition(cid))
doCreatureAddMana(cid, -26)
doConvinceCreature(cid, creature8)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 55 and getPlayerLevel(cid) <= 59 then
local creature9 = doCreateMonster("kikaichu[10]", getPlayerPosition(cid))
doCreatureAddMana(cid, -28)
doConvinceCreature(cid, creature9)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 60 and getPlayerLevel(cid) <= 64 then
local creature10 = doCreateMonster("kikaichu[11]", getPlayerPosition(cid))
doCreatureAddMana(cid, -30)
doConvinceCreature(cid, creature10)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 65 and getPlayerLevel(cid) <= 69 then
local creature11 = doCreateMonster("kikaichu[12]", getPlayerPosition(cid))
doCreatureAddMana(cid, -32)
doConvinceCreature(cid, creature11)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 70 and getPlayerLevel(cid) <= 74 then
local creature12 = doCreateMonster("kikaichu[13]", getPlayerPosition(cid))
doCreatureAddMana(cid, -34)
doConvinceCreature(cid, creature12)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 75 and getPlayerLevel(cid) <= 79 then
local creature13 = doCreateMonster("kikaichu[14]", getPlayerPosition(cid))
doCreatureAddMana(cid, -36)
doConvinceCreature(cid, creature13)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 80 and getPlayerLevel(cid) <= 84 then
local creature14 = doCreateMonster("kikaichu[15]", getPlayerPosition(cid))
doCreatureAddMana(cid, -38)
doConvinceCreature(cid, creature14)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 85 and getPlayerLevel(cid) <= 89 then
local creature15 = doCreateMonster("kikaichu[16]", getPlayerPosition(cid))
doCreatureAddMana(cid, -40)
doConvinceCreature(cid, creature15)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 90 and getPlayerLevel(cid) <= 94 then
local creature16 = doCreateMonster("kikaichu[17]", getPlayerPosition(cid))
doCreatureAddMana(cid, -42)
doConvinceCreature(cid, creature16)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 95 and getPlayerLevel(cid) <= 99 then
local creature17 = doCreateMonster("kikaichu[18]", getPlayerPosition(cid))
doCreatureAddMana(cid, -44)
doConvinceCreature(cid, creature17)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 100 and getPlayerLevel(cid) <= 104 then
local creature18 = doCreateMonster("kikaichu[19]", getPlayerPosition(cid))
doCreatureAddMana(cid, -46)
doConvinceCreature(cid, creature18)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 105 and getPlayerLevel(cid) <= 109 then
local creature19 = doCreateMonster("kikaichu[20]", getPlayerPosition(cid))
doCreatureAddMana(cid, -48)
doConvinceCreature(cid, creature19)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 110 and getPlayerLevel(cid) <= 114 then
local creature20 = doCreateMonster("kikaichu[21]", getPlayerPosition(cid))
doCreatureAddMana(cid, -50)
doConvinceCreature(cid, creature20)
registerCreatureEvent(creature20, "summon1")
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 115 and getPlayerLevel(cid) <= 119 then
local creature21 = doCreateMonster("kikaichu[22]", getPlayerPosition(cid))
doCreatureAddMana(cid, -52)
doConvinceCreature(cid, creature21)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 120 and getPlayerLevel(cid) <= 124 then
local creature22 = doCreateMonster("kikaichu[23]", getPlayerPosition(cid))
doCreatureAddMana(cid, -54)
doConvinceCreature(cid, creature22)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 125 and getPlayerLevel(cid) <= 129 then
local creature23 = doCreateMonster("kikaichu[24]", getPlayerPosition(cid))
doCreatureAddMana(cid, -56)
doConvinceCreature(cid, creature23)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 130 and getPlayerLevel(cid) <= 134 then
local creature24 = doCreateMonster("kikaichu[25]", getPlayerPosition(cid))
doCreatureAddMana(cid, -58)
doConvinceCreature(cid, creature24)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 135 and getPlayerLevel(cid) <= 139 then
local creature25 = doCreateMonster("kikaichu[26]", getPlayerPosition(cid))
doCreatureAddMana(cid, -60)
doConvinceCreature(cid, creature25)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 140 and getPlayerLevel(cid) <= 144 then
local creature26 = doCreateMonster("kikaichu[27]", getPlayerPosition(cid))
doCreatureAddMana(cid, -62)
doConvinceCreature(cid, creature26)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 145 and getPlayerLevel(cid) <= 149 then
local creature27 = doCreateMonster("kikaichu[28]", getPlayerPosition(cid))
doCreatureAddMana(cid, -64)
doConvinceCreature(cid, creature27)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 150 and getPlayerLevel(cid) <= 154 then
local creature28 = doCreateMonster("kikaichu[29]", getPlayerPosition(cid))
doCreatureAddMana(cid, -66)
doConvinceCreature(cid, creature28)
end

if (table.maxn(summons) < MaximoSummon) and getPlayerLevel(cid) >= 155 and getPlayerLevel(cid) <= 1000 then
local creature29 = doCreateMonster("kikaichu[30]", getPlayerPosition(cid))
doCreatureAddMana(cid, -68)
doConvinceCreature(cid, creature29)
return TRUE
end
end