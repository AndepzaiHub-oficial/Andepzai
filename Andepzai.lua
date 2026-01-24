--// Andepzai Hub V2 | HARD OBFUSCATION + ANTI DUMP + ANTI DEBUG

local _x=function(...)
	local t={...}
	local r=""
	for i=1,#t do
		r=r..string.char(t[i])
	end
	return r
end

local _d=function(s,k)
	local o={}
	for i=1,#s do
		o[i]=string.char(bit32.bxor(s:byte(i),k))
	end
	return table.concat(o)
end

local _k=73
local _e=loadstring or load

--// =========================
--// ANTI DUMP / ANTI DEBUG
--// =========================
local function _kill()
	pcall(function()
		script:Destroy()
	end)
end

pcall(function()
	if typeof(getgc)=="function" then _kill() end
	if debug and (debug.getinfo or debug.sethook) then _kill() end
	local ok=pcall(function()
		local f=function() return 1 end
		if f()~=1 then _kill() end
	end)
	if not ok then _kill() end
	if _G or shared then
		setmetatable(_G,{__newindex=function() _kill() end})
	end
end)

--// =========================
--// REAL SOURCE
--// =========================
local _src=[[
local Players = game:GetService("Players")

local player = Players.LocalPlayer or Players.PlayerAdded:Wait()
local playerGui = player:WaitForChild("PlayerGui")

pcall(function()
	if playerGui:FindFirstChild("AndepzaiHub") then
		playerGui.AndepzaiHub:Destroy()
	end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "AndepzaiHub"
gui.DisplayOrder = 999999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.Parent = playerGui

local PANEL = Color3.fromRGB(26,26,26)
local ACTIVE = Color3.fromRGB(80,80,80)
local INACTIVE = Color3.fromRGB(45,45,45)
local TEXT = Color3.fromRGB(220,220,220)
local BORDER = Color3.fromRGB(255,193,7)

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(560,300)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = PANEL
main.BorderSizePixel = 0
main.ZIndex = 10
Instance.new("UICorner",main).CornerRadius = UDim.new(0,20)

local stroke = Instance.new("UIStroke",main)
stroke.Color = BORDER
stroke.Thickness = 2

--// LOGO CUADRADO CORRECTO
local logoBox = Instance.new("Frame", main)
logoBox.Size = UDim2.fromOffset(42,38)
logoBox.Position = UDim2.fromOffset(15,8)
logoBox.BackgroundColor3 = Color3.fromRGB(18,18,18)
logoBox.BorderSizePixel = 0
logoBox.ZIndex = 15

local logoStroke = Instance.new("UIStroke", logoBox)
logoStroke.Color = BORDER
logoStroke.Thickness = 2

local logo = Instance.new("ImageLabel", logoBox)
logo.Size = UDim2.fromScale(1,1)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://107282251430253"
logo.ZIndex = 16

--// TOGGLE
local toggleBtn = Instance.new("ImageButton",gui)
toggleBtn.Size = UDim2.fromOffset(44,44)
toggleBtn.Position = UDim2.fromScale(0.03,0.45)
toggleBtn.BackgroundColor3 = Color3.fromRGB(18,18,18)
toggleBtn.BorderSizePixel = 0
toggleBtn.Image = "rbxassetid://107282251430253"
toggleBtn.ZIndex = 9999
toggleBtn.Active = true
toggleBtn.Draggable = true

toggleBtn.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

--// TABS BAR
local tabsFrame = Instance.new("ScrollingFrame", main)
tabsFrame.Size = UDim2.new(1,-90,0,38)
tabsFrame.Position = UDim2.fromOffset(70,6)
tabsFrame.BackgroundTransparency = 1
tabsFrame.ScrollBarImageTransparency = 1
tabsFrame.ScrollingDirection = Enum.ScrollingDirection.X
tabsFrame.ZIndex = 30

local tabLayout = Instance.new("UIListLayout", tabsFrame)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0,8)

tabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	tabsFrame.CanvasSize = UDim2.fromOffset(tabLayout.AbsoluteContentSize.X+10,38)
end)

local tabs, contents = {}, {}

--// CARD
local function makeCard(parent,titleText)
	local card = Instance.new("ScrollingFrame", parent)
	card.Size = UDim2.new(1,-6,1,-6)
	card.Position = UDim2.fromOffset(3,3)
	card.BackgroundColor3 = Color3.fromRGB(18,18,18)
	card.ScrollBarThickness = 4
	card.BorderSizePixel = 0
	card.ZIndex = 26
	card.ScrollingDirection = Enum.ScrollingDirection.Y
	Instance.new("UICorner",card).CornerRadius = UDim.new(0,14)
	Instance.new("UIStroke",card).Color = Color3.fromRGB(35,35,35)

	local layout = Instance.new("UIListLayout",card)
	layout.Padding = UDim.new(0,10)

	local title = Instance.new("TextLabel",card)
	title.Size = UDim2.new(1,-10,0,28)
	title.Text = titleText
	title.TextColor3 = TEXT
	title.Font = Enum.Font.GothamBold
	title.TextSize = 15
	title.BackgroundTransparency = 1
	title.ZIndex = 27

	for i=1,6 do
		local section = Instance.new("TextLabel",card)
		section.Size = UDim2.new(1,-10,0,34)
		section.Text = "• Sección "..i
		section.TextColor3 = Color3.fromRGB(200,200,200)
		section.Font = Enum.Font.Gotham
		section.TextSize = 13
		section.BackgroundColor3 = Color3.fromRGB(24,24,24)
		section.BorderSizePixel = 0
		section.ZIndex = 27
		Instance.new("UICorner",section).CornerRadius = UDim.new(0,8)
	end

	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		card.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+12)
	end)
end

local function createTab(name
