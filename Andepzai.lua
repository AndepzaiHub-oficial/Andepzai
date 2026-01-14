-- Andepzai Hub V2 | Ronix Compatible + MiniMap FIXED + Farm Panel

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
Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0,8)

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
local mapEnabled = true

toggleButton.MouseButton1Click:Connect(function()
	isHidden = not isHidden
	mapEnabled = not isHidden
	local target = isHidden and UDim2.fromScale(1.5,0.5) or UDim2.fromScale(0.5,0.5)
	main:TweenPosition(target, "Out", "Quad", 0.25, true)
end)

-- TABS
local tabs = {"Farm","Player","Race V4","Visual"}
local buttons,pages = {},{}

local top = Instance.new("Frame", main)
top.Size = UDim2.fromOffset(600,52)
top.BackgroundColor3 = Color3.fromRGB(18,18,18)
top.BorderSizePixel = 0
top.ZIndex = 80
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
	b.ZIndex = 85
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
	buttons[name]=b

	local p = Instance.new("Frame", content)
	p.Size = UDim2.fromScale(1,1)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.ZIndex = 85
	pages[name]=p

	b.MouseButton1Click:Connect(function()
		setActive(name)
	end)
end

setActive("Farm")
pages["Farm"].Visible = true

-- ========================
-- PANEL IZQUIERDO FARM
-- ========================
local farmPanel = Instance.new("Frame", pages["Farm"])
farmPanel.Size = UDim2.fromScale(0.48,1)
farmPanel.Position = UDim2.fromScale(0,0)
farmPanel.BackgroundTransparency = 1
farmPanel.ZIndex = 85

local farmTitle = Instance.new("TextLabel", farmPanel)
farmTitle.Size = UDim2.fromOffset(260,32)
farmTitle.BackgroundTransparency = 1
farmTitle.Text = "Farm"
farmTitle.TextColor3 = TEXT
farmTitle.Font = Enum.Font.GothamBold
farmTitle.TextSize = 18
farmTitle.ZIndex = 90

local divider = Instance.new("Frame", farmPanel)
divider.Position = UDim2.fromOffset(0,36)
divider.Size = UDim2.fromOffset(260,2)
divider.BackgroundColor3 = ACTIVE
divider.BorderSizePixel = 0
divider.ZIndex = 90

local farmList = Instance.new("UIListLayout", farmPanel)
farmList.Padding = UDim.new(0,10)

-- ===== BOTONES FARM (MODIFICADOS AQUÍ) =====
local function createFarmButton(text)
	local b = Instance.new("TextButton")
	b.Size = UDim2.fromOffset(240,38)
	b.BackgroundColor3 = Color3.fromRGB(35,35,35)
	b.Text = text
	b.TextColor3 = Color3.fromRGB(200,200,200)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.BorderSizePixel = 0
	b.ZIndex = 90
	b.AutoButtonColor = false

	local corner = Instance.new("UICorner", b)
	corner.CornerRadius = UDim.new(1,0)

	local stroke = Instance.new("UIStroke", b)
	stroke.Color = Color3.fromRGB(45,45,45)
	stroke.Thickness = 1

	b.MouseEnter:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {
			BackgroundColor3 = Color3.fromRGB(45,45,45)
		}):Play()
	end)

	b.MouseLeave:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.15), {
			BackgroundColor3 = Color3.fromRGB(35,35,35)
		}):Play()
	end)

	b.Parent = farmPanel
	return b
end

createFarmButton("Auto Farm")
createFarmButton("Fast Attack")
createFarmButton("Boss Farm")
createFarmButton("Chest Farm")

-- ========================
-- MAPA DERECHA
-- ========================
local mapPanel = Instance.new("Frame", pages["Farm"])
mapPanel.Size = UDim2.fromScale(0.47,1)
mapPanel.Position = UDim2.fromScale(0.53,0)
mapPanel.BackgroundTransparency = 1
mapPanel.ZIndex = 85

local title = Instance.new("TextLabel", mapPanel)
title.Size = UDim2.fromOffset(260,32)
title.BackgroundTransparency = 1
title.Text = "Map"
title.TextColor3 = TEXT
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.ZIndex = 90

local viewport = Instance.new("ViewportFrame", mapPanel)
viewport.Position = UDim2.fromOffset(0,40)
viewport.Size = UDim2.new(1,0,1,-40)
viewport.BackgroundColor3 = Color3.fromRGB(15,15,15)
viewport.BorderSizePixel = 0
viewport.ZIndex = 90
Instance.new("UICorner", viewport).CornerRadius = UDim.new(0,12)

local s = Instance.new("UIStroke", viewport)
s.Color = ACTIVE
s.Thickness = 2

local cam = Instance.new("Camera", viewport)
viewport.CurrentCamera = cam

local worldModel = Instance.new("WorldModel", viewport)

local function cloneMap()
	worldModel:ClearAllChildren()
	for _,obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Anchored and obj.Transparency < 1 then
			obj:Clone().Parent = worldModel
		end
	end
end

cloneMap()

task.spawn(function()
	while gui.Parent do
		task.wait(6)
		cloneMap()
	end
end)

task.spawn(function()
	while gui.Parent do
		task.wait(0.1)
		if mapEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			local hrp = player.Character.HumanoidRootPart
			cam.CFrame = CFrame.new(hrp.Position + Vector3.new(0,250,0), hrp.Position)
		end
	end
end)

-- ========================
-- OVERLAY DIVIDER (NO TOCA NADA EXISTENTE)
-- ========================
task.wait(0.2)

local overlayDivider = Instance.new("Frame")
overlayDivider.Parent = pages["Farm"]
overlayDivider.Size = UDim2.fromOffset(2, content.AbsoluteSize.Y)
overlayDivider.Position = UDim2.fromScale(0.5, 0)
overlayDivider.AnchorPoint = Vector2.new(0.5, 0)
overlayDivider.BackgroundColor3 = ACTIVE
overlayDivider.BorderSizePixel = 0
overlayDivider.ZIndex = 1000
overlayDivider.Name = "OverlayDivider"

content:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
	if overlayDivider then
		overlayDivider.Size = UDim2.fromOffset(2, content.AbsoluteSize.Y)
	end
end)

print("Andepzai Hub cargado correctamente 😎")
