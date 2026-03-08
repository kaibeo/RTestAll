-- Jujutsu Shenanigans Full PvP Fly Script

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")

local LP = Players.LocalPlayer
local Char, HRP, Hum
local Target

local FlySpeed = 200
local Delay = 0.1

local attacking = false
local LastHealth = 0

------------------------------------------------
-- PRESS KEY

local function press(key)

VIM:SendKeyEvent(true,key,false,game)
task.wait(0.05)
VIM:SendKeyEvent(false,key,false,game)

end

------------------------------------------------
-- M1 SYSTEM

local function StartM1()

if attacking then return end
attacking = true

task.spawn(function()

while attacking do

VIM:SendMouseButtonEvent(0,0,0,true,game,0)
task.wait()
VIM:SendMouseButtonEvent(0,0,0,false,game,0)

task.wait(0.08)

end

end)

end

local function StopM1()
attacking = false
end

------------------------------------------------
-- FIND TARGET

local function GetTarget()

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

------------------------------------------------
-- Noclip

RunService.Stepped:Connect(function()

for _,v in pairs(Char:GetDescendants()) do
if v:IsA("BasePart") then
v.CanCollide = false
end
end

end)

------------------------------------------------
-- Dodge khi bị đánh

Hum.HealthChanged:Connect(function(h)

if h < LastHealth then

HRP.CFrame = HRP.CFrame * CFrame.new(math.random(-8,8),0,0)

press(Enum.KeyCode.Q)

end

LastHealth = h

end)

------------------------------------------------
-- Fly system

local attachment = Instance.new("Attachment")
attachment.Parent = HRP

local velocity = Instance.new("LinearVelocity")
velocity.Attachment0 = attachment
velocity.MaxForce = math.huge
velocity.VectorVelocity = Vector3.zero
velocity.Parent = HRP

------------------------------------------------
-- MAIN LOOP

RunService.Heartbeat:Connect(function()

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

------------------------------------------------
-- LOCK SAU LƯNG

local behind =
enemyHRP.Position -
enemyHRP.CFrame.LookVector * 3

local direction =
(behind - HRP.Position).Unit

velocity.VectorVelocity =
direction * FlySpeed

HRP.CFrame =
CFrame.lookAt(HRP.Position, enemyHRP.Position)

------------------------------------------------
-- COMBAT

local dist =
(HRP.Position - enemyHRP.Position).Magnitude

if dist <= 6 then

press(Enum.KeyCode.R)

StartM1()

press(Enum.KeyCode.One)
press(Enum.KeyCode.Two)
press(Enum.KeyCode.Three)
press(Enum.KeyCode.Four)

else

StopM1()

end

end)

end

------------------------------------------------

LP.CharacterAdded:Connect(function(c)

task.wait(1)
SetupCharacter(c)
Target=nil

end)

if LP.Character then
SetupCharacter(LP.Character)
end

------------------------------------------------
-- ESP

local function CreateESP(player)

if player == LP then return end

local function Setup(char)

local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

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

local dist =
math.floor((myHRP.Position - hrp.Position).Magnitude)

text.Text =
player.Name.." | "..math.floor(hum.Health).." | "..dist.."m"

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
