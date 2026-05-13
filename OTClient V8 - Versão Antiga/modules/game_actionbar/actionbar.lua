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

local currentVocation = 0
ProtocolGame.registerExtendedOpcode(198, function(protocol, opcode, buffer)
    if not buffer or buffer == "" then return end
    
    currentVocation = tonumber(buffer)
    print("ActionBar recebeu nova vocação: " .. currentVocation)
end)

STATIC_ITEMS = {
  [3552] = {cooldown = 5000}, -- speed shoes
  [3034] = {cooldown = 1000}, -- genin pill
  [3028] = {cooldown = 1000}, -- chunin pill
  [3026] = {cooldown = 1000}, -- jounin pill
  [3008] = {cooldown = 1000}, -- gamakichi pet
  [3025] = {cooldown = 1000}, -- katsuyo pet
}

local VOCATION_GROUPS = {
    [1] = "Naruto", [2] = "Naruto", [3] = "Naruto", [4] = "Naruto",
    [15] = "Sasuke", [16] = "Sasuke", [17] = "Sasuke", [18] = "Sasuke", [19] = "Sasuke",
    [24] = "Sakura", [25] = "Sakura", [26] = "Sakura", [27] = "Sakura", [28] = "Sakura",
}

local STATIC_SPELLS = {
    ["Naruto"] = {
      {id = "Kage Bunshin No Jutsu", words = "kage bunshin no jutsu", icon = 3147, cooldown = 1000},
      {id = "Dai Rendan", words = "dai rendan", icon = 3154, cooldown = 2000},
      {id = "Kyuubi Form", words = "kyuubi form", icon = 3149, cooldown = 1000},
      {id = "Rasengan", words = "rasengan", icon = 3150, cooldown = 2000},
      {id = "Daihoko", words = "daihoko", icon = 3157, cooldown = 3000},
      {id = "Oodama Rasengan", words = "oodama rasengan", icon = 3151, cooldown = 2000},
      {id = "Rasenshuriken", words = "rasenshuriken", icon = 3153, cooldown = 3000},
      {id = "Sanin Mode", words = "sanin mode", icon = 3161, cooldown = 1000},
      {id = "Meditate", words = "meditate", icon = 3158, cooldown = 1000},
      {id = "Bunshin Meditate", words = "bunshin meditate", icon = 3159, cooldown = 1000},
      {id = "Bijudama", words = "bijudama", icon = 3155, cooldown = 3000},
    },
    ["Sasuke"] = {
      {id = "Katon Daiendan No Jutsu", words = "katon daiendan no jutsu", icon = 3163, cooldown = 2000},
      {id = "Sharingan", words = "sharingan", icon = 3166, cooldown = 1000},
      {id = "Katon Goukakyu No Jutsu", words = "katon goukakyu no jutsu", icon = 3162, cooldown = 2000},
      {id = "Cursed Seal", words = "cursed seal", icon = 3167, cooldown = 1000},
      {id = "Chidori", words = "chidori", icon = 3168, cooldown = 2000},
      {id = "Katon Ryuuka No Jutsu", words = "katon ryuuka no jutsu", icon = 3165, cooldown = 2000},
      {id = "Chidori Nagashi", words = "chidori nagashi", icon = 3169, cooldown = 2000},
      {id = "Katon Gouryuuka No Jutsu", words = "katon gouryuuka no jutsu", icon = 3170, cooldown = 2000},
      {id = "Kirin", words = "kirin", icon = 3171, cooldown = 3000},
      {id = "Amaterasu", words = "amaterasu", icon = 3172, cooldown = 3000},
      {id = "Susanoo", words = "susanoo", icon = 3173, cooldown = 3000},
    },
    ["Sakura"] = {
      {id = "Bunshin No Jutsu", words = "bunshin no jutsu", icon = 3174, cooldown = 1000},
      {id = "Shannaro", words = "shannaro", icon = 3175, cooldown = 2000},
      {id = "Chiyute", words = "chiyute", icon = 3176, cooldown = 1000},
      {id = "Doku Chiyo", words = "doku chiyo", icon = 3177, cooldown = 1000},
      {id = "Chakra Gan No Seizou", words = "chakra gan no seizou", icon = 3178, cooldown = 1000},
      {id = "Chakra No Mesu", words = "chakra no mesu", icon = 3181, cooldown = 1000}, 
      {id = "Chiyute Koumou", words = "chiyute koumou", icon = 3179, cooldown = 1000},
      {id = "Create Scroll Of Healing", words = "create scroll of healing", icon = 3183, cooldown = 1000},
      {id = "Create Scroll Of Chakra", words = "create scroll of chakra", icon = 3184, cooldown = 1000},
      {id = "Create Scroll Of Speed", words = "create scroll of speed", icon = 3185, cooldown = 1000},
      {id = "Oukashou", words = "oukashou", icon = 3186, cooldown = 2000},
      {id = "Sozo Sazei", words = "sozo sazei", icon = 3187, cooldown = 1000},
      {id = "Jinshin", words = "jinshin", icon = 3188, cooldown = 2000},
    }
}

