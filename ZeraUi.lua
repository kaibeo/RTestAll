-- ============================================================
--  AUTO BOUNTY HUB UI  |  Chỉ 3 phần được khoanh vàng
--  Đặt LocalScript này trong StarterPlayerScripts
-- ============================================================

local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local player     = Players.LocalPlayer
local gui        = player:WaitForChild("PlayerGui")

-- ── Helpers ──────────────────────────────────────────────────
local function hms(s)          -- format  00:12:45
	s = math.max(0, math.floor(s))
	return string.format("%02d:%02d:%02d",
		math.floor(s/3600), math.floor(s%3600/60), s%60)
end
local function hmsWords(s)     -- format  0 Hours, 1 Minutes, 37 Seconds
	s = math.max(0, math.floor(s))
	return string.format("(%d Hours, %d Minutes, %d Seconds)",
		math.floor(s/3600), math.floor(s%3600/60), s%60)
end
local function uiStroke(parent, color, thick)
	local st = Instance.new("UIStroke")
	st.Color     = color  or Color3.fromRGB(180,30,30)
	st.Thickness = thick  or 2
	st.Parent    = parent
end
local function corner(parent, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 8)
	c.Parent = parent
end

-- ── ScreenGui ────────────────────────────────────────────────
local SG = Instance.new("ScreenGui")
SG.Name            = "Ziner Hub Auto Bounty m1"
SG.ResetOnSpawn    = false
SG.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
SG.Parent          = gui

-- ╔══════════════════════════════════════════════════════╗
-- ║  1. TIÊU ĐỀ TRÊN CÙNG  (giữa-trên)                  ║
-- ╚══════════════════════════════════════════════════════╝
local TitleFrame = Instance.new("Frame")
TitleFrame.Name              = "TitleFrame"
TitleFrame.AnchorPoint       = Vector2.new(0.5, 0)
TitleFrame.Position          = UDim2.new(0.5, 0,  0, 28)   -- căn giữa, sát trên
TitleFrame.Size               = UDim2.new(0, 320, 0, 70)
TitleFrame.BackgroundTransparency = 1
TitleFrame.Parent            = SG

--  "Auto Bounty Hub"
local TitleMain = Instance.new("TextLabel")
TitleMain.Size               = UDim2.new(1, 0, 0, 28)
TitleMain.Position           = UDim2.new(0, 0, 0, 0)
TitleMain.BackgroundTransparency = 1
TitleMain.Text               = "Auto Bounty Hub"
TitleMain.TextColor3         = Color3.fromRGB(255, 90, 30)
TitleMain.Font               = Enum.Font.GothamBold
TitleMain.TextScaled         = true
TitleMain.Parent             = TitleFrame

--  "(0 Hours, 1 Minutes, 37 Seconds)"
local TitleTime = Instance.new("TextLabel")
TitleTime.Size               = UDim2.new(1, 0, 0, 20)
TitleTime.Position           = UDim2.new(0, 0, 0, 28)
TitleTime.BackgroundTransparency = 1
TitleTime.Text               = "(0 Hours, 0 Minutes, 0 Seconds)"
TitleTime.TextColor3         = Color3.fromRGB(255, 255, 255)
TitleTime.Font               = Enum.Font.Gotham
TitleTime.TextScaled         = true
TitleTime.Parent             = TitleFrame

--  "( khanhlyxinhgai680 )"
local TitleUser = Instance.new("TextLabel")
TitleUser.Size               = UDim2.new(1, 0, 0, 18)
TitleUser.Position           = UDim2.new(0, 0, 0, 50)
TitleUser.BackgroundTransparency = 1
TitleUser.Text               = "( " .. player.Name .. " )"
TitleUser.TextColor3         = Color3.fromRGB(255, 255, 255)
TitleUser.Font               = Enum.Font.Gotham
TitleUser.TextScaled         = true
TitleUser.Parent             = TitleFrame

-- ╔══════════════════════════════════════════════════════╗
-- ║  2. NÚT NHỎ GÓC PHẢI TRÊN                           ║
-- ╚══════════════════════════════════════════════════════╝
local MiniBtn = Instance.new("Frame")
MiniBtn.Name          = "MiniBtn"
MiniBtn.AnchorPoint   = Vector2.new(1, 0)
MiniBtn.Position      = UDim2.new(1, -10, 0, 55)   -- góc phải, dưới topbar
MiniBtn.Size          = UDim2.new(0, 145, 0, 44)
MiniBtn.BackgroundColor3 = Color3.fromRGB(160, 20, 20)
MiniBtn.Parent        = SG
corner(MiniBtn, 6)
uiStroke(MiniBtn, Color3.fromRGB(220,40,40), 1.5)

