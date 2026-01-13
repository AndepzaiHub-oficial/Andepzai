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
main.ZIndex = 10
Instance.new("UICorner", main).CornerRadius = UDim.new(0,24)

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

-- LEFT / RIGHT PANELS + DIVIDER
local leftPanelTemplate = Instance.new("Frame")
leftPanelTemplate.Size = UDim2.fromScale(0.48,1)
leftPanelTemplate.Position = UDim2.fromScale(0,0)
leftPanelTemplate.BackgroundTransparency = 1

local rightPanelTemplate = Instance.new("Frame")
rightPanelTemplate.Size = UDim2.fromScale(0.48,1)
rightPanelTemplate.Position = UDim2.fromScale(0.52,0)
rightPanelTemplate.BackgroundTransparency = 1

local dividerTemplate = Instance.new("Frame")
dividerTemplate.Size = UDim2.fromOffset(2,200)
dividerTemplate.Position = UDim2.fromScale(0.5,0)
dividerTemplate.AnchorPoint = Vector2.new(0.5,0)
dividerTemplate.BackgroundColor3 = Color3.fromRGB(35,35,35)
dividerTemplate.BorderSizePixel = 0
Instance.new("UICorner", dividerTemplate).CornerRadius = UDim.new(1,0)

local tabs = {"Principal","Farm","Race V4","Visual"}
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
	b.ZIndex = 11
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
	buttons[name] = b

	local p = Instance.new("Frame", content)
	p.Size = UDim2.fromScale(1,1)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.ZIndex = 11
	pages[name] = p

	-- CLONAR PANEL IZQ, DER Y DIVIDER POR CADA PÁGINA
	local left = leftPanelTemplate:Clone()
	left.Name = "LeftPanel"
	left.Parent = p

	local right = rightPanelTemplate:Clone()
	right.Name = "RightPanel"
	right.Parent = p

	local divider = dividerTemplate:Clone()
	divider.Parent = p

	b.MouseButton1Click:Connect(function()
		setActive(name)
	end)
end

setActive("Principal")

-- EJEMPLO DE CONTENIDO
local label = Instance.new("TextLabel", pages["Principal"].RightPanel)
label.Size = UDim2.fromScale(1,1)
label.BackgroundTransparency = 1
label.Text = "Opciones próximamente..."
label.TextColor3 = TEXT
label.Font = Enum.Font.Gotham
label.TextSize = 16

-- FLOATING TOGGLE

local floatGui = Instance.new("ScreenGui")
floatGui.Name = "AndepzaiFloatingToggle"
floatGui.IgnoreGuiInset = true
floatGui.ResetOnSpawn = false
floatGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
floatGui.DisplayOrder = 10^9
pcall(function() floatGui.Parent = CoreGui end)

local floating = Instance.new("ImageButton", floatGui)
floating.Name = "FloatingToggle"
floating.Size = UDim2.fromOffset(64,64)
floating.Position = UDim2.fromOffset(40,200)
floating.BackgroundTransparency = 1
floating.Image = "rbxassetid://12902444443"
floating.ZIndex = 10^9
floating.AutoButtonColor = false
floating.Visible = true
floating.Active = true
Instance.new("UICorner", floating).CornerRadius = UDim.new(1,0)

-- Drag
local dragging = false
local dragStart, startPos

floating.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = floating.Position
	end
end)

floating.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
		local delta = input.Position - dragStart
		floating.Position = startPos + UDim2.fromOffset(delta.X, delta.Y)
	end
end)

-- Toggle
local visible = true
local shownPos = main.Position
local hiddenPos = UDim2.fromScale(1.6,0.5)
local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

floating.MouseButton1Click:Connect(function()
	if dragging then return end
	visible = not visible
	TweenService:Create(main, tweenInfo, {Position = visible and shownPos or hiddenPos}):Play()
end)

print("Andepzai Hub V2 Loaded + Floating Toggle (RoniX Android FIXED)")
