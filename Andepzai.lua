-- Andepzai Hub V2 | Bugfixed UI

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

pcall(function()
	player.PlayerGui:FindFirstChild("AndepzaiHub"):Destroy()
end)

local AutoFarmLevel = false

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "AndepzaiHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

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
main.ZIndex = 1
Instance.new("UICorner", main).CornerRadius = UDim.new(0,24)

local border = Instance.new("UIStroke", main)
border.Color = ACTIVE
border.Thickness = 2
border.Transparency = 0.15

local top = Instance.new("Frame", main)
top.Size = UDim2.fromOffset(600,52)
top.BackgroundTransparency = 1
top.ZIndex = 2

local layout = Instance.new("UIListLayout", top)
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0,12)

local content = Instance.new("Frame", main)
content.Size = UDim2.fromOffset(560,210)
content.Position = UDim2.fromOffset(20,70)
content.BackgroundTransparency = 1
content.ZIndex = 2

local divider = Instance.new("Frame", content)
divider.Size = UDim2.fromOffset(4, content.AbsoluteSize.Y)
divider.Position = UDim2.fromScale(0.5,0)
divider.AnchorPoint = Vector2.new(0.5,0)
divider.BackgroundColor3 = ACTIVE
divider.BorderSizePixel = 0
divider.ZIndex = 3

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

local function animatePage(page)
	page.Visible = true
	page.Position = UDim2.fromScale(0.05,0)
	TweenService:Create(page, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Position = UDim2.fromScale(0,0)
	}):Play()
end

local function setActive(name)
	hideAll()
	animatePage(pages[name])
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
	b.ZIndex = 3
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
	buttons[name] = b

	local p = Instance.new("Frame", content)
	p.Size = UDim2.fromScale(1,1)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.ZIndex = 2
	pages[name] = p

	b.MouseButton1Click:Connect(function()
		setActive(name)
	end)
end

setActive("Farm")

local function makeScroll(parent)
	local s = Instance.new("ScrollingFrame", parent)
	s.Size = UDim2.fromScale(1,1)
	s.ScrollBarThickness = 4
	s.BackgroundTransparency = 1
	s.ZIndex = 2
	s.CanvasSize = UDim2.fromOffset(0,0)
	s.AutomaticCanvasSize = Enum.AutomaticSize.None

	local l = Instance.new("UIListLayout", s)
	l.Padding = UDim.new(0,8)
	l.SortOrder = Enum.SortOrder.LayoutOrder

	l:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		s.CanvasSize = UDim2.fromOffset(0, l.AbsoluteContentSize.Y + 12)
	end)

	return s
end

local playerScroll = makeScroll(pages["Player"])
local farmsScroll = makeScroll(pages["Farm"])
farmsScroll.Size = UDim2.fromScale(0.47,1)

local playerTitle = Instance.new("TextLabel", playerScroll)
playerTitle.Size = UDim2.fromOffset(260,32)
playerTitle.BackgroundTransparency = 1
playerTitle.Text = "Player"
playerTitle.TextColor3 = TEXT
playerTitle.Font = Enum.Font.GothamBold
playerTitle.TextSize = 18
playerTitle.LayoutOrder = -1

local farmTitle = Instance.new("TextLabel", farmsScroll)
farmTitle.Size = UDim2.fromOffset(260,32)
farmTitle.BackgroundTransparency = 1
farmTitle.Text = "Farms"
farmTitle.TextColor3 = TEXT
farmTitle.Font = Enum.Font.GothamBold
farmTitle.TextSize = 18
farmTitle.LayoutOrder = -1

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

-- BOTÓN FLOTANTE TOGGLE UI (FUNCIONAL, DRAG REAL, CLIC, IMAGEN)

local toggleFrame = Instance.new("Frame", gui)
toggleFrame.Name = "FloatingToggle"
toggleFrame.Size = UDim2.fromOffset(64,64)
toggleFrame.Position = UDim2.fromScale(0.5,0.15)
toggleFrame.AnchorPoint = Vector2.new(0.5,0.5)
toggleFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
toggleFrame.BorderSizePixel = 0
toggleFrame.Active = true
toggleFrame.Selectable = true
toggleFrame.ZIndex = 10000

local stroke = Instance.new("UIStroke", toggleFrame)
stroke.Color = ACTIVE
stroke.Thickness = 2

local toggleButton = Instance.new("ImageButton", toggleFrame)
toggleButton.Size = UDim2.fromScale(1,1)
toggleButton.BackgroundTransparency = 1
toggleButton.Image = "rbxassetid://12902444443"
toggleButton.ScaleType = Enum.ScaleType.Fit
toggleButton.Active = true
toggleButton.Selectable = true
toggleButton.AutoButtonColor = false
toggleButton.ZIndex = 10001

-- 🔹 Drag manual (funciona en móvil y PC)
local dragging = false
local dragStart, startPos

local function updateDrag(input)
	local delta = input.Position - dragStart
	toggleFrame.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

toggleFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = toggleFrame.Position
	end
end)

toggleFrame.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		updateDrag(input)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- 🔹 Click toggle UI
local uiVisible = true
local shownPos = main.Position
local hiddenPos = UDim2.fromScale(1.5,0.5)

toggleButton.MouseButton1Click:Connect(function()
	uiVisible = not uiVisible
	TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
		Position = uiVisible and shownPos or hiddenPos
	}):Play()
end)

print("Andepzai Hub cargado correctamente 😎")
