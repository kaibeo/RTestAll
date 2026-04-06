-- =============================================
-- AUTO BOUNTY HUB UI (CHỈ UI THUẦN - KHÔNG CÓ CODE CHỨC NĂNG)
-- Copy paste nguyên đoạn này vào LocalScript hoặc Executor
-- Giống y chang ảnh cuối cùng mày gửi (đã bỏ status moon %)
-- =============================================

local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoBountyHubUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1, 0, 1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- =============================================
-- TOP BAR
-- =============================================
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.BackgroundTransparency = 1
topBar.Parent = mainFrame

local robloxLogo = Instance.new("ImageLabel")
robloxLogo.Size = UDim2.new(0, 40, 0, 40)
robloxLogo.Position = UDim2.new(0, 20, 0, 5)
robloxLogo.BackgroundTransparency = 1
robloxLogo.Image = "rbxassetid://357249130"
robloxLogo.Parent = topBar

local menuIcon = Instance.new("TextButton")
menuIcon.Size = UDim2.new(0, 40, 0, 40)
menuIcon.Position = UDim2.new(0, 80, 0, 5)
menuIcon.BackgroundTransparency = 1
menuIcon.Text = "≡"
menuIcon.TextColor3 = Color3.fromRGB(255,255,255)
menuIcon.TextScaled = true
menuIcon.Font = Enum.Font.GothamBold
menuIcon.Parent = topBar

local chatIcon = Instance.new("TextButton")
chatIcon.Size = UDim2.new(0, 40, 0, 40)
chatIcon.Position = UDim2.new(0, 130, 0, 5)
chatIcon.BackgroundTransparency = 1
chatIcon.Text = "💬"
chatIcon.TextColor3 = Color3.fromRGB(255,255,255)
chatIcon.TextScaled = true
chatIcon.Font = Enum.Font.GothamBold
chatIcon.Parent = topBar

-- =============================================
-- LEFT PANEL
-- =============================================
local leftPanel = Instance.new("Frame")
leftPanel.Size = UDim2.new(0, 180, 1, 0)
leftPanel.Position = UDim2.new(0, 20, 0, 60)
leftPanel.BackgroundTransparency = 1
leftPanel.Parent = mainFrame

local compass = Instance.new("ImageLabel")
compass.Size = UDim2.new(0, 60, 0, 60)
compass.Position = UDim2.new(0, 0, 0, 0)
compass.BackgroundTransparency = 1
compass.Image = "rbxassetid://3926305904"
compass.Parent = leftPanel

local menuBtn = Instance.new("TextButton")
menuBtn.Size = UDim2.new(0, 150, 0, 40)
menuBtn.Position = UDim2.new(0, 0, 0, 80)
menuBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
menuBtn.Text = "Menu"
menuBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
menuBtn.TextScaled = true
menuBtn.Font = Enum.Font.GothamBold
menuBtn.Parent = leftPanel

local menuNotif = Instance.new("TextLabel")
menuNotif.Size = UDim2.new(0, 20, 0, 20)
menuNotif.Position = UDim2.new(1, -25, 0, 5)
menuNotif.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
menuNotif.Text = "24"
menuNotif.TextColor3 = Color3.fromRGB(255, 255, 255)
menuNotif.TextScaled = true
menuNotif.Font = Enum.Font.GothamBold
menuNotif.Parent = menuBtn

local levelLabel = Instance.new("TextLabel")
levelLabel.Size = UDim2.new(0, 150, 0, 30)
levelLabel.Position = UDim2.new(0, 0, 0, 130)
levelLabel.BackgroundTransparency = 1
levelLabel.Text = "Cấp 29"
levelLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
levelLabel.TextScaled = true
levelLabel.Font = Enum.Font.GothamBold
levelLabel.Parent = leftPanel

local moneyLabel = Instance.new("TextLabel")
moneyLabel.Size = UDim2.new(0, 150, 0, 30)
moneyLabel.Position = UDim2.new(0, 0, 0, 170)
moneyLabel.BackgroundTransparency = 1
moneyLabel.Text = "$36,253"
moneyLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
moneyLabel.TextScaled = true
moneyLabel.Font = Enum.Font.GothamBold
moneyLabel.Parent = leftPanel

-- =============================================
-- CENTER CONTENT
-- =============================================
local centerFrame = Instance.new("Frame")
centerFrame.Size = UDim2.new(0.55, 0, 0.8, 0)
centerFrame.Position = UDim2.new(0.25, 0, 0.12, 0)
centerFrame.BackgroundTransparency = 1
centerFrame.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 60)
title.BackgroundTransparency = 1
title.Text = "Auto Bounty Hub"
title.TextColor3 = Color3.fromRGB(0, 255, 200)
title.TextScaled = true
title.Font = Enum.Font.GothamBlack
title.Parent = centerFrame

