SpelllistSettings = {
    ['Default'] = {
        -- O caminho para a sua nova imagem que contém todos os Jutsus juntos
        iconFile = '/images/game/spells/naruto-icons-32x32', 
        
        -- O caminho para a imagem de cooldown (pode ser a mesma ou uma menor)
        iconsForGameCooldown = '/images/game/spells/naruto-icons-32x32', 
        
        iconSize = {
            width = 32,
            height = 32
        },
        iconSizeCooldown = {
            width = 32, -- Ajustado para 32 para bater com seu novo ícone
            height = 32
        },
        spellListWidth = 210,
        spellWindowWidth = 550,
        
        -- Ordem de exibição na lista
        spellOrder = {
            -- Naruto (0-10)
            'Kage Bunshin No Jutsu', 'Dai Rendan', 'Kyuubi Form', 'Rasengan', 'Daihoko', 'Oodama Rasengan', 'Rasenshuriken', 'Sanin Mode', 'Meditate', 'Bunshin Meditate', 'Bijudama',
            -- Sasuke (11-21)
            'Katon Daiendan No Jutsu', 'Sharingan', 'Katon Goukakyu No Jutsu', 'Cursed Seal', 'Chidori', 'Katon Ryuuka No Jutsu', 'Chidori Nagashi', 'Katon Gouryuuka No Jutsu', 'Kirin', 'Amaterasu', 'Susanoo',
            -- Sakura (22-32)
            'Bunshin No Jutsu', 'Shannaro', 'Chiyute', 'Doku Chiyo', 'Chakra Gan No Seizou', 'Chakra No Mesu', 'Chiyute Koumou', 'Create Scroll Of Healing', 'Oukashou', 'Sozo Sazei', 'Jinshin'
        }
    }
}