function getPlayerSpellList()
  -- Agora usamos a variável preenchida pelo Opcode
  local groupName = VOCATION_GROUPS[currentVocation]
  
  -- Debug para você ver no terminal se o mapeamento deu certo
  print("Montando lista - VocID: " .. currentVocation .. " | Grupo: " .. tostring(groupName))
  
  if not groupName then
    return {} 
  end
  
  return STATIC_SPELLS[groupName] or {}
end

-- servers may have different id's, change if not working properly (only for protocols 910+)
local function translateVocation(id) 
  if id == 1 or id == 11 then
    return 8 -- ek
  elseif id == 2 or id == 12 then
    return 7 -- rp
  elseif id == 3 or id == 13 then
    return 5 -- ms
  elseif id == 4 or id == 14 then
    return 6 -- ed
  end
end

local function isSpell(text) -- returns bool or table (spelldata, param text)
  text = text:lower():trim()

  for spellName, spellData in pairs(SpellInfo['Default']) do
    local words = spellData.words
    local param = spellData.parameter
    local data = spellData
    data.spellName = spellName

    if not param then
      if words == text then
        return {data=data}
      end
    else
      if text:find(words) then
        text = text:gsub(words, ""):trim()
        text = text:gsub('"', "")
        text = text:gsub("'", "")
        return {data=data, param=text}
      end
    end
  end

  return false
end

function init()
  connect(g_game, {
    onGameStart = online,
    onGameEnd = offline,
    onSpellGroupCooldown = onSpellGroupCooldown,
    onSpellCooldown = onSpellCooldown
  })

  if g_game.isOnline() then
    online()
  end

  -- taken from game_hotkeys
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
end

function createActionBars()
  local bottomPanel = modules.game_interface.getBottomActionPanel()
  local leftPanel = modules.game_interface.getLeftActionPanel()
  local rightPanel = modules.game_interface.getRightActionPanel()

  for i=1,9 do
    local parent
    local index
    local layout

    if i <= 3 then
      parent = bottomPanel
      index = i
      layout = 'actionbar'
    elseif i <= 6 then
      parent = leftPanel
      index = i - 3
      layout = 'sideactionbar'
    else
      parent = rightPanel
      index = i - 6
      layout = 'sideactionbar'
    end

    actionBars[i] = g_ui.loadUI(layout, parent)
    actionBars[i]:setId("actionbar."..i)
    actionBars[i].n = i
    parent:moveChildToIndex(actionBars[i], index)
  end
end

