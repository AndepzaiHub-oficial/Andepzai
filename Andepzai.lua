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
Instance.new("UICorner", main).CornerRadius = UDim.new(0,24)

local border = Instance.new("UIStroke", main)
border.Color = ACTIVE
border.Thickness = 2

local isHidden = false

toggleButton.MouseButton1Click:Connect(function()
	isHidden = not isHidden
	local target = isHidden and UDim2.fromScale(1.5,0.5) or UDim2.fromScale(0.5,0.5)
	main:TweenPosition(target, "Out", "Quad", 0.25, true)
end)

-- TABS (SCROLL)
local tabs = {"Main","Farm","Player","Race V4","Visual"}
local buttons,pages = {},{}

local top = Instance.new("ScrollingFrame", main)
top.Size = UDim2.fromOffset(600,52)
top.BackgroundColor3 = Color3.fromRGB(18,18,18)
top.BorderSizePixel = 0
top.ZIndex = 80
top.CanvasSize = UDim2.new(0,0,0,0)
top.AutomaticCanvasSize = Enum.AutomaticSize.X
top.ScrollingDirection = Enum.ScrollingDirection.X
top.ScrollBarImageTransparency = 1
Instance.new("UICorner", top).CornerRadius = UDim.new(0,24)

local layout = Instance.new("UIListLayout", top)
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0,12)

local content = Instance.new("Frame", main)
content.Size = UDim2.fromOffset(560,210)
content.Position = UDim2.fromOffset(20,70)
content.BackgroundTransparency = 1
content.ZIndex = 80

-- ========================
-- TEMPLATE PARA TODAS LAS TABS
-- ========================
local function createPageLayout(page)
	local left = Instance.new("ScrollingFrame", page)
	left.Name = "LeftPanel"
	left.Size = UDim2.fromScale(0.48,1)
	left.BackgroundTransparency = 1
	left.CanvasSize = UDim2.new(0,0,0,0)
	left.AutomaticCanvasSize = Enum.AutomaticSize.Y
	left.ScrollBarImageTransparency = 0.7

	local l = Instance.new("UIListLayout", left)
	l.Padding = UDim.new(0,8)

	local divider = Instance.new("Frame", page)
	divider.Size = UDim2.new(0,2,1,0)
	divider.Position = UDim2.fromScale(0.505,0)
	divider.BackgroundColor3 = ACTIVE
	divider.BorderSizePixel = 0
	divider.ZIndex = 200

	local right = Instance.new("ScrollingFrame", page)
	right.Name = "RightPanel"
	right.Size = UDim2.fromScale(0.47,1)
	right.Position = UDim2.fromScale(0.53,0)
	right.BackgroundTransparency = 1
	right.CanvasSize = UDim2.new(0,0,0,0)
	right.AutomaticCanvasSize = Enum.AutomaticSize.Y
	right.ScrollBarImageTransparency = 0.7

	local r = Instance.new("UIListLayout", right)
	r.Padding = UDim.new(0,8)

	return left,right
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
	b.ZIndex = 85
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
	buttons[name]=b

	local p = Instance.new("Frame", content)
	p.Size = UDim2.fromScale(1,1)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.ZIndex = 85
	pages[name]=p

	createPageLayout(p)

	b.MouseButton1Click:Connect(function()
		setActive(name)
	end)
end

setActive("Main")

-- REFERENCIAS MAIN
local mainPanel = pages["Main"]:FindFirstChild("LeftPanel")
local settingsPanel = pages["Main"]:FindFirstChild("RightPanel")

local mainTitle = Instance.new("TextLabel", mainPanel)
mainTitle.Text = "Main"
mainTitle.Size = UDim2.fromOffset(260,32)
mainTitle.TextColor3 = TEXT
mainTitle.Font = Enum.Font.GothamBold
mainTitle.TextSize = 18
mainTitle.BackgroundTransparency = 1

local function mainBtn(text)
	local b = Instance.new("TextButton", mainPanel)
	b.Size = UDim2.fromOffset(240,36)
	b.BackgroundColor3 = Color3.fromRGB(35,35,35)
	b.Text = text
	b.TextColor3 = TEXT
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
	return b
end

mainBtn("Auto Farm Level (Coming Soon)")
mainBtn("Farm Bone")
mainBtn("Auto Farm Bone")
mainBtn("Auto Farm Gun")

local settingsTitle = Instance.new("TextLabel", settingsPanel)
settingsTitle.Text = "⚙ Settings"
settingsTitle.Size = UDim2.fromOffset(260,32)
settingsTitle.TextColor3 = TEXT
settingsTitle.Font = Enum.Font.GothamBold
settingsTitle.TextSize = 18
settingsTitle.BackgroundTransparency = 1

local function setting(text)
	local f = Instance.new("Frame", settingsPanel)
	f.Size = UDim2.fromOffset(240,36)
	f.BackgroundColor3 = Color3.fromRGB(30,30,30)
	f.BorderSizePixel = 0
	Instance.new("UICorner", f).CornerRadius = UDim.new(0,6)

	local lbl = Instance.new("TextLabel", f)
	lbl.Text = text
	lbl.Size = UDim2.fromScale(0.7,1)
	lbl.TextColor3 = TEXT
	lbl.BackgroundTransparency = 1

	local chk = Instance.new("TextLabel", f)
	chk.Text = "✓"
	chk.TextColor3 = ACTIVE
	chk.Size = UDim2.fromScale(0.3,1)
	chk.Position = UDim2.fromScale(0.7,0)
	chk.BackgroundTransparency = 1

	return f
end

setting("Fast Attack")
setting("Bring Mob")
setting("Get Quest When Farm")

print("Andepzai Hub cargado correctamente 😎")
