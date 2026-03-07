-- Jujutsu Shenanigans Auto PvP Farm (Fly Speed 80)

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

-------------------------------------------------

local function press(key)

    pcall(function()

        VIM:SendKeyEvent(true,key,false,game)
        task.wait(0.05)
        VIM:SendKeyEvent(false,key,false,game)

    end)

end

-------------------------------------------------

local function M1()

    pcall(function()

        VIM:SendMouseButtonEvent(0,0,0,true,game,0)
        task.wait(0.04)
        VIM:SendMouseButtonEvent(0,0,0,false,game,0)

    end)

end

-------------------------------------------------

-- SMART FIND PLAYER

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

-------------------------------------------------

local function SetupCharacter(char)

    Character = char
    HRP = char:WaitForChild("HumanoidRootPart")

    -- noclip xuyên tường

    RunService.Stepped:Connect(function()

        if Character then

            for _,part in ipairs(Character:GetDescendants()) do

                if part:IsA("BasePart") then
                    part.CanCollide = false
                    part.Massless = true
                end

            end

        end

    end)

end

-------------------------------------------------

LocalPlayer.CharacterAdded:Connect(function(char)

    task.wait(1)

    SetupCharacter(char)

    Target = nil

end)

if LocalPlayer.Character then
    SetupCharacter(LocalPlayer.Character)
end

-------------------------------------------------

RunService.Heartbeat:Connect(function()

    if not HRP then return end

    -------------------------------------------------

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

    -------------------------------------------------

    -- Target chết

    if Target
    and Target.Character
    and Target.Character:FindFirstChild("Humanoid")
    and Target.Character.Humanoid.Health <= 0 then

        Target = nil

    end

    -------------------------------------------------

    -- tìm player

    if not Target then
        Target = GetTarget()
    end

    if not Target then return end

    local enemyChar = Target.Character

    if not enemyChar then
        Target = nil
        return
    end

    local enemyHRP = enemyChar:FindFirstChild("HumanoidRootPart")

    if not enemyHRP then
        Target = nil
        return
    end

    -------------------------------------------------

    -- bay ra sau lưng

    local behind = enemyHRP.CFrame * CFrame.new(0,0,5)

    local direction = (behind.Position - HRP.Position).Unit
    HRP.Velocity = direction * FlySpeed

    HRP.CFrame = CFrame.lookAt(HRP.Position,enemyHRP.Position)

    -------------------------------------------------

    local dist = (HRP.Position - enemyHRP.Position).Magnitude

    if dist <= 5 then

        press(Enum.KeyCode.Q)

        M1()
        M1()
        M1()

        press(Enum.KeyCode.One)
        press(Enum.KeyCode.Two)
        press(Enum.KeyCode.Three)
        press(Enum.KeyCode.Four)

        press(Enum.KeyCode.F)

    end

end)
