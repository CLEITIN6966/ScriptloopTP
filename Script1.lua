-- Créditos
local creditos = "Créditos: CLEITI6966"

-- Função para teleportar o jogador em loop
local function teleportarEmLoop(nomeInicial)
    -- Encontrar o jogador com nome iniciado pela letra fornecida
    local jogador = nil
    for _, player in ipairs(game.Players:GetPlayers()) do
        if string.sub(player.Name:lower(), 1, 1) == nomeInicial:lower() then
            jogador = player
            break
        end
    end
    
    if jogador then
        while true do
            -- Teleportar o jogador 10 vezes em loop
            for i = 1, 10 do
                -- Teleportar o jogador para uma posição aleatória
                jogador:MoveTo(Vector3.new(math.random(-100, 100), 10, math.random(-100, 100)))
                wait(0.65) -- Esperar 0.65 segundos antes do próximo teleport
            end
        end
    else
        print("Jogador não encontrado.")
    end
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = game.Players.LocalPlayer.PlayerGui

local frame = Instance.new("Frame")
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.Size = UDim2.new(0, 300, 0, 150)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.5
frame.Parent = gui

local nomeTextBox = Instance.new("TextBox")
nomeTextBox.Position = UDim2.new(0.5, -100, 0.5, -25)
nomeTextBox.Size = UDim2.new(0, 200, 0, 50)
nomeTextBox.TextScaled = true
nomeTextBox.PlaceholderText = "Digite a primeira letra do nome do jogador"
nomeTextBox.Parent = frame

local teleportButton = Instance.new("TextButton")
teleportButton.Position = UDim2.new(0.5, -50, 0.5, 35)
teleportButton.Size = UDim2.new(0, 100, 0, 30)
teleportButton.BackgroundColor3 = Color3.new(1, 1, 1)
teleportButton.TextColor3 = Color3.new(0, 0, 0)
teleportButton.Text = "Teleportar"
teleportButton.Parent = frame

teleportButton.MouseButton1Click:Connect(function()
    local nomeInicial = nomeTextBox.Text
    if #nomeInicial == 1 then
        teleportarEmLoop(nomeInicial)
    else
        print("Digite apenas uma letra.")
    end
end)

-- Créditos
print(creditos)