function offline()
  -- save settings to json
  save()

  -- destroy windows
  destroyAssignWindows()
  mouseGrabberWidget:destroy()

  -- remove binds
  for index, actionbar in ipairs(actionBars) do
    if actionbar.tabBar then
      for i, actionButton in ipairs(actionbar.tabBar:getChildren()) do
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
  for i, panel in ipairs(actionBars) do
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
  for i=1,#actionBars do
    local actionbar = actionBars[i]
    local enabled = g_settings.getBoolean("actionbar"..i, false)

    actionbar:setOn(enabled)
    setupActionBar(i)
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
  local visible = actionbar:isVisible()
  locked = settings[actionbar:getId()]
  actionbar.tabBar.onMouseWheel = nil -- disable scroll wheel

  actionbar.locked = locked
  actionbar.nextPanel.lock:setOn(not locked)
  actionbar.nextPanel.lock.image:setOn(not locked)

  if not visible then
    return actionbar.tabBar:destroyChildren() -- will hopefully lower stress
  else
    actionbar.tabBar:destroyChildren()
    for i=1,50 do
      local layout = n < 4 and 'ActionButton' or 'SideActionButton'
      local widget = g_ui.createWidget(layout, actionbar.tabBar)
      widget:setId(actionbar.n.."."..i)

      setupButton(widget)
    end
  end
end

