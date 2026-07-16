--[[
	Trident Survival Compact Script (Ocel-hub)
	Features retained:
	- Big Head ESP (Hitbox / Scale Changer)
	- Hand & Weapon Chams (Materials & Colors)
	- Sky Changer & Cloud Color Changer
]]

local v0 = (function()
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")

    local function GetSafeUIContainer()
        local success, container = pcall(function() return gethui and gethui() end)
        if success and container then return container end
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
        return LocalPlayer:WaitForChild("PlayerGui")
    end
    local CoreGui = GetSafeUIContainer()

    local OcelUI = {}

    function OcelUI:CreateWindow(options)
        local Window = {}
        local Title = options.Name or "Ocel-hub"
        
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "OcelLocalUI"
        ScreenGui.Parent = CoreGui
        ScreenGui.ResetOnSpawn = false
        
        local MainFrame = Instance.new("Frame")
        MainFrame.Name = "MainFrame"
        MainFrame.Parent = ScreenGui
        MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
        MainFrame.Size = UDim2.new(0, 500, 0, 350)
        MainFrame.ClipsDescendants = true
        
        local MainCorner = Instance.new("UICorner")
        MainCorner.CornerRadius = UDim.new(0, 8)
        MainCorner.Parent = MainFrame
        
        local MainStroke = Instance.new("UIStroke")
        MainStroke.Color = Color3.fromRGB(0, 110, 255)
        MainStroke.Thickness = 2
        MainStroke.Parent = MainFrame

        local Topbar = Instance.new("Frame")
        Topbar.Name = "Topbar"
        Topbar.Parent = MainFrame
        Topbar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Topbar.Size = UDim2.new(1, 0, 0, 40)
        
        local TopCorner = Instance.new("UICorner")
        TopCorner.CornerRadius = UDim.new(0, 8)
        TopCorner.Parent = Topbar
        
        local TopbarFix = Instance.new("Frame")
        TopbarFix.Parent = Topbar
        TopbarFix.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TopbarFix.BorderSizePixel = 0
        TopbarFix.Position = UDim2.new(0, 0, 1, -8)
        TopbarFix.Size = UDim2.new(1, 0, 0, 8)
        
        local TitleLabel = Instance.new("TextLabel")
        TitleLabel.Parent = Topbar
        TitleLabel.BackgroundTransparency = 1
        TitleLabel.Position = UDim2.new(0, 15, 0, 0)
        TitleLabel.Size = UDim2.new(1, -15, 1, 0)
        TitleLabel.Font = Enum.Font.GothamBold
        TitleLabel.Text = Title
        TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TitleLabel.TextSize = 16
        TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

        local dragging, dragInput, dragStart, startPos
        Topbar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = MainFrame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        Topbar.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)

        local TabContainer = Instance.new("ScrollingFrame")
        TabContainer.Name = "TabContainer"
        TabContainer.Parent = MainFrame
        TabContainer.Active = true
        TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabContainer.BorderSizePixel = 0
        TabContainer.Position = UDim2.new(0, 0, 0, 40)
        TabContainer.Size = UDim2.new(0, 130, 1, -40)
        TabContainer.ScrollBarThickness = 2
        
        local TabList = Instance.new("UIListLayout")
        TabList.Parent = TabContainer
        TabList.SortOrder = Enum.SortOrder.LayoutOrder
        TabList.Padding = UDim.new(0, 2)

        local TabPadding = Instance.new("UIPadding")
        TabPadding.Parent = TabContainer
        TabPadding.PaddingTop = UDim.new(0, 5)

        local ContentContainer = Instance.new("Frame")
        ContentContainer.Name = "ContentContainer"
        ContentContainer.Parent = MainFrame
        ContentContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        ContentContainer.BorderSizePixel = 0
        ContentContainer.Position = UDim2.new(0, 130, 0, 40)
        ContentContainer.Size = UDim2.new(1, -130, 1, -40)

        local FirstTab = true
        local Tabs = {}

        function Window:CreateTab(name, icon)
            local Tab = {}
            
            local TabButton = Instance.new("TextButton")
            TabButton.Name = name
            TabButton.Parent = TabContainer
            TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            TabButton.BackgroundTransparency = 1
            TabButton.BorderSizePixel = 0
            TabButton.Size = UDim2.new(1, 0, 0, 30)
            TabButton.Font = Enum.Font.GothamSemibold
            TabButton.Text = "  " .. name
            TabButton.TextColor3 = Color3.fromRGB(180, 180, 180)
            TabButton.TextSize = 13
            TabButton.TextXAlignment = Enum.TextXAlignment.Left
            
            local Page = Instance.new("ScrollingFrame")
            Page.Name = name .. "Page"
            Page.Parent = ContentContainer
            Page.Active = true
            Page.PageNavigationMode = Enum.PageNavigationMode.Standard
            Page.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            Page.BackgroundTransparency = 1
            Page.BorderSizePixel = 0
            Page.Size = UDim2.new(1, 0, 1, 0)
            Page.ScrollBarThickness = 3
            Page.Visible = false
            
            local PageLayout = Instance.new("UIListLayout")
            PageLayout.Parent = Page
            PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
            PageLayout.Padding = UDim.new(0, 5)
            
            local PagePadding = Instance.new("UIPadding")
            PagePadding.Parent = Page
            PagePadding.PaddingTop = UDim.new(0, 5)
            PagePadding.PaddingLeft = UDim.new(0, 10)
            PagePadding.PaddingRight = UDim.new(0, 10)
            
            table.insert(Tabs, {Button = TabButton, Page = Page})
            
            TabButton.MouseButton1Click:Connect(function()
                for _, t in pairs(Tabs) do
                    t.Button.TextColor3 = Color3.fromRGB(180, 180, 180)
                    t.Page.Visible = false
                end
                TabButton.TextColor3 = Color3.fromRGB(0, 110, 255)
                Page.Visible = true
            end)
            
            if FirstTab then
                TabButton.TextColor3 = Color3.fromRGB(0, 110, 255)
                Page.Visible = true
                FirstTab = false
            end

            local function UpdateCanvas()
                Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 15)
            end
            PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvas)

            function Tab:CreateSection(secName)
                local SecLabel = Instance.new("TextLabel")
                SecLabel.Parent = Page
                SecLabel.BackgroundTransparency = 1
                SecLabel.Size = UDim2.new(1, 0, 0, 25)
                SecLabel.Font = Enum.Font.GothamBold
                SecLabel.Text = secName
                SecLabel.TextColor3 = Color3.fromRGB(0, 110, 255)
                SecLabel.TextSize = 14
                SecLabel.TextXAlignment = Enum.TextXAlignment.Left
                UpdateCanvas()
            end
            
            function Tab:CreateToggle(tOpts)
                local TogFrame = Instance.new("Frame")
                TogFrame.Parent = Page
                TogFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                TogFrame.Size = UDim2.new(1, 0, 0, 35)
                
                local TogCorner = Instance.new("UICorner")
                TogCorner.CornerRadius = UDim.new(0, 6)
                TogCorner.Parent = TogFrame
                
                local Label = Instance.new("TextLabel")
                Label.Parent = TogFrame
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 10, 0, 0)
                Label.Size = UDim2.new(1, -50, 1, 0)
                Label.Font = Enum.Font.Gotham
                Label.Text = tOpts.Name
                Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                Label.TextSize = 14
                Label.TextXAlignment = Enum.TextXAlignment.Left
                
                local Check = Instance.new("TextButton")
                Check.Parent = TogFrame
                Check.BackgroundColor3 = tOpts.CurrentValue and Color3.fromRGB(0, 110, 255) or Color3.fromRGB(50, 50, 50)
                Check.Position = UDim2.new(1, -35, 0.5, -10)
                Check.Size = UDim2.new(0, 20, 0, 20)
                Check.Font = Enum.Font.Gotham
                Check.Text = ""
                
                local CheckCorner = Instance.new("UICorner")
                CheckCorner.CornerRadius = UDim.new(0, 4)
                CheckCorner.Parent = Check
                
                local State = tOpts.CurrentValue or false
                
                local function toggle()
                    State = not State
                    TweenService:Create(Check, TweenInfo.new(0.2), {BackgroundColor3 = State and Color3.fromRGB(0, 110, 255) or Color3.fromRGB(50, 50, 50)}):Play()
                    if tOpts.Callback then tOpts.Callback(State) end
                end
                
                Check.MouseButton1Click:Connect(toggle)
                UpdateCanvas()
            end
            
            function Tab:CreateSlider(sOpts)
                local SldFrame = Instance.new("Frame")
                SldFrame.Parent = Page
                SldFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                SldFrame.Size = UDim2.new(1, 0, 0, 50)
                
                local SldCorner = Instance.new("UICorner")
                SldCorner.CornerRadius = UDim.new(0, 6)
                SldCorner.Parent = SldFrame
                
                local Label = Instance.new("TextLabel")
                Label.Parent = SldFrame
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 10, 0, 0)
                Label.Size = UDim2.new(1, -20, 0, 25)
                Label.Font = Enum.Font.Gotham
                Label.Text = sOpts.Name
                Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                Label.TextSize = 14
                Label.TextXAlignment = Enum.TextXAlignment.Left
                
                local ValLabel = Instance.new("TextLabel")
                ValLabel.Parent = SldFrame
                ValLabel.BackgroundTransparency = 1
                ValLabel.Position = UDim2.new(1, -60, 0, 0)
                ValLabel.Size = UDim2.new(0, 50, 0, 25)
                ValLabel.Font = Enum.Font.Gotham
                ValLabel.Text = tostring(sOpts.CurrentValue) .. (sOpts.Suffix or "")
                ValLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                ValLabel.TextSize = 14
                ValLabel.TextXAlignment = Enum.TextXAlignment.Right
                
                local SliderBg = Instance.new("TextButton")
                SliderBg.Parent = SldFrame
                SliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                SliderBg.Position = UDim2.new(0, 10, 0, 30)
                SliderBg.Size = UDim2.new(1, -20, 0, 8)
                SliderBg.Text = ""
                
                local BgCorner = Instance.new("UICorner")
                BgCorner.CornerRadius = UDim.new(1, 0)
                BgCorner.Parent = SliderBg
                
                local SliderFill = Instance.new("Frame")
                SliderFill.Parent = SliderBg
                SliderFill.BackgroundColor3 = Color3.fromRGB(0, 110, 255)
                SliderFill.Size = UDim2.new((sOpts.CurrentValue - sOpts.Range[1]) / (sOpts.Range[2] - sOpts.Range[1]), 0, 1, 0)
                
                local FillCorner = Instance.new("UICorner")
                FillCorner.CornerRadius = UDim.new(1, 0)
                FillCorner.Parent = SliderFill
                
                local sliding = false
                
                local function update(input)
                    local pos = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
                    SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                    local val = sOpts.Range[1] + (sOpts.Range[2] - sOpts.Range[1]) * pos
                    local inc = sOpts.Increment or 1
                    val = math.floor(val / inc + 0.5) * inc
                    
                    ValLabel.Text = tostring(val) .. (sOpts.Suffix or "")
                    if sOpts.Callback then sOpts.Callback(val) end
                end
                
                SliderBg.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        sliding = true
                        update(input)
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        sliding = false
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        update(input)
                    end
                end)
                UpdateCanvas()
            end

            function Tab:CreateColorPicker(cOpts)
                local ColFrame = Instance.new("Frame")
                ColFrame.Parent = Page
                ColFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                ColFrame.Size = UDim2.new(1, 0, 0, 35)
                ColFrame.ClipsDescendants = true
                
                local ColCorner = Instance.new("UICorner")
                ColCorner.CornerRadius = UDim.new(0, 6)
                ColCorner.Parent = ColFrame
                
                local Label = Instance.new("TextLabel")
                Label.Parent = ColFrame
                Label.BackgroundTransparency = 1
                Label.Position = UDim2.new(0, 10, 0, 0)
                Label.Size = UDim2.new(1, -50, 0, 35)
                Label.Font = Enum.Font.Gotham
                Label.Text = cOpts.Name
                Label.TextColor3 = Color3.fromRGB(255, 255, 255)
                Label.TextSize = 14
                Label.TextXAlignment = Enum.TextXAlignment.Left
                
                local ColorDispBtn = Instance.new("TextButton")
                ColorDispBtn.Parent = ColFrame
                ColorDispBtn.BackgroundColor3 = cOpts.Color or Color3.fromRGB(255, 255, 255)
                ColorDispBtn.Position = UDim2.new(1, -35, 0, 7)
                ColorDispBtn.Size = UDim2.new(0, 20, 0, 20)
                ColorDispBtn.Text = ""
                
                local DispCorner = Instance.new("UICorner")
                DispCorner.CornerRadius = UDim.new(0, 4)
                DispCorner.Parent = ColorDispBtn
                
                local currentR, currentG, currentB = ColorDispBtn.BackgroundColor3.R, ColorDispBtn.BackgroundColor3.G, ColorDispBtn.BackgroundColor3.B
                
                local function CreateRGBSlider(name, yPos, color, initVal)
                    local SLabel = Instance.new("TextLabel", ColFrame)
                    SLabel.BackgroundTransparency = 1
                    SLabel.Position = UDim2.new(0, 10, 0, yPos)
                    SLabel.Size = UDim2.new(0, 15, 0, 20)
                    SLabel.Font = Enum.Font.GothamBold
                    SLabel.Text = name
                    SLabel.TextColor3 = color
                    SLabel.TextSize = 12
                    
                    local SBg = Instance.new("TextButton", ColFrame)
                    SBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    SBg.Position = UDim2.new(0, 35, 0, yPos + 6)
                    SBg.Size = UDim2.new(1, -45, 0, 8)
                    SBg.Text = ""
                    Instance.new("UICorner", SBg).CornerRadius = UDim.new(1, 0)
                    
                    local SFill = Instance.new("Frame", SBg)
                    SFill.BackgroundColor3 = color
                    SFill.Size = UDim2.new(initVal, 0, 1, 0)
                    Instance.new("UICorner", SFill).CornerRadius = UDim.new(1, 0)
                    
                    return SBg, SFill
                end
                
                local rBg, rFill = CreateRGBSlider("R", 40, Color3.fromRGB(255, 50, 50), currentR)
                local gBg, gFill = CreateRGBSlider("G", 65, Color3.fromRGB(50, 255, 50), currentG)
                local bBg, bFill = CreateRGBSlider("B", 90, Color3.fromRGB(50, 100, 255), currentB)
                
                local function updateColor()
                    local newCol = Color3.new(currentR, currentG, currentB)
                    ColorDispBtn.BackgroundColor3 = newCol
                    if cOpts.Callback then cOpts.Callback(newCol) end
                end
                
                local function hookSlider(bg, fill, component)
                    local sliding = false
                    bg.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            sliding = true
                            local pos = math.clamp((input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
                            fill.Size = UDim2.new(pos, 0, 1, 0)
                            if component == "R" then currentR = pos
                            elseif component == "G" then currentG = pos
                            elseif component == "B" then currentB = pos end
                            updateColor()
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then sliding = false end
                    end)
                    UserInputService.InputChanged:Connect(function(input)
                        if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                            local pos = math.clamp((input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X, 0, 1)
                            fill.Size = UDim2.new(pos, 0, 1, 0)
                            if component == "R" then currentR = pos
                            elseif component == "G" then currentG = pos
                            elseif component == "B" then currentB = pos end
                            updateColor()
                        end
                    end)
                end
                
                hookSlider(rBg, rFill, "R")
                hookSlider(gBg, gFill, "G")
                hookSlider(bBg, bFill, "B")
                
                local expanded = false
                ColorDispBtn.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    TweenService:Create(ColFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, expanded and 120 or 35)}):Play()
                    for i = 1, 15 do
                        task.wait(0.02)
                        UpdateCanvas()
                    end
                end)
                
                if cOpts.Callback then task.spawn(function() cOpts.Callback(ColorDispBtn.BackgroundColor3) end) end
                UpdateCanvas()
            end

            function Tab:CreateDropdown(dOpts)
                local DdFrame = Instance.new("Frame")
                DdFrame.Parent = Page
                DdFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                DdFrame.Size = UDim2.new(1, 0, 0, 35)
                
                local DdCorner = Instance.new("UICorner")
                DdCorner.CornerRadius = UDim.new(0, 6)
                DdCorner.Parent = DdFrame
                
                local Btn = Instance.new("TextButton")
                Btn.Parent = DdFrame
                Btn.BackgroundTransparency = 1
                Btn.Position = UDim2.new(0, 10, 0, 0)
                Btn.Size = UDim2.new(1, -20, 1, 0)
                Btn.Font = Enum.Font.Gotham
                
                local currentIdx = 1
                local initialOption = dOpts.CurrentOption and dOpts.CurrentOption[1] or dOpts.Options[1]
                for i, opt in ipairs(dOpts.Options) do
                    if opt == initialOption then
                        currentIdx = i
                        break
                    end
                end
                
                Btn.Text = dOpts.Name .. " [" .. dOpts.Options[currentIdx] .. "]"
                Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                Btn.TextSize = 14
                Btn.TextXAlignment = Enum.TextXAlignment.Left
                
                Btn.MouseButton1Click:Connect(function()
                    currentIdx = currentIdx + 1
                    if currentIdx > #dOpts.Options then
                        currentIdx = 1
                    end
                    local selected = dOpts.Options[currentIdx]
                    dOpts.CurrentOption = {selected}
                    Btn.Text = dOpts.Name .. " [" .. selected .. "]"
                    if dOpts.Callback then dOpts.Callback({selected}) end
                end)
                UpdateCanvas()
            end

            return Tab
        end

        local UIVisible = true
        UserInputService.InputBegan:Connect(function(input, gp)
            if not gp and input.KeyCode == Enum.KeyCode[options.ToggleUIKeybind or "RightShift"] then
                UIVisible = not UIVisible
                MainFrame.Visible = UIVisible
            end
        end)
        
        if UserInputService.TouchEnabled then
            local MobileToggle = Instance.new("TextButton")
            MobileToggle.Parent = ScreenGui
            MobileToggle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            MobileToggle.Position = UDim2.new(0, 50, 0, 50)
            MobileToggle.Size = UDim2.new(0, 45, 0, 45)
            MobileToggle.Font = Enum.Font.GothamBold
            MobileToggle.Text = "Ocel"
            MobileToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            MobileToggle.TextSize = 14
            
            local MTCorner = Instance.new("UICorner")
            MTCorner.CornerRadius = UDim.new(0.5, 0)
            MTCorner.Parent = MobileToggle
            
            local MTStroke = Instance.new("UIStroke")
            MTStroke.Color = Color3.fromRGB(0, 110, 255)
            MTStroke.Thickness = 2
            MTStroke.Parent = MobileToggle
            
            local dragging = false
            local dragStart = nil
            local startPos = nil

            MobileToggle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = MobileToggle.Position
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local delta = input.Position - dragStart
                    MobileToggle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            MobileToggle.MouseButton1Click:Connect(function()
                UIVisible = not UIVisible
                MainFrame.Visible = UIVisible
            end)
        end
        
        function Window:Notify(nOpts)
            print("[Ocel-hub]:", nOpts.Title, "-", nOpts.Content)
        end

        return Window
    end

    function OcelUI:Destroy()
        if CoreGui then
            local old = CoreGui:FindFirstChild("OcelLocalUI")
            if old then old:Destroy() end
        end
    end

    return OcelUI
