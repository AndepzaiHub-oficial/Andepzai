-- Andepzai Hub V2 | Ronix Compatible + MiniMap FIXED + Farm Panel + Main Section + Scroll

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

pcall(function()
	if player.PlayerGui:FindFirstChild("AndepzaiHub") then
		player.PlayerGui.AndepzaiHub:Destroy()
	end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "AndepzaiHub"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 1000

local PANEL = Color3.fromRGB(12,12,12)
local ACTIVE = Color3.fromRGB(255,193,7)
local INACTIVE = Color3.fromRGB(70,70,70)
local TEXT = Color3.fromRGB(220,220,220)

-- ========================
-- BOTONES ESTILO ANDEPZAI
-- ========================

local function createAndepzaiButton(parent, text, callback)
	local btn = Instance.new("TextButton", parent)
	btn.Size = UDim2.new(1, -12, 0, 38)
	btn.BackgroundColor3 = Color3.fromRGB(28,28,28)
	btn.Text = text
	btn.TextColor3 = TEXT
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = false

	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,18)

	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = INACTIVE

	local glow = Instance.new("UIStroke", btn)
	glow.Color = ACTIVE
	glow.Transparency = 1

	btn.MouseButton1Click:Connect(function()
		glow.Transparency = 0
		task.delay(0.2,function() glow.Transparency = 1 end)
		if callback then callback() end
	end)

	return btn
end

-- BOTÓN FLOTANTE
local toggleFrame = Instance.new("Frame", gui)
toggleFrame.Size = UDim2.fromOffset(42,42)
toggleFrame.Position = UDim2.fromScale(0.02,0.18)
toggleFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
toggleFrame.BorderSizePixel = 0
toggleFrame.ZIndex = 9999
toggleFrame.Active = true

local stroke = Instance.new("UIStroke", toggleFrame)
stroke.Color = ACTIVE
stroke.Thickness = 2

local toggleButton = Instance.new("ImageButton", toggleFrame)
toggleButton.Size = UDim2.fromScale(1,1)
toggleButton.BackgroundTransparency = 1
toggleButton.Image = "rbxassetid://107282251430253"
toggleButton.ZIndex = 10000
toggleButton.AutoButtonColor = false

-- PANEL PRINCIPAL
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(600,300)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.Position = UDim2.fromScale(0.5,0.5)
main.BackgroundColor3 = PANEL
main.BorderSizePixel = 0
main.ZIndex = 50

Instance.new("UICorner", main).CornerRadius = UDim.new(0,24)

local border = Instance.new("UIStroke", main)
border.Color = ACTIVE
border.Thickness = 2
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

toggleButton.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- TABS
local tabs = {"Main","Farm","Player","Race V4","Visual"}
local buttons,pages = {},{}

local top = Instance.new("ScrollingFrame", main)
top.Size = UDim2.fromOffset(560,48)
top.Position = UDim2.fromScale(0.5,0.04)
top.AnchorPoint = Vector2.new(0.5,0)
top.BackgroundColor3 = Color3.fromRGB(18,18,18)
top.BorderSizePixel = 0
top.ZIndex = 120
top.ScrollingDirection = Enum.ScrollingDirection.X
top.ScrollBarImageTransparency = 1
top.ScrollBarThickness = 0
Instance.new("UICorner", top).CornerRadius = UDim.new(0,24)

local layout = Instance.new("UIListLayout", top)
layout.FillDirection = Enum.FillDirection.Horizontal
layout.Padding = UDim.new(0,12)

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	top.CanvasSize = UDim2.fromOffset(layout.AbsoluteContentSize.X + 20, 0)
end)

local content = Instance.new("Frame", main)
content.Size = UDim2.fromOffset(560,210)
content.Position = UDim2.fromOffset(20,70)
content.BackgroundTransparency = 1
content.ZIndex = 120

-- 🔧 FIX DE PANELES INVISIBLES (RONIX)
local function createPageLayout(page)
	-- IZQUIERDA
	local left = Instance.new("ScrollingFrame", page)
	left.Name = "LeftPanel"
	left.Size = UDim2.fromScale(0.48,1)
	left.CanvasSize = UDim2.fromOffset(0,0)
	left.ScrollBarImageTransparency = 1
	left.BackgroundTransparency = 1
	left.BorderSizePixel = 0
	left.AutomaticCanvasSize = Enum.AutomaticSize.None

	local leftLayout = Instance.new("UIListLayout", left)
	leftLayout.Padding = UDim.new(0,8)
	leftLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		left.CanvasSize = UDim2.fromOffset(0, leftLayout.AbsoluteContentSize.Y + 12)
	end)

	-- DIVISOR
	local divider = Instance.new("Frame", page)
	divider.Size = UDim2.new(0,2,1,0)
	divider.Position = UDim2.fromScale(0.505,0)
	divider.BackgroundColor3 = ACTIVE
	divider.BorderSizePixel = 0

	-- DERECHA
	local right = Instance.new("ScrollingFrame", page)
	right.Name = "RightPanel"
	right.Size = UDim2.fromScale(0.47,1)
	right.Position = UDim2.fromScale(0.53,0)
	right.CanvasSize = UDim2.fromOffset(0,0)
	right.ScrollBarImageTransparency = 1
	right.BackgroundTransparency = 1
	right.BorderSizePixel = 0
	right.AutomaticCanvasSize = Enum.AutomaticSize.None

	local rightLayout = Instance.new("UIListLayout", right)
	rightLayout.Padding = UDim.new(0,8)
	rightLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		right.CanvasSize = UDim2.fromOffset(0, rightLayout.AbsoluteContentSize.Y + 12)
	end)
end

local function hideAll()
	for _,p in pairs(pages) do p.Visible = false end
	for _,b in pairs(buttons) do b.BackgroundColor3 = INACTIVE end
end

local function setActive(name)
	hideAll()
	pages[name].Visible = true
	buttons[name].BackgroundColor3 = ACTIVE
end

for _,name in ipairs(tabs) do
	local b = Instance.new("TextButton", top)
	b.Size = UDim2.fromOffset(100,34)
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

	createPageLayout(p)
	b.MouseButton1Click:Connect(function() setActive(name) end)
end

setActive("Main")

-- AÑADIR BOTONES
task.wait(0.2)

local mainPage = pages["Main"]
local left = mainPage:FindFirstChild("LeftPanel")
local right = mainPage:FindFirstChild("RightPanel")

if left then
	createAndepzaiButton(left,"Auto Farm",function() print("Auto Farm") end)
	createAndepzaiButton(left,"Auto Quest",function() print("Auto Quest") end)
end

if right then
	createAndepzaiButton(right,"Fast Attack",function() print("Fast Attack") end)
	createAndepzaiButton(right,"Bring Mob",function() print("Bring Mob") end)
end

print("LISTO 😄")