-- check "/docs/generate_spell_data.py"
-- spells from canary
SpellInfo = {
    Default = {
        -- --- NARUTO (Voca 1-4) ---
        ['Kage Bunshin No Jutsu'] = {id = 100, name = 'Kage Bunshin No Jutsu', words = 'kage bunshin no jutsu', icon = 'kage_bunshin_no_jutsu', clientId = 0, exhaustion = 1000, vocations = {1, 2, 3, 4}, level = 1, mana = 0, soul = 0, type = 'instant', premium = false, group = {[3] = 1000}, description = 'Cria um clone de você mesmo'},
        ['Dai Rendan'] = {id = 101, name = 'Dai Rendan', words = 'dai rendan', icon = 'dai_rendan', clientId = 1, exhaustion = 2000, vocations = {1, 2, 3, 4}, level = 20, mana = 50, soul = 0, type = 'instant', premium = false, group = {[1] = 2000}, description = 'Ataque rápido múltiplo'},
        ['Kyuubi Form'] = {id = 102, name = 'Kyuubi Form', words = 'kyuubi form', icon = 'kyuubi_form', clientId = 2, exhaustion = 1000, vocations = {1, 2, 3, 4}, level = 35, mana = 100, soul = 0, type = 'instant', premium = false, group = {[3] = 1000}, description = 'Transforma em Kyuubi'},
        ['Rasengan'] = {id = 103, name = 'Rasengan', words = 'rasengan', icon = 'rasengan', clientId = 3, exhaustion = 2000, vocations = {1, 2, 3, 4}, level = 15, mana = 40, soul = 0, type = 'instant', premium = false, group = {[1] = 2000}, description = 'Rotação pura de chakra'},
        ['Daihoko'] = {id = 104, name = 'Daihoko', words = 'daihoko', icon = 'daihoko', clientId = 4, exhaustion = 3000, vocations = {1, 2, 3, 4}, level = 25, mana = 70, soul = 0, type = 'instant', premium = false, group = {[1] = 3000}, description = 'Grande respiração de fogo'},
        ['Oodama Rasengan'] = {id = 105, name = 'Oodama Rasengan', words = 'oodama rasengan', icon = 'oodama_rasengan', clientId = 5, exhaustion = 2000, vocations = {1, 2, 3, 4}, level = 30, mana = 80, soul = 0, type = 'instant', premium = false, group = {[1] = 2000}, description = 'Rasengan gigante'},
        ['Rasenshuriken'] = {id = 106, name = 'Rasenshuriken', words = 'rasenshuriken', icon = 'rasenshuriken', clientId = 6, exhaustion = 3000, vocations = {1, 2, 3, 4}, level = 40, mana = 120, soul = 0, type = 'instant', premium = false, group = {[1] = 3000}, description = 'Shuriken de Chakra'},
        ['Sanin Mode'] = {id = 107, name = 'Sanin Mode', words = 'sanin mode', icon = 'sanin_mode', clientId = 7, exhaustion = 1000, vocations = {1, 2, 3, 4}, level = 32, mana = 90, soul = 0, type = 'instant', premium = false, group = {[3] = 1000}, description = 'Modo dos Três Ninjas'},
        ['Meditate'] = {id = 108, name = 'Meditate', words = 'meditate', icon = 'meditate', clientId = 8, exhaustion = 1000, vocations = {1, 2, 3, 4}, level = 5, mana = 0, soul = 0, type = 'instant', premium = false, group = {[3] = 1000}, description = 'Medita para recuperar mana'},
        ['Bunshin Meditate'] = {id = 109, name = 'Bunshin Meditate', words = 'bunshin meditate', icon = 'bunshin_meditate', clientId = 9, exhaustion = 1000, vocations = {1, 2, 3, 4}, level = 10, mana = 0, soul = 0, type = 'instant', premium = false, group = {[3] = 1000}, description = 'Meditação dupla'},
        ['Bijudama'] = {id = 110, name = 'Bijudama', words = 'bijudama', icon = 'bijudama', clientId = 10, exhaustion = 3000, vocations = {1, 2, 3, 4}, level = 45, mana = 150, soul = 0, type = 'instant', premium = false, group = {[1] = 3000}, description = 'Ataque final bijuu'},

        -- --- SASUKE (Voca 15-19) ---
        ['Katon Daiendan No Jutsu'] = {id = 200, name = 'Katon Daiendan No Jutsu', words = 'katon daiendan no jutsu', icon = 'katon_daiendan', clientId = 11, exhaustion = 2000, vocations = {15, 16, 17, 18, 19}, level = 12, mana = 45, soul = 0, type = 'instant', premium = false, group = {[1] = 2000}, description = 'Explosão de fogo'},
        ['Sharingan'] = {id = 201, name = 'Sharingan', words = 'sharingan', icon = 'sharingan', clientId = 12, exhaustion = 1000, vocations = {15, 16, 17, 18, 19}, level = 8, mana = 30, soul = 0, type = 'instant', premium = false, group = {[3] = 1000}, description = 'Ativa o Sharingan'},
        ['Katon Goukakyu No Jutsu'] = {id = 202, name = 'Katon Goukakyu No Jutsu', words = 'katon goukakyu no jutsu', icon = 'katon_goukakyu', clientId = 13, exhaustion = 2000, vocations = {15, 16, 17, 18, 19}, level = 18, mana = 55, soul = 0, type = 'instant', premium = false, group = {[1] = 2000}, description = 'Bola de fogo grande'},
        ['Cursed Seal'] = {id = 203, name = 'Cursed Seal', words = 'cursed seal', icon = 'cursed_seal', clientId = 14, exhaustion = 1000, vocations = {15, 16, 17, 18, 19}, level = 22, mana = 60, soul = 0, type = 'instant', premium = false, group = {[3] = 1000}, description = 'Marcação amaldiçoada'},
        ['Chidori'] = {id = 204, name = 'Chidori', words = 'chidori', icon = 'chidori', clientId = 15, exhaustion = 2000, vocations = {15, 16, 17, 18, 19}, level = 25, mana = 70, soul = 0, type = 'instant', premium = false, group = {[1] = 2000}, description = 'Lâmina de eletricidade'},
        ['Katon Ryuuka No Jutsu'] = {id = 205, name = 'Katon Ryuuka No Jutsu', words = 'katon ryuuka no jutsu', icon = 'katon_ryuuka', clientId = 16, exhaustion = 2000, vocations = {15, 16, 17, 18, 19}, level = 28, mana = 75, soul = 0, type = 'instant', premium = false, group = {[1] = 2000}, description = 'Dragão de fogo'},
        ['Chidori Nagashi'] = {id = 206, name = 'Chidori Nagashi', words = 'chidori nagashi', icon = 'chidori_nagashi', clientId = 17, exhaustion = 2000, vocations = {15, 16, 17, 18, 19}, level = 30, mana = 85, soul = 0, type = 'instant', premium = false, group = {[1] = 2000}, description = 'Chidori em rede'},
        ['Katon Gouryuuka No Jutsu'] = {id = 207, name = 'Katon Gouryuuka No Jutsu', words = 'katon gouryuuka no jutsu', icon = 'katon_gouryuuka', clientId = 18, exhaustion = 2000, vocations = {15, 16, 17, 18, 19}, level = 35, mana = 100, soul = 0, type = 'instant', premium = false, group = {[1] = 2000}, description = 'Dragão de fogo grande'},
        ['Kirin'] = {id = 208, name = 'Kirin', words = 'kirin', icon = 'kirin', clientId = 19, exhaustion = 3000, vocations = {15, 16, 17, 18, 19}, level = 42, mana = 130, soul = 0, type = 'instant', premium = false, group = {[1] = 3000}, description = 'Relâmpago celestial'},
        ['Amaterasu'] = {id = 209, name = 'Amaterasu', words = 'amaterasu', icon = 'amaterasu', clientId = 20, exhaustion = 3000, vocations = {15, 16, 17, 18, 19}, level = 48, mana = 160, soul = 0, type = 'instant', premium = false, group = {[1] = 3000}, description = 'Chama negra eterna'},
        ['Susanoo'] = {id = 210, name = 'Susanoo', words = 'susanoo', icon = 'susanoo', clientId = 21, exhaustion = 3000, vocations = {15, 16, 17, 18, 19}, level = 50, mana = 180, soul = 0, type = 'instant', premium = false, group = {[3] = 3000}, description = 'Avatar lendário'},

        -- --- SAKURA (Voca 24-28) ---
        ['Bunshin No Jutsu'] = {id = 300, name = 'Bunshin No Jutsu', words = 'bunshin no jutsu', icon = 'bunshin', clientId = 22, exhaustion = 1000, vocations = {24, 25, 26, 27, 28}, level = 6, mana = 15, soul = 0, type = 'instant', premium = false, group = {[3] = 1000}, description = 'Clone básico'},
        ['Shannaro'] = {id = 301, name = 'Shannaro', words = 'shannaro', icon = 'shannaro', clientId = 23, exhaustion = 2000, vocations = {24, 25, 26, 27, 28}, level = 16, mana = 50, soul = 0, type = 'instant', premium = false, group = {[1] = 2000}, description = 'Soco poderoso'},
        ['Chiyute'] = {id = 302, name = 'Chiyute', words = 'chiyute', icon = 'chiyute', clientId = 24, exhaustion = 1000, vocations = {24, 25, 26, 27, 28}, level = 10, mana = 35, soul = 0, type = 'instant', premium = false, group = {[2] = 1000}, description = 'Técnica de cura'},
        ['Doku Chiyo'] = {id = 303, name = 'Doku Chiyo', words = 'doku chiyo', icon = 'doku_chiyo', clientId = 25, exhaustion = 1000, vocations = {24, 25, 26, 27, 28}, level = 14, mana = 40, soul = 0, type = 'instant', premium = false, group = {[2] = 1000}, description = 'Veneno curandeiro'},
        ['Chakra Gan No Seizou'] = {id = 304, name = 'Chakra Gan No Seizou', words = 'chakra gan no seizou', icon = 'chakra_gan', clientId = 26, exhaustion = 1000, vocations = {24, 25, 26, 27, 28}, level = 18, mana = 55, soul = 0, type = 'instant', premium = false, group = {[3] = 1000}, description = 'Criação de chakra'},
        ['Chakra No Mesu'] = {id = 305, name = 'Chakra No Mesu', words = 'chakra no mesu', icon = 'chakra_mesu', clientId = 27, exhaustion = 1000, vocations = {24, 25, 26, 27, 28}, level = 20, mana = 60, soul = 0, type = 'instant', premium = false, group = {[3] = 1000}, description = 'Escalpelo de chakra'},
        ['Chiyute Koumou'] = {id = 306, name = 'Chiyute Koumou', words = 'chiyute koumou', icon = 'chiyute_koumou', clientId = 28, exhaustion = 1000, vocations = {24, 25, 26, 27, 28}, level = 24, mana = 70, soul = 0, type = 'instant', premium = false, group = {[2] = 1000}, description = 'Técnica de ressurreição'},
        ['Create Scroll Of Healing'] = {id = 307, name = 'Create Scroll Of Healing', words = 'create scroll of healing', icon = 'scroll_healing', clientId = 29, exhaustion = 1000, vocations = {24, 25, 26, 27, 28}, level = 5, mana = 25, soul = 0, type = 'instant', premium = false, group = {[3] = 1000}, description = 'Cria rolo de cura'},
        ['Oukashou'] = {id = 308, name = 'Oukashou', words = 'oukashou', icon = 'oukashou', clientId = 30, exhaustion = 2000, vocations = {24, 25, 26, 27, 28}, level = 32, mana = 90, soul = 0, type = 'instant', premium = false, group = {[1] = 2000}, description = 'Palma vermelho-branca'},
        ['Sozo Sazei'] = {id = 309, name = 'Sozo Sazei', words = 'sozo sazei', icon = 'sozo_sazei', clientId = 31, exhaustion = 1000, vocations = {24, 25, 26, 27, 28}, level = 38, mana = 110, soul = 0, type = 'instant', premium = false, group = {[2] = 1000}, description = 'Regeneração de órgãos'},
        ['Jinshin'] = {id = 310, name = 'Jinshin', words = 'jinshin', icon = 'jinshin', clientId = 32, exhaustion = 2000, vocations = {24, 25, 26, 27, 28}, level = 44, mana = 140, soul = 0, type = 'instant', premium = false, group = {[1] = 2000}, description = 'Técnica de criação divina'},
    }
}

