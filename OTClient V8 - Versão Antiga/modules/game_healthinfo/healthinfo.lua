-- Health Info & Circles Logic
-- Corrigido para esconder o conjunto (cor + fundo) e evitar erros no options.lua

Icons = {}
Icons[PlayerStates.Poison] = { tooltip = tr('You are poisoned'), path = '/images/game/states/poisoned', id = 'condition_poisoned' }
Icons[PlayerStates.Burn] = { tooltip = tr('You are burning'), path = '/images/game/states/burning', id = 'condition_burning' }
Icons[PlayerStates.Energy] = { tooltip = tr('You are electrified'), path = '/images/game/states/electrified', id = 'condition_electrified' }
Icons[PlayerStates.Drunk] = { tooltip = tr('You are drunk'), path = '/images/game/states/drunk', id = 'condition_drunk' }
Icons[PlayerStates.ManaShield] = { tooltip = tr('You are protected by a magic shield'), path = '/images/game/states/magic_shield', id = 'condition_magic_shield' }
Icons[PlayerStates.Paralyze] = { tooltip = tr('You are paralysed'), path = '/images/game/states/slowed', id = 'condition_slowed' }
Icons[PlayerStates.Haste] = { tooltip = tr('You are hasted'), path = '/images/game/states/haste', id = 'condition_haste' }
Icons[PlayerStates.Swords] = { tooltip = tr('You may not logout during a fight'), path = '/images/game/states/logout_block', id = 'condition_logout_block' }
Icons[PlayerStates.Drowning] = { tooltip = tr('You are drowning'), path = '/images/game/states/drowning', id = 'condition_drowning' }
Icons[PlayerStates.Freezing] = { tooltip = tr('You are freezing'), path = '/images/game/states/freezing', id = 'condition_freezing' }
Icons[PlayerStates.Dazzled] = { tooltip = tr('You are dazzled'), path = '/images/game/states/dazzled', id = 'condition_dazzled' }
Icons[PlayerStates.Cursed] = { tooltip = tr('You are cursed'), path = '/images/game/states/cursed', id = 'condition_cursed' }
Icons[PlayerStates.PartyBuff] = { tooltip = tr('You are strengthened'), path = '/images/game/states/strengthened', id = 'condition_strengthened' }
Icons[PlayerStates.PzBlock] = { tooltip = tr('You may not logout or enter a protection zone'), path = '/images/game/states/protection_zone_block', id = 'condition_protection_zone_block' }
Icons[PlayerStates.Pz] = { tooltip = tr('You are within a protection zone'), path = '/images/game/states/protection_zone' }
Icons[PlayerStates.Bleeding] = { tooltip = tr('You are bleeding'), path = '/images/game/states/bleeding', id = 'condition_bleeding' }
Icons[PlayerStates.Hungry] = { tooltip = tr('You are hungry'), path = '/images/game/states/hungry', id = 'condition_hungry' }

-- Variáveis de controle de UI
healthInfoWindow = nil
healthBar = nil
manaBar = nil
soulLabel = nil
overlay = nil
healthCircleFront = nil
manaCircleFront = nil

-- REFERÊNCIAS GLOBAIS PARA O OPTIONS.LUA
topHealthBar = nil
topManaBar = nil
healthCircle = nil
manaCircle = nil

function init()
    connect(g_game, { onGameStart = onGameStart, onGameEnd = offline })

    -- Janela de topo
    healthInfoWindow = g_ui.loadUI('healthinfo', rootWidget)
    healthInfoWindow:hide()

    healthBar = healthInfoWindow:recursiveGetChildById('healthBar')
    manaBar = healthInfoWindow:recursiveGetChildById('manaBar')
    soulLabel = healthInfoWindow:recursiveGetChildById('soulBar')

    topHealthBar = healthBar
    topManaBar = manaBar

    -- Cria o Overlay (Círculos) no MapPanel
    overlay = g_ui.createWidget('HealthOverlay', modules.game_interface.getMapPanel())
    overlay:hide()
    
    healthCircleFront = overlay:getChildById('healthCircleFront')
    manaCircleFront = overlay:getChildById('manaCircleFront')
    
    -- CORREÇÃO PARA ESCONDER TUDO:
    -- Atribuímos o 'overlay' inteiro às variáveis que o menu de opções controla.
    -- Quando desmarcar "Show health and mana circle", o container pai some por completo.
    healthCircle = overlay
    manaCircle = overlay

    if g_game.isOnline() then onGameStart() end
end

