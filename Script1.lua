-- Função para matar o jogador selecionado
local function killSelectedPlayer(selectedPlayer)
    if selectedPlayer then
        local selectedCharacter = selectedPlayer.Character
        if selectedCharacter then
            local selectedHumanoid = selectedCharacter:FindFirstChildOfClass("Humanoid")
            if selectedHumanoid then
                selectedHumanoid.Health = 0
            end
        end
    end
end

-- Função para lançar o jogador selecionado
local function flingSelectedPlayer(selectedPlayer)
    if selectedPlayer then
        local selectedCharacter = selectedPlayer.Character
        if selectedCharacter then
            local rootPart = selectedCharacter:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 50, 0) -- Lança o jogador para cima
                bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
                bodyVelocity.P = 5000
                bodyVelocity.Parent = rootPart

                -- Remove a BodyVelocity após alguns segundos
                wait(1)
                bodyVelocity:Destroy()
            end
        end
    end
end

-- Cria a GUI
local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 150)
frame.Position = UDim2.new(0.5, -125, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui

-- Barra de título para arrastar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 20)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = frame

-- Texto da barra de título
local titleText = Instance.new("TextLabel")
titleText.Text = "REFORMA DO FAZBEAR ALPHA"
titleText.Size = UDim2.new(1, 0, 1, 0)
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.BackgroundTransparency = 1
titleText.TextScaled = true
titleText.Parent = titleBar

-- Dropdown para selecionar jogador
local dropdown = Instance.new("TextButton")
dropdown.Text = "Selecionar Jogador"
dropdown.Size = UDim2.new(0, 200, 0, 40)
dropdown.Position = UDim2.new(0.5, -100, 0.3, -20)
dropdown.Parent = frame

local dropdownList = Instance.new("ScrollingFrame")
dropdownList.Size = UDim2.new(1, 0, 0, 100)
dropdownList.Position = UDim2.new(0, 0, 1, 0)
dropdownList.CanvasSize = UDim2.new(0, 0, 0, 0)
dropdownList.BackgroundTransparency = 1
dropdownList.Parent = dropdown
dropdown.MouseButton1Click:Connect(function()
    dropdownList.Visible = not dropdownList.Visible
end)

-- Botão para atualizar a lista de jogadores
local refreshButton = Instance.new("TextButton")
refreshButton.Text = "Atualizar Lista"
refreshButton.Size = UDim2.new(0, 200, 0, 30)
refreshButton.Position = UDim2.new(0.5, -100, 0.2, -15)
refreshButton.Parent = frame
refreshButton.MouseButton1Click:Connect(function()
    dropdown.Text = "Selecionar Jogador"
    dropdownList:ClearAllChildren()
    populateDropdown()
end)

-- Função para preencher a lista suspensa com jogadores
local function populateDropdown()
    for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
        if p ~= game.Players.LocalPlayer then
            local playerButton = Instance.new("TextButton")
            playerButton.Text = p.Name
            playerButton.Size = UDim2.new(1, 0, 0, 30)
            playerButton.Parent = dropdownList

            playerButton.MouseButton1Click:Connect(function()
                dropdown.Text = p.Name
                dropdownList.Visible = false
            end)
        end
    end
end

populateDropdown()

-- Botão para matar o jogador selecionado
local killButton = Instance.new("TextButton")
killButton.Text = "Matar Jogador"
killButton.Size = UDim2.new(0, 200, 0, 40)
killButton.Position = UDim2.new(0.5, -100, 0.55, -20)
killButton.Parent = frame
killButton.MouseButton1Click:Connect(function()
    local selectedPlayer = game:GetService("Players"):FindFirstChild(dropdown.Text)
    killSelectedPlayer(selectedPlayer)
end)

-- Botão para lançar o jogador selecionado
local flingButton = Instance.new("TextButton")
flingButton.Text = "Lançar Jogador"
flingButton.Size = UDim2.new(0, 200, 0, 40)
flingButton.Position = UDim2.new(0.5, -100, 0.75, -20)
flingButton.Parent = frame
flingButton.MouseButton1Click:Connect(function()
    local selectedPlayer = game:GetService("Players"):FindFirstChild(dropdown.Text)
    flingSelectedPlayer(selectedPlayer)
end)

-- Incorpora a GUI no PlayerGui
gui.Parent = player:WaitForChild("PlayerGui")