end)()

-- Create MainWindow
local Window = v0:CreateWindow({
    Name = "🌟 Ocel-hub 🌟",
    ToggleUIKeybind = "RightShift"
})

----------------------------------------------------------------
-- 1. ESP Tab (Big Head controls)
----------------------------------------------------------------
local ESPTab = Window:CreateTab("ESP", nil)
ESPTab:CreateSection("Big Head")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

local HeadSizeEnabled = false
local headScale = Vector3.new(2, 2, 2)
local headTransparency = 0
local originalHeadStats = {}

local function updateHead(character)
    local head = character:FindFirstChild("Head")
    if head and head:IsA("BasePart") then
        if HeadSizeEnabled then
            if not originalHeadStats[head] then
                originalHeadStats[head] = {
                    Size = head.Size, 
                    Transparency = head.Transparency
                }
            end
            head.Size = headScale
            head.Transparency = headTransparency
        elseif originalHeadStats[head] then
            head.Size = originalHeadStats[head].Size
            head.Transparency = originalHeadStats[head].Transparency
            originalHeadStats[head] = nil
        end
    end
end

RunService.RenderStepped:Connect(function()
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("Model") and child ~= localPlayer.Character then
            updateHead(child)
        end
    end
end)

ESPTab:CreateToggle({
    Name = "Big Head", 
    CurrentValue = false, 
    Flag = "HeadToggle", 
    Callback = function(state)
        HeadSizeEnabled = state
        if not state then
            for head, stats in pairs(originalHeadStats) do
                if head and head.Parent then
                    head.Size = stats.Size
                    head.Transparency = stats.Transparency
                end
            end
            originalHeadStats = {}
        end
    end
})

