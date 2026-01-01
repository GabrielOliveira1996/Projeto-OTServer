local monsters = {
    ["mizuki"] = {stor = 11112, lose = 2},
    ["ebisu"] = {stor = 11117, lose = 2},
    ["zabuza"] = {stor = 11120, lose = 2},
    ["second zabuza"] = {stor = 11121, lose = 2},
    ["haku"] = {stor = 11122, lose = 2},
    ["orochimaru"] = {stor = 11000, lose = 2},
    ["zaku"] = {stor = 11127, lose = 2},
    ["kin"] = {stor = 11128, lose = 2},
    ["dosu"] = {stor = 11129, lose = 2},
    ["rain shinobi"] = {stor = 11131, lose = 2},
    ["kiba"] = {stor = 11133, lose = 2},
    ["neji"] = {stor = 11136, lose = 2},
    ["kankuro"] = {stor = 11138, lose = 2},
    ["temari"] = {stor = 11139, lose = 2},
    ["gaara"] = {stor = 11140, lose = 2},
    ["shukaku one"] = {stor = 11141, lose = 2},
    ["shukaku two"] = {stor = 11142, lose = 2},
    ["kabuto"] = {stor = 11146, lose = 2},
    ["sasuke"] = {stor = 11148, lose = 2},
    ["jiroubou"] = {stor = 11151, lose = 2},
    ["jiroubou cursed"] = {stor = 11152, lose = 2},
    ["kidomaru"] = {stor = 11153, lose = 2},
    ["kidomaru cursed"] = {stor = 11154, lose = 2},
    ["sakon and ukon"] = {stor = 11155, lose = 2},
    ["sakon and ukon cursed"] = {stor = 11156, lose = 2},
    ["tayuya"] = {stor = 11157, lose = 2},
    ["tayuya cursed"] = {stor = 11158, lose = 2},
    ["kimimaru"] = {stor = 11159, lose = 2},
    ["kimimaru cursed"] = {stor = 11160, lose = 2}
}

function onDeath(monster, corpse, deathList)
    local m = monsters[getCreatureName(monster):lower()]
    if not m then return true end
    for _, cid in pairs (deathList) do
        if isCreature(cid) and isPlayer(cid) then
            setPlayerStorageValue(cid, m.stor, getPlayerStorageValue(cid, m.stor) - m.lose)
        end
    end
return true
end