AkamaruSystem = {}

local akamaruWindow = nil
local akamaruButton = nil

local playerSpells = {}

-- Função que realmente atualiza a UI
function AkamaruSystem.refresh()
  local player = g_game.getLocalPlayer()
  if not player or not akamaruWindow then return end

  local function setLabel(id, text)
    local widget = akamaruWindow:recursiveGetChildById(id)
    if widget then widget:setText(text) end
  end

  setLabel('levelLabel', 'Nivel: ' .. player:getAkamaruLevel())
  setLabel('pointsLabel', 'Pontos: ' .. player:getAkamaruPoints())
  setLabel('expLabel', 'Experiencia: ' .. player:getAkamaruExp() .. ' / ' .. math.max(1, player:getAkamaruNextLevelExp()))
  
  local expBar = akamaruWindow:recursiveGetChildById('expBar')
  if expBar then
    local currentExp = player:getAkamaruExp()
    local nextExp = player:getAkamaruNextLevelExp()
    local perc = (nextExp > 0) and math.min(100, math.floor((currentExp / nextExp) * 100)) or 0
  
    if expBar.setPercentage then
        expBar:setPercentage(perc)
    elseif expBar.setPercent then
        expBar:setPercent(perc)
    else
        expBar:setText(perc .. '%')
    end
  end

  setLabel('totalHpLabel', 'Hp: ' .. player:getAkamaruMaxHealth())
  setLabel('totalSpeedLabel', 'Speed: ' .. player:getAkamaruMaxSpeed())
  setLabel('attackLabel',   player:getAkamaruAttack())
  setLabel('agilityLabel',  player:getAkamaruAgility())
  setLabel('dodgeLabel',    player:getAkamaruDodge())
  setLabel('hpLabel',       player:getAkamaruHealthPts())
  setLabel('speedLabel',    player:getAkamaruSpeedPts())

  local appearanceWidget = akamaruWindow:recursiveGetChildById('akamaruAppearance')
  if appearanceWidget then
      local outfitId = player:getAkamaruOutfit()
      
      if not outfitId or outfitId <= 0 then 
          outfitId = 45
      end

      appearanceWidget:setFixedCreatureSize(true)
      appearanceWidget:setOutfit({type = outfitId}) 
      appearanceWidget:setVisible(true)
      appearanceWidget:setOpacity(1.0)
      appearanceWidget:setCenter(true)
      appearanceWidget:setMargin(0)
  end
end

function AkamaruSystem.onAkamaruUpdate()
    AkamaruSystem.refresh()
end

function init()
  -- Carrega a interface
  akamaruWindow = g_ui.displayUI('akamaru') 
  akamaruWindow:hide()
  
  -- Sinais globais e de magias
  connect(LocalPlayer, { 
    onSpellListUpdate = onSpellListUpdate 
  })
  
  connect(g_game, { 
    onGameStart = AkamaruSystem.setup,
    onGameEnd = AkamaruSystem.clear,
  })

  g_keyboard.bindKeyDown('Ctrl+Shift+A', AkamaruSystem.toggle)
  g_keyboard.bindKeyDown('Escape', function()
    if akamaruWindow and akamaruWindow:isVisible() then
      akamaruWindow:hide()
    end
  end)

  -- Se já estiver logado (Reload)
  if g_game.isOnline() then
    local player = g_game.getLocalPlayer()
    if player then
        -- CONEXÃO VITAL PARA ATUALIZAÇÃO EM TEMPO REAL
        connect(player, { onAkamaruUpdate = AkamaruSystem.onAkamaruUpdate })
    end
    AkamaruSystem.setup()
  end
end

function terminate()
  disconnect(LocalPlayer, { onSpellListUpdate = onSpellListUpdate })

  disconnect(g_game, { 
    onGameStart = AkamaruSystem.setup, 
    onGameEnd = AkamaruSystem.clear
  })
  
  local player = g_game.getLocalPlayer()
  if player then
    disconnect(player, { onAkamaruUpdate = AkamaruSystem.onAkamaruUpdate })
  end

  g_keyboard.unbindKeyDown('Ctrl+Shift+A')
  AkamaruSystem.destroy()
end

function onSpellListUpdate(spells)
  AkamaruSystem.setup() -- Atualiza o botão assim que recebe as magias
end

function AkamaruSystem.setup()
  local player = g_game.getLocalPlayer()
  if not player then return end

  if AkamaruSystem.canUse() then
    if not akamaruButton and modules.client_topmenu then
      akamaruButton = modules.client_topmenu.addLeftGameButton('akamaruButton', 'Akamaru', '/images/topbuttons/akamaru', AkamaruSystem.toggle)
    end
    
    if akamaruButton then 
      akamaruButton:show() 
    end
    
    disconnect(player, { onAkamaruUpdate = AkamaruSystem.onAkamaruUpdate })
    connect(player, { onAkamaruUpdate = AkamaruSystem.onAkamaruUpdate })
  else
    if akamaruButton then 
      akamaruButton:hide() 
    end
    
    if akamaruWindow and akamaruWindow:isVisible() then 
      akamaruWindow:hide() 
    end
  end
end

function AkamaruSystem.clear()
  if akamaruWindow then akamaruWindow:hide() end
  
  -- Limpa a conexão do player antigo para não dar conflito no próximo login
  local player = g_game.getLocalPlayer()
  if player then
    disconnect(player, { onAkamaruUpdate = AkamaruSystem.onAkamaruUpdate })
  end
end

function AkamaruSystem.destroy()
  if akamaruWindow then akamaruWindow:destroy(); akamaruWindow = nil end
  if akamaruButton then akamaruButton:destroy(); akamaruButton = nil end
end

function AkamaruSystem.canUse()
  local player = g_game.getLocalPlayer()
  if not player then return false end

  local spells = {}
  if modules.game_actionbar and modules.game_actionbar.getPlayerSpellList then
    spells = modules.game_actionbar.getPlayerSpellList()
  end

  if type(spells) == 'table' then
    for _, spellData in pairs(spells) do
      if spellData and spellData.name and tostring(spellData.name):lower() == "akamaru" then
        return true
      end
    end
  end

  return false
end

function AkamaruSystem.toggle()
  if not g_game.isOnline() or not akamaruWindow then return end

  if not AkamaruSystem.canUse() then
    return 
  end

  if akamaruWindow:isVisible() then
    AkamaruSystem.hideAndFocus() 
  else
    AkamaruSystem.refresh()
    akamaruWindow:show()
    akamaruWindow:raise()
    akamaruWindow:focus()
  end
end

function AkamaruSystem.addPoint(attributeName)
  local protocol = g_game.getProtocolGame()
  if protocol then
      protocol:sendAkamaruAddPoint(attributeName)
  else
      perror("AkamaruSystem: Protocolo de jogo nao encontrado.")
  end
end

function AkamaruSystem.hideAndFocus()
  if not akamaruWindow then return end
  
  akamaruWindow:hide()
  
  local gameRootPanel = modules.game_interface.getRootPanel()
  if gameRootPanel then
    gameRootPanel:focus()
  end
end
