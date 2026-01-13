-- Andepzai Hub V2 | Bugfixed UI

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

pcall(function()
	player.PlayerGui:FindFirstChild("AndepzaiHub"):Destroy()
end)

local AutoFarmLevel = false

local gui = Instance.new("ScreenGui")
gui.Name = "AndepzaiHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player.PlayerGui

local PANEL = Color3.fromRGB(12,12,12)
local ACTIVE = Color3.fromRGB(255,193,7)
local INACTIVE = Color3.fromRGB(70,70,70)
local TEXT = Color3.fromRGB(220,220,220)

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(600,300)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.Position = UDim2.fromScale(0.5,0.5)
main.BackgroundColor3 = PANEL
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,24)

local border = Instance.new("UIStroke", main)
border.Color = ACTIVE
border.Thickness = 2
border.Transparency = 0.15

local top = Instance.new("Frame", main)
top.Size = UDim2.fromOffset(600,52)
top.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", top)
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0,12)

local content = Instance.new("Frame", main)
content.Size = UDim2.fromOffset(560,210)
content.Position = UDim2.fromOffset(20,70)
content.BackgroundTransparency = 1

-- Divider vertical (MODIFICADA)
local divider = Instance.new("Frame", content)
divider.Size = UDim2.fromOffset(4, content.AbsoluteSize.Y) -- 2x más gruesa
divider.Position = UDim2.fromScale(0.5, 0)
divider.AnchorPoint = Vector2.new(0.5,0)
divider.BackgroundColor3 = ACTIVE -- Amarilla Andepzai
divider.BorderSizePixel = 0

content:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	divider.Size = UDim2.fromOffset(4, content.AbsoluteSize.Y)
end)

local tabs = {"Farm","Player","Race V4","Visual"}
local buttons, pages = {}, {}

local function hideAll()
	for _,p in pairs(pages) do p.Visible = false end
	for _,b in pairs(buttons) do
		b.BackgroundColor3 = INACTIVE
		b.TextColor3 = TEXT
	end
end

local function setActive(name)
	hideAll()
	pages[name].Visible = true
	buttons[name].BackgroundColor3 = ACTIVE
	buttons[name].TextColor3 = Color3.fromRGB(20,20,20)
end

for _,name in ipairs(tabs) do
	local b = Instance.new("TextButton", top)
	b.Size = UDim2.fromOffset(125,34)
	b.BackgroundColor3 = INACTIVE
	b.Text = name
	b.TextColor3 = TEXT
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
	buttons[name] = b

	local p = Instance.new("Frame", content)
	p.Size = UDim2.fromScale(1,1)
	p.BackgroundTransparency = 1
	p.Visible = false
	pages[name] = p

	b.MouseButton1Click:Connect(function()
		setActive(name)
	end)
end

setActive("Farm")

-- Scroll creator
local function makeScroll(parent)
	local s = Instance.new("ScrollingFrame", parent)
	s.Size = UDim2.fromScale(1,1)
	s.CanvasSize = UDim2.fromOffset(0,0)
	s.ScrollBarThickness = 4
	s.BackgroundTransparency = 1
	s.ScrollingEnabled = true
	s.AutomaticCanvasSize = Enum.AutomaticSize.None

	local l = Instance.new("UIListLayout", s)
	l.Padding = UDim.new(0,8)
	l.SortOrder = Enum.SortOrder.LayoutOrder

	l:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		s.CanvasSize = UDim2.fromOffset(0, l.AbsoluteContentSize.Y + 12)
	end)

	return s, l
end

-- Player
local playerScroll, playerLayout = makeScroll(pages["Player"])

local playerTitle = Instance.new("TextLabel", playerScroll)
playerTitle.Size = UDim2.fromOffset(300,32)
playerTitle.BackgroundTransparency = 1
playerTitle.Text = "Player"
playerTitle.TextColor3 = TEXT
playerTitle.Font = Enum.Font.GothamBold
playerTitle.TextSize = 18
playerTitle.TextXAlignment = Enum.TextXAlignment.Center
playerTitle.LayoutOrder = 0

-- Farm
local farmsScroll, farmLayout = makeScroll(pages["Farm"])
farmsScroll.Size = UDim2.fromScale(0.47,1)

local farmTitle = Instance.new("TextLabel", farmsScroll)
farmTitle.Size = UDim2.fromOffset(260,32)
farmTitle.BackgroundTransparency = 1
farmTitle.Text = "Farms"
farmTitle.TextColor3 = TEXT
farmTitle.Font = Enum.Font.GothamBold
farmTitle.TextSize = 18
farmTitle.TextXAlignment = Enum.TextXAlignment.Center
farmTitle.LayoutOrder = 0

local farmIndex = 1

local function makeFarmToggle(text)
	local row = Instance.new("Frame", farmsScroll)
	row.LayoutOrder = farmIndex
	farmIndex += 1

	row.Size = UDim2.fromOffset(260,36)
	row.BackgroundColor3 = Color3.fromRGB(22,22,22)
	row.BorderSizePixel = 0
	Instance.new("UICorner", row).CornerRadius = UDim.new(0,8)

	local label = Instance.new("TextLabel", row)
	label.Size = UDim2.new(1,-90,1,0)
	label.Position = UDim2.fromOffset(10,0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = TEXT
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left

	local t = Instance.new("TextButton", row)
	t.Size = UDim2.fromOffset(22,22)
	t.Position = UDim2.new(1,-32,0.5,-11)
	t.BackgroundColor3 = Color3.fromRGB(55,55,55)
	t.BorderSizePixel = 0
	t.Text = ""
	Instance.new("UICorner", t).CornerRadius = UDim.new(1,0)

	local check = Instance.new("TextLabel", t)
	check.Size = UDim2.fromScale(1,1)
	check.BackgroundTransparency = 1
	check.Text = "✓"
	check.TextColor3 = Color3.new(1,1,1)
	check.Font = Enum.Font.GothamBold
	check.TextSize = 16
	check.Visible = false

	local state = false
	t.MouseButton1Click:Connect(function()
		state = not state
		check.Visible = state
		t.BackgroundColor3 = state and Color3.fromRGB(60,150,255) or Color3.fromRGB(55,55,55)
		if text == "Auto Farm Level" then AutoFarmLevel = state end
	end)
end

makeFarmToggle("Auto Farm Level")
makeFarmToggle("Auto Farm Bone")
makeFarmToggle("Auto Farm Gun")
makeFarmToggle("Auto Farm Chest")
makeFarmToggle("Auto Farm Boss")

print("Andepzai Hub cargado correctamente 😎")
