local actionBars = {}
local settings = {}
local settingsFile = ""
local cachedSettings = nil
local window = nil
local mouseGrabberWidget = nil
local lastExecution = 0

local TYPE = {
  BLANK = 0,
  TEXT = 1,
  SPELL = 2,
  ITEM = 3
}

local ACTION = {
  BLANK = 0,
  EQUIP = 1,
  USE = 2,
  USE_SELF = 3,
  USE_TARGET = 4,
  USE_CROSS = 5
}

local playerSpells = {} -- Aqui vamos guardar os dados completos (id, icon, cooldown)
local spellUpdateEvent = nil

STATIC_ITEMS = {
  [3552] = {cooldown = 5000}, -- speed shoes
  [3034] = {cooldown = 1000}, -- genin pill
  [3028] = {cooldown = 1000}, -- chunin pill
  [3026] = {cooldown = 1000}, -- jounin pill
  [3008] = {cooldown = 1000}, -- gamakichi pet
  [3025] = {cooldown = 1000}, -- katsuyo pet
}

local STATIC_SPELLS = {
    
}

local function normalizeSpellData(spell)
  if not spell then return end

  if not spell.chakra or spell.chakra == 0 then
      spell.chakra = spell.mana or 20
  end

  if not spell.description or spell.description == '' then
      spell.description = 'Jutsu: ' .. (spell.name or spell.id or 'Desconhecido')
  end
end

-- Tabela para facilitar a ordenação
local playerSpellsList = {}

function onSpellListUpdate(player, spellid, name, words, icon, cooldown, mana, description, level)
  local registryId = (spellid and spellid ~= "") and spellid or name
  if not registryId then return end

  local spell = {
    id = registryId,
    name = name,
    words = words,
    icon = tonumber(icon) or 3000,
    cooldown = tonumber(cooldown) or 2000,
    mana = tonumber(mana) or 0,
    description = description,
    level = tonumber(level) or 0 -- Nível recebido do servidor
  }

  normalizeSpellData(spell)
  playerSpells[registryId] = spell

  -- Organiza a lista para a ActionBar
  playerSpellsList = {}
  for _, s in pairs(playerSpells) do
    table.insert(playerSpellsList, s)
  end

  -- ORDENAÇÃO: Do nível mais baixo para o mais alto
  table.sort(playerSpellsList, function(a, b) return a.level < b.level end)

  if spellUpdateEvent then removeEvent(spellUpdateEvent) end
  spellUpdateEvent = scheduleEvent(function()
    for i = 1, 3 do
      if actionBars[i] then 
         -- Aqui você deve passar a lista ordenada para o setup
         setupActionBar(i, playerSpellsList) 
      end
    end
    spellUpdateEvent = nil
  end, 200)
end

function getPlayerSpellList()
    return playerSpells
end

local function isSpell(text)
  if not text or text == "" then return false end
  
  text = text:lower():trim()

  for id, spellData in pairs(playerSpells) do
    local words = spellData.words:lower():trim()
    local data = spellData
    data.spellName = spellData.name 

    if words == text then
      return {data = data}
    end

    if text:find(words, 1, true) == 1 then
      local param = text:sub(#words + 1):trim()
      param = param:gsub('"', ""):gsub("'", "")
      
      return {data = data, param = param}
    end
  end

  return false
end

function init()
  modules.game_actionbar.createActionBar = createActionBar
  modules.game_actionbar.createActionBars = createActionBars
  modules.game_actionbar.setupActionBar = setupActionBar
  modules.game_actionbar.setActionBarEnabled = setActionBarEnabled
  modules.game_actionbar.isActionBarEnabled = isActionBarEnabled
  modules.game_actionbar.debugActionBars = debugActionBars
  modules.game_actionbar.actionBars = actionBars
  modules.game_actionbar.settings = settings
  modules.game_actionbar.resetActionBarDefaults = resetActionBarDefaults

  _G.createActionBar = function(i) return modules.game_actionbar.createActionBar(i) end
  _G.setupActionBar = function(i) return modules.game_actionbar.setupActionBar(i) end
  _G.setActionBarEnabled = function(i,v) return modules.game_actionbar.setActionBarEnabled(i,v) end
  _G.debugActionBars = function() return modules.game_actionbar.debugActionBars() end
  _G.resetActionBarDefaults = function() return modules.game_actionbar.resetActionBarDefaults() end

  connect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
    onSpellGroupCooldown = onSpellGroupCooldown,
    onSpellCooldown = onSpellCooldown
  })

  connect(LocalPlayer, { 
    onSpellListUpdate = onSpellListUpdate 
  })

  if g_game.isOnline() then
    online()
  end

  if mouseGrabberWidget then
    mouseGrabberWidget:destroy()
  end

  -- ConfiguraÃ§Ã£o do widget de mouse (arrastar itens da barra)
  mouseGrabberWidget = g_ui.createWidget('UIWidget')
  mouseGrabberWidget:setVisible(false)
  mouseGrabberWidget:setFocusable(false)
  mouseGrabberWidget.onMouseRelease = onDropActionButton
end

function terminate()
  disconnect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
    onSpellGroupCooldown = onSpellGroupCooldown,
    onSpellCooldown = onSpellCooldown
  })

  disconnect(LocalPlayer, { 
    onSpellListUpdate = onSpellListUpdate 
  })

  _G.createActionBar = nil
  _G.setupActionBar = nil
  _G.setActionBarEnabled = nil
  _G.debugActionBars = nil

  offline()
end

