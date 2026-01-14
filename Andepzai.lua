-- Andepzai Hub V2 | Bugfixed UI + MiniMap (FIXED)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

pcall(function()
	player.PlayerGui:FindFirstChild("AndepzaiHub"):Destroy()
end)

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "AndepzaiHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local PANEL = Color3.fromRGB(12,12,12)
local ACTIVE = Color3.fromRGB(255,193,7)
local INACTIVE = Color3.fromRGB(70,70,70)
local TEXT = Color3.fromRGB(220,220,220)

-- BOTÓN FLOTANTE
local toggleFrame = Instance.new("Frame", gui)
toggleFrame.Size = UDim2.fromOffset(42,42)
toggleFrame.Position = UDim2.fromScale(0.02,0.35)
toggleFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
toggleFrame.BorderSizePixel = 0
toggleFrame.ZIndex = 1000
toggleFrame.Active = true
Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0,8)
local stroke = Instance.new("UIStroke", toggleFrame)
stroke.Color = ACTIVE
stroke.Thickness = 2

local toggleButton = Instance.new("ImageButton", toggleFrame)
toggleButton.Size = UDim2.fromScale(1,1)
toggleButton.BackgroundTransparency = 1
toggleButton.Image = "rbxassetid://12902444443"
toggleButton.ZIndex = 1001
toggleButton.AutoButtonColor = false

-- MAIN
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

toggleButton.MouseButton1Click:Connect(function()
	local hidden = main.Position.X.Scale > 1
	if hidden then
		main:TweenPosition(UDim2.fromScale(0.5,0.5), "Out", "Quad", 0.3, true)
	else
		main:TweenPosition(UDim2.fromScale(1.5,0.5), "Out", "Quad", 0.3, true)
	end
end)

-- TOP BAR
local top = Instance.new("Frame", main)
top.Size = UDim2.fromOffset(600,52)
top.BackgroundTransparency = 1
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

local divider = Instance.new("Frame", content)
divider.Size = UDim2.new(0,4,1,0)
divider.Position = UDim2.fromScale(0.5,0)
divider.AnchorPoint = Vector2.new(0.5,0)
divider.BackgroundColor3 = ACTIVE

-- TABS
local tabs = {"Farm","Player","Race V4","Visual"}
local buttons,pages = {},{}

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
	buttons[name]=b

	local p = Instance.new("Frame", content)
	p.Size = UDim2.fromScale(1,1)
	p.BackgroundTransparency = 1
	p.Visible = false
	pages[name]=p

	b.MouseButton1Click:Connect(function()
		setActive(name)
	end)
end

setActive("Farm")

-- LEFT FARM LIST
local farmsScroll = Instance.new("ScrollingFrame", pages["Farm"])
farmsScroll.Size = UDim2.fromScale(0.47,1)
farmsScroll.ScrollBarThickness = 4
farmsScroll.BackgroundTransparency = 1

local farmLayout = Instance.new("UIListLayout", farmsScroll)
farmLayout.Padding = UDim.new(0,8)
farmLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	farmsScroll.CanvasSize = UDim2.fromOffset(0, farmLayout.AbsoluteContentSize.Y + 12)
end)

local function makeFarmToggle(text)
	local row = Instance.new("Frame", farmsScroll)
	row.Size = UDim2.fromOffset(260,36)
	row.BackgroundColor3 = Color3.fromRGB(22,22,22)
	row.BorderSizePixel = 0
	Instance.new("UICorner", row).CornerRadius = UDim.new(0,8)

	local label = Instance.new("TextLabel", row)
	label.Size = UDim2.new(1,-60,1,0)
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
	check.Font = Enum.Font.GothamBold
	check.TextSize = 16
	check.Visible = false

	t.MouseButton1Click:Connect(function()
		check.Visible = not check.Visible
		t.BackgroundColor3 = check.Visible and Color3.fromRGB(60,150,255) or Color3.fromRGB(55,55,55)
	end)
end

makeFarmToggle("Auto Farm Level")
makeFarmToggle("Auto Farm Bone")
makeFarmToggle("Auto Farm Gun")
makeFarmToggle("Auto Farm Chest")
makeFarmToggle("Auto Farm Boss")

print("Andepzai Hub cargado correctamente 😎")
