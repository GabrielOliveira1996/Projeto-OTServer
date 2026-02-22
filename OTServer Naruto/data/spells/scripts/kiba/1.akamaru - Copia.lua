function onCastSpell(cid, var)
    local summonNameBase = "akamaru"
    local akamarus = {
        {level = {from = 0, to = 5}, monster = "akamaru"},
        {level = {from = 6, to = 10}, monster = "akamaru"},
        {level = {from = 11, to = 15}, monster = "akamaru"},
        {level = {from = 16, to = 20}, monster = "akamaru"},
        {level = {from = 21, to = 25}, monster = "akamaru"},
        {level = {from = 26, to = 30}, monster = "akamaru"},
        {level = {from = 31, to = 35}, monster = "akamaru"},
        {level = {from = 36, to = 40},  monster = "akamaru"},
        {level = {from = 41, to = 45},  monster = "akamaru"},
        {level = {from = 46, to = 50},  monster = "akamaru"},
        {level = {from = 51, to = 55},  monster = "akamaru"},
        {level = {from = 56, to = 60},  monster = "akamaru"},
        {level = {from = 61, to = 65},  monster = "akamaru"},
        {level = {from = 66, to = 70},  monster = "akamaru"},
        {level = {from = 71, to = 75},  monster = "akamaru"},
        {level = {from = 76, to = 80},  monster = "akamaru"},
        {level = {from = 81, to = 85},  monster = "akamaru"},
        {level = {from = 86, to = 90},  monster = "akamaru"},
        {level = {from = 91, to = 95},  monster = "akamaru"},
        {level = {from = 96, to = 100},  monster = "akamaru"},
        {level = {from = 101, to = 105},  monster = "akamaru"},
        {level = {from = 106, to = 110},  monster = "akamaru"},
        {level = {from = 111, to = 115},  monster = "akamaru"},
        {level = {from = 116, to = 120},  monster = "akamaru"},
        {level = {from = 121, to = 125},  monster = "akamaru"},
        {level = {from = 126, to = 130},  monster = "akamaru"},
        {level = {from = 131, to = 135},  monster = "akamaru"},
        {level = {from = 136, to = 140},  monster = "akamaru"},
        {level = {from = 141, to = 145},  monster = "akamaru"},
        {level = {from = 146, to = 150},  monster = "akamaru"},
        {level = {from = 151, to = 155},  monster = "akamaru"},
        {level = {from = 156, to = 160},  monster = "akamaru"},
        {level = {from = 161, to = 165},  monster = "akamaru"},
        {level = {from = 166, to = 170},  monster = "akamaru"},
        {level = {from = 171, to = 175},  monster = "akamaru"},
        {level = {from = 176, to = 180},  monster = "akamaru"},
        {level = {from = 181, to = 185},  monster = "akamaru"},
        {level = {from = 186, to = 1000},  monster = "akamaru"},
    }

    -- NOVA VERIFICAÇÃO: Apenas para Akamaru ou Bunshin (Player Name)
    local summons = getCreatureSummons(cid)
    local pName = getPlayerName(cid):lower()
    
    for _, summon in ipairs(summons) do
        local sName = getCreatureName(summon):lower()
        -- Se já existir um Akamaru OU um Bunshin (mesmo nome do player)
        if sName:find("akamaru") or sName == pName then
            doPlayerSendCancel(cid, "You can only have one Akamaru at a time.")
            doSendMagicEffect(getThingPos(cid), CONST_ME_POFF)
            return false
        end
    end

    local pLevel = getPlayerLevel(cid)
    local pSpeed = getCreatureSpeed(cid)

    for i, akamaru in ipairs(akamarus) do
        if pLevel >= akamaru.level.from and pLevel <= akamaru.level.to then
            local monsterName = akamaru.monster .. "[" .. i .. "]"
            local monster = doCreateMonster(monsterName, getThingPos(cid))
            
            if monster then
                doConvinceCreature(cid, monster)
                registerCreatureEvent(monster, "summon1")
                doChangeSpeed(monster, pSpeed - getCreatureSpeed(monster))
                doSendMagicEffect(getThingPos(cid), 10)
                return true
            end
        end
    end

    return true
end