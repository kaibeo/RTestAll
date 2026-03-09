local _version = "1.6.63"
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. _version .. "/main.lua"))()

WindUI:AddTheme({
    Name = "Dark",
    Accent = Color3.fromHex("#18181b"),
    Background = Color3.fromHex("#101010"),
    Outline = Color3.fromHex("#FFFFFF"),
    Text = Color3.fromHex("#FFFFFF"),
    Placeholder = Color3.fromHex("#7a7a7a"),
    Button = Color3.fromHex("#52525b"),
    Icon = Color3.fromHex("#a1a1aa"),
})

local Window = WindUI:CreateWindow({
    Title = "Ziner Hub | JuJutsu Shenanigans",
    Icon = "rbxassetid://140139922076121",
    Author = "Version: <font color=\"#FFD700\">FREEMIUM</font>",
    Folder = "bet",
    Size = UDim2.fromOffset(580,460),
    MinSize = Vector2.new(560,350),
    MaxSize = Vector2.new(850,560),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {Enabled = true}
})

local Infotab = Window:Tab({
    Title = "Tab Information",
    Icon = "info",
    Border = true
})

local Hoptab = Window:Tab({
    Title = "Tab Farming",
    Icon = "person-standing",
    Border = true
})

Window:EditOpenButton({
    Title = "Click Here To Open",
    Icon = "rbxassetid://140139922076121",
    CornerRadius = UDim.new(1),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("#EFBA54"),
        Color3.fromHex("#000000")
    ),
    Enabled = true
})

------------------------------------------------
-- SERVICES

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")

local LP = Players.LocalPlayer

------------------------------------------------
-- VARIABLES

local FlyFarm = false
local AutoCombo = false
local ESP = false

local Target

------------------------------------------------
-- TARGET AI

local function GetTarget()

    local Char = LP.Character
    if not Char then return end

    local HRP = Char:FindFirstChild("HumanoidRootPart")
    if not HRP then return end

    local nearest
    local dist = math.huge

    for _,p in pairs(Players:GetPlayers()) do

        if p ~= LP then

            local c = p.Character
            local hum = c and c:FindFirstChildOfClass("Humanoid")
            local hrp = c and c:FindFirstChild("HumanoidRootPart")

            if c and hum and hrp and hum.Health > 0 then

                local d = (HRP.Position - hrp.Position).Magnitude

                if d < dist then
                    dist = d
                    nearest = p
                end

            end

        end

    end

    return nearest

end

------------------------------------------------
-- FLY FARM

Hoptab:Toggle({
    Title = "Fly Farm",
    Default = false,
    Callback = function(v)
        FlyFarm = v
    end
})

------------------------------------------------
-- AUTO COMBO

local function press(key)

    VIM:SendKeyEvent(true,key,false,game)
    task.wait(0.05)
    VIM:SendKeyEvent(false,key,false,game)

end

Hoptab:Toggle({
    Title = "Auto Combo",
    Default = false,
    Callback = function(v)
        AutoCombo = v
    end
})

------------------------------------------------
-- MAIN FARM LOOP

RunService.Heartbeat:Connect(function()

    if not FlyFarm then return end

    local Char = LP.Character
    if not Char then return end

    local HRP = Char:FindFirstChild("HumanoidRootPart")
    if not HRP then return end

    if not Target then
        Target = GetTarget()
    end

    if not Target then return end

    local enemy = Target.Character
    if not enemy then Target=nil return end

    local enemyHRP = enemy:FindFirstChild("HumanoidRootPart")
    local enemyHum = enemy:FindFirstChildOfClass("Humanoid")

    if not enemyHRP or not enemyHum then
        Target=nil
        return
    end

    if enemyHum.Health <= 0 then
        Target=nil
        return
    end

    local behind = enemyHRP.Position - enemyHRP.CFrame.LookVector * 3

    HRP.CFrame = CFrame.new(behind, enemyHRP.Position)

    if AutoCombo then

        VIM:SendMouseButtonEvent(0,0,0,true,game,0)
        task.wait()
        VIM:SendMouseButtonEvent(0,0,0,false,game,0)

        press(Enum.KeyCode.One)
        press(Enum.KeyCode.Two)
        press(Enum.KeyCode.Three)
        press(Enum.KeyCode.Four)

    end

end)

------------------------------------------------
-- BOX ESP

Infotab:Toggle({
    Title = "Box ESP",
    Default = false,
    Callback = function(v)
        ESP = v
    end
})

local function CreateESP(player)

    if player == LP then return end

    local function Setup(char)

        local hrp = char:WaitForChild("HumanoidRootPart")

        local box = Instance.new("BoxHandleAdornment")
        box.Adornee = hrp
        box.Parent = hrp
        box.Size = Vector3.new(4,6,2)
        box.Transparency = 0.4
        box.AlwaysOnTop = true

        RunService.RenderStepped:Connect(function()

            box.Visible = ESP

        end)

    end

    if player.Character then
        Setup(player.Character)
    end

    player.CharacterAdded:Connect(Setup)

end

for _,p in pairs(Players:GetPlayers()) do
    CreateESP(p)
end

Players.PlayerAdded:Connect(CreateESP)