--  Icon  (chữ Z màu đỏ đậm thay icon ảnh gốc)
local MiniIcon = Instance.new("TextLabel")
MiniIcon.Size             = UDim2.new(0, 36, 1, 0)
MiniIcon.Position         = UDim2.new(0, 4, 0, 0)
MiniIcon.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
MiniIcon.Text             = "Z"
MiniIcon.TextColor3       = Color3.fromRGB(255,255,255)
MiniIcon.Font             = Enum.Font.GothamBlack
MiniIcon.TextScaled       = true
MiniIcon.Parent           = MiniBtn
corner(MiniIcon, 5)

--  Hai dòng text
local MiniL1 = Instance.new("TextLabel")
MiniL1.Size     = UDim2.new(1,-44,0,22)
MiniL1.Position = UDim2.new(0,42,0,2)
MiniL1.BackgroundTransparency = 1
MiniL1.Text     = "Auto Bounty"
MiniL1.TextColor3 = Color3.fromRGB(255,255,255)
MiniL1.Font     = Enum.Font.GothamBold
MiniL1.TextScaled = true
MiniL1.TextXAlignment = Enum.TextXAlignment.Left
MiniL1.Parent   = MiniBtn

local MiniL2 = Instance.new("TextLabel")
MiniL2.Size     = UDim2.new(1,-44,0,18)
MiniL2.Position = UDim2.new(0,42,0,24)
MiniL2.BackgroundTransparency = 1
MiniL2.Text     = "White Screen (B)"
MiniL2.TextColor3 = Color3.fromRGB(220,220,220)
MiniL2.Font     = Enum.Font.Gotham
MiniL2.TextScaled = true
MiniL2.TextXAlignment = Enum.TextXAlignment.Left
MiniL2.Parent   = MiniBtn

-- ╔══════════════════════════════════════════════════════╗
-- ║  3. PANEL "AUTO BOUNTY FEATURES"  (giữa-dưới)       ║
-- ╚══════════════════════════════════════════════════════╝
local Panel = Instance.new("Frame")
Panel.Name            = "BountyPanel"
Panel.AnchorPoint     = Vector2.new(0.5, 1)
Panel.Position        = UDim2.new(0.5, 0, 1, -70)  -- sát đáy
Panel.Size            = UDim2.new(0, 490, 0, 158)
Panel.BackgroundColor3 = Color3.fromRGB(20, 5, 5)
Panel.Parent          = SG
corner(Panel, 10)
uiStroke(Panel, Color3.fromRGB(200,30,30), 2)

--  Tiêu đề panel
local PanelTitle = Instance.new("TextLabel")
PanelTitle.Size     = UDim2.new(0.55, 0, 0, 28)
PanelTitle.Position = UDim2.new(0, 12, 0, 6)
PanelTitle.BackgroundTransparency = 1
PanelTitle.Text     = "Auto Bounty Features"
PanelTitle.TextColor3 = Color3.fromRGB(255, 80, 50)
PanelTitle.Font     = Enum.Font.GothamBold
PanelTitle.TextScaled = true
PanelTitle.TextXAlignment = Enum.TextXAlignment.Left
PanelTitle.Parent   = Panel

-- ── hàm tạo 1 hàng timer (thanh đỏ trái + tên + giờ) ────────
local function makeTimerRow(parent, label, initSec, yPos)
	-- Thanh đỏ dọc bên trái
	local bar = Instance.new("Frame")
	bar.Size     = UDim2.new(0, 4, 0, 26)
	bar.Position = UDim2.new(0, 8, 0, yPos)
	bar.BackgroundColor3 = Color3.fromRGB(200,30,30)
	bar.BorderSizePixel  = 0
	bar.Parent   = parent

	-- Tên
	local nm = Instance.new("TextLabel")
	nm.Size     = UDim2.new(0, 180, 0, 22)
	nm.Position = UDim2.new(0, 18, 0, yPos+2)
	nm.BackgroundTransparency = 1
	nm.Text     = label
	nm.TextColor3 = Color3.fromRGB(210,210,210)
	nm.Font     = Enum.Font.Gotham
	nm.TextScaled = true
	nm.TextXAlignment = Enum.TextXAlignment.Left
	nm.Parent   = parent

	-- Giờ đếm ngược
	local tl = Instance.new("TextLabel")
	tl.Size     = UDim2.new(0, 100, 0, 22)
	tl.Position = UDim2.new(0, 200, 0, yPos+2)
	tl.BackgroundTransparency = 1
	tl.Text     = hms(initSec)
	tl.TextColor3 = Color3.fromRGB(255, 215, 50)
	tl.Font     = Enum.Font.GothamBold
	tl.TextScaled = true
	tl.TextXAlignment = Enum.TextXAlignment.Left
	tl.Parent   = parent

	return tl
end

-- Hàng 1: Time Bounty + Player (2 dòng)
local bar1 = Instance.new("Frame")
bar1.Size     = UDim2.new(0, 4, 0, 42)
bar1.Position = UDim2.new(0, 8, 0, 36)
bar1.BackgroundColor3 = Color3.fromRGB(200,30,30)
bar1.BorderSizePixel  = 0
bar1.Parent   = Panel

