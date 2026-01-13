-- Andepzai Hub V2 | Exact UI + Forced Resize + Floating Toggle (RoniX Android FIXED)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

pcall(function()
	player.PlayerGui:FindFirstChild("AndepzaiHub"):Destroy()
	CoreGui:FindFirstChild("AndepzaiFloatingToggle"):Destroy()
end)

-- ======================
-- AUTO FARM CONFIG
-- ======================
local AutoFarmLevel = false
local REJOIN_TIME = 3600
local lastRejoin = os.time()

-- ======================
-- MAIN GUI
-- ======================
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
main.ZIndex = 50
Instance.new("UICorner", main).CornerRadius = UDim.new(0,24)

local border = Instance.new("UIStroke", main)
border.Thickness = 2
border.Color = ACTIVE
border.Transparency = 0.15

-- TOP BAR
local top = Instance.new("Frame", main)
top.Size = UDim2.fromOffset(600,52)
top.BackgroundTransparency = 1
top.ZIndex = 55

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
content.ZIndex = 51

-- LEFT / RIGHT PANELS + DIVIDER
local leftPanelTemplate = Instance.new("Frame")
leftPanelTemplate.Size = UDim2.fromScale(0.48,1)
leftPanelTemplate.BackgroundTransparency = 1
leftPanelTemplate.ZIndex = 53

local rightPanelTemplate = Instance.new("Frame")
rightPanelTemplate.Size = UDim2.fromScale(0.48,1)
rightPanelTemplate.Position = UDim2.fromScale(0.52,0)
rightPanelTemplate.BackgroundTransparency = 1
	rightPanelTemplate.ZIndex = 53

local dividerTemplate = Instance.new("Frame")
dividerTemplate.Size = UDim2.fromOffset(5,200)
dividerTemplate.Position = UDim2.fromScale(0.5,0)
dividerTemplate.AnchorPoint = Vector2.new(0.5,0)
dividerTemplate.BackgroundColor3 = ACTIVE
dividerTemplate.BorderSizePixel = 0
dividerTemplate.ZIndex = 54

-- TABS
local tabs = {"Farm","Race V4","Visual"}
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
	b.ZIndex = 55
	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
	buttons[name] = b

	local p = Instance.new("Frame", content)
	p.Size = UDim2.fromScale(1,1)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.ZIndex = 52
	pages[name] = p

	leftPanelTemplate:Clone().Parent = p
	rightPanelTemplate:Clone().Parent = p
	dividerTemplate:Clone().Parent = p

	b.MouseButton1Click:Connect(function()
		setActive(name)
	end)
end

setActive("Farm")

-- FARMS SCROLL
local farmsScroll = Instance.new("ScrollingFrame", pages["Farm"])
farmsScroll.Size = UDim2.fromScale(0.48,1)
farmsScroll.CanvasSize = UDim2.fromScale(0,0)
farmsScroll.ScrollBarThickness = 4
farmsScroll.ScrollBarImageTransparency = 0.4
farmsScroll.BackgroundTransparency = 1
farmsScroll.ZIndex = 55

local farmLayout = Instance.new("UIListLayout", farmsScroll)
farmLayout.Padding = UDim.new(0,8)

farmLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	farmsScroll.CanvasSize = UDim2.fromOffset(0, farmLayout.AbsoluteContentSize.Y + 10)
end)

local farmTitle = Instance.new("TextLabel", farmsScroll)
farmTitle.Size = UDim2.fromOffset(260,36)
farmTitle.BackgroundTransparency = 1
farmTitle.Text = "Farms"
farmTitle.TextColor3 = TEXT
farmTitle.Font = Enum.Font.GothamBold
farmTitle.TextSize = 18

-- FARM ROW + TOGGLE
local function makeFarmRow(text)
	local row = Instance.new("Frame", farmsScroll)
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

	return row
end

local function makeFarmToggle(text)
	local parent = makeFarmRow(text)

	local t = Instance.new("TextButton", parent)
	t.Size = UDim2.fromOffset(22,22)
	t.Position = UDim2.new(1,-32,0.5,-11)
	t.BackgroundColor3 = Color3.fromRGB(55,55,55)
	t.Text = ""
	t.AutoButtonColor = false
	Instance.new("UICorner", t).CornerRadius = UDim.new(1,0)

	local check = Instance.new("TextLabel", t)
	check.Size = UDim2.fromScale(1,1)
	check.BackgroundTransparency = 1
	check.Text = "✓"
	check.TextColor3 = Color3.fromRGB(255,255,255)
	check.Font = Enum.Font.GothamBold
	check.TextSize = 16
	check.Visible = false

	local state = false

	t.MouseButton1Click:Connect(function()
		state = not state
		check.Visible = state
		TweenService:Create(t, TweenInfo.new(0.15), {
			BackgroundColor3 = state and Color3.fromRGB(60,150,255) or Color3.fromRGB(55,55,55)
		}):Play()

		if text == "Auto Farm Level" then
			AutoFarmLevel = state
		end
	end)