VocationNames = {
    [0] = 'None',

    [1] = 'Naruto',
    [2] = 'Naruto',
    [3] = 'Naruto',
    [4] = 'Naruto',

    [15] = 'Sasuke',
    [16] = 'Sasuke',
    [17] = 'Sasuke',
    [18] = 'Sasuke',
    [19] = 'Sasuke',

    [24] = 'Sakura',
    [25] = 'Sakura',
    [26] = 'Sakura',
    [27] = 'Sakura',
    [28] = 'Sakura',
}

SpellGroups = {
    [1] = 'Attack',
    [2] = 'Healing',
    [3] = 'Support',
    [4] = 'Special',
    [5] = 'Conjure',
    [6] = 'Crippling',
    [7] = 'Focus',
    [8] = 'UltimateStrikes',
    [9] = 'GreatBeams',
    [10] = 'BurstsOfNature',
    [11] = 'Virtue'
}

SpellRunesData = {
    [3148] = {id = 30, group = 3, name = 'destroy field rune', exhaustion = 2000},
    [3149] = {id = 55, group = 1, name = 'energybomb rune', exhaustion = 2000},
    [3152] = {id = 4, group = 2, name = 'intense healing rune', exhaustion = 1000},
    [3153] = {id = 31, group = 2, name = 'antidote rune', exhaustion = 1000},
    [3155] = {id = 21, group = 1, name = 'sudden death rune', exhaustion = 2000},
    [3156] = {id = 94, group = 1, name = 'Wild Growth Rune', exhaustion = 2000},
    [3158] = {id = 114, group = 1, name = 'icicle rune', exhaustion = 2000},
    [3160] = {id = 5, group = 2, name = 'ultimate healing rune', exhaustion = 1000},
    [3161] = {id = 115, group = 1, name = 'avalanche rune', exhaustion = 2000},
    [3164] = {id = 27, group = 1, name = 'energy field rune', exhaustion = 2000},
    [3165] = {id = 54, group = 3, name = 'paralyze rune', exhaustion = 6000},
    [3166] = {id = 33, group = 1, name = 'energy wall rune', exhaustion = 2000},
    [3172] = {id = 26, group = 1, name = 'poison field rune', exhaustion = 2000},
    [3173] = {id = 91, group = 1, name = 'poison bomb rune', exhaustion = 2000},
    [3174] = {id = 7, group = 1, name = 'light magic missile rune', exhaustion = 2000},
    [3175] = {id = 116, group = 1, name = 'stone shower rune', exhaustion = 2000},
    [3176] = {id = 32, group = 1, name = 'poison wall rune', exhaustion = 2000},
    [3177] = {id = 12, group = 3, name = 'convince creature rune', exhaustion = 2000},
    [3178] = {id = 14, group = 3, name = 'chameleon rune', exhaustion = 2000},
    [3179] = {id = 77, group = 1, name = 'stalagmite rune', exhaustion = 2000},
    [3180] = {id = 86, group = 1, name = 'Magic Wall Rune', exhaustion = 2000},
    [3182] = {id = 130, group = 1, name = 'holy missile rune', exhaustion = 2000},
    [3188] = {id = 25, group = 1, name = 'fire field rune', exhaustion = 2000},
    [3189] = {id = 15, group = 1, name = 'fireball rune', exhaustion = 2000},
    [3190] = {id = 28, group = 1, name = 'fire wall rune', exhaustion = 2000},
    [3191] = {id = 16, group = 1, name = 'great fireball rune', exhaustion = 2000},
    [3192] = {id = 17, group = 1, name = 'firebomb rune', exhaustion = 2000},
    [3195] = {id = 50, group = 1, name = 'soulfire rune', exhaustion = 2000},
    [3197] = {id = 78, group = 3, name = 'desintegrate rune', exhaustion = 2000},
    [3198] = {id = 8, group = 1, name = 'heavy magic missile rune', exhaustion = 2000},
    [3200] = {id = 18, group = 1, name = 'explosion rune', exhaustion = 2000},
    [3202] = {id = 117, group = 1, name = 'thunderstorm rune', exhaustion = 2000},
    [3203] = {id = 83, group = 3, name = 'animate dead rune', exhaustion = 2000},
    [17512] = {id = 7, group = 1, name = 'lightest magic missile rune', exhaustion = 2000},
    [21351] = {id = 116, group = 1, name = 'light stone shower rune', exhaustion = 2000},
    [21352] = {id = 7, group = 1, name = 'lightest missile rune', exhaustion = 2000}
}

