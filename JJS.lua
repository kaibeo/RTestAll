-- Jujutsu Shenanigans Backstab PvP FIX

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")

local LP = Players.LocalPlayer
local Char, HRP
local Target

local attacking = false

------------------------------------------------
-- PRESS KEY

local function press(key)

VIM:SendKeyEvent(true,key,false,game)
task.wait(0.05)
VIM:SendKeyEvent(false,key,false,game)

end

------------------------------------------------
-- M1

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
-- CHARACTER SETUP

local function SetupCharacter(c)

Char = c
HRP = c:WaitForChild("HumanoidRootPart")

RunService.Stepped:Connect(function()

for _,v in pairs(Char:GetDescendants()) do
if v:IsA("BasePart") then
v.CanCollide = false
end
end

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
-- GET BEHIND POSITION

local function GetBehind(enemyHRP)

local behind =
enemyHRP.Position -
enemyHRP.CFrame.LookVector * 4

return behind

end

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
-- MOVE BEHIND

local behind = GetBehind(enemyHRP)

local direction =
(behind - HRP.Position).Unit

HRP.AssemblyLinearVelocity =
direction * 200

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
