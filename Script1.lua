-- Coloque este script dentro de um LocalScript dentro da ScreenGui no Roblox Studio

-- Lista de comandos de administração
local commands = {
    ["kill"] = function(player)
        player:LoadCharacter()
    end,
    ["tp"] = function(player, targetPlayer)
        player.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position)
    end,
    ["giveitem"] = function(player, itemId)
        local tool = Instance.new("Tool")
        tool.Name = "AdminTool"
        tool.RequiresHandle = false
        tool.TextureId = "rbxassetid://" .. itemId
        tool.Parent = player.Backpack
    end,
    ["msg"] = function(player, message)
        game:GetService("ReplicatedStorage").RemoteEvent:FireClient(player, message)
    end,
    ["tploop"] = function(player, targetPlayer)
        -- Verifica se já existe um loop em execução
        if player.TeleportLoop then
            player.TeleportLoop:Disconnect()
            player.TeleportLoop = nil
            return
        end
        
        -- Função para teleportar repetidamente
        local function teleportLoop()
            while true do
                player.Character:MoveTo(targetPlayer.Character.HumanoidRootPart.Position)
                wait(1)  -- Teleporta a cada segundo
            end
        end
        
        -- Inicia o loop de teleportação
        player.TeleportLoop = game:GetService("RunService").Heartbeat:Connect(teleportLoop)
    end,
    -- Adicione mais comandos conforme necessário
}

-- Função para criar e configurar a GUI de administração
local function createAdminGUI()
    local player = game.Players.LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Name = "AdminGUI"
    gui.ResetOnSpawn = false  -- Evita que a GUI seja redefinida quando o jogador morrer ou se desconectar
    gui.Parent = player.PlayerGui

    local frame = Instance.new("Frame")
    frame.Name = "AdminFrame"
    frame.Size = UDim2.new(0, 200, 0, 300)
    frame.Position = UDim2.new(0.5, -100, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    frame.Active = true
    frame.Draggable = true  -- Permite arrastar a janela
    frame.Parent = gui

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "Administração"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 18
    titleLabel.Font = Enum.Font.SourceSansBold
    titleLabel.Parent = frame

    -- Campo de entrada para o nome do jogador de destino
    local playerInput = Instance.new("TextBox")
    playerInput.Name = "PlayerInput"
    playerInput.Size = UDim2.new(0.9, 0, 0, 30)
    playerInput.Position = UDim2.new(0.05, 0, 0, 40)
    playerInput.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    playerInput.BorderSizePixel = 2
    playerInput.BorderColor3 = Color3.fromRGB(0, 0, 0)
    playerInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    playerInput.TextSize = 14
    playerInput.Font = Enum.Font.SourceSans
    playerInput.PlaceholderText = "Nome do jogador"
    playerInput.Parent = frame

    -- Botão para iniciar/parar o loop de teleportação
    local tpLoopButton = Instance.new("TextButton")
    tpLoopButton.Name = "TpLoopButton"
    tpLoopButton.Size = UDim2.new(0.9, 0, 0, 30)
    tpLoopButton.Position = UDim2.new(0.05, 0, 0, 80)
    tpLoopButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    tpLoopButton.BorderSizePixel = 2
    tpLoopButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    tpLoopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tpLoopButton.TextSize = 14
    tpLoopButton.Font = Enum.Font.SourceSans
    tpLoopButton.Text = "TpLoop"
    tpLoopButton.Parent = frame

    -- Conectar clique do botão ao comando correspondente
    tpLoopButton.MouseButton1Click:Connect(function()
        local targetPlayer = game.Players:FindFirstChild(playerInput.Text)
        if targetPlayer then
            commands["tploop"](player, targetPlayer)
        else
            print("Jogador não encontrado.")
        end
    end)

    -- Função para permitir arrastar a janela
    local dragging
    local dragStartOffset

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStartOffset = frame.Position - UDim2.new(0, input.Position.X, 0, input.Position.Y)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.TouchMovement and dragging then
            local newPosition = UDim2.new(dragStartOffset.X.Scale, input.Position.X + dragStartOffset.X.Offset, dragStartOffset.Y.Scale, input.Position.Y + dragStartOffset.Y.Offset)
            frame.Position = newPosition
        end
    end)
end

-- Chama a função para criar a GUI
createAdminGUI()