function setupButton(widget)
  local id = widget:getId()
  local config = settings[id]
  local actionbar = widget:getParent():getParent()

  -- Configurações iniciais / Reset
  widget.item:setShowCount(false)
  widget.item.onItemChange = nil
  widget.type = TYPE.BLANK
  widget.text:setText("")
  widget.parameterText:setText("")
  
  if widget.item:getItemId() ~= 0 then
    widget.item:setItemId(0)
  end
  
  widget.item:setOn(false)
  widget.autoSay = nil
  widget.action = ACTION.BLANK
  widget.spellData = nil
  widget.item:setItemVisible(true)
  widget.text:setImageSource('') 
  widget.hotkey = config and config.hotkey or ""
  widget.callback = nil

  -- Limpa qualquer cooldown visual residual ao remontar o botão
  -- Usamos recursiveGetChildById para garantir que encontre o widget de cooldown
  local cd = widget:recursiveGetChildById('cooldown')
  if cd then 
    cd:setPercent(0)
    cd:setText("")
    cd:setVisible(false)
  end
  if widget.cooldownEvent then
    removeEvent(widget.cooldownEvent)
    widget.cooldownEvent = nil
  end

  -- Aplica as configurações salvas no JSON
  if config and config.type then
    widget.item:setOn(true)
    widget.type = config.type
    widget.sayText = config.sayText
    widget.autoSay = config.autoSay
    widget.action = config.action
    widget.spellData = config.spellData

    -- Lógica para ITENS
    if config.type == TYPE.ITEM then
      if widget.item:getItemId() ~= (config.itemId and config.itemId > 100 and config.itemId or 0) then
        widget.item:setItem(Item.create(config.itemId, 50))
      end
      widget.item:setItemVisible(true)
      
    -- Lógica para SPELLS (Estáticas)
    elseif config.type == TYPE.SPELL and config.spellData then
      if config.spellData.icon and config.spellData.icon > 0 then
        widget.item:setItemId(config.spellData.icon)
        widget.item:setItemVisible(true)
        widget.text:setText("") 
      else
        widget.item:setItemId(0)
        widget.item:setItemVisible(false)
        widget.text:setText(config.spellData.id) 
      end
      
    -- Lógica para TEXTO
    elseif config.type == TYPE.TEXT then
        widget.text:setText(config.sayText or "")
        widget.item:setItemVisible(false)
    end
  end

  -- Registra a Hotkey e a Função original através do setupAction
  setupAction(widget)

  -- SOBRECARGA DE EXECUÇÃO: Isso garante que o cooldown rode sempre (Hotkey ou Clique)
  local oldCallback = widget.callback
  widget.callback = function()
    print(">>> Clique detectado no slot: " .. widget:getId())

    if widget.cooldownEvent then 
      print(">>> Bloqueado: Ja em cooldown.")
      return 
    end

    if oldCallback then oldCallback() end

    if widget.type == TYPE.SPELL then
      local cdValue = (widget.spellData and widget.spellData.cooldown) or 2000
      print(">>> Iniciando visual com: " .. cdValue .. "ms")
      startCooldown(widget, cdValue)
    end
  end

  -- Atualiza o texto da Hotkey visualmente
  widget.hotkeyLabel:setText(translateHotkeyDesc(widget.hotkey))
  
  -- Tooltip e Drag & Drop
  widget.item.onDragEnter = function(self)
    if g_ui.isMouseGrabbed() or actionbar.locked then return end
    mouseGrabberWidget:grabMouse()
    g_mouse.pushCursor('target')
    self:setBorderColor('#FFFFFF')
    cachedSettings = {id=widget:getId(), data=settings[widget:getId()], widget=widget}
  end

  -- Menu do Botão Direito e Clique Esquerdo com a nova lógica
  widget.onMouseRelease = function(self, mousePos, mouseButton)
    if mouseButton == MouseRightButton then 
      local menu = g_ui.createWidget('PopupMenu')
      menu:setGameMenu(true)
      menu:addOption(widget.type == TYPE.SPELL and tr('Edit Spell') or tr('Assign Spell'), function() assignSpell(widget) end)
      menu:addOption(widget.type == TYPE.ITEM and tr('Edit Object') or tr('Assign Object'), function() assignItem(widget) end)
      menu:addOption(widget.type == TYPE.TEXT and tr('Edit Text') or tr('Assign Text'), function() assignText(widget) end)
      menu:addOption(widget.hotkey ~= "" and tr('Edit Hotkey') or tr('Assign Hotkey'), function() assignHotkey(widget) end)

      if widget.type > 0 then
        menu:addSeparator()
        menu:addOption(tr('Clear Action'), function() resetSlot(widget) end)
      end
      menu:display(mousePos)
    elseif mouseButton == MouseLeftButton then
      if self.callback then self.callback() end -- Dispara nossa sobrecarga (com cooldown)
    end
    return true
  end

  widget.item.onItemChange = function(widget)
    widget:setOn(true)
    assignItem(widget:getParent())
  end

  -- Tooltip dinâmico
  local actionDesc = "None"
  if widget.type == TYPE.TEXT then
    actionDesc = 'Say: "'.. (widget.sayText or "") ..'"'
  elseif widget.type == TYPE.SPELL and widget.spellData then
    actionDesc = "Cast: " .. widget.spellData.id .. "\nWords: " .. widget.spellData.words
  elseif widget.type == TYPE.ITEM then
    actionDesc = "Object ID: " .. widget.item:getItemId()
  end

  widget.item:setTooltip("Action Button: " .. id .. "\nAction: " .. actionDesc .. "\nHotkey: " .. (widget.hotkey ~= "" and widget.hotkey or "None"))
end

function resetSlot(widget)
  local hotkey = settings[widget:getId()] and settings[widget:getId()].hotkey or nil
  if hotkey and hotkey:len() > 0 and widget.callback then
    local gameRootPanel = modules.game_interface.getRootPanel()
    g_keyboard.unbindKeyPress(widget.hotkey, widget.callback, gameRootPanel)
  end
  
  if hotkey then
    settings[widget:getId()] = {hotkey=hotkey}
  else
    settings[widget:getId()] = nil
  end

  setupButton(widget)
end

