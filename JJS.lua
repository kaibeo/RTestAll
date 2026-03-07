-- Jujutsu Shenanigans Auto PvP (FULL FIX)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer

local Character
local HRP
local Target

local Height = 100
local Smooth = 0.15

local State = "RAISE"

local LastPos
local StuckTime = 0

----------------------------------------------------

local function press(key)

    pcall(function()

        VIM:SendKeyEvent(true,key,false,game)
        task.wait(0.05)
        VIM:SendKeyEvent(false,key,false,game)

    end)

end

----------------------------------------------------

local function M1()

    pcall(function()

        VIM:SendMouseButtonEvent(0,0,0,true,game,0)
        task.wait(0.04)
        VIM:SendMouseButtonEvent(0,0,0,false,game,0)

    end)

end

----------------------------------------------------

local function GetNearest()

    if not HRP then return nil end

    local nearest
    local shortest = math.huge

    for _,v in pairs(Players:GetPlayers()) do

        if v ~= LocalPlayer then

            local char = v.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            local hrp = char and char:FindFirstChild("HumanoidRootPart")

            if char and hum and hrp and hum.Health > 0 then

                local dist = (HRP.Position - hrp.Position).Magnitude

                if dist < shortest then
                    shortest = dist
                    nearest = v
                end

            end

        end

    end

    return nearest
end

----------------------------------------------------

local function SetupCharacter(char)

    Character = char
    HRP = char:WaitForChild("HumanoidRootPart",5)

    if not HRP then
        warn("HRP not found")
        return
    end

    RunService.Stepped:Connect(function()

        if Character then
            for _,v in pairs(Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end

    end)

end

----------------------------------------------------

LocalPlayer.CharacterAdded:Connect(function(char)

    task.wait(1)

    SetupCharacter(char)

    Target = nil
    State = "RAISE"

end)

if LocalPlayer.Character then
    SetupCharacter(LocalPlayer.Character)
end

----------------------------------------------------

RunService.Heartbeat:Connect(function()

    if not HRP then return end

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

    -- target chết

    if Target
    and Target.Character
    and Target.Character:FindFirstChild("Humanoid")
    and Target.Character.Humanoid.Health <= 0 then

        Target = nil
        State = "RAISE"

    end

    ------------------------------------------------

    -- tìm target

    if not Target then

        Target = GetNearest()

        if not Target then
            return
        end

        State = "RAISE"

    end

    ------------------------------------------------

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

    local dist = (HRP.Position - enemyHRP.Position).Magnitude

    ------------------------------------------------

    if State == "RAISE" then

        local raisePos = Vector3.new(
            HRP.Position.X,
            enemyHRP.Position.Y + Height,
            HRP.Position.Z
        )

        HRP.CFrame = HRP.CFrame:Lerp(CFrame.new(raisePos),Smooth)

        if math.abs(HRP.Position.Y - (enemyHRP.Position.Y + Height)) < 5 then
            State = "MOVE"
        end

    elseif State == "MOVE" then

        local movePos = Vector3.new(
            enemyHRP.Position.X,
            enemyHRP.Position.Y + Height,
            enemyHRP.Position.Z
        )

        HRP.CFrame = HRP.CFrame:Lerp(CFrame.new(movePos),Smooth)

        if dist < 25 then
            State = "DROP"
        end

    elseif State == "DROP" then

        local behind = enemyHRP.CFrame * CFrame.new(0,0,5)

        HRP.CFrame = HRP.CFrame:Lerp(behind,0.3)

        HRP.CFrame = CFrame.lookAt(HRP.Position,enemyHRP.Position)

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

    end

end)
