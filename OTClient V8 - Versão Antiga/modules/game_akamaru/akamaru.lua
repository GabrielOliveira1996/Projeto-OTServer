-- Criamos um objeto para facilitar a referência no OTUI
AkamaruSystem = {}

akamaruWindow = nil
akamaruButton = nil

function init()
  ProtocolGame.registerExtendedOpcode(101, onReceiveAkamaruData)
  g_keyboard.bindKeyDown('Ctrl+Shift+A', AkamaruSystem.toggle)
  connect(g_game, { onGameStart = createButton, 
                    onGameEnd = destroyWindow })
end

function terminate()
  ProtocolGame.unregisterExtendedOpcode(101)
  destroyWindow()
  g_keyboard.unbindKeyDown('Ctrl+Shift+A')
end

function toggle()
  if not akamaruWindow then return end

  if akamaruWindow:isVisible() then
    akamaruWindow:hide()
  else
    akamaruWindow:show()
    akamaruWindow:raise()
    akamaruWindow:focus()
    
    -- Se os dados ainda não chegaram, mostramos o loading
    local loading = akamaruWindow:getChildById('loadingPanel')
    if loading then
       loading:setVisible(true)
       -- Pedimos os dados ao servidor toda vez que abrir a tela
       g_game.getProtocolGame():sendExtendedOpcode(AKAMARU_OPCODE, "request")
    end
  end
end

-- recebe os dados do akamaru
function onReceiveAkamaruData(protocol, opcode, buffer)
  
  if not buffer or buffer == "" then 
    return 
  end
  
  if not akamaruWindow then
    akamaruWindow = g_ui.displayUI('akamaru')
    akamaruWindow:hide()
  end

  local data = string.explode(buffer, "|")

  local function setLabelText(id, text)
    local widget = akamaruWindow:getChildById(id)
    if widget then widget:setText(text) end
  end

  setLabelText('levelLabel', 'Nivel: ' .. (data[1] or 0))
  setLabelText('pointsLabel', 'Pontos: ' .. (data[4] or 0))

  local currentExp = tonumber(data[2]) or 0
  local neededExp  = tonumber(data[3]) or 1 -- Evita divisão por zero
  setLabelText('expLabel', 'Experiencia: ' .. currentExp .. ' / ' .. neededExp)
  
  local expBar = akamaruWindow:getChildById('expBar')
  if expBar then
    local percent = math.min(100, math.floor((currentExp / neededExp) * 100))
    expBar:setPercent(percent)
  end
  -- vida total
  setLabelText('totalHpLabel', 'Hp: ' .. (data[9] or 0))
  -- velocidade total
  setLabelText('totalSpeedLabel', 'Speed: ' .. (data[11] or 0))

  -- atributos simples
  setLabelText('attackLabel', (data[5] or 0))
  setLabelText('agilityLabel', (data[6] or 0))
  setLabelText('dodgeLabel', (data[7] or 0))
  setLabelText('hpLabel', (data[8] or 0))
  setLabelText('speedLabel', (data[10] or 0))
  local loading = akamaruWindow:getChildById('loadingPanel')
  if loading then
     loading:setVisible(false)
  end
end

function createButton()
  if akamaruButton then return end
  if modules.client_topmenu then
    akamaruButton = modules.client_topmenu.addLeftGameButton('akamaruButton', 'Akamaru', '/images/topbuttons/spelllist', AkamaruSystem.toggle)
  end
end

function destroyWindow()
  if akamaruWindow then
    akamaruWindow:destroy()
    akamaruWindow = nil
  end
  if akamaruButton then
    akamaruButton:destroy()
    akamaruButton = nil
  end
end

-- Funções dentro da tabela AkamaruSystem para o OTUI encontrar
function AkamaruSystem.toggle()
  -- Só cria a janela se o jogador estiver logado
  if not g_game.isOnline() then return end

  -- Se a janela não existir (primeira vez que abre), cria agora
  if not akamaruWindow then
    akamaruWindow = g_ui.displayUI('akamaru')
    akamaruWindow:hide()
  end

  if akamaruWindow:isVisible() then
    akamaruWindow:hide()
  else
    akamaruWindow:show()
    akamaruWindow:raise()
    akamaruWindow:focus()
  end
end

function AkamaruSystem.addPoint(attr)
  -- Aqui enviaremos o comando para o servidor no próximo passo
  print("Enviando ponto para: " .. attr)
end