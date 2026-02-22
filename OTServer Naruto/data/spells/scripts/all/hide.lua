local effect = 10 -- efeito que sai ao remover o summon

function onCastSpell(cid, var)
    local summons = getCreatureSummons(cid)
    
    local protegidos = {"gamakichi", "katsuyo"}

    for _, summon in pairs(summons) do
        local name = getCreatureName(summon):lower()
        local isProtected = false

        for _, nomeProtegido in ipairs(protegidos) do
            if name:find(nomeProtegido) then
                isProtected = true
                break
            end
        end

        if not isProtected then
            doSendMagicEffect(getThingPos(summon), effect)
            doRemoveCreature(summon)
        end
    end
    
    return true
end