local function getActionBarParent(i)
  local root = modules.game_interface.getRootPanel()
  local panel = nil
  local layout = 'actionbar'
  local index = i

  -- 1 a 3: PainÃ©is Inferiores (Bottom)
  if i <= 3 then
    panel = modules.game_interface.gameBottomActionPanel
      or modules.game_interface.gameBottomPanel
      or (modules.game_interface.getBottomActionPanel and modules.game_interface.getBottomActionPanel())
      or (modules.game_interface.getBottomPanel and modules.game_interface.getBottomPanel())
      or root
    layout = 'actionbar'
    index = i

  -- 4 a 6: PainÃ©is Esquerdos (Left)
  elseif i <= 6 then
    panel = modules.game_interface.gameLeftActionPanel
      or modules.game_interface.gameLeftPanels
      or (modules.game_interface.getLeftActionPanel and modules.game_interface.getLeftActionPanel())
      or (modules.game_interface.getLeftPanel and modules.game_interface.getLeftPanel())
      or root
    layout = 'sideactionbar'
    index = i - 3

  -- 7 a 9: PainÃ©is Direitos (Right)
  else
    panel = modules.game_interface.gameRightActionPanel
      or modules.game_interface.gameRightPanels
      or (modules.game_interface.getRightActionPanel and modules.game_interface.getRightActionPanel())
      or (modules.game_interface.getRightPanel and modules.game_interface.getRightPanel())
      or root
    layout = 'sideactionbar'
    index = i - 6
  end

  -- Retorno seguro com fallback para o Root caso o painel especÃ­fico nÃ£o exista
  if panel then
    return panel, index, layout
  end

  -- Fallback absoluto (se tudo falhar, joga na tela principal)
  local fallbackRoot = root or g_ui.getRootWidget()
  return fallbackRoot, index or 1, layout
end

local function createActionBar(i)
  if not i or i > 3 then return nil end

  if actionBars[i] and not actionBars[i]:isDestroyed() then
    return actionBars[i]
  end

  local parent, index, layout = getActionBarParent(i)
  if not parent then
    parent = modules.game_interface.getRootPanel() or g_ui.getRootWidget()
    if not parent then
      actionBars[i] = nil
      return nil
    end
  end

  local targetParent = parent or modules.game_interface.getRootPanel() or g_ui.getRootWidget()

  if parent and parent.setVisible then parent:setVisible(true) end
  if targetParent and targetParent.setVisible then targetParent:setVisible(true) end

  local barWidget = g_ui.loadUI(layout, targetParent)
  if not barWidget then
    barWidget = g_ui.createWidget('Panel', targetParent)
    barWidget:setId('actionbar.' .. i)
    if barWidget.setBackgroundColor then barWidget:setBackgroundColor('#00000000') end
    barWidget:setStyle('border')
  end

  if not barWidget then
    actionBars[i] = nil
    return nil
  end

  if barWidget.setPhantom then barWidget:setPhantom(true) end
  if barWidget.setFocusable then barWidget:setFocusable(false) end
  if barWidget.setOn then barWidget:setOn(true) end
  if barWidget.setOpacity then barWidget:setOpacity(1) end
  if barWidget.raise then barWidget:raise() end

  if not barWidget.tabBar then
    barWidget.tabBar = g_ui.createWidget('Panel', barWidget)
    barWidget.tabBar:setId('tabBar')
    barWidget.tabBar:setLayout({type = 'grid', cellSize = {x = 40, y = 40}, cellSpacing = 2})
    barWidget.tabBar:setPadding(4)
  end

  actionBars[i] = barWidget
  actionBars[i]:setId("actionbar." .. i)
  actionBars[i].n = i

  actionBars[i]:setVisible(true)
  actionBars[i]:setOn(true)
  if actionBars[i].setOpacity then actionBars[i]:setOpacity(1) end
  if actionBars[i].raise then actionBars[i]:raise() end

  if layout == 'actionbar' then
    actionBars[i]:setHeight(60)
    actionBars[i]:setWidth(450)
  elseif layout == 'sideactionbar' then
    actionBars[i]:setWidth(40)
    actionBars[i]:setHeight(260)
  end

  if settings.positions and settings.positions[i] then
    actionBars[i]:setPosition(settings.positions[i])
  else
    local posX, posY = 0, 0
    if layout == 'actionbar' then
      posX = 10 + (index - 1) * 460
      posY = 10
    elseif layout == 'sideactionbar' then
      posX = 10
      posY = 80 + (index - 1) * 270
    end
    
    if actionBars[i].moveTo then actionBars[i]:moveTo(posX, posY) end
    if actionBars[i].setPosition then pcall(function() actionBars[i]:setPosition({x = posX, y = posY}) end) end
    if actionBars[i].setMargin then actionBars[i]:setMargin(posX, posY, 0, 0) end
  end

  return actionBars[i]
end

function createActionBars()
  local gameInterface = modules.game_interface
  local mapPanel = gameInterface and gameInterface.getMapPanel()

  -- Percorremos atÃ© 10 para garantir que vamos pegar qualquer lixo antigo
  for i = 1, 10 do
    if i <= 3 and isActionBarEnabled(i) then
      -- SÃ³ entra aqui se for Barra 1, 2 ou 3 e estiver ligada nas opÃ§Ãµes
      if not actionBars[i] then
        createActionBar(i)
        setupActionBar(i)
      end
    else
      -- MATA A BARRA NA MEMÃ“RIA LUA
      if actionBars[i] then
        actionBars[i]:destroy()
        actionBars[i] = nil
      end

      -- MATA O WIDGET DIRETO NO MAP PANEL (Onde o "fantasma" mora)
      if mapPanel then
        local oldBar = mapPanel:getChildById('actionbar' .. i)
        if oldBar then
          oldBar:destroy()
        end
      end
      
      -- LIMPA O REGISTRO NO ARQUIVO DE CONFIGURAÃ‡ÃƒO (settings.otml)
      -- Isso impede que elas voltem ao reiniciar o client
      if g_settings.exists('ActionBars') then
        local node = g_settings.getNode('ActionBars')
        if node and node[tostring(i)] then
          node[tostring(i)] = nil
          g_settings.setNode('ActionBars', node)
        end
      end
    end
  end
  g_settings.save()
end

function resetActionBarDefaults()
  settings.bars = {}
  settings.positions = {}

  for i = 1, 9 do
    local enabled = (i <= 3)
    settings.bars[i] = enabled
    
    if g_settings and g_settings.setValue then
      g_settings.setValue("actionbar" .. i, enabled)
    end
    
    if actionBars[i] then
      actionBars[i]:destroy()
      actionBars[i] = nil
    end
  end

  save()
  
  createActionBars()
  
end

function isActionBarEnabled(index)
  local settingsKey = "actionbar" .. index
  local value = nil

  if settings then
    if settings.bars and settings.bars[index] ~= nil then
      value = settings.bars[index]
    elseif settings[settingsKey] ~= nil then
      value = settings[settingsKey]
    end
  end

  if value == nil and g_settings and g_settings.getValue then
    local gvalue = g_settings.getValue(settingsKey)
    if gvalue ~= nil then
      value = gvalue
    end
  end

  if value == nil then
    value = (index <= 3)
  end

  if type(value) == "string" then
    local low = value:lower()
    value = not (low == "false" or low == "0" or low == "")
  elseif type(value) == "number" then
    value = (value ~= 0)
  end

  return value == true
