-- Andepzai Hub V2 | UI + Auto Farm Level | Blox Fruits (LEGIT MODE)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "AndepzaiClone"
gui.ResetOnSpawn = false

local AND_YELLOW = Color3.fromRGB(255,193,7)
local INACTIVE = Color3.fromRGB(55,55,55)

-- ===== CONFIG GLOBAL =====
getgenv().TweenSpeed = 150

local function CreateTween(part, cf)
	local speed = math.clamp(getgenv().TweenSpeed or 150, 1, 350)
    	local time = math.clamp(1 / speed * 60, 0.05, 2)
        	return TweenService:Create(part, TweenInfo.new(time, Enum.EasingStyle.Quad), {CFrame = cf})
            end

            -- TOGGLE UI BUTTON
            local toggle = Instance.new("ImageButton", gui)
            toggle.Size = UDim2.fromOffset(50,50)
            toggle.Position = UDim2.fromOffset(30,120)
            toggle.Image = "rbxassetid://12902444443"
            toggle.BackgroundTransparency = 1
            toggle.ZIndex = 100

            -- MAIN PANEL
            local main = Instance.new("Frame", gui)
            main.Size = UDim2.fromOffset(760,420)
            main.Position = UDim2.fromScale(0.5,0) + UDim2.fromOffset(-380,60)
            main.BackgroundColor3 = Color3.fromRGB(16,16,16)
            main.BorderSizePixel = 0
            main.ZIndex = 10
            Instance.new("UICorner", main).CornerRadius = UDim.new(0,18)

            local openPos = main.Position
            local closedPos = main.Position - UDim2.fromOffset(0,500)
            local opened = true

            toggle.MouseButton1Click:Connect(function()
            	opened = not opened
                	TweenService:Create(main, TweenInfo.new(0.25), {Position = opened and openPos or closedPos}):Play()
                    end)

                    -- TABS
                    local tabHolder = Instance.new("Frame", main)
                    tabHolder.Size = UDim2.fromOffset(760,70)
                    tabHolder.BackgroundTransparency = 1

                    local layout = Instance.new("UIListLayout", tabHolder)
                    layout.FillDirection = Enum.FillDirection.Horizontal
                    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                    layout.VerticalAlignment = Enum.VerticalAlignment.Center
                    layout.Padding = UDim.new(0,12)

                    local tabs = {"Principal","Item Farm","Race V4","Visual","Config"}
                    local buttons = {}

                    local function setActive(btn)
                    	for _,b in ipairs(buttons) do
                        		b.BackgroundColor3 = INACTIVE
                                		b.TextColor3 = Color3.fromRGB(235,235,235)
                                        	end
                                            	btn.BackgroundColor3 = AND_YELLOW
                                                	btn.TextColor3 = Color3.fromRGB(25,25,25)
                                                    end

                                                    -- CONTENT
                                                    local content = Instance.new("Frame", main)
                                                    content.Size = UDim2.fromOffset(720,320)
                                                    content.Position = UDim2.fromOffset(20,80)
                                                    content.BackgroundColor3 = Color3.fromRGB(22,22,22)
                                                    content.BorderSizePixel = 0
                                                    Instance.new("UICorner", content).CornerRadius = UDim.new(0,16)

                                                    -- PAGE SYSTEM
                                                    local pages = {}
                                                    local function hideAllPages() for _,p in pairs(pages) do p.Visible = false end end

                                                    for i,name in ipairs(tabs) do
                                                    	local b = Instance.new("TextButton", tabHolder)
                                                        	b.Size = UDim2.fromOffset(150,40)
                                                            	b.BackgroundColor3 = INACTIVE
                                                                	b.Text = name
                                                                    	b.TextColor3 = Color3.fromRGB(235,235,235)
                                                                        	b.Font = Enum.Font.GothamBold
                                                                            	b.TextSize = 16
                                                                                	b.BorderSizePixel = 0
                                                                                    	Instance.new("UICorner", b).CornerRadius = UDim.new(1,0)
                                                                                        	table.insert(buttons,b)
                                                                                            end

                                                                                            for i,name in ipairs(tabs) do
                                                                                            	local b = buttons[i]
                                                                                                	if i == 1 then setActive(b) end
                                                                                                    	b.MouseButton1Click:Connect(function()
                                                                                                        		setActive(b)
                                                                                                                		hideAllPages()
                                                                                                                        		if pages[name] then pages[name].Visible = true end
                                                                                                                                	end)
                                                                                                                                    end

                                                                                                                                    -- ===== CONFIG PAGE =====
                                                                                                                                    local configPage = Instance.new("Frame", content)
                                                                                                                                    configPage.Size = UDim2.fromScale(1,1)
                                                                                                                                    configPage.BackgroundTransparency = 1
                                                                                                                                    configPage.Visible = false
                                                                                                                                    pages["Config"] = configPage

                                                                                                                                    local label = Instance.new("TextLabel", configPage)
                                                                                                                                    label.Size = UDim2.fromOffset(260,40)
                                                                                                                                    label.Position = UDim2.fromOffset(20,20)
                                                                                                                                    label.BackgroundTransparency = 1
                                                                                                                                    label.Text = "Tween Speed (0 - 350)"
                                                                                                                                    label.Font = Enum.Font.GothamBold
                                                                                                                                    label.TextSize = 16
                                                                                                                                    label.TextColor3 = Color3.fromRGB(235,235,235)

                                                                                                                                    local box = Instance.new("TextBox", configPage)
                                                                                                                                    box.Size = UDim2.fromOffset(120,40)
                                                                                                                                    box.Position = UDim2.fromOffset(20,70)
                                                                                                                                    box.Text = tostring(getgenv().TweenSpeed)
                                                                                                                                    box.Font = Enum.Font.GothamBold
                                                                                                                                    box.TextSize = 16
                                                                                                                                    box.TextColor3 = Color3.new(1,1,1)
                                                                                                                                    box.BackgroundColor3 = Color3.fromRGB(45,45,45)
                                                                                                                                    box.BorderSizePixel = 0
                                                                                                                                    box.ClearTextOnFocus = false
                                                                                                                                    Instance.new("UICorner", box).CornerRadius = UDim.new(0,10)

                                                                                                                                    box.FocusLost:Connect(function()
                                                                                                                                    	local v = tonumber(box.Text)
                                                                                                                                        	if v and v >= 0 and v <= 350 then
                                                                                                                                            		getgenv().TweenSpeed = v
                                                                                                                                                    	else
                                                                                                                                                        		box.Text = tostring(getgenv().TweenSpeed)
                                                                                                                                                                	end
                                                                                                                                                                    end)

                                                                                                                                                                    hideAllPages()
                                                                                                                                                                    pages["Principal"] = Instance.new("Frame", content) -- placeholder visible page
                                                                                                                                                                    pages["Principal"].Visible = true

                                                                                                                                                                    print("Andepzai Hub loaded with Config system.")
