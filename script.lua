
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local seguindo = false

local gui = Instance.new("ScreenGui")
gui.Name = "SeguirBola"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local botao = Instance.new("TextButton")
botao.Size = UDim2.fromOffset(150, 50)
botao.Position = UDim2.new(0.5, -75, 0.75, 0)
botao.Text = "SEGUIR"
botao.TextScaled = true
botao.Parent = gui

botao.Activated:Connect(function()
    seguindo = not seguindo
    botao.Text = seguindo and "PARAR" or "SEGUIR"
end)

RunService.RenderStepped:Connect(function()
    if not seguindo then return end

    local character = player.Character
    local humanoid = character
        and character:FindFirstChildOfClass("Humanoid")
    local root = character
        and character:FindFirstChild("HumanoidRootPart")

    local bola = workspace:FindFirstChild("Ball", true)
        or workspace:FindFirstChild("SoccerBall", true)

    if humanoid and root and bola and bola:IsA("BasePart") then
        local distancia = (bola.Position - root.Position).Magnitude

        if distancia > 5 then
            humanoid:MoveTo(bola.Position)
        else
            humanoid:Move(Vector3.zero)
        end
    end
end)