ESPTab:CreateSlider({
    Name = "Head Size", 
    Range = {1, 10}, 
    Increment = 1, 
    Suffix = "x", 
    CurrentValue = 2, 
    Flag = "HeadSizeSlider", 
    Callback = function(val)
        headScale = Vector3.new(val, val, val)
    end
})

ESPTab:CreateSlider({
    Name = "Head Transparency", 
    Range = {0, 1}, 
    Increment = 0.1, 
    CurrentValue = 0, 
    Flag = "HeadTransparencySlider", 
    Callback = function(val)
        headTransparency = val
    end
})

----------------------------------------------------------------
-- 2. Chams Tab (Hand and Weapon Chams)
----------------------------------------------------------------
local ChamsTab = Window:CreateTab("Chams", nil)
ChamsTab:CreateSection("Hand Chams")

local handMaterial = "Default"
local handColor = Color3.fromRGB(255, 255, 255)
local handParts = {}
local originalHandMaterials = {}

local function findHandParts()
    handParts = {}
    local paths = {
        {"Const", "Ignore", "FPSArms", "RightHand"},
        {"Const", "Ignore", "FPSArms", "RightLowerArm"},
        {"Const", "Ignore", "FPSArms", "LeftLowerArm"},
        {"Const", "Ignore", "FPSArms", "LeftHand"},
        {"Const", "Ignore", "FPSArms", "Fake", "c_RightLowerArm"},
        {"Const", "Ignore", "FPSArms", "Fake", "c_LeftLowerArm"}
    }
    for _, path in ipairs(paths) do
        local part = workspace
        for _, pName in ipairs(path) do
            if part then
                part = part:FindFirstChild(pName)
            end
        end
        if part and part:IsA("BasePart") then
            table.insert(handParts, part)
            if not originalHandMaterials[part] then
                originalHandMaterials[part] = part.Material
            end
        end
    end