end

function setActionBarEnabled(index, enabled)
  if index < 1 or index > 9 then return end

  settings["actionbar" .. index] = enabled
  
  if not settings.bars then settings.bars = {} end
  settings.bars[index] = enabled

  if g_settings and g_settings.setValue then
    g_settings.setValue("actionbar" .. index, enabled)
  end
  
  save()

  if enabled then
    if not actionBars[index] or actionBars[index]:isDestroyed() then
      createActionBar(index)
    end
    
    if actionBars[index] then
      actionBars[index]:setVisible(true)
      actionBars[index]:setOn(true)
      setupActionBar(index) 
    end
  else
    if actionBars[index] and not actionBars[index]:isDestroyed() then
      actionBars[index]:destroy()
      actionBars[index] = nil
    end
  end

  if type(show) == "function" then
    show()
  end
end

function offline()
  playerSpells = {}
  -- save settings to json
  save()

  -- destroy windows
  destroyAssignWindows()
  mouseGrabberWidget:destroy()

  -- remove binds
  for i=1,9 do
    local actionbar = actionBars[i]
    if actionbar and actionbar.tabBar then
      for j, actionButton in ipairs(actionbar.tabBar:getChildren()) do
        local hotkey = actionButton.hotkey and actionButton.hotkey:len() > 0 and actionButton.hotkey or false
        if actionButton.callback and hotkey then
          local gameRootPanel = modules.game_interface.getRootPanel()
          -- IMPORTANTE: Desvincular o KeyDown que criamos
          g_keyboard.unbindKeyDown(hotkey, actionButton.callback, gameRootPanel)
        end
      end
    end
  end

  -- destroy actionbars
  for i=1,9 do
    local panel = actionBars[i]

    if panel and not panel:isDestroyed() then
      panel:destroy()
    end
  end
  actionBars = {}
end

function online()
  settingsFile = modules.client_profiles.getSettingsFilePath("actionbar_v2.json")
  -- load settings
  load()

  -- create actionbars
  createActionBars()

  -- show & setup actionbars
  show()

  destroyAssignWindows()
end

function show()
  local root = modules.game_interface.getRootPanel()
  -- Se o root nÃ£o existir, nÃ£o hÃ¡ onde desenhar as barras
  if not root then 
    --print('[ActionBar] Erro: rootPanel nÃ£o encontrado.')
    return 
  end

  local size = root:getSize()
  local screenW = size.width or 1024
  local screenH = size.height or 768
  
  local bottomBarWidth, bottomBarHeight = 450, 60
  local sideBarWidth, sideBarHeight = 40, 260
  local gap = 6

  -- Debug inicial
  --print(string.format('[ActionBar] show(): Tela %dx%d', screenW, screenH))

  -- Verifica se hÃ¡ algo habilitado; se nÃ£o, forÃ§a as 3 primeiras (padrÃ£o)
  local enabledCount = 0
  for i=1, 9 do
    if isActionBarEnabled(i) then enabledCount = enabledCount + 1 end
  end

  if enabledCount == 0 then
    --print('[ActionBar] show(): ForÃ§ando barras 1-3')
    for i=1, 3 do
      if g_settings then g_settings.setValue('actionbar' .. i, true) end
      -- assume-se que isActionBarEnabled lÃª do settings
    end
  end

  -- Loop principal de renderizaÃ§Ã£o e posicionamento
  for i = 1, 9 do
    local enabled = isActionBarEnabled(i)
    
    -- 1. CriaÃ§Ã£o/VerificaÃ§Ã£o
    if enabled and (not actionBars[i] or actionBars[i]:isDestroyed()) then
      createActionBar(i)
    end

    local actionbar = actionBars[i]
    if actionbar then
      actionbar:setVisible(enabled)
      
      if enabled then
        -- 2. GARANTIA DE PAI (Essencial para aparecer)
        if actionbar:getParent() ~= root then
          actionbar:setParent(root)
        end

        actionbar:setOpacity(1)
        actionbar:raise() -- Fica por cima de outros elementos de UI

        local x, y = 0, 0

        -- 3. LÃ“GICA DE POSICIONAMENTO
        if i <= 3 then
          -- Barras Inferiores (Centro)
          x = (screenW - bottomBarWidth) / 2
          y = screenH - 100 - ((i - 1) * (bottomBarHeight + gap))
          actionbar:setSize({width = bottomBarWidth, height = bottomBarHeight})
        
        elseif i <= 6 then
          -- Barras Laterais Esquerdas
          x = 10
          y = (screenH * 0.2) + ((i - 4) * (sideBarHeight + gap))
          actionbar:setSize({width = sideBarWidth, height = sideBarHeight})

        else
          -- Barras Laterais Direitas
          x = screenW - sideBarWidth - 10
          y = (screenH * 0.2) + ((i - 7) * (sideBarHeight + gap))
          actionbar:setSize({width = sideBarWidth, height = sideBarHeight})
        end

        -- 4. APLICAÃ‡ÃƒO DA POSIÃ‡ÃƒO
        actionbar:setPosition({x = x, y = y})
        
        -- Inicializa os slots/botÃµes
        setupActionBar(i)
        
        --print(string.format('[ActionBar] Barra %d posicionada em: %d, %d', i, x, y))
      else
        -- Se estiver desabilitada, limpa os filhos para economizar memÃ³ria
        if actionbar.tabBar then
          actionbar.tabBar:destroyChildren()
        end
      end
    end
  end
end

