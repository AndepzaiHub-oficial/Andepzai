-- Andepzai Hub V2 | RONIX Fixed Version

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer or Players.PlayerAdded:Wait()
local playerGui = player:WaitForChild("PlayerGui")

pcall(function()
	if playerGui:FindFirstChild("AndepzaiHub") then
		playerGui.AndepzaiHub:Destroy()
	end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "AndepzaiHub"
gui.IgnoreGuiInset = false
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Parent = playerGui

-- Colors
local PANEL = Color3.fromRGB(26,26,26)
local ACTIVE = Color3.fromRGB(80,80,80)
local INACTIVE = Color3.fromRGB(45,45,45)
local TEXT = Color3.fromRGB(220,220,220)
local BORDER = Color3.fromRGB(255,193,7)

-- Main panel
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(560, 300)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = PANEL
main.BorderSizePixel = 0
main.ZIndex = 10
Instance.new("UICorner", main).CornerRadius = UDim.new(0,20)

local stroke = Instance.new("UIStroke", main)
stroke.Color = BORDER
stroke.Thickness = 2

-- Logo
local leftSlot = Instance.new("Frame", main)
leftSlot.Size = UDim2.fromOffset(42, 38)
leftSlot.Position = UDim2.fromOffset(15, 6)
leftSlot.BackgroundColor3 = Color3.fromRGB(18,18,18)
leftSlot.BorderSizePixel = 0
leftSlot.ZIndex = 20
Instance.new("UIStroke", leftSlot).Color = BORDER

local logo = Instance.new("ImageLabel", leftSlot)
logo.Size = UDim2.fromScale(1,1)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://107282251430253"
logo.ZIndex = 21

-- Toggle button
local toggleBtn = Instance.new("ImageButton", gui)
toggleBtn.Size = UDim2.fromOffset(44,44)
toggleBtn.Position = UDim2.fromScale(0.03, 0.45)
toggleBtn.BackgroundColor3 = Color3.fromRGB(18,18,18)
toggleBtn.BorderSizePixel = 0
toggleBtn.Image = "rbxassetid://107282251430253"
toggleBtn.ZIndex = 9999

toggleBtn.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- Tabs bar
local tabsFrame = Instance.new("ScrollingFrame", main)
tabsFrame.Size = UDim2.new(1, -90, 0, 38)
tabsFrame.Position = UDim2.fromOffset(70, 6)
tabsFrame.BackgroundTransparency = 1
tabsFrame.ScrollBarImageTransparency = 1
tabsFrame.ZIndex = 11
tabsFrame.ScrollingDirection = Enum.ScrollingDirection.X
tabsFrame.ElasticBehavior = Enum.ElasticBehavior.Never

tabsFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
	tabsFrame.CanvasPosition = Vector2.new(tabsFrame.CanvasPosition.X, 0)
end)

local tabLayout = Instance.new("UIListLayout", tabsFrame)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 8)

tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	tabsFrame.CanvasSize = UDim2.fromOffset(tabLayout.AbsoluteContentSize.X + 10, 38)
end)

local tabs, contents = {}, {}

-- Card
local function makeCard(parent, titleText)
	local card = Instance.new("ScrollingFrame", parent)
	card.Size = UDim2.new(1, -6, 1, -6)
	card.Position = UDim2.fromOffset(3,3)
	card.BackgroundColor3 = Color3.fromRGB(18,18,18)
	card.ScrollBarThickness = 4
	card.BorderSizePixel = 0
	card.ZIndex = 20
	card.CanvasSize = UDim2.new(0,0,0,0)
	card.AutomaticCanvasSize = Enum.AutomaticSize.None
	card.ScrollingDirection = Enum.ScrollingDirection.Y

	Instance.new("UICorner", card).CornerRadius = UDim.new(0,14)
	Instance.new("UIStroke", card).Color = Color3.fromRGB(35,35,35)

	local layout = Instance.new("UIListLayout", card)
	layout.Padding = UDim.new(0, 10)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	local title = Instance.new("TextLabel", card)
	title.Size = UDim2.new(1,-10,0,28)
	title.Text = titleText
	title.TextColor3 = TEXT
	title.Font = Enum.Font.GothamBold
	title.TextSize = 15
	title.BackgroundTransparency = 1
	title.TextXAlignment = Enum.TextXAlignment.Center
	title.TextYAlignment = Enum.TextYAlignment.Center
	title.ZIndex = 21

	for i = 1, 6 do
		local section = Instance.new("TextLabel", card)
		section.Size = UDim2.new(1,-10,0,34)
		section.Text = "• Sección " .. i
		section.TextColor3 = Color3.fromRGB(200,200,200)
		section.Font = Enum.Font.Gotham
		section.TextSize = 13
		section.BackgroundColor3 = Color3.fromRGB(24,24,24)
		section.BorderSizePixel = 0
		section.ZIndex = 21
		Instance.new("UICorner", section).CornerRadius = UDim.new(0,8)
	end

	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		card.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 12)
	end)

	return card
end

-- Tab creator
local function createTab(name, leftTitle, rightTitle)
	local btn = Instance.new("TextButton", tabsFrame)
	btn.Size = UDim2.fromOffset(110, 26)
	btn.Text = name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 13
	btn.TextColor3 = TEXT
	btn.BackgroundColor3 = INACTIVE
	btn.BorderSizePixel = 0
	btn.ZIndex = 12
	Instance.new("UICorner", btn)

	local content = Instance.new("Frame", main)
	content.Size = UDim2.new(1, -30, 1, -60)
	content.Position = UDim2.fromOffset(15, 50)
	content.BackgroundTransparency = 1
	content.Visible = false
	content.ZIndex = 11

	local left = Instance.new("Frame", content)
	left.Size = UDim2.new(0.5, -8, 1, -6)
	left.BackgroundTransparency = 1

	local right = Instance.new("Frame", content)
	right.Size = UDim2.new(0.5, -8, 1, -6)
	right.Position = UDim2.fromScale(0.5,0)
	right.BackgroundTransparency = 1

	makeCard(left, leftTitle)
	makeCard(right, rightTitle)

	btn.MouseButton1Click:Connect(function()
		for k,v in pairs(tabs) do
			v.BackgroundColor3 = INACTIVE
			contents[k].Visible = false
		end
		btn.BackgroundColor3 = ACTIVE
		content.Visible = true
	end)

	tabs[name] = btn
	contents[name] = content
end

-- Tabs
createTab("Main", "Main", "Settings")
createTab("Item Farm", "Sea 1 + Sea 2", "Sea 3")
createTab("Race V4", "Temple of Time", "Trial + Config")
createTab("Player", "Local Player", "Visual")
createTab("Visual", "ESP", "Visuals")

task.wait()
tabs["Main"].BackgroundColor3 = ACTIVE
contents["Main"].Visible = true

print("UI cargado correctamente en RONIX 😎")
