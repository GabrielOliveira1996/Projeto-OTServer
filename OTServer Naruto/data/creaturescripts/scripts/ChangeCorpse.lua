function onLogin(cid)
    registerCreatureEvent(cid, "ChangeCorpse")
return true
end

function onDeath(cid, corpse, deathList)
    local voc = {
        [1] = 2830, --- shikamaru
        [2] = 2930, --- shikamaru 
        [3] = 2832, --- shikamaru
        [4] = 2833, --- shikamaru

        [5] = 2816, --- gaara
        [6] = 2816, --- gaara
        [7] = 2817, --- gaara
        [8] = 2818, --- gaara

        [9] = 2845, --- kiba
        [10] = 2845, --- kiba
        [11] = 2946, --- kiba
        [12] = 2946, --- kiba

        [13] = 2813, --- sakura
        [14] = 2814, --- sakura
        [15] = 2815, --- sakura
        [16] = 2815, --- sakura

        [17] = 2843, --- shino
        [18] = 2843, --- shino
        [19] = 2844, --- shino
        [20] = 2844, --- shino

        [21] = 2823, --- kankuro
        [22] = 2824, --- kankuro
        [23] = 2825, --- kankuro
        [24] = 2825, --- kankuro

        [25] = 2819, --- temari
        [26] = 2820, --- temari
        [27] = 2821, --- temari
        [28] = 2822, --- temari

        [29] = 2834, --- neji
        [30] = 2834, --- neji
        [31] = 2835, --- neji
        [32] = 2835, --- neji

        [33] = 2809, --- sasuke
        [34] = 2809, --- sasuke
        [35] = 2810, --- sasuke
        [36] = 2811, --- sasuke

        [37] = 2806, --- naruto
        [38] = 2806, --- naruto
        [39] = 2807, --- naruto
        [40] = 2807, --- naruto

        [41] = 2836, --- rock lee
        [42] = 2836, --- rock lee
        [43] = 2837, --- rock lee
        [44] = 2837, --- rock lee

        [45] = 2828, --- ino
        [46] = 2828, --- ino
        [47] = 2829, --- ino
        [48] = 2829, --- ino

        [49] = 2826, --- chouji
        [50] = 2826, --- chouji
        [51] = 2827, --- chouji 4323 -- mudar
        [52] = 2827, --- chouji 4323 -- mudar

        [53] = 2841, --- hinata
        [54] = 2841, --- hinata
        [55] = 2842, --- hinata
        [56] = 2842, --- hinata

        [57] = 2847, --- sai
        [58] = 2847, --- sai
        [59] = 2848, --- sai
        [60] = 2848, --- sai

        [61] = 2809,  --- cursed two
        [62] = 2809, --- cursed three
        [63] = 2810, --- cursed four
       
        [64] = 2806, --- kyuubi form one
        [65] = 2806, --- kyuubi two
        [66] = 2806, --- kyuubi three
        [67] = 2807, --- kyuubi four
        
        [68] = 6023, --- vazio

        [69] = 2814, --- haruno power

        [70] = 2836, --- gate one
        [71] = 2836, --- gate two
        [72] = 2836, --- gate three
        [73] = 2837, --- gate four

        [74] = 2816, --- shukaku one
        [75] = 2816, --- shukaku two

        [76] = 2838, --- tenten
        [77] = 2839, --- tenten
        [78] = 2840, --- tenten
        [79] = 2840, --- tenten

        [80] = 2847, --- sai cumulated

        [81] = 2808, --- sage mode

        [82] = 2837, --- gate seven
 
        [83] = 2816, --- shukaku form three
        [84] = 2945, --- vazio

        [85] = 2945, --- vazio
        [86] = 2945, --- vazio
        [87] = 2945, --- vazio
        [88] = 2945, --- vazio

        [89] = 2820, --- vazio
        [90] = 2820, --- vazio
        [91] = 2945, --- vazio
        [92] = 2809, --- cursed one

        [95] = 2834, --- neji cumulated

        [98] = 2815, --- sakura shippuden cumulated
        [99] = 2815, --- sakura strong cumulated

        [100] = 2835, --- neji shippuden cumulated
        [101] = 2835, --- neji strong cumulated
        [102] = 2883, --- minato
        [103] = 2884, --- minato train
        [104] = 2885, --- minato shippuden
        [105] = 2886 --- minato yondaime
    }

    local newCorpse = voc[getPlayerVocation(cid)]
    if newCorpse and newCorpse ~= corpse.itemid then
        addEvent(function (pos, newId, oldId)
            local corpse = getTileItemById(pos, oldId)
            if corpse.uid <= 1 then return end
            doTransformItem(corpse.uid, newId)
            doDecayItem(corpse.uid)
            end, 1, getThingPos(cid), newCorpse, corpse.itemid)
    end

return true
end