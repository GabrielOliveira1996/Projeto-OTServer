local function getExpForLevel(level)
    level = level - 1
    return (50/3) * (level^3 - 6*(level^2) + 17*level - 12)
end

local config = {
    exp_rate = 1.0, 
    storage_lv = 60001,
    storage_exp = 60002,
    storage_points = 60003, -- Pontos disponíveis
    points_per_level = 3   -- Quantos pontos ganha por nível
}

function onKill(cid, target)
    if not isPlayer(cid) or not isMonster(target) then return true end

    local summons = getCreatureSummons(cid)
    if #summons > 0 then
        local akamaru = summons[1]
        if getCreatureName(akamaru):lower():find("akamaru") then
            
            local monster_exp = getMonsterInfo(getCreatureName(target)).experience
            local give_exp = math.floor(monster_exp * config.exp_rate)
            
            local current_lv = math.max(1, getPlayerStorageValue(cid, config.storage_lv))
            local current_exp = math.max(0, getPlayerStorageValue(cid, config.storage_exp))
            
            local new_exp = current_exp + give_exp
            
            if new_exp >= getExpForLevel(current_lv + 1) then
                local levels_gained = 0
                while new_exp >= getExpForLevel(current_lv + 1) do
                    current_lv = current_lv + 1
                    levels_gained = levels_gained + 1
                end

                setPlayerStorageValue(cid, config.storage_lv, current_lv)
                setPlayerStorageValue(cid, config.storage_exp, new_exp)
                
                -- Adiciona os pontos
                local old_pts = math.max(0, getPlayerStorageValue(cid, config.storage_points))
                setPlayerStorageValue(cid, config.storage_points, old_pts + (levels_gained * config.points_per_level))

                doSendMagicEffect(getCreaturePosition(akamaru), 28) 
                doPlayerSendTextMessage(cid, MESSAGE_STATUS_CONSOLE_BLUE, "Akamaru subiu para o nível " .. current_lv .. "! Ganhou " .. (levels_gained * config.points_per_level) .. " pontos.")
            else
                setPlayerStorageValue(cid, config.storage_exp, new_exp)
            end
        end
    end
    return true
end