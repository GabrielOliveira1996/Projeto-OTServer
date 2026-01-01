function onLogin(cid)

        local Vocations = {
        [0] = {Type=382}, -- Madara
        [1] = {Type=6}, -- shikamaru
        [2] = {Type=388}, -- shikamaru train
        [3] = {Type=5}, -- shikamaru shippuden
        [4] = {Type=7}, -- shikamaru master of shadowns
        [5] = {Type=8}, -- gaara 
        [7] = {Type=59}, -- gaara shippuden
        [8] = {Type=162}, -- gaara kazekage
        [9] = {Type=18}, -- kiba x
        [10] = {Type=386}, -- kiba train x
        [11] = {Type=25}, -- kiba shippuden x
        [12] = {Type=25}, -- kiba stronger x
        [13] = {Type=387}, -- sakura do cabelo grande type 50
        [14] = {Type=387}, -- sakura train x
        [15] = {Type=69}, -- sakura shippuden x
        [16] = {Type=12}, -- sakura stronger x
        [17] = {Type=174}, -- shino x
        [18] = {Type=174}, -- shino x
        [19] = {Type=175}, -- shino shippuden x
        [20] = {Type=175}, -- shino master of insects x
        [21] = {Type=4}, -- kankuro  
        [22] = {Type=385}, -- kankuro train  
        [23] = {Type=34}, -- kankuro shippuden
        [24] = {Type=163}, -- kankuro stronger 
        [25] = {Type=82}, -- temari 
        [26] = {Type=389}, -- temari train 
        [27] = {Type=83}, -- temari shippuden 
        [28] = {Type=173}, -- temari stronger
        [29] = {Type=206}, -- neji x
        [30] = {Type=206}, -- neji x
        [31] = {Type=68}, -- neji shippuden x
        [32] = {Type=171}, -- neji stronger x
        [33] = {Type=358}, -- sasuke 
        [35] = {Type=359}, -- sasuke shippuden
        [36] = {Type=172}, -- sasuke akatsuki member
        [37] = {Type=352}, -- naruto x
        [39] = {Type=353}, -- naruto shippuden x
        [40] = {Type=164}, -- naruto sannin x
        [41] = {Type=373}, -- rock lee
        [43] = {Type=374}, -- rock lee shippuden
        [44] = {Type=374}, -- rock lee stronger
        [45] = {Type=176}, -- ino 
        [46] = {Type=176}, -- ino 
        [47] = {Type=177}, -- ino shippuden
        [48] = {Type=179}, -- ino stronger
        [49] = {Type=180}, -- chouji
        [50] = {Type=180}, -- chouji
        [51] = {Type=181}, -- chouji shippuden
        [52] = {Type=181}, -- chouji stronger
        [53] = {Type=184}, -- hinata
        [54] = {Type=384}, -- hinata train
        [55] = {Type=185}, -- hinata shippuden
        [56] = {Type=186}, -- hinata stronger
        [57] = {Type=187}, -- sai x
        [58] = {Type=187}, -- sai x
        [59] = {Type=187}, -- sai shippuden x
        [60] = {Type=188}, -- sai stronger x

        [64] = {Type=188}, -- kyuubi x
        [65] = {Type=188}, -- kyuubi x
        [66] = {Type=188}, -- kyuubi x
        [67] = {Type=188}, -- kyuubi x
        [81] = {Type=188}, -- kyuubi x

        [76] = {Type=190}, -- tenten 
        [77] = {Type=390}, -- tenten train
        [78] = {Type=191}, -- tenten shippuden
        [79] = {Type=191}, -- tenten master of weapons

        [102] = {Type=26}, -- minato
        [103] = {Type=27}, -- minato train 
        [104] = {Type=33}, -- minato shippuden
        [105] = {Type=37} -- minato yondaime
        }

        --[[
        Addons // 
                0 = sem
                1 = primeiro addons
                2 = segundo addons
                3 = primeiro addons e segundo addons // Addons Full
        ]]--

        if getPlayerVocation(cid) >= 0 and getPlayerVocation(cid) <=105 then
                local Voc = Vocations[getPlayerVocation(cid)]
                doCreatureChangeOutfit(cid, {lookType = Voc.Type, lookHead = Voc.Head, lookBody = Voc.Body, lookLegs = Voc.Legs, lookFeet = Voc.Feet, lookAddons = Voc.Addons})
                
                if getPlayerVocation(cid) == 0 then
                        VocName = "[MadarA]"
                else
                        VocName = getPlayerVocationName(cid)
                end
                
                doCreatureSay(cid, VocName, TALKTYPE_ORANGE_1)
        else
                doPlayerSendTextMessage(cid,26,"Vocação não configurada.")
        end
        return true
end



