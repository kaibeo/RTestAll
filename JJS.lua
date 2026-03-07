local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

------------------------------------------------

local function CreateESP(player)

    if player == LocalPlayer then return end

    local function Setup(char)

        local hum = char:WaitForChild("Humanoid")
        local hrp = char:WaitForChild("HumanoidRootPart")

------------------------------------------------

-- BOX ESP

        local box = Instance.new("BoxHandleAdornment")
        box.Adornee = hrp
        box.Parent = hrp
        box.Size = Vector3.new(4,6,2)
        box.Transparency = 0.4
        box.AlwaysOnTop = true

------------------------------------------------

-- TEXT ESP

        local gui = Instance.new("BillboardGui")
        gui.Parent = hrp
        gui.Size = UDim2.new(0,140,0,30)
        gui.StudsOffset = Vector3.new(0,3,0)
        gui.AlwaysOnTop = true

        local text = Instance.new("TextLabel")
        text.Parent = gui
        text.Size = UDim2.new(1,0,1,0)
        text.BackgroundTransparency = 1
        text.TextScaled = true
        text.TextStrokeTransparency = 0
        text.Font = Enum.Font.SourceSansBold

------------------------------------------------

-- SKELETON LINES

        local lines = {}

        for i=1,12 do
            local line = Drawing.new("Line")
            line.Thickness = 2
            line.Transparency = 1
            lines[i] = line
        end

------------------------------------------------

        RunService.RenderStepped:Connect(function()

            if not char.Parent then return end

            local myChar = LocalPlayer.Character
            if not myChar then return end

            local myHRP = myChar:FindFirstChild("HumanoidRootPart")
            if not myHRP then return end

------------------------------------------------

-- RAINBOW COLOR

            local t = tick()

            local color = Color3.new(
                math.sin(t)*0.5+0.5,
                math.sin(t+2)*0.5+0.5,
                math.sin(t+4)*0.5+0.5
            )

            box.Color3 = color

------------------------------------------------

-- DISTANCE + TEXT

            local dist = math.floor((myHRP.Position - hrp.Position).Magnitude)

            text.Text = player.Name.." | "..math.floor(hum.Health).." | "..dist.."m"

------------------------------------------------

-- SKELETON PARTS

            local parts = {
                char:FindFirstChild("Head"),
                char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"),
                char:FindFirstChild("LowerTorso"),
                char:FindFirstChild("LeftUpperArm"),
                char:FindFirstChild("LeftLowerArm"),
                char:FindFirstChild("RightUpperArm"),
                char:FindFirstChild("RightLowerArm"),
                char:FindFirstChild("LeftUpperLeg"),
                char:FindFirstChild("LeftLowerLeg"),
                char:FindFirstChild("RightUpperLeg"),
                char:FindFirstChild("RightLowerLeg")
            }

------------------------------------------------

            local function draw(p1,p2,index)

                if not p1 or not p2 then
                    lines[index].Visible = false
                    return
                end

                local v1,on1 = Camera:WorldToViewportPoint(p1.Position)
                local v2,on2 = Camera:WorldToViewportPoint(p2.Position)

                if on1 and on2 then

                    lines[index].From = Vector2.new(v1.X,v1.Y)
                    lines[index].To = Vector2.new(v2.X,v2.Y)

                    lines[index].Color = color
                    lines[index].Visible = true

                else
                    lines[index].Visible = false
                end

            end

------------------------------------------------

            draw(parts[1],parts[2],1)

            draw(parts[2],parts[4],2)
            draw(parts[4],parts[5],3)

            draw(parts[2],parts[6],4)
            draw(parts[6],parts[7],5)

            draw(parts[3],parts[8],6)
            draw(parts[8],parts[9],7)

            draw(parts[3],parts[10],8)
            draw(parts[10],parts[11],9)

        end)

    end

    if player.Character then
        Setup(player.Character)
    end

    player.CharacterAdded:Connect(Setup)

end

------------------------------------------------

for _,p in ipairs(Players:GetPlayers()) do
    CreateESP(p)
end

Players.PlayerAdded:Connect(CreateESP)
