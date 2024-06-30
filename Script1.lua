-- Verifica se o jogador está em um dispositivo mobile
local isMobile = game:GetService("UserInputService").TouchEnabled

-- Criar a GUI
local gui = Instance.new("ScreenGui")
gui.Name = "PlayerTeleportGUI"
gui.IgnoreGuiInset = true  -- Ignora margens de GUI (importante para mobile)
gui.Parent = game.Players.LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 140)  -- Aumentado um pouco para acomodar o campo de texto
frame.Position = UDim2.new(0.5, -100, 0.5, -70)
frame.BackgroundColor3 = Color3.new(1, 1, 1)
frame.BorderSizePixel = 2

local title = Instance.new("TextLabel")
title.Text = "Player Teleport GUI"
title.Size = UDim2.new(1, 0, 0, 20)
title.Position = UDim2.new(0, 0, 0, 0)
title.TextColor3 = Color3.new(0, 0, 0)
title.Parent = frame

local minimizeButton = Instance.new("TextButton")
minimizeButton.Text = "-"
minimizeButton.Size = UDim2.new(0, 20, 0, 20)
minimizeButton.Position = UDim2.new(1, -20, 0, 0)
minimizeButton.Parent = title

local nameLabel = Instance.new("TextLabel")
nameLabel.Text = "Digite o nome do jogador:"
nameLabel.Size = UDim2.new(1, 0, 0, 20)
nameLabel.Position = UDim2.new(0, 10, 0, 30)
nameLabel.TextColor3 = Color3.new(0, 0, 0)
nameLabel.Parent = frame

local nameInput = Instance.new("TextBox")
nameInput.PlaceholderText = "Digite aqui"
nameInput.Size = UDim2.new(1, -20, 0, 30)
nameInput.Position = UDim2.new(0, 10, 0, 60)
nameInput.TextColor3 = Color3.new(0, 0, 0)
nameInput.Parent = frame

local teleportButton = Instance.new("TextButton")
teleportButton.Text = "Teleportar Jogador"
teleportButton.Size = UDim2.new(0, 150, 0, 30)
teleportButton.Position = UDim2.new(0.5, -75, 0, 100)
teleportButton.Parent = frame

local function findPlayerByName(name)
    name = name:lower()
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player.Name:lower():match(name) then
            return player
        end
    end
    return nil
end

teleportButton.MouseButton1Click:Connect(function()
    local playerName = nameInput.Text
    local player = findPlayerByName(playerName)
    if player then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
    else
        print("Jogador não encontrado.")
    end
end)

-- Implementar função de arrastar para mobile
if isMobile then
    local touchGui = gui:Clone()
    touchGui.Parent = game.Players.LocalPlayer.PlayerGui
    touchGui.Enabled = true  -- Garantir que a GUI esteja visível

    local touchFrame = frame:Clone()
    touchFrame.Parent = touchGui

    local touchStartPos = nil
    local dragOffset = nil

    local function onTouchStart(touchPosition)
        touchStartPos = touchPosition.Position
        dragOffset = touchFrame.Position - UDim2.new(0, touchStartPos.X, 0, touchStartPos.Y)
    end

    local function onTouchMove(touchPosition)
        local newPos = UDim2.new(0, touchPosition.Position.X, 0, touchPosition.Position.Y) + dragOffset
        touchFrame.Position = newPos
    end

    game:GetService("UserInputService").TouchMoved:Connect(function(touch)
        if touchGui.Enabled and touchFrame then
            onTouchMove(touch)
        end
    end)

    game:GetService("UserInputService").TouchStarted:Connect(function(touch)
        if touchGui.Enabled and touchFrame then
            onTouchStart(touch)
        end
    end)
end