end

local function applyHandMaterial(materialName)
    handMaterial = materialName
    if materialName == "Default" then
        for _, part in ipairs(handParts) do
            if part and part.Parent then
                part.Material = originalHandMaterials[part] or Enum.Material.Plastic
            end
        end
    else
        local success, result = pcall(function() return Enum.Material[materialName] end)
        if success and result then
            for _, part in ipairs(handParts) do
                if part and part.Parent then
                    part.Material = result
                end
            end
        else
            for _, part in ipairs(handParts) do
                if part and part.Parent then
                    pcall(function() part.MaterialVariant = materialName end)
                end
            end
        end
    end
end

ChamsTab:CreateDropdown({
    Name = "Hand Material", 
    Options = {"Default", "ForceField", "Neon", "Asphalt"}, 
    CurrentOption = {"Default"}, 
    MultipleOptions = false, 
    Flag = "Dropdown_HandMaterial", 
    Callback = function(option)
        local opt = type(option) == "table" and option[1] or option
        findHandParts()
        applyHandMaterial(opt)
    end
})

ChamsTab:CreateColorPicker({
    Name = "Hand Cham Color", 
    Color = Color3.fromRGB(255, 255, 255), 
    Flag = "ColorPicker_Hand", 
    Callback = function(col)
        handColor = col
        for _, part in ipairs(handParts) do
            if part and part.Parent then
                part.Color = col
            end
        end
    end
})