Spells = {}

function Spells.getSpellList()
    local spells = {}
    for k, spell in pairs(SpellInfo["Default"]) do
        table.insert(spells, spell)
    end
    return spells
end

function Spells.getSpellByName(name)
    return SpellInfo[Spells.getSpellProfileByName(name)][name]
end

function Spells.getSpellByWords(words)
    local words = words:lower():trim()
    for profile, data in pairs(SpellInfo) do
        for k, spell in pairs(data) do
            if spell.words == words then
                return spell, profile, k
            end
        end
    end
    return nil
end

function Spells.getSpellByIcon(iconId)
    for profile, data in pairs(SpellInfo) do
        for k, spell in pairs(data) do
            if spell.id == iconId then
                return spell, profile, k
            end
        end
    end
    return nil
end

function Spells.getSpellIconIds()
    local ids = {}
    for profile, data in pairs(SpellInfo) do
        for k, spell in pairs(data) do
            table.insert(ids, spell.id)
        end
    end
    return ids
end

function Spells.getSpellProfileById(id)
    for profile, data in pairs(SpellInfo) do
        for k, spell in pairs(data) do
            if spell.id == id then
                return profile
            end
        end
    end
    return nil
end

function Spells.getSpellProfileByWords(words)
    for profile, data in pairs(SpellInfo) do
        for k, spell in pairs(data) do
            if spell.words == words then
                return profile
            end
        end
    end
    return nil
