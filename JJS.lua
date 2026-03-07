-- Jujutsu Shenanigans Auto PvP FULL

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer

local Character
local HRP
local Target

local FlySpeed = 80

local LastPos
local StuckTime = 0
local attacking = false

------------------------------------------------

local function press(key)

    VIM:SendKeyEvent(true,key,false,game)
    task.wait(0.05)
    VIM:SendKeyEvent(false,key,false,game)

end

------------------------------------------------

-- Smooth M1

local function M1()

    if attacking then return end
    attacking = true

    VIM:SendMouseButtonEvent(0,0,0,true,game,0)
    task.wait(0.05)
    VIM:SendMouseButtonEvent(0,0,0,false,game,0)

    task.wait(0.12)

    attacking = false

end

------------------------------------------------

-- Smart Find Player

local function GetTarget()

    if not HRP then return nil end

    local nearest
    local shortest = math.huge

    for _,player in ipairs(Players:GetPlayers()) do

        if player ~= LocalPlayer then

            local char = player.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if char and hum and hrp and hum.Health > 0 then

                local dist = (HRP.Position - hrp.Position).Magnitude

                if dist < shortest then
                    shortest = dist
                    nearest = player
                end

            end

        end

    end

    return nearest

end

------------------------------------------------

-- Character Setup

local function SetupCharacter(char)

    Character = char
    HRP = char:WaitForChild("HumanoidRootPart")

    RunService.Stepped:Connect(function()

        for _,v in ipairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
                v.Massless = true
            end
        end

    end)

end

------------------------------------------------

LocalPlayer.CharacterAdded:Connect(function(char)

    task.wait(1)

    SetupCharacter(char)

    Target = nil

end)

if LocalPlayer.Character then
    SetupCharacter(LocalPlayer.Character)
end

------------------------------------------------

-- ESP SYSTEM

local function CreateESP(player)

    if player == LocalPlayer then return end

    local function Setup(char)

        local hrp = char:WaitForChild("HumanoidRootPart",5)
        local hum = char:FindFirstChildOfClass("Humanoid")

        if not hrp or not hum then return end

        local highlight = Instance.new("Highlight")
        highlight.Parent = char
        highlight.FillTransparency = 1
        highlight.OutlineColor = Color3.fromRGB(255,0,0)

        local gui = Instance.new("BillboardGui")
        gui.Parent = hrp
        gui.Size = UDim2.new(0,200,0,50)
        gui.StudsOffset = Vector3.new(0,3,0)
        gui.AlwaysOnTop = true

        local text = Instance.new("TextLabel")
        text.Parent = gui
        text.Size = UDim2.new(1,0,1,0)
        text.BackgroundTransparency = 1
        text.TextColor3 = Color3.fromRGB(255,0,0)
        text.TextStrokeTransparency = 0
        text.TextScaled = true

        RunService.Heartbeat:Connect(function()
            if hum then
                text.Text = player.Name.." | "..math.floor(hum.Health)
            end
        end)

    end

    if player.Character then
        Setup(player.Character)
    end

    player.CharacterAdded:Connect(Setup)

end

for _,p in ipairs(Players:GetPlayers()) do
    CreateESP(p)
end

Players.PlayerAdded:Connect(CreateESP)

------------------------------------------------

-- DOMAIN DETECT

local DomainActive = false

local function CheckDomain()

    if Character and Character:FindFirstChild("Domain") then
        DomainActive = true
    else
        DomainActive = false
    end

end

------------------------------------------------

RunService.Heartbeat:Connect(function()

    if not HRP then return end

    CheckDomain()

------------------------------------------------

-- Anti Stuck

    if LastPos then

        local dist = (HRP.Position - LastPos).Magnitude

        if dist < 1 then
            StuckTime += 1
        else
            StuckTime = 0
        end

        if StuckTime > 180 then

            if Target and Target.Character then
                local enemyHRP = Target.Character:FindFirstChild("HumanoidRootPart")
                if enemyHRP then
                    HRP.CFrame = enemyHRP.CFrame * CFrame.new(0,0,5)
                end
            end

            StuckTime = 0

        end

    end

    LastPos = HRP.Position

------------------------------------------------

-- Target chết

    if Target
    and Target.Character
    and Target.Character:FindFirstChild("Humanoid")
    and Target.Character.Humanoid.Health <= 0 then
        Target = nil
    end

------------------------------------------------

    if not Target then
        Target = GetTarget()
    end

    if not Target then return end

    local enemyChar = Target.Character
    if not enemyChar then Target = nil return end

    local enemyHRP = enemyChar:FindFirstChild("HumanoidRootPart")
    if not enemyHRP then Target = nil return end

------------------------------------------------

-- Fly sau lưng

    local behind = enemyHRP.CFrame * CFrame.new(0,0,5)

    local direction = (behind.Position - HRP.Position).Unit
    HRP.Velocity = direction * FlySpeed

    HRP.CFrame = CFrame.lookAt(HRP.Position,enemyHRP.Position)

------------------------------------------------

    local dist = (HRP.Position - enemyHRP.Position).Magnitude

    if dist <= 6 then

        -- Auto Domain
        if not DomainActive then
            press(Enum.KeyCode.R)
        end

        M1()

        press(Enum.KeyCode.One)
        press(Enum.KeyCode.Two)
        press(Enum.KeyCode.Three)
        press(Enum.KeyCode.Four)

    end

end)
