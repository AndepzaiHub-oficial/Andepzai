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

-- Borde amarillo
local border = Instance.new("UIStroke", main)
border.Thickness = 2
border.Color = ACTIVE
border.Transparency = 0.15
border.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

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

-- DIVIDER AMARILLO GRUESO
local dividerTemplate = Instance.new("Frame")
dividerTemplate.Size = UDim2.fromOffset(5,200)
dividerTemplate.Position = UDim2.fromScale(0.5,0)
dividerTemplate.AnchorPoint = Vector2.new(0.5,0)
dividerTemplate.BackgroundColor3 = ACTIVE
dividerTemplate.BorderSizePixel = 0
dividerTemplate.ZIndex = 20
Instance.new("UICorner", dividerTemplate).CornerRadius = UDim.new(1,0)

local dividerStroke = Instance.new("UIStroke", dividerTemplate)
dividerStroke.Color = ACTIVE
dividerStroke.Thickness = 2

-- Glow
local glowTemplate = Instance.new("Frame")
glowTemplate.Size = UDim2.fromOffset(14,200)
glowTemplate.Position = UDim2.fromScale(0.5,0)
glowTemplate.AnchorPoint = Vector2.new(0.5,0)
glowTemplate.BackgroundColor3 = ACTIVE
glowTemplate.BackgroundTransparency = 0.85
glowTemplate.BorderSizePixel = 0
glowTemplate.ZIndex = 19
Instance.new("UICorner", glowTemplate).CornerRadius = UDim.new(1,0)

local glowStroke = Instance.new("UIStroke", glowTemplate)
glowStroke.Color = ACTIVE
glowStroke.Thickness = 1
glowStroke.Transparency = 0.6

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
	b.ZIndex = 11
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
	buttons[name] = b

	local p = Instance.new("Frame", content)
	p.Size = UDim2.fromScale(1,1)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.ZIndex = 11
	pages[name] = p

	local left = leftPanelTemplate:Clone()
	left.Name = "LeftPanel"
	left.Parent = p

	local right = rightPanelTemplate:Clone()
	right.Name = "RightPanel"
	right.Parent = p

	local glow = glowTemplate:Clone()
	glow.Parent = p

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

-- FLOATING TOGGLE (igual que antes)

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

print("Andepzai Hub V2 Loaded + Divider + Border")