end

function Spells.getSpellDataByWords(words)
    for profile, data in pairs(SpellInfo) do
        for k, spell in pairs(data) do
            if spell.words == words then
                return spell
            end
        end
    end
    return nil
end

function Spells.getSpellDataByParamWords(words)
    for profile, data in pairs(SpellInfo) do
        for k, spell in pairs(data) do
            local inputWords = words:lower()
            local spellWords = spell.words:lower()
            local quoteStartIndex = inputWords:find('%"')

            if not spell.parameter then
                if inputWords == spellWords then
                    return spell, nil
                end
            else
                if quoteStartIndex then
                    local spellPart = inputWords:sub(1, quoteStartIndex - 1):match("^%s*(.-)%s*$")
                    local parameter = inputWords:sub(quoteStartIndex + 1)
                    if spellPart == spellWords then
                        return spell, parameter
                    end
                else
                    if inputWords == spellWords then
                        return spell, nil
                    end
                end
            end
        end
    end
    return nil, nil
end

function Spells.getSpellFormatedName(words)
    for profile, data in pairs(SpellInfo) do
        for k, spell in pairs(data) do
            local inputWords = words:lower()
            local spellWords = spell.words:lower()

            if not spell.parameter then
                if inputWords == spellWords then
                    return spellWords
                end
            else
                if string.sub(inputWords, 1, string.len(spellWords)) == spellWords then
                    local extraText = string.sub(inputWords, string.len(spellWords) + 1)
                    if extraText ~= "" then
                        if string.sub(extraText, 1, 1) == " " then
                            local firstChar = string.sub(extraText, 2, 2)
                            if firstChar == '"' then
                                local fomated = extraText:gsub('"', '')
                                fomated = "\"" .. string.sub(fomated, 2) .. "\""
                                return spellWords .. " " .. fomated
                            else
                                return spellWords .. extraText
                            end
                        end
                    else
                        return spellWords
                    end
                end
            end
        end
    end
    return words