local nm1a = Instance.new("TextLabel") -- "Time Bounty"
nm1a.Size     = UDim2.new(0, 180, 0, 20); nm1a.Position = UDim2.new(0,18,0,36)
nm1a.BackgroundTransparency = 1; nm1a.Text = "Time Bounty"
nm1a.TextColor3 = Color3.fromRGB(210,210,210); nm1a.Font = Enum.Font.Gotham
nm1a.TextScaled = true; nm1a.TextXAlignment = Enum.TextXAlignment.Left; nm1a.Parent = Panel

local nm1b = Instance.new("TextLabel") -- "Player"
nm1b.Size     = UDim2.new(0, 180, 0, 18); nm1b.Position = UDim2.new(0,18,0,56)
nm1b.BackgroundTransparency = 1; nm1b.Text = "Player"
nm1b.TextColor3 = Color3.fromRGB(170,170,170); nm1b.Font = Enum.Font.Gotham
nm1b.TextScaled = true; nm1b.TextXAlignment = Enum.TextXAlignment.Left; nm1b.Parent = Panel

local tl1 = Instance.new("TextLabel") -- timer hàng 1
tl1.Size     = UDim2.new(0, 100, 0, 22); tl1.Position = UDim2.new(0,200,0,40)
tl1.BackgroundTransparency = 1; tl1.Text = hms(12*60+45)
tl1.TextColor3 = Color3.fromRGB(255,215,50); tl1.Font = Enum.Font.GothamBold
tl1.TextScaled = true; tl1.TextXAlignment = Enum.TextXAlignment.Left; tl1.Parent = Panel

-- "Bounty Player: NoobSlayer123"
local BPLabel = Instance.new("TextLabel")
BPLabel.Size     = UDim2.new(0, 300, 0, 18); BPLabel.Position = UDim2.new(0,8,0,78)
BPLabel.BackgroundTransparency = 1; BPLabel.Text = "Bounty Player: NoobSlayer123"
BPLabel.TextColor3 = Color3.fromRGB(190,190,190); BPLabel.Font = Enum.Font.Gotham
BPLabel.TextScaled = true; BPLabel.TextXAlignment = Enum.TextXAlignment.Left; BPLabel.Parent = Panel

-- Hàng 2: TG Hop
local tl2 = makeTimerRow(Panel, "TG Hop",        45,      100)
-- Hàng 3: TG Skip Player
local tl3 = makeTimerRow(Panel, "TG Skip Player", 1*60+12, 126)

-- ── Nút "Next Player >>" ──────────────────────────────────────
local BtnNext = Instance.new("TextButton")
BtnNext.Size     = UDim2.new(0, 160, 0, 52)
BtnNext.Position = UDim2.new(1,-172, 0, 36)
BtnNext.BackgroundColor3 = Color3.fromRGB(210,150,0)
BtnNext.Text     = "Next Player  »"
BtnNext.TextColor3 = Color3.fromRGB(255,255,255)
BtnNext.Font     = Enum.Font.GothamBold
BtnNext.TextScaled = true
BtnNext.Parent   = Panel
corner(BtnNext, 7)
BtnNext.MouseButton1Click:Connect(function()
	BPLabel.Text = "Bounty Player: (scanning...)"
end)

-- ── Nút "Hop Server" ─────────────────────────────────────────
local BtnHop = Instance.new("TextButton")
BtnHop.Size     = UDim2.new(0, 160, 0, 44)
BtnHop.Position = UDim2.new(1,-172, 0, 96)
BtnHop.BackgroundColor3 = Color3.fromRGB(170, 18, 18)
BtnHop.Text     = "🔁  Hop Server"
BtnHop.TextColor3 = Color3.fromRGB(255,255,255)
BtnHop.Font     = Enum.Font.GothamBold
BtnHop.TextScaled = true
BtnHop.Parent   = Panel
corner(BtnHop, 7)
uiStroke(BtnHop, Color3.fromRGB(230,50,50), 1.5)

-- ╔══════════════════════════════════════════════════════╗
-- ║  LOGIC TIMER                                         ║
-- ╚══════════════════════════════════════════════════════╝
local elapsed  = 0          -- đếm LÊN  (tiêu đề)
local cd = {12*60+45, 45, 1*60+12}  -- đếm XUỐNG (panel)
local labels = {tl1, tl2, tl3}

local acc = 0
RunService.Heartbeat:Connect(function(dt)
	acc = acc + dt
	if acc < 1 then return end
	acc = acc - 1

	-- Tiêu đề: đếm lên
	elapsed = elapsed + 1
	TitleTime.Text = hmsWords(elapsed)

	-- Panel: đếm xuống
	for i = 1, 3 do
		if cd[i] > 0 then
			cd[i] = cd[i] - 1
			labels[i].Text = hms(cd[i])
			if cd[i] == 0 then
				labels[i].TextColor3 = Color3.fromRGB(255,60,60)
			end
		end
	end
end)