local mainTimer = Instance.new("TextLabel")
mainTimer.Size = UDim2.new(1, 0, 0, 40)
mainTimer.Position = UDim2.new(0, 0, 0, 60)
mainTimer.BackgroundTransparency = 1
mainTimer.Text = "0 Hours, 1 Minutes, 37 Seconds"
mainTimer.TextColor3 = Color3.fromRGB(255, 255, 255)
mainTimer.TextScaled = true
mainTimer.Font = Enum.Font.GothamBold
mainTimer.Parent = centerFrame

local username = Instance.new("TextLabel")
username.Size = UDim2.new(1, 0, 0, 30)
username.Position = UDim2.new(0, 0, 0, 100)
username.BackgroundTransparency = 1
username.Text = "( khanhlyxinhgai680 )"
username.TextColor3 = Color3.fromRGB(200, 200, 255)
username.TextScaled = true
username.Font = Enum.Font.Gotham
username.Parent = centerFrame

-- Health bar
local healthFrame = Instance.new("Frame")
healthFrame.Size = UDim2.new(0.48, 0, 0, 25)
healthFrame.Position = UDim2.new(0, 0, 0, 140)
healthFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
healthFrame.BorderColor3 = Color3.fromRGB(0, 255, 0)
healthFrame.BorderSizePixel = 2
healthFrame.Parent = centerFrame

local healthBar = Instance.new("Frame")
healthBar.Size = UDim2.new(1, -4, 1, -4)
healthBar.Position = UDim2.new(0, 2, 0, 2)
healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
healthBar.Parent = healthFrame

local healthText = Instance.new("TextLabel")
healthText.Size = UDim2.new(1, 0, 1, 0)
healthText.BackgroundTransparency = 1
healthText.Text = "Máu 115/115"
healthText.TextColor3 = Color3.fromRGB(255, 255, 255)
healthText.TextScaled = true
healthText.Font = Enum.Font.GothamBold
healthText.Parent = healthFrame

-- Energy bar
local energyFrame = Instance.new("Frame")
energyFrame.Size = UDim2.new(0.48, 0, 0, 25)
energyFrame.Position = UDim2.new(0.52, 0, 0, 140)
energyFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
energyFrame.BorderColor3 = Color3.fromRGB(0, 200, 255)
energyFrame.BorderSizePixel = 2
energyFrame.Parent = centerFrame

local energyBar = Instance.new("Frame")
energyBar.Size = UDim2.new(1, -4, 1, -4)
energyBar.Position = UDim2.new(0, 2, 0, 2)
energyBar.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
energyBar.Parent = energyFrame

local energyText = Instance.new("TextLabel")
energyText.Size = UDim2.new(1, 0, 1, 0)
energyText.BackgroundTransparency = 1
energyText.Text = "Năng Lượng 195/195"
energyText.TextColor3 = Color3.fromRGB(255, 255, 255)
energyText.TextScaled = true
energyText.Font = Enum.Font.GothamBold
energyText.Parent = energyFrame

-- Fist + Creature
local fistIcon = Instance.new("ImageLabel")
fistIcon.Size = UDim2.new(0, 60, 0, 60)
fistIcon.Position = UDim2.new(0.1, 0, 0, 180)
fistIcon.BackgroundTransparency = 1
fistIcon.Image = "rbxassetid://3926307971"
fistIcon.Parent = centerFrame

local creatureIcon = Instance.new("ImageLabel")
creatureIcon.Size = UDim2.new(0, 80, 0, 80)
creatureIcon.Position = UDim2.new(0.35, 0, 0, 170)
creatureIcon.BackgroundTransparency = 1
creatureIcon.Image = "rbxassetid://1234567890" -- thay ID creature nếu mày có
creatureIcon.Parent = centerFrame

-- =============================================
-- AUTO BOUNTY FEATURES PANEL
-- =============================================
local featurePanel = Instance.new("Frame")
featurePanel.Size = UDim2.new(0.95, 0, 0, 220)
featurePanel.Position = UDim2.new(0.025, 0, 0, 280)
featurePanel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
featurePanel.BorderColor3 = Color3.fromRGB(0, 255, 200)
featurePanel.BorderSizePixel = 3
featurePanel.Parent = centerFrame

local featureTitle = Instance.new("TextLabel")
featureTitle.Size = UDim2.new(1, 0, 0, 40)
featureTitle.BackgroundTransparency = 1
featureTitle.Text = "Auto Bounty Features"
featureTitle.TextColor3 = Color3.fromRGB(0, 255, 200)
featureTitle.TextScaled = true
featureTitle.Font = Enum.Font.GothamBold
featureTitle.Parent = featurePanel

