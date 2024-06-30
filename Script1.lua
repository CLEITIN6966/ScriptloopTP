local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer.PlayerGui
gui.Name = "TeleportGUI"
gui.Enabled = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local playerNameTextBox = Instance.new("TextBox")
playerNameTextBox.Parent = gui
playerNameTextBox.Size = UDim2.new(0.5, 0, 0.1, 0)
playerNameTextBox.Position = UDim2.new(0.25, 0, 0.2, 0)
playerNameTextBox.PlaceholderText = "Digite o nome do jogador"
playerNameTextBox.TextScaled = true

local loopPlayerButton = Instance.new("TextButton")
loopPlayerButton.Parent = gui
loopPlayerButton.Size = UDim2.new(0.5, 0, 0.1, 0)
loopPlayerButton.Position = UDim2.new(0.25, 0, 0.4, 0)
loopPlayerButton.Text = "Loop Player"

local minimizeButton = Instance.new("TextButton")
minimizeButton.Parent = gui
minimizeButton.Size = UDim2.new(0.2, 0, 0.1, 0)
minimizeButton.Position = UDim2.new(0.8, 0, 0, 0)
minimizeButton.Text = "-"
minimizeButton.TextScaled = true

local closeButton = Instance.new("TextButton")
closeButton.Parent = gui
closeButton.Size = UDim2.new(0.2, 0, 0.1, 0)
closeButton.Position = UDim2.new(0.6, 0, 0, 0)
closeButton.Text = "X"
closeButton.TextScaled = true

local isLooping = false
local teleportInterval = 5

local function teleportPlayer()
    local targetPlayer = game.Players:FindFirstChild(playerNameTextBox.Text)
    if targetPlayer then
        local playerCharacter = player.Character
        local targetCharacter = targetPlayer.Character
        if playerCharacter and targetCharacter then
            playerCharacter:SetPrimaryPartCFrame(targetCharacter.PrimaryPart.CFrame)
        end
    end
end

loopPlayerButton.MouseButton1Click:Connect(function()
    isLooping = not isLooping
    if isLooping then
        while isLooping do
            teleportPlayer()
            wait(teleportInterval)
        end
    end
end)

minimizeButton.MouseButton1Click:Connect(function()
    gui.Enabled = not gui.Enabled
end)

closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
