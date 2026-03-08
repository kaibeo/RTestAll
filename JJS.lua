-- Jujutsu Shenanigans PERFECT PvP Script

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")

local LP = Players.LocalPlayer
local Char, HRP, Hum
local Target

local attacking = false
local LastHealth = 0
local LastDamage = tick()

------------------------------------------------
-- PRESS KEY

local function press(key)

VIM:SendKeyEvent(true,key,false,game)
task.wait(0.05)
VIM:SendKeyEvent(false,key,false,game)

end

------------------------------------------------
-- M1

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
-- FIND TARGET

local function GetTarget()

if not HRP then return end

local nearest
local shortest = math.huge

for _,p in pairs(Players:GetPlayers()) do

if p ~= LP then

local c = p.Character
local h = c and c:FindFirstChildOfClass("Humanoid")
local r = c and c:FindFirstChild("HumanoidRootPart")

if c and h and r and h.Health > 0 then

local d = (HRP.Position - r.Position).Magnitude

if d < shortest then
shortest = d
nearest = p
end

end

end

end

return nearest

end

------------------------------------------------
-- SETUP CHARACTER

local function SetupCharacter(c)

Char = c
HRP = c:WaitForChild("HumanoidRootPart")
Hum = c:WaitForChild("Humanoid")

LastHealth = Hum.Health

RunService.Stepped:Connect(function()

for _,v in pairs(Char:GetDescendants()) do
if v:IsA("BasePart") then
v.CanCollide = false
end
end

end)

Hum.HealthChanged:Connect(function(h)

if h < LastHealth then

HRP.CFrame = HRP.CFrame * CFrame.new(math.random(-8,8),0,0)

press(Enum.KeyCode.Q)

end

LastHealth = h

end)

end

LP.CharacterAdded:Connect(function(c)

task.wait(1)
SetupCharacter(c)
Target=nil

end)

if LP.Character then
SetupCharacter(LP.Character)
end

------------------------------------------------
-- PREDICT BEHIND POSITION

local function GetBehind(enemyHRP)

local predict = enemyHRP.Position + enemyHRP.AssemblyLinearVelocity * 0.2

return CFrame.new(predict) * CFrame.new(0,0,5)

end

------------------------------------------------
-- MAIN LOOP

RunService.Heartbeat:Connect(function()

if not HRP then return end

if tick() - LastDamage > 120 then
Target=nil
end

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

------------------------------------------------
-- MOVE PERFECT BEHIND

local behind = GetBehind(enemyHRP)

local dist = (behind.Position - HRP.Position).Magnitude

local speed = math.clamp(dist*2,30,90)

HRP.AssemblyLinearVelocity =
(behind.Position - HRP.Position).Unit * speed

HRP.CFrame = CFrame.lookAt(HRP.Position,enemyHRP.Position)

------------------------------------------------
-- COMBAT

local distEnemy = (HRP.Position - enemyHRP.Position).Magnitude

if distEnemy <= 6 then

press(Enum.KeyCode.R)

M1()

press(Enum.KeyCode.One)
press(Enum.KeyCode.Two)
press(Enum.KeyCode.Three)
press(Enum.KeyCode.Four)

LastDamage = tick()

end

end)

------------------------------------------------
-- ESP

local function CreateESP(player)

if player == LP then return end

local function Setup(char)

local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

local box = Instance.new("BoxHandleAdornment")
box.Adornee = hrp
box.Parent = hrp
box.Size = Vector3.new(4,6,2)
box.AlwaysOnTop = true
box.Transparency = 0.4

local gui = Instance.new("BillboardGui")
gui.Parent = hrp
gui.Size = UDim2.new(0,120,0,25)
gui.StudsOffset = Vector3.new(0,3,0)
gui.AlwaysOnTop = true

local text = Instance.new("TextLabel")
text.Parent = gui
text.Size = UDim2.new(1,0,1,0)
text.BackgroundTransparency = 1
text.TextScaled = true
text.TextStrokeTransparency = 0

RunService.RenderStepped:Connect(function()

local myChar = LP.Character
if not myChar then return end

local myHRP = myChar:FindFirstChild("HumanoidRootPart")
if not myHRP then return end

local t = tick()

local color = Color3.new(
math.sin(t)*0.5+0.5,
math.sin(t+2)*0.5+0.5,
math.sin(t+4)*0.5+0.5
)

box.Color3 = color

local dist = math.floor(
(myHRP.Position - hrp.Position).Magnitude)

text.Text = player.Name.." | "..math.floor(hum.Health).." | "..dist.."m"

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