task.spawn(function()
    while true do
        findHandParts()
        applyHandMaterial(handMaterial)
        for _, part in ipairs(handParts) do
            if part and part.Parent then
                part.Color = handColor
            end
        end
        task.wait(0.1)
    end
end)

ChamsTab:CreateSection("Weapon Chams")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local handModels = ReplicatedStorage:WaitForChild("HandModels")
local weaponParts = {}
local originalWeaponMaterials = {}
local weaponMaterial = "Default"
local weaponColor = Color3.fromRGB(255, 255, 255)

local function getBaseParts(instance)
    local parts = {}
    local originalMats = {}
    local function traverse(obj)
        if obj:IsA("BasePart") then
            table.insert(parts, obj)
            originalMats[obj] = obj.Material
        end
        for _, child in ipairs(obj:GetChildren()) do
            traverse(child)
        end
    end
    traverse(instance)
    return parts, originalMats
end

local function scanWeaponModels()
    weaponParts = {}
    for _, model in ipairs(handModels:GetChildren()) do
        local parts, originalMats = getBaseParts(model)
        weaponParts[model] = parts
        for part, mat in pairs(originalMats) do
            if not originalWeaponMaterials[part] then
                originalWeaponMaterials[part] = mat
            end
        end
    end
end

local function applyWeaponMaterial(materialName)
    weaponMaterial = materialName
    if materialName == "Default" then
        for _, parts in pairs(weaponParts) do
            for _, part in ipairs(parts) do
                if part and part.Parent then
                    part.Material = originalWeaponMaterials[part] or Enum.Material.Plastic
                end
            end
        end
    else
        local success, result = pcall(function() return Enum.Material[materialName] end)
        if success and result then
            for _, parts in pairs(weaponParts) do
                for _, part in ipairs(parts) do
                    if part and part.Parent then
                        part.Material = result
                    end
                end
            end
        else
            for _, parts in pairs(weaponParts) do
                for _, part in ipairs(parts) do
                    if part and part.Parent then
                        pcall(function() part.MaterialVariant = materialName end)
                    end
                end
            end
        end
    end