end

makeFarmToggle("Auto Farm Level")
makeFarmToggle("Auto Farm Bone")
makeFarmToggle("Auto Farm Gun")
makeFarmToggle("Auto Farm Chest")
makeFarmToggle("Auto Farm Boss")

-- ======================
-- AUTO FARM LOGIC
-- ======================

local function tweenTo(cf, speed)
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end
	local dist = (hrp.Position - cf.Position).Magnitude
	local t = dist / (speed or 250)
	TweenService:Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = cf}):Play()
	task.wait(t)
end

local function hasQuest()
	return false -- cambia esto por tu detección real
end

local function takeQuest()
	-- Placeholder
end

local function getMob()
	for _, m in ipairs(workspace:GetDescendants()) do
		if m:IsA("Model") and m:FindFirstChild("Humanoid") and m.Humanoid.Health > 0 then
			return m
		end
	end
end

local function attackMob(mob)
	while mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and AutoFarmLevel do
		tweenTo(mob.HumanoidRootPart.CFrame * CFrame.new(0,0,3), 300)
		task.wait(0.2)
	end
end

task.spawn(function()
	while true do
		task.wait(0.5)
		if AutoFarmLevel then
			if not hasQuest() then
				takeQuest()
			else
				local mob = getMob()
				if mob then
					attackMob(mob)
				end
			end
		end
	end
end)

task.spawn(function()
	while true do
		task.wait(10)
		if AutoFarmLevel and os.time() - lastRejoin >= REJOIN_TIME then
			lastRejoin = os.time()
			TeleportService:Teleport(game.PlaceId, player)
		end
	end
end)

print("Andepzai Hub V2 Loaded with Auto Farm")

-- ============================
-- BLOX FRUITS AUTO FARM REAL
-- ============================

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local function getLevel()
	return player.Data.Level.Value
end

local function getSea()
	if workspace:FindFirstChild("_WorldOrigin") then
		return 2
	elseif workspace:FindFirstChild("ThirdSea") then
		return 3
	end
	return 1
end

-- Quest table (SEA 1 basic)
local QuestTable = {
	{min=1, max=9, npc="BanditQuest1", mob="Bandit"},
	{min=10, max=14, npc="BanditQuest2", mob="Bandit"},
	{min=15, max=29, npc="MonkeyQuest", mob="Monkey"},
	{min=30, max=39, npc="GorillaQuest", mob="Gorilla"},
	{min=40, max=59, npc="PirateQuest", mob="Pirate"},
}

local function getQuestForLevel(lv)
	for _,q in ipairs(QuestTable) do
		if lv >= q.min and lv <= q.max then
			return q
		end
	end
end

local function hasQuest()
	return player.PlayerGui:FindFirstChild("Main"):FindFirstChild("Quest").Visible
end

local function takeQuest(q)
	for _,npc in ipairs(workspace.NPCs:GetChildren()) do
		if npc.Name == q.npc then
			tweenTo(npc.HumanoidRootPart.CFrame * CFrame.new(0,0,4), 200)
			task.wait(0.3)
			Remotes.CommF_:InvokeServer("StartQuest", q.npc, 1)
		end
	end
end

local function getMob(q)
	for _,mob in ipairs(workspace.Enemies:GetChildren()) do
		if mob.Name == q.mob and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
			return mob
		end
	end
end

local function attackMob(mob)
	while mob and mob.Parent and mob.Humanoid.Health > 0 and AutoFarmLevel do
		tweenTo(mob.HumanoidRootPart.CFrame * CFrame.new(0,0,3), 250)
		Remotes.CommF_:InvokeServer("Attack")
		task.wait(0.25)
	end
end

-- MAIN LOOP
task.spawn(function()
	while true do
		task.wait(0.4)
		if AutoFarmLevel then
			local lv = getLevel()
			local q = getQuestForLevel(lv)

			if q then
				if not hasQuest() then
					takeQuest(q)
				else
					local mob = getMob(q)
					if mob then
						attackMob(mob)
					end
				end
			end
		end
	end
end)
