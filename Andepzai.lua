-- Andepzai Hub V2 | Exact UI + Page System

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

if player.PlayerGui:FindFirstChild("AndepzaiHub") then
	player.PlayerGui.AndepzaiHub:Destroy()
end

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "AndepzaiHub"
gui.ResetOnSpawn = false

-- COLORS
local BG = Color3.fromRGB(18,18,18)
local PANEL = Color3.fromRGB(12,12,12)
local ACTIVE = Color3.fromRGB(255,193,7)
local INACTIVE = Color3.fromRGB(70,70,70)
local TEXT = Color3.fromRGB(220,220,220)

-- MAIN PANEL
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(680,360) -- 🔽 reducido
main.Position = UDim2.fromScale(0.5,0.5) - UDim2.fromOffset(340,180)
main.BackgroundColor3 = PANEL
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0,26)

-- TOP BAR
local top = Instance.new("Frame", main)
top.Size = UDim2.fromOffset(680,60) -- 🔽 reducido
top.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", top)
layout.FillDirection = Enum.FillDirection.Horizontal
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0,14)

-- CONTENT
local content = Instance.new("Frame", main)
content.Size = UDim2.fromOffset(640,260) -- 🔽 reducido
content.Position = UDim2.fromOffset(20,80)
content.BackgroundTransparency = 1

local tabs = {"Principal","Item Farm","Race V4","Visual"}
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
	b.Size = UDim2.fromOffset(140,36) -- 🔽 reducido
	b.BackgroundColor3 = INACTIVE
	b.Text = name
	b.TextColor3 = TEXT
	b.Font = Enum.Font.GothamBold
	b.TextSize = 15
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
	buttons[name] = b

	local p = Instance.new("Frame", content)
	p.Size = UDim2.fromScale(1,1)
	p.BackgroundTransparency = 1
	p.Visible = false
	pages[name] = p

	b.MouseButton1Click:Connect(function()
		setActive(name)
	end)
end

setActive("Principal")

-- PLACEHOLDER TEXT
local label = Instance.new("TextLabel", pages["Principal"])
label.Size = UDim2.fromScale(1,1)
label.BackgroundTransparency = 1
label.Text = "Auto Farm Level (coming soon)"
label.TextColor3 = TEXT
label.Font = Enum.Font.Gotham
label.TextSize = 17

print("Andepzai Hub V2 UI Loaded")