end

local function applyWeaponColor(color)
    weaponColor = color
    for _, parts in pairs(weaponParts) do
        for _, part in ipairs(parts) do
            if part and part.Parent then
                part.Color = color
            end
        end
    end
end

scanWeaponModels()

handModels.ChildAdded:Connect(function()
    task.wait(0.5)
    scanWeaponModels()
    applyWeaponMaterial(weaponMaterial)
    applyWeaponColor(weaponColor)
end)

ChamsTab:CreateDropdown({
    Name = "Weapon Material", 
    Options = {"Default", "ForceField", "Neon", "Asphalt"}, 
    CurrentOption = {"Default"}, 
    MultipleOptions = false, 
    Flag = "Dropdown_WeaponMaterial", 
    Callback = function(option)
        local opt = type(option) == "table" and option[1] or option
        scanWeaponModels()
        applyWeaponMaterial(opt)
    end
})

ChamsTab:CreateColorPicker({
    Name = "Weapon Cham Color", 
    Color = Color3.fromRGB(255, 255, 255), 
    Flag = "ColorPicker_Weapon", 
    Callback = function(col)
        applyWeaponColor(col)
    end
})

----------------------------------------------------------------
-- 3. Sky Tab (Skybox Changer & Cloud Color)
----------------------------------------------------------------
local SkyTab = Window:CreateTab("Sky", nil)
SkyTab:CreateSection("Sky Settings")

