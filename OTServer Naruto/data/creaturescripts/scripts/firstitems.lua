local firstItems = {}
firstItems[0] =
{
2459,
2470,
2483
}
firstItems[1] =
{
2459,
2470,
2483
}
firstItems[2] =
{
2459,
2470,
2483
}
firstItems[3] =
{
2459,
2470,
2483
}
firstItems[4] =
{
2459,
2470,
2483
}
firstItems[5] =
{
2459,
2470,
2483
}
firstItems[6] =
{
2459,
2470,
2483
}
firstItems[7] =
{
2459,
2470,
2483
}
firstItems[8] =
{
2459,
2470,
2483
}

firstItems[9] = {2459, 2483, 2470, 2445, 3982} -- Kiba

firstItems[13] = {2459, 2483, 2470, 2445, 3982} -- Sakura

firstItems[19] =
{
2459,
2470,
2445
}
firstItems[20] =
{
2459,
2470,
2445
}
firstItems[21] =
{
2459,
2470,
2388
}
firstItems[22] =
{
2459,
2470,
2388
}
firstItems[23] =
{
2459,
2470,
2388
}
firstItems[24] =
{
2459,
2470,
2388
}
firstItems[25] =
{
2459,
2470,
2388
}
firstItems[26] =
{
2459,
2470,
2388
}
firstItems[27] =
{
2459,
2470,
2388
}
firstItems[28] =
{
2459,
2470,
2388
}
firstItems[29] =
{
2459,
2470,
2388
}
firstItems[30] =
{
2459,
2470,
2388
}
firstItems[31] =
{
2459,
2470,
2388
}
firstItems[32] =
{
2459,
2470,
2388
}
firstItems[33] = -- Sasuke
{
    2459,
    2483,
    2470,
    2412,
    3982
}
firstItems[34] =
{
2459,
2470,
2445
}
firstItems[35] =
{
2459,
2470,
2445
}
firstItems[36] =
{
    2459,
    2483,
    2470,
    2445,
    3982
}
firstItems[37] = -- Naruto
{
    2459,
    2483,
    2470,
    2445,
    3982
}
firstItems[38] =
{
    2459,
    2483,
    2470,
    2445,
    3982
}
firstItems[39] =
{
    2459,
    2483,
    2470,
    2445,
    3982
}
firstItems[40] =
{
    2459,
    2483,
    2470,
    2445,
    3982
}
firstItems[41] = -- rock lee
{
    2459,
    2483,
    2470,
    2445,
    3982
}
firstItems[42] =
{
    2459,
    2483,
    2470,
    2445,
    3982
}
firstItems[43] =
{
    2459,
    2483,
    2470,
    2445,
    3982
}
firstItems[44] =
{
    2459,
    2483,
    2470,
    2445,
    3982
}
firstItems[45] =
{
    2459,
    2483,
    2470,
    2445,
    3982
}
firstItems[46] =
{
    2459,
    2483,
    2470,
    2445,
    3982
}
firstItems[47] =
{
2459,
2470,
2388
}
firstItems[48] =
{
2459,
2470,
2388
}
firstItems[49] =
{
2459,
2470,
2388
}
firstItems[50] =
{
2459,
2470,
2388
}
firstItems[51] =
{
2459,
2470,
2388
}
firstItems[52] =
{
2459,
2470,
2388
}
firstItems[53] = -- Hinata
{
    2459,
    2483,
    2470,
    2445,
    3982
}
firstItems[57] =
{
2459,
2470,
2388
}
firstItems[58] =
{
2459,
2470,
2388
}
firstItems[59] =
{
2459,
2470,
2388
}
firstItems[60] =
{
2459,
2470,
2388
}
firstItems[76] =
{
2459,
2470,
2388
}
firstItems[77] =
{
2459,
2470,
2388
}
firstItems[78] =
{
2459,
2470,
2388
}
firstItems[79] =
{
2459,
2470,
2388
}

firstItems[102] =
{
2459,
2470,
2483
}

function onLogin(cid)
    if getPlayerStorageValue(cid, 30001) == -1 then
        for i = 1, table.maxn(firstItems[getPlayerVocation(cid)]) do
            doPlayerAddItem(cid, firstItems[getPlayerVocation(cid)][i], 1)
        end
        local bag = doPlayerAddItem(cid, 1987, 1)
        doAddContainerItem(bag, 2666, 2)
        setPlayerStorageValue(cid, 30001, 1)
    end
    return true
end