function assignItem(widget)
  destroyAssignWindows()
  local radio = UIRadioGroup.create()
  local item = widget.item:getItem()
  local id = widget.item:getItemId()

  -- check if item wasn't cleared
  if id == 0 and widget.item:isOn() then
    return resetSlot(widget) 
  end

  -- create window
  window = g_ui.loadUI('object', g_ui.getRootWidget())
  window:show()
  window:raise()
  window:focus()

  -- basics
  window:setText("Assign Object to Action Button "..widget:getId())
  window:setId("assignItemWindow")

  -- select item
  window.select.onClick = function()
    modules.game_itemselector.show(widget.item)
  end

  -- checks
  window.item:setShowCount(false)
  window.item.onItemChange = function(widget)
    local item = window.item:getItem()

    if item then
      for i, child in ipairs(window.checks:getChildren()) do
        -- add to radio grouo
        radio:addWidget(child)

        -- enabled
        if item:getId() < 100 then
          child:setEnabled(false)
        elseif i < 4 then
          local check = item:isMultiUse()
          child:setEnabled(check)
          if check then
            radio:selectWidget(child)
          end
        elseif g_game.getClientVersion() >= 910 then
          if i == 4 then
  --           local check = item:getClothSlot() > 0
            local check = true -- unfortunately two handed weapons returns cloth 0, so we have to disable this check
            child:setEnabled(check)
            if check then
              radio:selectWidget(child)
            end
          else
            child:setEnabled(true)
            radio:selectWidget(child)
          end
        else
          child:setVisible(false)
        end
      end
    end

    -- validation
    window.buttonOk:setEnabled(item and item:getId() > 100)
    window.buttonApply:setEnabled(item and item:getId() > 100)
  end

  window.item:setItemId(id)

  -- select current action, if exists
  local actionType = widget.action or 0
  if actionType > ACTION.BLANK then
    local id
    if actionType == ACTION.USE_SELF then
      id = "useSelf"
    elseif actionType == ACTION.USE_TARGET then
      id = "useTarget"
    elseif actionType == ACTION.USE_CROSS then
      id = "useCross"
    elseif actionType == ACTION.EQUIP then
      id = "equip"
    elseif actionType == ACTION.USE then
      id = "use"
    end

    for i, child in ipairs(radio.widgets) do
      local childId = child:getId()
      if childId == id then
        radio:selectWidget(child)
        break
      end
    end
  end

  -- functions
  local okFunc = function(destroy)
    local hotkey = settings[widget:getId()] and settings[widget:getId()].hotkey
    if hotkey and hotkey:len() > 0 and widget.callback then
      local gameRootPanel = modules.game_interface.getRootPanel()
      g_keyboard.unbindKeyPress(widget.hotkey, widget.callback, gameRootPanel)
    end

    settings[widget:getId()] = {hotkey=hotkey}
    settings[widget:getId()].itemId = window.item:getItemId()
    settings[widget:getId()].type = TYPE.ITEM

    local selected = radio:getSelectedWidget():getId()
    if selected == "useSelf" then
      settings[widget:getId()].action = ACTION.USE_SELF
    elseif selected == "useTarget" then
      settings[widget:getId()].action = ACTION.USE_TARGET
    elseif selected == "useCross" then
      settings[widget:getId()].action = ACTION.USE_CROSS
    elseif selected == "equip" then
      settings[widget:getId()].action = ACTION.EQUIP
    else
      settings[widget:getId()].action = ACTION.USE
    end

    if destroy then
      window:destroy()
      radio:destroy()
    end
    setupButton(widget)
  end

  local cancelFunc = function()
    setupButton(widget)
    window:destroy()
    radio:destroy()
  end

  -- callbacks
  window.buttonOk.onClick = function() okFunc(true) end
  window.onEnter = function() okFunc(true) end
  window.buttonApply.onClick = function() okFunc(false) end
  window.buttonClose.onClick = cancelFunc
  window.onEscape = cancelFunc

  local actionbar = widget:getParent():getParent()
  if actionbar.locked then
    cancelFunc()
  end
end

