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

local tabs = {"Configuración","Farm","Race V4","Visual"}
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

setActive("Configuración")

-- SETTINGS SCROLL (FIXED)
local base = pages["Configuración"]:FindFirstChildOfClass("Frame")

local settings = Instance.new("ScrollingFrame", pages["Configuración"])
settings.Size = UDim2.fromScale(0.48,1)
settings.Position = UDim2.fromScale(0,0)
settings.CanvasSize = UDim2.fromScale(0,0)
settings.ScrollBarThickness = 4
settings.ScrollBarImageTransparency = 0.4
settings.BackgroundTransparency = 1
settings.ZIndex = base.ZIndex
settings.AutomaticCanvasSize = Enum.AutomaticSize.None

base:Destroy()

local layoutS = Instance.new("UIListLayout", settings)
layoutS.Padding = UDim.new(0,8)
layoutS.SortOrder = Enum.SortOrder.LayoutOrder
layoutS.HorizontalAlignment = Enum.HorizontalAlignment.Center

layoutS:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	settings.CanvasSize = UDim2.fromOffset(0, layoutS.AbsoluteContentSize.Y + 10)
end)

-- TITLE (ALWAYS ON TOP)
local title = Instance.new("TextLabel", settings)
title.Size = UDim2.fromOffset(260,36)
title.BackgroundTransparency = 1
title.Text = "Configuración"
title.TextColor3 = TEXT
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextYAlignment = Enum.TextYAlignment.Center
title.ZIndex = 56
title.LayoutOrder = -100

local orderCounter = 1

local function makeRow(text)
	local row = Instance.new("Frame", settings)
	row.Size = UDim2.fromOffset(260,36)
	row.BackgroundColor3 = Color3.fromRGB(22,22,22)
	row.BorderSizePixel = 0
	row.ZIndex = 55
	row.LayoutOrder = orderCounter
	orderCounter += 1
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

local function makeToggle(parent)
	local t = Instance.new("TextButton", parent)
	t.Size = UDim2.fromOffset(22,22)
	t.Position = UDim2.new(1,-32,0.5,-11)
	t.BackgroundColor3 = Color3.fromRGB(40,40,40)
	t.Text = ""
	t.ZIndex = 56
	Instance.new("UICorner", t).CornerRadius = UDim.new(1,0)
end

local function makeInput(parent, value)
	local b = Instance.new("TextBox", parent)
	b.Size = UDim2.fromOffset(60,24)
	b.Position = UDim2.new(1,-70,0.5,-12)
	b.BackgroundColor3 = Color3.fromRGB(35,35,35)
	b.Text = tostring(value)
	b.TextColor3 = TEXT
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.ZIndex = 56
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
end

local r1 = makeRow("Select Weapon")
local btn = Instance.new("TextButton", r1)
btn.Size = UDim2.fromOffset(90,24)
btn.Position = UDim2.new(1,-100,0.5,-12)
btn.Text = "Cận chiến"
btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
btn.TextColor3 = TEXT
btn.ZIndex = 56
Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)

local r2 = makeRow("Distance Bring")
makeInput(r2,150)

local r3 = makeRow("Fast Attack")
makeToggle(r3)

local r4 = makeRow("Bring Mob")
makeToggle(r4)

local r5 = makeRow("Get Quest When Farm")
makeToggle(r5)

print("Andepzai Hub V2 Loaded with FULL Scrollable Settings")