-- Left column
local timeBounty = Instance.new("TextLabel")
timeBounty.Size = UDim2.new(0.5, -10, 0, 30)
timeBounty.Position = UDim2.new(0, 10, 0, 50)
timeBounty.BackgroundTransparency = 1
timeBounty.Text = "Time Bounty          00:12:45"
timeBounty.TextColor3 = Color3.fromRGB(255, 255, 255)
timeBounty.TextXAlignment = Enum.TextXAlignment.Left
timeBounty.TextScaled = true
timeBounty.Font = Enum.Font.Gotham
timeBounty.Parent = featurePanel

local playerLabel = Instance.new("TextLabel")
playerLabel.Size = UDim2.new(0.5, -10, 0, 30)
playerLabel.Position = UDim2.new(0, 10, 0, 85)
playerLabel.BackgroundTransparency = 1
playerLabel.Text = "Player\nBounty Player: NoobSlayer123"
playerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
playerLabel.TextXAlignment = Enum.TextXAlignment.Left
playerLabel.TextScaled = true
playerLabel.Font = Enum.Font.Gotham
playerLabel.Parent = featurePanel

local tgHop = Instance.new("TextLabel")
tgHop.Size = UDim2.new(0.5, -10, 0, 30)
tgHop.Position = UDim2.new(0, 10, 0, 120)
tgHop.BackgroundTransparency = 1
tgHop.Text = "TG Hop               00:45"
tgHop.TextColor3 = Color3.fromRGB(255, 255, 255)
tgHop.TextXAlignment = Enum.TextXAlignment.Left
tgHop.TextScaled = true
tgHop.Font = Enum.Font.Gotham
tgHop.Parent = featurePanel

local tgSkip = Instance.new("TextLabel")
tgSkip.Size = UDim2.new(0.5, -10, 0, 30)
tgSkip.Position = UDim2.new(0, 10, 0, 155)
tgSkip.BackgroundTransparency = 1
tgSkip.Text = "TG Skip Player     01:12"
tgSkip.TextColor3 = Color3.fromRGB(255, 255, 255)
tgSkip.TextXAlignment = Enum.TextXAlignment.Left
tgSkip.TextScaled = true
tgSkip.Font = Enum.Font.Gotham
tgSkip.Parent = featurePanel

-- Right column buttons (chỉ UI, không có chức năng)
local nextPlayerBtn = Instance.new("TextButton")
nextPlayerBtn.Size = UDim2.new(0.45, 0, 0, 55)
nextPlayerBtn.Position = UDim2.new(0.52, 0, 0, 50)
nextPlayerBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
nextPlayerBtn.Text = "Next Player >>"
nextPlayerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
nextPlayerBtn.TextScaled = true
nextPlayerBtn.Font = Enum.Font.GothamBold
nextPlayerBtn.Parent = featurePanel

local hopServerBtn = Instance.new("TextButton")
hopServerBtn.Size = UDim2.new(0.45, 0, 0, 55)
hopServerBtn.Position = UDim2.new(0.52, 0, 0, 115)
hopServerBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 255)
hopServerBtn.Text = "Hop Server"
hopServerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hopServerBtn.TextScaled = true
hopServerBtn.Font = Enum.Font.GothamBold
hopServerBtn.Parent = featurePanel

-- =============================================
-- RIGHT BOX
-- =============================================
local rightBox = Instance.new("Frame")
rightBox.Size = UDim2.new(0, 220, 0, 80)
rightBox.Position = UDim2.new(1, -250, 0, 80)
rightBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
rightBox.BorderColor3 = Color3.fromRGB(0, 255, 200)
rightBox.BorderSizePixel = 3
rightBox.Parent = mainFrame

local boxIcon = Instance.new("ImageLabel")
boxIcon.Size = UDim2.new(0, 50, 0, 50)
boxIcon.Position = UDim2.new(0, 10, 0.5, -25)
boxIcon.BackgroundTransparency = 1
boxIcon.Image = "rbxassetid://3926307971"
boxIcon.Parent = rightBox

local boxText = Instance.new("TextLabel")
boxText.Size = UDim2.new(0.6, 0, 1, 0)
boxText.Position = UDim2.new(0.3, 0, 0, 0)
boxText.BackgroundTransparency = 1
boxText.Text = "Auto Bounty\nWhite Screen (B)"
boxText.TextColor3 = Color3.fromRGB(0, 255, 200)
boxText.TextScaled = true
boxText.Font = Enum.Font.GothamBold
boxText.TextXAlignment = Enum.TextXAlignment.Left
boxText.Parent = rightBox

-- =============================================
-- BOTTOM VERSION
-- =============================================
local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(0, 300, 0, 20)
versionLabel.Position = UDim2.new(0.5, -150, 1, -30)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "v31.1.2-Sea1 : 2326e1df"
versionLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
versionLabel.TextScaled = true
versionLabel.Font = Enum.Font.Gotham
versionLabel.Parent = mainFrame
