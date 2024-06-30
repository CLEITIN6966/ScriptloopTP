-- Crie uma GUI flutuante
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Estilo da GUI
gui.Name = "TeleportGUI"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 150, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Position = UDim2.new(0.5, -75, 0.5, -50)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Draggable = true  -- Permitir arrastar a GUI

-- Texto de créditos
local credits = Instance.new("TextLabel")
credits.Parent = frame
credits.Size = UDim2.new(1, 0, 0, 20)
credits.Position = UDim2.new(0, 0, 0, 0)
credits.BackgroundTransparency = 1
credits.TextColor3 = Color3.fromRGB(255, 255, 255)
credits.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
credits.TextStrokeTransparency = 0.5
credits.TextSize = 14
credits.Font = Enum.Font.SourceSansBold
credits.Text = "Créditos: CLEITI6966"

-- Função de teleportar em loop
local function teleportLoop(playerName)
    local targetPlayer = game.Players:FindFirstChild(playerName)
    if targetPlayer then
        for i = 1, 10 do
            game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(targetPlayer.Character.PrimaryPart.CFrame)
            wait(0.69)
        end
    else
        warn("Jogador não encontrado!")
    end
end

-- Criar um botão para iniciar o teleport
local teleportButton = Instance.new("TextButton")
teleportButton.Parent = frame
teleportButton.Size = UDim2.new(1, -10, 0, 30)
teleportButton.Position = UDim2.new(0, 5, 0, 40)
teleportButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportButton.TextSize = 18
teleportButton.Font = Enum.Font.SourceSansBold
teleportButton.Text = "Teleportar"
teleportButton.MouseButton1Click:Connect(function()
    teleportLoop("NomeParcial") -- Substitua "NomeParcial" pelo nome desejado ou use uma entrada dinâmica
end)
