-- Andepzai Hub V2 | UI + Auto Fix

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- === UI ROOT ===
local gui = Instance.new("ScreenGui")
gui.Name = "AndepzaiClone"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- === COLORS ===
local AND_YELLOW = Color3.fromRGB(255, 213, 0)
local INACTIVE = Color3.fromRGB(120,120,120)

-- === MAIN FRAME ===
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.65,0.7)
main.Position = UDim2.fromScale(0.175,0.15)
main.BackgroundColor3 = Color3.fromRGB(15,15,15)
main.BorderSizePixel = 0

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0,18)

-- === TABS BAR ===
local tabBar = Instance.new("Frame", main)
tabBar.Size = UDim2.fromScale(0.25,1)
tabBar.BackgroundColor3 = Color3.fromRGB(20,20,20)
tabBar.BorderSizePixel = 0

-- === CONTENT ===
local content = Instance.new("Frame", main)
content.Size = UDim2.fromScale(0.75,1)
content.Position = UDim2.fromScale(0.25,0)
content.BackgroundTransparency = 1

-- === PAGES SYSTEM ===
local pages = {}

local function hideAllPages()
	for _,p in pairs(pages) do
		p.Visible = false
	end
end

-- === PRINCIPAL PAGE ===
local mainPage = Instance.new("Frame", content)
mainPage.Size = UDim2.fromScale(1,1)
mainPage.BackgroundTransparency = 1
mainPage.Visible = true
pages["Principal"] = mainPage

local title = Instance.new("TextLabel", mainPage)
title.Size = UDim2.fromOffset(400,50)
title.Position = UDim2.fromOffset(20,20)
title.BackgroundTransparency = 1
title.Text = "Andepzai Hub V2"
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextColor3 = AND_YELLOW
title.TextXAlignment = Enum.TextXAlignment.Left

-- === VISUAL PAGE ===
local visualPage = Instance.new("Frame", content)
visualPage.Size = UDim2.fromScale(1,1)
visualPage.BackgroundTransparency = 1
visualPage.Visible = false
pages["Visual"] = visualPage

-- === TAB BUTTON CREATOR ===
local function createTab(name, order)
	local btn = Instance.new("TextButton", tabBar)
	btn.Size = UDim2.new(1,0,0,50)
	btn.Position = UDim2.new(0,0,0,(order-1)*50)
	btn.Text = name
	btn.BackgroundTransparency = 1
	btn.TextColor3 = INACTIVE
	btn.Font = Enum.Font.Gotham
	btn.TextSize = 18
	
	btn.MouseButton1Click:Connect(function()
		hideAllPages()
		pages[name].Visible = true
		for _,b in pairs(tabBar:GetChildren()) do
			if b:IsA("TextButton") then
				b.TextColor3 = INACTIVE
			end
		end
		btn.TextColor3 = AND_YELLOW
	end)
end

createTab("Principal",1)
createTab("Visual",2)

hideAllPages()
mainPage.Visible = true

print("Andepzai Hub loaded")
