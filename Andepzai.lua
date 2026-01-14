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

-- 🔧 CORNER + BORDE CORREGIDO
local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0,24)

local border = Instance.new("UIStroke", main)
border.Color = ACTIVE
border.Thickness = 2
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
-- 🔧 FIN FIX

toggleButton.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- TABS (SCROLL)
local tabs = {"Main","Farm","Player","Race V4","Visual"}
local buttons,pages = {},{}

local top = Instance.new("ScrollingFrame", main)
top.Size = UDim2.fromOffset(560,48)
top.Position = UDim2.fromScale(0.5,0.04)
top.AnchorPoint = Vector2.new(0.5,0)
top.BackgroundColor3 = Color3.fromRGB(18,18,18)
top.BorderSizePixel = 0
top.ZIndex = 120
top.CanvasSize = UDim2.new(0,0,0,0)
top.ScrollingDirection = Enum.ScrollingDirection.X
top.ScrollBarImageTransparency = 1
top.ScrollBarThickness = 0
Instance.new("UICorner", top).CornerRadius = UDim.new(0,24)

local layout = Instance.new("UIListLayout", top)
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0,12)

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	top.CanvasSize = UDim2.fromOffset(layout.AbsoluteContentSize.X + 20, 0)
end)

local content = Instance.new("Frame", main)
content.Size = UDim2.fromOffset(560,210)
content.Position = UDim2.fromOffset(20,70)
content.BackgroundTransparency = 1
content.ZIndex = 120

-- ========================
-- TEMPLATE PARA TODAS LAS TABS
-- ========================
local function createPageLayout(page)
	local left = Instance.new("ScrollingFrame", page)
	left.Name = "LeftPanel"
	left.Size = UDim2.fromScale(0.48,1)
	left.BackgroundTransparency = 1
	left.AutomaticCanvasSize = Enum.AutomaticSize.Y
	left.ScrollBarImageTransparency = 1
	left.ScrollBarThickness = 0
	left.ZIndex = 120

	local l = Instance.new("UIListLayout", left)
	l.Padding = UDim.new(0,8)

	local divider = Instance.new("Frame", page)
	divider.Size = UDim2.new(0,2,1,0)
	divider.Position = UDim2.fromScale(0.505,0)
	divider.BackgroundColor3 = ACTIVE
	divider.BorderSizePixel = 0
	divider.ZIndex = 130

	local right = Instance.new("ScrollingFrame", page)
	right.Name = "RightPanel"
	right.Size = UDim2.fromScale(0.47,1)
	right.Position = UDim2.fromScale(0.53,0)
	right.BackgroundTransparency = 1
	right.AutomaticCanvasSize = Enum.AutomaticSize.Y
	right.ScrollBarImageTransparency = 1
	right.ScrollBarThickness = 0
	right.ZIndex = 120

	local r = Instance.new("UIListLayout", right)
	r.Padding = UDim.new(0,8)
end

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
	b.Size = UDim2.fromOffset(100,34)
	b.BackgroundColor3 = INACTIVE
	b.Text = name
	b.TextColor3 = TEXT
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.BorderSizePixel = 0
	b.ZIndex = 125
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
	buttons[name]=b

	local p = Instance.new("Frame", content)
	p.Size = UDim2.fromScale(1,1)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.ZIndex = 120
	pages[name]=p

	createPageLayout(p)

	b.MouseButton1Click:Connect(function()
		setActive(name)
	end)
end

setActive("Main")

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

	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0,18)

	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = INACTIVE
	stroke.Thickness = 1.5

	local glow = Instance.new("UIStroke", btn)
	glow.Color = ACTIVE
	glow.Thickness = 2
	glow.Transparency = 1

	-- Hover
	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(34,34,34)}):Play()
	end)

	btn.MouseLeave:Connect(function()
		if glow.Transparency == 1 then
			TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(28,28,28)}):Play()
		end
	end)

	-- Click
	btn.MouseButton1Click:Connect(function()
		TweenService:Create(glow, TweenInfo.new(0.15), {Transparency = 0}):Play()
		TweenService:Create(stroke, TweenInfo.new(0.15), {Transparency = 1}):Play()
		TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = ACTIVE, TextColor3 = Color3.fromRGB(20,20,20)}):Play()

		task.delay(0.2, function()
			TweenService:Create(glow, TweenInfo.new(0.2), {Transparency = 1}):Play()
			TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
			TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(28,28,28), TextColor3 = TEXT}):Play()
		end)

		if callback then
			pcall(callback)
		end
	end)

	return btn
end

print("🇮🇱🇮🇱")