function assignText(widget)
  destroyAssignWindows()

  -- create window
  window = g_ui.loadUI('text', g_ui.getRootWidget())
  window:show()
  window:raise()
  window:focus()

  window.text.onTextChange = function(self, text)
    window.buttonOk:setEnabled(text:len() > 0)
    window.buttonApply:setEnabled(text:len() > 0)
  end

  -- copy settings from current widget
  window.text:setText(widget.text:getText())
  if widget.type > 0 then
    window.checkPanel.tick:setChecked(widget.autoSay)
  end

  -- functions
  local okFunc = function(destroy) 
    local autoSay = window.checkPanel.tick:isChecked()
    local text = window.text:getText()

    local hotkey = settings[widget:getId()] and settings[widget:getId()].hotkey
    if hotkey and hotkey:len() > 0 and widget.callback then
      local gameRootPanel = modules.game_interface.getRootPanel()
      g_keyboard.unbindKeyPress(hotkey, widget.callback, gameRootPanel)
    end

    settings[widget:getId()] = {hotkey=hotkey}

    local spell = isSpell(text)
    if spell then -- entered text is spell
      local paramText = spell.param
      local spellData = spell.data
      local newGroup = {}
      for groupId, duration in pairs(spellData.group) do
        table.insert(newGroup, groupId)
      end
      spellData.group = newGroup

  
      settings[widget:getId()].type = TYPE.SPELL
      settings[widget:getId()].spellData = {
        words = spellData.words,
        cd = spellData.exhaustion/1000,
        mana = spellData.mana,
        source = SpelllistSettings['Default'].iconFile,
        clip = Spells.getImageClip(SpellIcons[spellData.icon][1], 'Default'),
        name = spellData.spellName,
        param = paramText,
        group = spellData.group,
        id = spellData.id
      }
    else -- is just text
      settings[widget:getId()].sayText = text
      settings[widget:getId()].type = TYPE.TEXT
      settings[widget:getId()].autoSay = autoSay
    end
  
    if destroy then
      window:destroy()
    end
    setupButton(widget)
  end
  local cancelFunc = function()
    window:destroy()
    setupButton(widget)
  end

  -- buttons
  window.buttonOk.onClick = function() okFunc(true) end
  window.buttonApply.onClick = function() okFunc(false) end
  window.buttonClose.onClick = cancelFunc
  window.onEscape = cancelFunc
  window.onEnter = function() okFunc(true) end

  local actionbar = widget:getParent():getParent()
  if actionbar.locked then
    cancelFunc()
  end
end

