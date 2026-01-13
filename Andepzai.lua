-- Andepzai Hub V2 | Exact UI + Forced Resize + Floating Toggle (RoniX Android FIXED)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

pcall(function()
	player.PlayerGui:FindFirstChild("AndepzaiHub"):Destroy()
	CoreGui:FindFirstChild("AndepzaiFloatingToggle"):Destroy()
end)

-- MAIN GUI
local gui = Instance.new("ScreenGui")
gui.Name = "AndepzaiHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Parent = player.PlayerGui

-- COLORS
local PANEL = Color3.fromRGB(12,12,12)
local ACTIVE = Color3.fromRGB(255,193,7)
local INACTIVE = Color3.fromRGB(70,70,70)
local TEXT = Color3.fromRGB(220,220,220)

-- MAIN PANEL
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(600,300)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.Position = UDim2.fromScale(0.5,0.5)
main.BackgroundColor3 = PANEL
main.BorderSizePixel = 0
main.ZIndex = 50
Instance.new("UICorner", main).CornerRadius = UDim.new(0,24)

local border = Instance.new("UIStroke", main)
border.Thickness = 2
border.Color = ACTIVE
border.Transparency = 0.15

-- TOP BAR
local top = Instance.new("Frame", main)
top.Size = UDim2.fromOffset(600,52)
top.BackgroundTransparency = 1
top.ZIndex = 55

local layout = Instance.new("UIListLayout", top)
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0,12)

-- CONTENT
local content = Instance.new("Frame", main)
content.Size = UDim2.fromOffset(560,210)
content.Position = UDim2.fromOffset(20,70)
content.BackgroundTransparency = 1
content.ZIndex = 51

-- LEFT / RIGHT PANELS + DIVIDER
local leftPanelTemplate = Instance.new("Frame")
leftPanelTemplate.Size = UDim2.fromScale(0.48,1)
leftPanelTemplate.BackgroundTransparency = 1
leftPanelTemplate.ZIndex = 53

local rightPanelTemplate = Instance.new("Frame")
rightPanelTemplate.Size = UDim2.fromScale(0.48,1)
rightPanelTemplate.Position = UDim2.fromScale(0.52,0)
rightPanelTemplate.BackgroundTransparency = 1
rightPanelTemplate.ZIndex = 53

local dividerTemplate = Instance.new("Frame")
dividerTemplate.Size = UDim2.fromOffset(5,200)
dividerTemplate.Position = UDim2.fromScale(0.5,0)
dividerTemplate.AnchorPoint = Vector2.new(0.5,0)
dividerTemplate.BackgroundColor3 = ACTIVE
dividerTemplate.BorderSizePixel = 0
dividerTemplate.ZIndex = 54

-- TABS (Configuración eliminada)
local tabs = {"Farm","Race V4","Visual"}
local buttons = {}
local pages = {}

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
	b.ZIndex = 55
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
	buttons[name] = b

	local p = Instance.new("Frame", content)
	p.Size = UDim2.fromScale(1,1)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.ZIndex = 52
	pages[name] = p

	leftPanelTemplate:Clone().Parent = p
	rightPanelTemplate:Clone().Parent = p
	dividerTemplate:Clone().Parent = p

	b.MouseButton1Click:Connect(function()
		setActive(name)
	end)
end

setActive("Farm")

-- FARMS SCROLL
local farmsScroll = Instance.new("ScrollingFrame", pages["Farm"])
farmsScroll.Size = UDim2.fromScale(0.48,1)
farmsScroll.CanvasSize = UDim2.fromScale(0,0)
farmsScroll.ScrollBarThickness = 4
farmsScroll.ScrollBarImageTransparency = 0.4
farmsScroll.BackgroundTransparency = 1
farmsScroll.ZIndex = 55
farmsScroll.CanvasPosition = Vector2.new(0,0)

local farmLayout = Instance.new("UIListLayout", farmsScroll)
farmLayout.Padding = UDim.new(0,8)

farmLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	farmsScroll.CanvasSize = UDim2.fromOffset(0, farmLayout.AbsoluteContentSize.Y + 10)
end)

local farmTitle = Instance.new("TextLabel", farmsScroll)
farmTitle.Size = UDim2.fromOffset(260,36)
farmTitle.BackgroundTransparency = 1
farmTitle.Text = "Farms"
farmTitle.TextColor3 = TEXT
farmTitle.Font = Enum.Font.GothamBold
farmTitle.TextSize = 18
farmTitle.ZIndex = 56

local function makeFarmRow(text)
	local row = Instance.new("Frame", farmsScroll)
	row.Size = UDim2.fromOffset(260,36)
	row.BackgroundColor3 = Color3.fromRGB(22,22,22)
	row.BorderSizePixel = 0
	row.ZIndex = 55
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
	label.ZIndex = 56

	return row
end

local function makeFarmToggle(parent)
	local t = Instance.new("TextButton", parent)
	t.Size = UDim2.fromOffset(22,22)
	t.Position = UDim2.new(1,-32,0.5,-11)
	t.BackgroundColor3 = Color3.fromRGB(55,55,55)
	t.Text = ""
	t.ZIndex = 56
	t.AutoButtonColor = false
	Instance.new("UICorner", t).CornerRadius = UDim.new(1,0)

	local check = Instance.new("TextLabel", t)
	check.Size = UDim2.fromScale(1,1)
	check.BackgroundTransparency = 1
	check.Text = "✓"
	check.TextColor3 = Color3.fromRGB(255,255,255)
	check.Font = Enum.Font.GothamBold
	check.TextSize = 16
	check.Visible = false
	check.ZIndex = 57

	local state = false

	t.MouseButton1Click:Connect(function()
		state = not state
		if state then
			TweenService:Create(t, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60,150,255)}):Play()
			check.Visible = true
		else
			TweenService:Create(t, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(55,55,55)}):Play()
			check.Visible = false
		end
	end)
end

makeFarmToggle(makeFarmRow("Auto Farm Level"))
makeFarmToggle(makeFarmRow("Auto Farm Bone"))
makeFarmToggle(makeFarmRow("Auto Farm Gun"))
makeFarmToggle(makeFarmRow("Auto Farm Chest"))
makeFarmToggle(makeFarmRow("Auto Farm Boss"))

print("Andepzai Hub V2 Loaded")