function debugActionBars()
  for i=1,9 do
    local gs = g_settings and g_settings.getValue and g_settings.getValue("actionbar"..i) or "n.a."
    local ss = settings["actionbar"..i]
    local panel = actionBars[i]
    local vis = panel and panel:isVisible() or "nil"

    local parentId = "nil"
    local tabBarCount = "nil"
    local buttonCount = "nil"
    local width = "nil"
    local height = "nil"
    local posx = "nil"
    local posy = "nil"
    if panel then
      if type(panel.getParent) == "function" then
        local ok, p = pcall(panel.getParent, panel)
        if ok and p and type(p.getId) == "function" then
          local ok2, id = pcall(p.getId, p)
          if ok2 and id then parentId = id else parentId = tostring(p)
          end
        end
      end
      if type(panel.getSize) == "function" then
        local ok, s = pcall(panel.getSize, panel)
        if ok and s then width = s.width or s.x or "nil"; height = s.height or s.y or "nil" end
      end
      if type(panel.getPosition) == "function" then
        local ok, p = pcall(panel.getPosition, panel)
        if ok and p then posx = p.x or p[1] or "nil"; posy = p.y or p[2] or "nil" end
      end
      if panel.tabBar and panel.tabBar.getChildren then
        local ok, c = pcall(panel.tabBar.getChildren, panel.tabBar)
        if ok and c then tabBarCount = #c end
      end
      if panel.tabBar and panel.tabBar.getChildren then
        local ok2, c2 = pcall(panel.tabBar.getChildren, panel.tabBar)
        if ok2 and c2 then buttonCount = #c2 end
      end
    end

    --print(string.format("actionbar%d: gs=%s ss=%s visible=%s parent=%s size=%s=%s pos=%s=%s tabbar=%s buttons=%s", i, tostring(gs), tostring(ss), tostring(vis), tostring(parentId), tostring(width), tostring(height), tostring(posx), tostring(posy), tostring(tabBarCount), tostring(buttonCount)))
  end
end

function refresh()
  -- first save
  save()

  -- recheck file
  settingsFile = modules.client_profiles.getSettingsFilePath("actionbar_v2.json")

  -- load settings
  load()

  -- setup actionbars
  show()

  destroyAssignWindows()
end

function translateHotkeyDesc(text)
  -- formatting similar to cip Tibia 12
  if not text then 
    return ""
  end

  local values = {
    {"Shift", "S"},
    {"Ctrl", "C"},
    {"+", ""},
    {"PageUp", "PgUp"},
    {"PageDown", "PgDown"},
    {"Enter", "Return"},
    {"Insert", "Ins"},
    {"Delete", "Del"},
    {"Escape", "Esc"}
  }

  for i, v in pairs(values) do
    text = text:gsub(v[1], v[2])
  end

  if text:len() > 6 then
    text = text:sub(text:len()-3,text:len())
    text = "..."..text
  end

  return text
end

function destroyAssignWindows()
  local windows = {
    'assignItemWindow',
    'assignSpellWindow',
    'assignTextWindow',
    'assignHotkeyWindow'
  }

  local rootWidget = g_ui.getRootWidget()
  for i, id in ipairs(windows) do
    local widget = rootWidget[id]

    if widget and not widget:isDestroyed() then
      widget:destroy()
    end
  end
end

function changeLockState(widget)
  local actionbar = widget:getParent():getParent()

  widget:setOn(not widget:isOn())
  widget.image:setOn(widget:isOn())
  actionbar.locked = not widget:isOn()

  settings[actionbar:getId()] = not widget:isOn() or nil
end

function moveActionButtons(widget)
  local dir = widget:getId()
  local actionBar = widget:getParent():getParent()
  local scroll = actionBar.actionScroll
  local buttons = {actionBar.prevPanel.prev, actionBar.prevPanel.first, actionBar.nextPanel.next, actionBar.nextPanel.last}

  if dir == "next" then
    scroll:increment(37)
  elseif dir == "last" then
    scroll:setValue(scroll:getMaximum())
  elseif dir == "prev" then
    scroll:decrement(37)
  else
    scroll:setValue(scroll:getMinimum())
  end

  local prevEnabled = scroll:getValue() > 0
  local nextEnabled = scroll:getValue() < scroll:getMaximum()
  
  buttons[1]:setOn(prevEnabled)
  buttons[2]:setOn(prevEnabled)
  buttons[3]:setOn(nextEnabled)
  buttons[4]:setOn(nextEnabled)
  buttons[1].image:setOn(prevEnabled)
  buttons[2].image:setOn(prevEnabled)
  buttons[3].image:setOn(nextEnabled)
  buttons[4].image:setOn(nextEnabled)
end

function onDropActionButton(self, mousePosition, mouseButton)
  if not g_ui.isMouseGrabbed() then return end
  if not cachedSettings or not cachedSettings.widget then
    g_mouse.popCursor('target')
    self:ungrabMouse()
    return
  end

  local clickedWidget = modules.game_interface.getRootPanel():recursiveGetChildByPos(mousePosition, false)
  if clickedWidget and clickedWidget:getParent() and clickedWidget:getParent():getStyleName():find('ActionButton') then
    if cachedSettings then
      clickedWidget = clickedWidget:getParent()
      if clickedWidget ~= cachedSettings.widget then
        local clickedHotkey = clickedWidget.hotkey
        local cachedHotkey = cachedSettings.widget.hotkey

        settings[cachedSettings.id] = settings[clickedWidget:getId()]
        settings[clickedWidget:getId()] = cachedSettings.data
        
        local clickedTill = clickedWidget.cooldownTill or 0
        local clickedStart = clickedWidget.cooldownStart or 0
        local cachedTill = cachedSettings.widget.cooldownTill or 0
        local cachedStart = cachedSettings.widget.cooldownStart or 0

        cachedSettings.widget.cooldownTill = clickedTill
        cachedSettings.widget.cooldownStart = clickedStart
        clickedWidget.cooldownTill = cachedTill
        clickedWidget.cooldownStart = cachedStart

        -- hotkeys remain unchanged
        settings[cachedSettings.id] = settings[cachedSettings.id] or {}
        settings[cachedSettings.id].hotkey = cachedHotkey
        settings[clickedWidget:getId()] = settings[clickedWidget:getId()] or {}
        settings[clickedWidget:getId()].hotkey = clickedHotkey

        updateCooldown(clickedWidget)
        updateCooldown(cachedSettings.widget)
        setupButton(cachedSettings.widget)
        setupButton(clickedWidget)
      end
    end
  end

  cachedSettings.widget.item:setBorderColor('#00000000')
  cachedSettings = nil
  g_mouse.popCursor('target')
  self:ungrabMouse()
end