function assignSpell(widget)
  destroyAssignWindows()
  
  window = g_ui.loadUI('spell', g_ui.getRootWidget())
  window:setId("assignSpellWindow")
  window:show()
  window:raise()
  window:focus()

  local spellList = window:getChildById('spellList')
  spellList:destroyChildren()

  local jutsus = getPlayerSpellList()
  local radioGroup = UIRadioGroup.create()

  for _, spell in ipairs(jutsus) do
    local label = g_ui.createWidget('SpellPreview', spellList)
    label.spellData = spell
    
    -- No seu OTUI, o ícone é um filho chamado 'image'
    local iconWidget = label:getChildById('image')
    
    -- Lógica de Ícone vs Texto
    if iconWidget then
      if spell.icon and spell.icon > 0 then
        -- Mudamos o tipo do widget dinamicamente para UIItem para aceitar setItemId
        -- Ou simplesmente usamos a propriedade se o motor permitir
        iconWidget:setItemId(spell.icon)
        label:setText(spell.id) -- Mantendo o texto ao lado, como o text-offset: 38 sugere
      else
        iconWidget:setItemId(0)
        label:setText(spell.id)
      end
    end
    
    radioGroup:addWidget(label)
  end

  -- Botão OK
  window.buttonOk.onClick = function()
    local selected = radioGroup:getSelectedWidget()
    if selected then
      settings[widget:getId()] = settings[widget:getId()] or {}
      settings[widget:getId()].type = TYPE.SPELL
      settings[widget:getId()].spellData = selected.spellData
      
      setupButton(widget)
      save()
      radioGroup:destroy()
      window:destroy()
    end
  end
  
  -- Botão Close (Conforme seu OTUI)
  if window.buttonClose then
    window.buttonClose.onClick = function() 
      radioGroup:destroy()
      window:destroy() 
    end
  end

  window.onEscape = function() 
    radioGroup:destroy()
    window:destroy() 
  end
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
  if widget.type == TYPE.BLANK then 
    return
  end

  local executeLogic = nil

  if widget.type == TYPE.TEXT then
    executeLogic = function()
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
  elseif widget.type == TYPE.SPELL then
    executeLogic = function()
      local paramText = (widget.spellData and widget.spellData.param and widget.spellData.param:len() > 0) and (' "'.. widget.spellData.param ..'"') or ""
      if widget.spellData and widget.spellData.words then
        g_game.talk(widget.spellData.words..paramText)
      end
    end
  elseif widget.type == TYPE.ITEM then
    executeLogic = function()
      if widget.action == ACTION.BLANK then return end
      
      if widget.action == ACTION.EQUIP then
        if g_game.getClientVersion() >= 910 then
          local item = Item.create(widget.item:getItemId())
          return g_game.equipItem(item)
        end
      elseif widget.action == ACTION.USE then
        g_game.useInventoryItem(widget.item:getItemId())
      elseif widget.action == ACTION.USE_SELF then
        g_game.useInventoryItemWith(widget.item:getItemId(), g_game.getLocalPlayer())
      elseif widget.action == ACTION.USE_TARGET then
        local attackingCreature = g_game.getAttackingCreature()
        if not attackingCreature then
          local item = Item.create(widget.item:getItemId())
          modules.game_interface.startUseWith(item)
          return
        end
        g_game.useInventoryItemWith(widget.item:getItemId(), attackingCreature)
      elseif widget.action == ACTION.USE_CROSS then
        local item = Item.create(widget.item:getItemId())
        modules.game_interface.startUseWith(item)
      end
    end
  end

  -- animação do cooldown
  widget.callback = function()
    -- 1. Executa a ação (Magia ou Item) sempre que apertar
    if executeLogic then
      executeLogic()
    end

    -- 2. Gerenciamento de Cooldown Visual
    -- Se JÁ EXISTE um cooldown rodando no visual, saímos daqui para não resetar a barra
    if widget.cooldownEvent then 
      return 
    end

    local cdValue = 0

    if widget.type == TYPE.SPELL then
      -- Cooldown de Magia
      cdValue = (widget.spellData and widget.spellData.cooldown) or 2000
    elseif widget.type == TYPE.ITEM and widget.item then
      -- Cooldown de Item (Ex: ID 3034)
      local itemId = widget.item:getItemId()
      cdValue = (STATIC_ITEMS[itemId] and STATIC_ITEMS[itemId].cooldown) or 1000
    end

    -- 3. Inicia a animação apenas se houver valor e se não houver uma rodando (check acima)
    if cdValue > 0 then
      startCooldown(widget, cdValue)
    end
  end

  -- Registro da Hotkey (Vincula a tecla ao callback acima)
  if widget.hotkey and widget.hotkey:len() > 0 and widget.callback then
    local gameRootPanel = modules.game_interface.getRootPanel()
    g_keyboard.unbindKeyDown(widget.hotkey, widget.callback, gameRootPanel)
    g_keyboard.bindKeyDown(widget.hotkey, widget.callback, gameRootPanel)
  end
end

function onSpellCooldown(iconId, duration)
  for index, actionbar in ipairs(actionBars) do
    for i, child in ipairs(actionbar.tabBar:getChildren()) do
      if child.type == 2 and child.spellData.id == iconId then
        startCooldown(child, duration)
      end
    end
  end
end

function onSpellGroupCooldown(groupId, duration)
  for index, actionbar in ipairs(actionBars) do
    for i, child in ipairs(actionbar.tabBar:getChildren()) do
      if child.type == 2 and child.spellData.group then
        for i, group in ipairs(child.spellData.group) do
          if groupId == group then
            startCooldown(child, duration)
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