function terminate()
    disconnect(g_game, { onGameStart = onGameStart, onGameEnd = offline })
    offline()
    
    if healthInfoWindow then 
        healthInfoWindow:destroy() 
        healthInfoWindow = nil
    end
    
    if overlay then 
        overlay:destroy() 
        overlay = nil
    end
end

function onGameStart()
    healthInfoWindow:show()
    overlay:show()
    
    local localPlayer = g_game.getLocalPlayer()
    if localPlayer then
        connect(localPlayer, { 
            onHealthChange = onHealthChange, 
            onManaChange = onManaChange, 
            onStatesChange = onStatesChange, 
            onSoulChange = onSoulChange 
        })
        
        onHealthChange(localPlayer, localPlayer:getHealth(), localPlayer:getMaxHealth())
        onManaChange(localPlayer, localPlayer:getMana(), localPlayer:getMaxMana())
        onStatesChange(localPlayer, localPlayer:getStates(), 0)
        onSoulChange(localPlayer, localPlayer:getSoul())
        
        local nameLabel = healthInfoWindow:getChildById('playerName')
        if nameLabel then nameLabel:setText(localPlayer:getName()) end
    end
end

function offline()
    local localPlayer = g_game.getLocalPlayer()
    if localPlayer then
        disconnect(localPlayer, { 
            onHealthChange = onHealthChange, 
            onManaChange = onManaChange, 
            onStatesChange = onStatesChange, 
            onSoulChange = onSoulChange 
        })
    end
    
    if healthInfoWindow then
        healthInfoWindow:hide()
        local condPanel = healthInfoWindow:recursiveGetChildById('conditionPanel')
        if condPanel then condPanel:destroyChildren() end
    end
    
    if overlay then overlay:hide() end
end

function onHealthChange(localPlayer, health, maxHealth)
    if healthBar then
        healthBar:setText(health .. ' / ' .. maxHealth)
        healthBar:setValue(health, 0, maxHealth)
    end

    if healthCircleFront then
        local healthPercent = localPlayer:getHealthPercent()
        local Yhppc = math.floor(208 * (1 - (healthPercent / 100)))
        local rect = { x = 0, y = Yhppc, width = 63, height = 208 - Yhppc }
        
        healthCircleFront:setImageClip(rect)
        healthCircleFront:setImageRect(rect)

        if healthPercent > 92 then healthCircleFront:setImageColor("#00BC00FF")
        elseif healthPercent > 60 then healthCircleFront:setImageColor("#50A150FF")
        elseif healthPercent > 30 then healthCircleFront:setImageColor("#A1A100FF")
        elseif healthPercent > 8 then healthCircleFront:setImageColor("#BF0A0AFF")
        elseif healthPercent > 3 then healthCircleFront:setImageColor("#910F0FFF")
        else healthCircleFront:setImageColor("#850C0CFF") end
    end
end

function onManaChange(localPlayer, mana, maxMana)
    if manaBar then
        manaBar:setText(mana .. ' / ' .. maxMana)
        manaBar:setValue(mana, 0, maxMana)
    end

    if manaCircleFront then
        local mpPercent = (maxMana > 0) and (mana * 100 / maxMana) or 0
        local Ymppc = math.floor(208 * (1 - (mpPercent / 100)))
        local rect = { x = 0, y = Ymppc, width = 63, height = 208 - Ymppc }
        
        manaCircleFront:setImageClip(rect)
        manaCircleFront:setImageRect(rect)
        manaCircleFront:setImageColor("#4444ffff")
    end
end

function onSoulChange(localPlayer, soul)
    if soulLabel then 
        soulLabel:setText('Chakra: ' .. soul) 
        soulLabel:setValue(soul, 0, 100)
    end
end

function onStatesChange(localPlayer, now, old)
    if now == old then return end
    local bitsChanged = bit32.bxor(now, old)
    for i = 1, 32 do
        local pow = math.pow(2, i-1)
        if pow > bitsChanged then break end
        local bitChanged = bit32.band(bitsChanged, pow)
        if bitChanged ~= 0 then toggleIcon(bitChanged) end
    end
end

function toggleIcon(bitChanged)
    local content = healthInfoWindow:recursiveGetChildById('conditionPanel')
    if not Icons[bitChanged] or not content then return end
    local icon = content:getChildById(Icons[bitChanged].id)
    if icon then icon:destroy()
    else
        icon = g_ui.createWidget('UIWidget', content)
        icon:setId(Icons[bitChanged].id)
        icon:setImageSource(Icons[bitChanged].path)
        icon:setTooltip(Icons[bitChanged].tooltip)
    end
end