function setupActionBar(n)
  local actionbar = actionBars[n]
  if not actionbar then return end

  -- Fix de ID e Ancoragem Inicial
  actionbar:setId('actionBarPanel' .. n)
  
  -- Garante que a barra esteja no RootPanel e limpa posições antigas
  if actionbar:getParent() == modules.game_interface.getRootPanel() then
    actionbar:breakAnchors()
    actionbar:addAnchor(AnchorBottom, 'parent', AnchorBottom)
    actionbar:addAnchor(AnchorHorizontalCenter, 'parent', AnchorHorizontalCenter)
    actionbar:setMarginBottom(10)
  end

  if not actionbar.tabBar then
    actionbar.tabBar = g_ui.createWidget('Panel', actionbar)
    actionbar.tabBar:setId('tabBar')
    actionbar.tabBar:setLayout({type = 'grid', cellSize = {x = 40, y = 40}, cellSpacing = 2})
    actionbar.tabBar:setPadding(4)
  end

  actionbar.tabBar:destroyChildren()

  if not isActionBarEnabled(n) then
    actionbar:setVisible(false)
    return
  end

  local spells = {}
  for _, data in pairs(playerSpells) do
    table.insert(spells, data)
  end

  local slotCount = math.max(13, #spells)

  for i = 1, slotCount do
    local layout = n < 4 and 'ActionButton' or 'SideActionButton'
    local widget = g_ui.createWidget(layout, actionbar.tabBar)
    widget:setId(actionbar.n .. "." .. i)
    
    local spellData = spells[i]
    if spellData then
      if widget.item then
        widget.item:setItemId(tonumber(spellData.icon) or 3552)
        widget.item:setPhantom(true) 
        
        local tooltip = spellData.name or spellData.id
        if spellData.description then
          tooltip = tooltip .. "\n" .. spellData.description
        end
        widget.item:setTooltip(tooltip)
      end
    end

    setupButton(widget)
  end

  actionbar:setVisible(true)
end

function setupButton(widget)
  local id = widget:getId()
  local config = settings[id]
  
  -- Reset
  widget.item:setShowCount(false)
  widget.type = TYPE.BLANK
  widget.text:setText("")
  widget.item:setItemId(0)
  widget.item:setOn(false)
  widget.spellData = nil
  widget.hotkey = config and config.hotkey or ""
  widget.callback = nil

  -- Limpeza de CD
  local cd = widget:recursiveGetChildById('cooldown')
  if cd then cd:setVisible(false) end
  if widget.cooldownEvent then
    removeEvent(widget.cooldownEvent)
    widget.cooldownEvent = nil
  end

  -- Carrega Configuração
  if config and config.type then
    widget.item:setOn(true)
    widget.type = config.type
    widget.action = config.action
    
    if config.type == TYPE.ITEM then
      widget.item:setItemId(config.itemId or 0)
    elseif config.type == TYPE.SPELL and config.spellData then
      -- Busca dados atualizados, mas preserva o PARAM salvo
      local currentSpell = playerSpells[config.spellData.id] or config.spellData
      widget.spellData = {}
      for k,v in pairs(currentSpell) do widget.spellData[k] = v end
      widget.spellData.param = config.spellData.param 

      if currentSpell.icon and currentSpell.icon > 0 then
        widget.item:setItemId(tonumber(currentSpell.icon))
      else
        widget.text:setText(currentSpell.name or "") 
      end
    elseif config.type == TYPE.TEXT then
      widget.text:setText(config.sayText or "")
    end
  end

  -- Registra Hotkey e Mouse
  setupAction(widget)

  if widget.hotkeyLabel then
    widget.hotkeyLabel:setText(translateHotkeyDesc(widget.hotkey))
  end

  widget.onMouseRelease = function(self, mousePos, mouseButton)
    if mouseButton == MouseRightButton then 
      local menu = g_ui.createWidget('PopupMenu')
      menu:setGameMenu(true)
      menu:addOption(tr('Assign Spell'), function() assignSpell(widget) end)
      menu:addOption(tr('Assign Object'), function() assignItem(widget) end)
      menu:addOption(tr('Assign Hotkey'), function() assignHotkey(widget) end)
      if widget.type > 0 then
        menu:addSeparator()
        menu:addOption(tr('Clear Action'), function() resetSlot(widget) end)
      end
      menu:display(mousePos)
    elseif mouseButton == MouseLeftButton then
      if self.callback then self.callback() end
    end
    return true
  end
end

function resetSlot(widget)
  if not widget then return end

  local widgetId = widget:getId()
  
  local currentHotkey = nil
  if settings[widgetId] and settings[widgetId].hotkey then
    currentHotkey = settings[widgetId].hotkey
  end

  if currentHotkey and currentHotkey:len() > 0 then
    g_keyboard.unbindKeyDown(currentHotkey)
  end

  if currentHotkey and currentHotkey:len() > 0 then
    settings[widgetId] = { hotkey = currentHotkey }
  else
    settings[widgetId] = nil
  end

  setupButton(widget)
  
  save()
end

function assignItem(widget)
  if not widget then return end
  destroyAssignWindows()
  
  local radio = UIRadioGroup.create()
  local item = widget.item:getItem()
  local id = widget.item:getItemId()

  -- se o id for 0 tenta selecionar um item com o aim
  if id == 0 then
    local function onMouseRelease(self, mousePos, mouseButton)
      if mouseButton == MouseLeftButton then
        -- tenta pegar o item diretamente de um container
        local item = modules.game_interface.getRootPanel():recursiveGetChildByPos(mousePos)
        
        -- se não encontrou de forma direta, é usado o seletor de itens por posição
        if item and item:getClassName() ~= 'UIItem' then
           item = nil -- reseta para tentar a busca profunda
        end

        -- busca alternativa: varre os widgets sob o mouse atrás de um item
        if not item then
            local widgets = rootWidget:recursiveGetChildrenByPos(mousePos)
            for _, w in pairs(widgets) do
                if w.getItem and w:getItem() then
                    item = w:getItem()
                    break
                end
            end
        else
            item = item:getItem()
        end

        if item then
          local selectedId = item:getId()

          widget.item:setItemId(selectedId)
          id = selectedId 
          
          scheduleEvent(function() 
            assignItem(widget) 
          end, 100)
        end
      end
      
      -- limpeza
      g_mouse.popCursor()
      self:ungrabMouse()
      self:destroy()
      return true
    end

    local grabber = g_ui.createWidget('UIWidget', rootWidget)
    grabber:fill('parent')
    grabber.onMouseRelease = onMouseRelease
    
    grabber.onMousePress = function(self, mousePos, mouseButton)
        if mouseButton == MouseRightButton then
            g_mouse.popCursor()
            self:ungrabMouse()
            self:destroy()
        end
    end
    
    g_mouse.pushCursor('target')
    grabber:grabMouse()
    
    radio:destroy()
    return
  end

  -- criação o da Janela
  window = g_ui.loadUI('object', g_ui.getRootWidget())
  if not window then 
    radio:destroy()
    return 
  end

  window:show()
  window:raise()
  window:focus()
  window:setText("Atribuir objeto ao botão de ação " .. widget:getId())
  window:setId("assignItemWindow")

  -- seleção de Item
  window.select.onClick = function()
    if modules.game_itemselector then
      modules.game_itemselector.show(window.item)
    end
  end

  -- lógica de atualização dos checks
  window.item:setShowCount(false)
  window.item.onItemChange = function(itemWidget)
    local selectedItem = itemWidget:getItem()
    if not selectedItem then return end

    for i, child in ipairs(window.checks:getChildren()) do
      radio:addWidget(child)

      if selectedItem:getId() < 100 then
        child:setEnabled(false)
      elseif i < 4 then -- opções de Use (Self, Target, Cross)
        local multiUse = selectedItem:isMultiUse()
        child:setEnabled(multiUse)
        if multiUse and i == 3 then radio:selectWidget(child) end
      elseif g_game.getClientVersion() >= 910 then
        child:setEnabled(true) -- Equip/Use padrão
        if i == 4 then radio:selectWidget(child) end
      else
        child:setVisible(false)
      end
    end

    window.buttonOk:setEnabled(true)
    window.buttonApply:setEnabled(true)
  end

  -- inicializa com o item atual do widget
  window.item:setItemId(id)

  -- restaurar a ação selecionada anteriormente
  local actionType = widget.action or 0
  if actionType > ACTION.BLANK then
    local targetId = "use"
    if actionType == ACTION.USE_SELF then targetId = "useSelf"
    elseif actionType == ACTION.USE_TARGET then targetId = "useTarget"
    elseif actionType == ACTION.USE_CROSS then targetId = "useCross"
    elseif actionType == ACTION.EQUIP then targetId = "equip"
    end

    for _, child in ipairs(window.checks:getChildren()) do
      if child:getId() == targetId then
        radio:selectWidget(child)
        break
      end
    end
  end

  -- função de salvamento
  local okFunc = function(shouldDestroy)
    local widgetId = widget:getId()
    -- preserva a hotkey existente
    local hotkey = settings[widgetId] and settings[widgetId].hotkey

    -- limpa a hotkey antiga temporariamente para evitar conflito no re-bind
    if hotkey and hotkey:len() > 0 then
      g_keyboard.unbindKeyDown(hotkey)
    end

    -- salva as novas configurações
    settings[widgetId] = {
      hotkey = hotkey,
      itemId = window.item:getItemId(),
      type = TYPE.ITEM
    }

    local selected = radio:getSelectedWidget()
    local selectedId = selected and selected:getId() or "use"

    if selectedId == "useSelf" then settings[widgetId].action = ACTION.USE_SELF
    elseif selectedId == "useTarget" then settings[widgetId].action = ACTION.USE_TARGET
    elseif selectedId == "useCross" then settings[widgetId].action = ACTION.USE_CROSS
    elseif selectedId == "equip" then settings[widgetId].action = ACTION.EQUIP
    else settings[widgetId].action = ACTION.USE
    end
    
    if shouldDestroy then
      window:destroy()
      radio:destroy()
      window = nil

      -- impede a quera de foco do personagem
      rootWidget:ungrabMouse() 
      
      local rootPanel = modules.game_interface.getRootPanel()
      if rootPanel then
          rootPanel:focus()
      end
      
      local map = gameMapPanel or rootWidget:recursiveGetChildById('gameMapPanel')
      if map then 
          map:focus() 
      end
    end

    setupButton(widget)
    save()
  end

  -- callbacks de fechamento
  local cancelFunc = function()
    if window then
      window:destroy()
      window = nil
    end

    if radio then
      radio:destroy()
    end

    resetSlot(widget)

    rootWidget:ungrabMouse() 
    
    local rootPanel = modules.game_interface.getRootPanel()
    if rootPanel then
        rootPanel:focus()
    end
    
    local map = gameMapPanel or rootWidget:recursiveGetChildById('gameMapPanel')
    if map then 
        map:focus() 
    end
  end

  window.buttonOk.onClick = function() okFunc(true) end
  window.buttonApply.onClick = function() okFunc(false) end
  window.buttonClose.onClick = cancelFunc
  window.onEscape = cancelFunc
  window.onEnter = function() okFunc(true) end

  local actionbar = widget:getParent():getParent()
  if actionbar and actionbar.locked then
    cancelFunc()
  end
end

function assignSpell(widget)
  if not widget then return end
  destroyAssignWindows()
  
  local assignWindow = g_ui.loadUI('spell', g_ui.getRootWidget())
  if not assignWindow then return end
  
  assignWindow:setId("assignSpellWindow")
  assignWindow:show()
  assignWindow:raise()
  assignWindow:focus()

  local spellList = assignWindow:getChildById('spellList')
  if not spellList then assignWindow:destroy() return end
  spellList:destroyChildren()

  local jutsus = {}
  for _, data in pairs(playerSpells) do table.insert(jutsus, data) end
  
  -- Ordenação por Nível
  table.sort(jutsus, function(a, b) 
    local lvlA = tonumber(a.level) or 0
    local lvlB = tonumber(b.level) or 0
    if lvlA == lvlB then return (a.name or "") < (b.name or "") end
    return lvlA < lvlB 
  end)

  local radioGroup = UIRadioGroup.create()
  local addedSpells = {}
  local localPlayer = g_game.getLocalPlayer()
  local playerLevel = localPlayer and localPlayer:getLevel() or 0

  for _, spell in ipairs(jutsus) do
    local sName = spell.name or ""
    local sLevel = tonumber(spell.level) or 0 

    if sName ~= "" and not addedSpells[sName] then
      local label = g_ui.createWidget('SpellPreview', spellList)
      label.spellData = spell
      label:setText(sName)
      
      local icon = label:getChildById('image')
      if icon then
        icon:setItemId(tonumber(spell.icon) or 3000)
      end

      -- lógica de seleção
      label.onCheckChange = function(self, checked)
        if not checked then return end
        
        local details = assignWindow:getChildById('spellDetails')
        if not details then return end

        local fName = details:getChildById('spellName')
        local fLevel = details:getChildById('spellLevel')
        
        if fName then fName:setText(sName) end
        if fLevel then 
          fLevel:setText('(Lvl: ' .. sLevel .. ')')
          fLevel:setColor(playerLevel < sLevel and '#FF0000' or '#00FF00')
        end

        details:getChildById('spellDescription'):setText('Descrição: ' .. (spell.description or '...'))
        details:getChildById('spellChakra'):setText('Chakra: ' .. (spell.mana or 0))
        details:getChildById('spellCooldown'):setText(string.format('Cooldown: %.1fs', (tonumber(spell.cooldown) or 0) / 1000))
      end

      radioGroup:addWidget(label)
      addedSpells[sName] = true
    end
  end

  local function safeDestroy()
    if not assignWindow then return end
    if radioGroup then radioGroup:destroy() end
    assignWindow:destroy()
    assignWindow = nil

    rootWidget:ungrabMouse() 
    
    local rootPanel = modules.game_interface.getRootPanel()
    if rootPanel then
        rootPanel:focus()
    end
    
    local map = gameMapPanel or rootWidget:recursiveGetChildById('gameMapPanel')
    if map then 
        map:focus() 
    end
  end

  -- botão ok
  assignWindow.buttonOk.onClick = function()
    local selected = radioGroup:getSelectedWidget()
    if selected and selected.spellData then
      local s = selected.spellData
      local widgetId = widget:getId()
      
      -- BUSCA O TEXTO PELO ID CORRETO DO SEU OTUI (paramText)
      local paramInput = assignWindow:getChildById('paramText')
      local extraText = paramInput and paramInput:getText() or ""
      
      local hotkey = ""
      if settings[widgetId] then hotkey = settings[widgetId].hotkey or "" end

      -- Monta as palavras: Magia + espaço + " + Texto
      local finalWords = s.words
      if extraText ~= "" then
          -- O segredo para o servidor não dar "Offline" é esse espaço e aspas
          finalWords = finalWords .. ' "' .. extraText
      end

      settings[widgetId] = {
        type = TYPE.SPELL,
        hotkey = hotkey,
        spellData = {
          id = s.id,
          name = s.name,
          words = finalWords, 
          param = extraText,
          cooldown = tonumber(s.cooldown) or 0,
          icon = tonumber(s.icon) or 3000,
          level = tonumber(s.level) or 0
        }
      }
      setupButton(widget)
      save()
    end
    safeDestroy()
  end

  if assignWindow.buttonApply then
    assignWindow.buttonApply.onClick = assignWindow.buttonOk.onClick
  end

  assignWindow.buttonClose.onClick = safeDestroy
  assignWindow.onEscape = safeDestroy

  -- Seleciona o primeiro item da lista
  local first = spellList:getChildByIndex(1)
  if first then radioGroup:selectWidget(first) end
end

function assignHotkey(widget)
  destroyAssignWindows()

  -- create window
  window = g_ui.loadUI('hotkey', g_ui.getRootWidget())
  window:show()
  window:raise()
  window:focus()

  local barN = widget:getParent():getParent().n
  local barDesc
  if barN < 4 then
    barDesc = "Bottom"
  elseif barN < 7 then
    barDesc = "Left"
  else
    barDesc = "Right"
  end

  -- things
  barDesc = barDesc.." Action Bar: Action Button "..widget:getId()
  window:setText('Edit Hotkey for "'..barDesc)
  window.desc:setText(window.desc:getText()..barDesc..'"')
  window.display:setText(widget.hotkey or "")
  
  -- hotkey
  window:grabKeyboard()
  window.onKeyDown = function(window, keyCode, keyboardModifiers)
    local keyCombo = determineKeyComboDesc(keyCode, keyboardModifiers)
    window.display:setText(keyCombo)
    return true
  end

  local okFunc = function() 
    local hotkey = window.display:getText()

    if settings[widget:getId()].hotkey and settings[widget:getId()].hotkey:len() > 0 and widget.callback then
      local gameRootPanel = modules.game_interface.getRootPanel()
      g_keyboard.unbindKeyPress(widget.hotkey, widget.callback, gameRootPanel)
    end
    settings[widget:getId()] = settings[widget:getId()] or {}
    settings[widget:getId()].hotkey = hotkey

    window:destroy()
    setupButton(widget)
    save()
  end
  local clearFunc = function() 
    window.display:setText('')
    local hotkey = window.display:getText()

    if settings[widget:getId()].hotkey and settings[widget:getId()].hotkey:len() > 0 and widget.callback then
      local gameRootPanel = modules.game_interface.getRootPanel()
      g_keyboard.unbindKeyPress(widget.hotkey, widget.callback, gameRootPanel)
    end
    settings[widget:getId()] = settings[widget:getId()] or {}
    settings[widget:getId()].hotkey = hotkey
  
    window:destroy()
    setupButton(widget)
    save()
  end
  local closeFunc = function() 
    window:destroy()
    setupButton(widget)
  end

  window.buttonOk.onClick = okFunc
  window.buttonClear.onClick = clearFunc
  window.buttonClose.onClick = closeFunc

  local actionbar = widget:getParent():getParent()
  if actionbar.locked then
    cancelFunc()
  end
end

function setupAction(widget)
  if not widget or not widget.item or widget.type == TYPE.BLANK then 
    return
  end

  -- Criamos a lógica de execução dentro do callback direto para evitar conflitos
  widget.callback = function()
    if widget.cooldownEvent then return end 

    if widget.type == TYPE.SPELL and widget.spellData then
      local s = widget.spellData
      local target = g_game.getAttackingCreature()
      
      -- Limpa as palavras de possíveis aspas extras para não bugar o talk
      local cleanWords = s.words:gsub('"', ''):trim()
      
      -- HIERARQUIA: 
      -- 1. Se tem parâmetro manual (digitado no painel), manda ele.
      -- 2. Se não tem manual, mas tem target, manda o target.
      -- 3. Se não tem nada, manda a palavra pura.
      if widget.type == TYPE.SPELL and widget.spellData then
        local s = widget.spellData
        local cleanWords = s.words:gsub('"', ''):trim()
      
        -- Agora ele SÓ envia parâmetro se existir algo escrito no widget.param
        if s.param and s.param:len() > 0 then
          g_game.talk(cleanWords .. ' "' .. s.param .. '"')
        else
          -- Se não tem nada escrito, manda a magia pura, sem nome de target.
          g_game.talk(cleanWords)
        end

        local cdValue = tonumber(s.cooldown) or 2000
        startCooldown(widget, cdValue)
      end

      -- Cooldown
      local cdValue = tonumber(s.cooldown) or 2000
      startCooldown(widget, cdValue)

    elseif widget.type == TYPE.ITEM then
      local itemId = widget.item:getItemId()
      if not itemId or itemId <= 0 then return end

      if widget.action == ACTION.EQUIP then
        if g_game.getClientVersion() >= 910 then
          local item = Item.create(itemId)
          g_game.equipItem(item)
        end
      elseif widget.action == ACTION.USE then
        g_game.useInventoryItem(itemId)
      elseif widget.action == ACTION.USE_SELF then
        g_game.useInventoryItemWith(itemId, g_game.getLocalPlayer())
      elseif widget.action == ACTION.USE_TARGET then
        local attackingCreature = g_game.getAttackingCreature()
        if not attackingCreature then
          local item = Item.create(itemId)
          modules.game_interface.startUseWith(item)
        else
          g_game.useInventoryItemWith(itemId, attackingCreature)
        end
      elseif widget.action == ACTION.USE_CROSS then
        local item = Item.create(itemId)
        modules.game_interface.startUseWith(item)
      end
    
    elseif widget.type == TYPE.TEXT then
       if modules.game_interface.isChatVisible() then
        if widget.autoSay then
          modules.game_console.sendMessage(widget.sayText)
        else
          modules.game_console.setTextEditText(widget.sayText)
        end
      elseif widget.autoSay then
        g_game.talk(widget.sayText)
      end
    end
  end

  if widget.hotkey and widget.hotkey:len() > 0 then
    local gameRootPanel = modules.game_interface.getRootPanel()
    g_keyboard.unbindKeyDown(widget.hotkey)
    g_keyboard.bindKeyDown(widget.hotkey, widget.callback, gameRootPanel)
  end
end

function onSpellCooldown(iconId, duration)
  for i=1,9 do
    local actionbar = actionBars[i]
    if actionbar and actionbar.tabBar then
      for j, child in ipairs(actionbar.tabBar:getChildren()) do
        if child.type == 2 and child.spellData and child.spellData.id == iconId then
          startCooldown(child, duration)
        end
      end
    end
  end
end

function onSpellGroupCooldown(groupId, duration)
  for i=1,9 do
    local actionbar = actionBars[i]
    if actionbar and actionbar.tabBar then
      for j, child in ipairs(actionbar.tabBar:getChildren()) do
        if child.type == 2 and child.spellData and child.spellData.group then
          for k, group in ipairs(child.spellData.group) do
            if groupId == group then
              startCooldown(child, duration)
            end
          end
        end
      end
    end
  end
end

function startCooldown(widget, duration)
  if not widget then return end
  
  local cd = widget:recursiveGetChildById('cooldown')
  if not cd then return end

  if widget.cooldownEvent then 
    removeEvent(widget.cooldownEvent)
    widget.cooldownEvent = nil
  end

  cd:setVisible(true)
  cd:setPercent(100)
  
  -- Tenta pegar o tempo do sistema da forma que o seu client permitir
  local start = (g_clock and g_clock.realMillis and g_clock.realMillis()) or 
                (os.msec and os.msec()) or 
                (os.time() * 1000)
  
  local function update()
    local now = (g_clock and g_clock.realMillis and g_clock.realMillis()) or 
                (os.msec and os.msec()) or 
                (os.time() * 1000)
                
    local elapsed = now - start
    local pct = 100 - (elapsed / duration * 100)

    if pct > 0 then
      cd:setPercent(pct)
      local remaining = math.max(0, (duration - elapsed) / 1000)
      cd:setText(string.format("%.1f", remaining))
      widget.cooldownEvent = scheduleEvent(update, 30)
    else
      cd:setPercent(0)
      cd:setText("")
      cd:setVisible(false)
      widget.cooldownEvent = nil
    end
  end

  update()
end

function updateCooldown(action)
  if not action or not action.cooldownTill then return end
  local timeleft = action.cooldownTill - g_clock.millis()
  if timeleft <= 50 then
    action.cooldown:setPercent(100)
    action.cooldownEvent = nil
    action.cooldown:setText("")
    return
  end
  local duration = action.cooldownTill - action.cooldownStart
  local formattedText
  if timeleft > 60000 then
    formattedText = math.floor(timeleft / 60000) .. "m"
  else
    formattedText = timeleft/1000
    formattedText = math.floor(formattedText * 10) / 10
    formattedText = math.floor(formattedText) .. "." .. math.floor(formattedText * 10) % 10
  end

  local retry
  if timeleft > 60000 then
    retry = math.min(math.floor(timeleft * 0.1), 60 * 1000) -- max 1min
    retry = math.max(retry, 100) -- min 100
  elseif timeleft > 1000 then
    retry = 100
  else
    retry = 30
  end
  action.cooldown:setText(formattedText) 
  action.cooldown:setPercent(100 - math.floor(100 * timeleft / duration))
  action.cooldownEvent = scheduleEvent(function() updateCooldown(action) end, retry)
end

function save()
  local status, result = pcall(function() return json.encode(settings, 2) end)
  if not status then
      return g_logger.error(
                 "Error while saving top bar settings. Data won't be saved. Details: " ..
                     result)
  end

  if result:len() > 100 * 1024 * 1024 then
      return g_logger.error(
                 "Something went wrong, file is above 100MB, won't be saved")
  end

  g_resources.writeFileContents(settingsFile, result)
end

function load()
  if g_resources.fileExists(settingsFile) then
      local status, result = pcall(function()
          return json.decode(g_resources.readFileContents(settingsFile))
      end)
      if not status then
          return g_logger.error(
                     "Error while reading top bar settings file. To fix this problem you can delete storage.json. Details: " ..
                         result)
      end
      settings = result
  else
      settings = {}
  end
end