end

function Spells.getSpellNameByWords(words)
    for profile, data in pairs(SpellInfo) do
        for k, spell in pairs(data) do
            if spell.words == words then
                return k
            end
        end
    end
    return nil
end

function Spells.getSpellDataById(spellId)
    for _, data in pairs(SpellInfo) do
        for k, spell in pairs(data) do
            if spell.id == spellId then
                return spell
            end
        end
    end
    return nil
end

function Spells.getRuneSpellByItem(itemId)
    local data = SpellRunesData[itemId]
    if data then
        return data
    end
    return nil
end

function Spells.isRuneSpell(spellId)
    for _, data in pairs(SpellRunesData) do
        if data.id == spellId then
            return true
        end
    end
    return false
end

function Spells.getSpellProfileByName(spellName)
    for profile, data in pairs(SpellInfo) do
        if table.findbykey(data, spellName:trim(), true) then
            return profile
        end
    end
    return nil
end

function Spells.getSpellsByVocationId(vocId)
    local spells = {}
    for profile, data in pairs(SpellInfo) do
        for k, spell in pairs(data) do
            if table.contains(spell.vocations, vocId) then
                table.insert(spells, spell)
            end
        end
    end
    return spells
end

function Spells.filterSpellsByGroups(spells, groups)
    local filtered = {}
    for v, spell in pairs(spells) do
        local spellGroups = Spells.getGroupIds(spell)
        if table.equals(spellGroups, groups) then
            table.insert(filtered, spell)
        end
    end
    return filtered
end

function Spells.getCooldownByGroup(spellData, groupId)
    local keys = {}
    for k in pairs(spellData.group) do
        table.insert(keys, k)
    end
    table.sort(keys)
    local index = 1
    for _, k in ipairs(keys) do
        if index == 1 and k == groupId then
            return spellData.group[k]
        end
        index = index + 1
    end
    return nil
end

function Spells.getCooldownBySecondaryGroup(spellData, groupId)
    local keys = {}
    for k in pairs(spellData.group) do
        table.insert(keys, k)
    end
    table.sort(keys)
    local index = 1
    for _, k in ipairs(keys) do
        if index == 2 and k == groupId then
            return spellData.group[k]
        end
        index = index + 1
    end
    return nil
end

function Spells.getGroupIds(spell)
    local groups = {}
    for k, _ in pairs(spell.group) do
        table.insert(groups, k)
    end
    return groups
end

function Spells.getPrimaryGroup(spell)
    local indexes = {}
    for k in pairs(spell.group) do
        table.insert(indexes, k)
    end
    table.sort(indexes)
    return indexes[1] or -1
end

function Spells.getIconFileByProfile(profile)
    return SpelllistSettings[profile]['iconFile']
end

function Spells.getImageClip(indexClip, profile)
    if profile == nil or not SpelllistSettings[profile] then
        profile = "Default"
    end

    local settings = SpelllistSettings[profile]
    local iconWidth = settings.iconSize.width
    local iconHeight = settings.iconSize.height

    local id = tonumber(indexClip)

    if not id then
        return "0 0 " .. iconWidth .. " " .. iconHeight
    end

    local xOffset = id * iconWidth
    
    return xOffset .. " 0 " .. iconWidth .. " " .. iconHeight
end

function Spells.getImageClipCooldown(indexClip, profile)
    if profile == nil then profile = "Default" end
    local settings = SpelllistSettings[profile]
    if not settings or not settings.iconSizeCooldown then return "0 0 0 0" end
    
    local iconId = tonumber(indexClip) or 0
    local width = settings.iconSizeCooldown.width
    local height = settings.iconSizeCooldown.height
    
    -- Calcula a posição exata no Atlas
    return (iconId * width) .. " 0 " .. width .. " " .. height
end