local Lighting = game:GetService("Lighting")

local function applySky(skyName)
    for _, child in ipairs(Lighting:GetChildren()) do
        if child:IsA("Sky") then
            child:Destroy()
        end
    end
    if skyName == "Defalt" or skyName == "Default" then
        return
    end
    
    local skyboxes = {
        Magma = "rbxassetid://16468735533", 
        Water = "rbxassetid://17253866105", 
        Obsidian = "rbxassetid://17253878595", 
        Galaxy = "rbxassetid://13726625670", 
        Void = "rbxassetid://16666915143"
    }
    local assetId = skyboxes[skyName]
    if assetId then
        local sky = Instance.new("Sky")
        sky.Name = "ExecutorSky"
        sky.SkyboxBk = assetId
        sky.SkyboxDn = assetId
        sky.SkyboxFt = assetId
        sky.SkyboxLf = assetId
        sky.SkyboxRt = assetId
        sky.SkyboxUp = assetId
        sky.Parent = Lighting
    end
end

SkyTab:CreateDropdown({
    Name = "Sky Changer", 
    Options = {"Default", "Magma", "Water", "Obsidian", "Galaxy", "Void"}, 
    CurrentOption = {"Default"}, 
    MultipleOptions = false, 
    Flag = "Dropdown_SkyChanger", 
    Callback = function(option)
        local opt = type(option) == "table" and option[1] or option
        applySky(opt)
    end
})

SkyTab:CreateColorPicker({
    Name = "Clouds Color", 
    Color = Color3.fromRGB(255, 255, 255), 
    Flag = "ColorPicker_Clouds", 
    Callback = function(col)
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            local clouds = terrain:FindFirstChildOfClass("Clouds")
            if clouds then
                clouds.Color = col
            end
        end
    end
})
