--[[
	Aimbot & Silent Aim Only Menu
]]
Players = game:GetService("Players");
RunService = game:GetService("RunService");
localPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait();
camera = workspace.CurrentCamera;
Workspace = game:GetService("Workspace");

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
    local connections = {}
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
    local c1 = Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    local c2 = Topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    local c3 = UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    table.insert(connections, c1)
    table.insert(connections, c2)
    table.insert(connections, c3)

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
        TabButton.TextSize = 14
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        
        local Page = Instance.new("ScrollingFrame")
        Page.Name = name .. "Page"
        Page.Parent = ContentContainer
        Page.Active = true
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.ScrollBarThickness = 2
        Page.Visible = false
        
        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Parent = Page
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 8)
        
        local PagePadding = Instance.new("UIPadding")
        PagePadding.Parent = Page
        PagePadding.PaddingLeft = UDim.new(0, 10)
        PagePadding.PaddingRight = UDim.new(0, 10)
        PagePadding.PaddingTop = UDim.new(0, 10)
        
        local function UpdateCanvas()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 20)
        end
        
        PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvas)
        
        if FirstTab then
            FirstTab = false
            TabButton.TextColor3 = Color3.fromRGB(0, 110, 255)
            Page.Visible = true
        end
        
        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do
                t.Button.TextColor3 = Color3.fromRGB(180, 180, 180)
                t.Page.Visible = false
            end
            TabButton.TextColor3 = Color3.fromRGB(0, 110, 255)
            Page.Visible = true
        end)
        
        table.insert(Tabs, {Button = TabButton, Page = Page})
        
        function Tab:CreateSection(secName)
            local SecFrame = Instance.new("Frame")
            SecFrame.Parent = Page
            SecFrame.BackgroundTransparency = 1
            SecFrame.Size = UDim2.new(1, 0, 0, 25)
            
            local SecLabel = Instance.new("TextLabel")
            SecLabel.Parent = SecFrame
            SecLabel.BackgroundTransparency = 1
            SecLabel.Size = UDim2.new(1, 0, 1, 0)
            SecLabel.Font = Enum.Font.GothamBold
            SecLabel.Text = secName
            SecLabel.TextColor3 = Color3.fromRGB(0, 110, 255)
            SecLabel.TextSize = 13
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
            Label.Size = UDim2.new(1, -60, 1, 0)
            Label.Font = Enum.Font.Gotham
            Label.Text = tOpts.Name
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Parent = TogFrame
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ToggleBtn.Position = UDim2.new(1, -45, 0.5, -10)
            ToggleBtn.Size = UDim2.new(0, 35, 0, 20)
            ToggleBtn.Text = ""
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(1, 0)
            BtnCorner.Parent = ToggleBtn
            
            local Circle = Instance.new("Frame")
            Circle.Parent = ToggleBtn
            Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Circle.Position = UDim2.new(0, 2, 0.5, -8)
            Circle.Size = UDim2.new(0, 16, 0, 16)
            
            local CirCorner = Instance.new("UICorner")
            CirCorner.CornerRadius = UDim.new(1, 0)
            CirCorner.Parent = Circle
            
            local State = tOpts.CurrentValue or false
            local function UpdateVisuals()
                if State then
                    TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 110, 255)}):Play()
                    TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
                else
                    TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                    TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
                end
            end
            UpdateVisuals()
            
            ToggleBtn.MouseButton1Click:Connect(function()
                State = not State
                UpdateVisuals()
                if tOpts.Callback then tOpts.Callback(State) end
            end)
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
            local sliderEnded = UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sliding = false
                end
            end)
            table.insert(connections, sliderEnded)
            UpdateCanvas()
        end

        function Tab:CreateDropdown(dOpts)
            local DdFrame = Instance.new("Frame")
            DdFrame.Parent = Page
            DdFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            DdFrame.Size = UDim2.new(1, 0, 0, 35)
            DdFrame.ClipsDescendants = true
            
            local DdCorner = Instance.new("UICorner")
            DdCorner.CornerRadius = UDim.new(0, 6)
            DdCorner.Parent = DdFrame
            
            local OpenBtn = Instance.new("TextButton")
            OpenBtn.Parent = DdFrame
            OpenBtn.BackgroundTransparency = 1
            OpenBtn.Size = UDim2.new(1, 0, 0, 35)
            OpenBtn.Font = Enum.Font.Gotham
            OpenBtn.Text = ""
            
            local Label = Instance.new("TextLabel")
            Label.Parent = DdFrame
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Size = UDim2.new(1, -20, 0, 35)
            Label.Font = Enum.Font.Gotham
            Label.Text = dOpts.Name .. " [" .. (dOpts.CurrentOption and dOpts.CurrentOption[1] or "...") .. "]"
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            local OptionsContainer = Instance.new("Frame")
            OptionsContainer.Name = "OptionsContainer"
            OptionsContainer.Parent = DdFrame
            OptionsContainer.BackgroundTransparency = 1
            OptionsContainer.Position = UDim2.new(0, 10, 0, 35)
            OptionsContainer.Size = UDim2.new(1, -20, 0, #dOpts.Options * 25)
            
            local OptionsLayout = Instance.new("UIListLayout")
            OptionsLayout.Parent = OptionsContainer
            OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
            OptionsLayout.Padding = UDim.new(0, 2)
            
            local currentSelected = dOpts.CurrentOption and dOpts.CurrentOption[1] or ""
            local expanded = false
            
            local function updateLabel(val)
                Label.Text = dOpts.Name .. " [" .. val .. "]"
            end
            
            local dropdownObj = {
                CurrentOption = {currentSelected}
            }
            
            local function selectOption(val)
                currentSelected = val
                dropdownObj.CurrentOption[1] = val
                updateLabel(val)
                if dOpts.Callback then
                    task.spawn(function()
                        dOpts.Callback({val})
                    end)
                end
            end
            
            for i, opt in ipairs(dOpts.Options) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Name = opt
                OptBtn.Parent = OptionsContainer
                OptBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                OptBtn.Size = UDim2.new(1, 0, 0, 22)
                OptBtn.Font = Enum.Font.Gotham
                OptBtn.Text = opt
                OptBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
                OptBtn.TextSize = 12
                
                local OptCorner = Instance.new("UICorner")
                OptCorner.CornerRadius = UDim.new(0, 4)
                OptCorner.Parent = OptBtn
                
                OptBtn.MouseButton1Click:Connect(function()
                    selectOption(opt)
                    expanded = false
                    TweenService:Create(DdFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 35)}):Play()
                    for k = 1, 15 do
                        task.wait(0.02)
                        UpdateCanvas()
                    end
                end)
            end
            
            OpenBtn.MouseButton1Click:Connect(function()
                expanded = not expanded
                if expanded then
                    TweenService:Create(DdFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 35 + (#dOpts.Options * 25) + 10)}):Play()
                else
                    TweenService:Create(DdFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 35)}):Play()
                end
                for k = 1, 15 do
                    task.wait(0.02)
                    UpdateCanvas()
                end
            end)
            UpdateCanvas()
            return dropdownObj
        end
        
        function Tab:CreateColorPicker(cOpts)
            local CpFrame = Instance.new("Frame")
            CpFrame.Parent = Page
            CpFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            CpFrame.Size = UDim2.new(1, 0, 0, 35)
            
            local CpCorner = Instance.new("UICorner")
            CpCorner.CornerRadius = UDim.new(0, 6)
            CpCorner.Parent = CpFrame
            
            local Label = Instance.new("TextLabel")
            Label.Parent = CpFrame
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.Size = UDim2.new(1, -60, 1, 0)
            Label.Font = Enum.Font.Gotham
            Label.Text = cOpts.Name
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            local ColorDispBtn = Instance.new("TextButton")
            ColorDispBtn.Parent = CpFrame
            ColorDispBtn.BackgroundColor3 = cOpts.Color or Color3.fromRGB(255, 255, 255)
            ColorDispBtn.Position = UDim2.new(1, -45, 0.5, -10)
            ColorDispBtn.Size = UDim2.new(0, 35, 0, 20)
            ColorDispBtn.Text = ""
            
            local DispCorner = Instance.new("UICorner")
            DispCorner.CornerRadius = UDim.new(0, 4)
            DispCorner.Parent = ColorDispBtn
            
            ColorDispBtn.MouseButton1Click:Connect(function()
                local newCol = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
                ColorDispBtn.BackgroundColor3 = newCol
                if cOpts.Callback then cOpts.Callback(newCol) end
            end)
            UpdateCanvas()
        end
        
        function Tab:CreateButton(bOpts)
            local BtnFrame = Instance.new("Frame")
            BtnFrame.Parent = Page
            BtnFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            BtnFrame.Size = UDim2.new(1, 0, 0, 35)
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = BtnFrame
            
            local Button = Instance.new("TextButton")
            Button.Parent = BtnFrame
            Button.BackgroundTransparency = 1
            Button.Size = UDim2.new(1, 0, 1, 0)
            Button.Font = Enum.Font.GothamSemibold
            Button.Text = bOpts.Name
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 14
            
            Button.MouseButton1Click:Connect(function()
                if bOpts.Callback then bOpts.Callback() end
            end)
            UpdateCanvas()
        end
        
        return Tab
    end
    
    local UIVisible = true
    local toggleConnection = UserInputService.InputBegan:Connect(function(input, gp)
        if not gp and input.KeyCode == Enum.KeyCode[options.ToggleUIKeybind or "RightShift"] then
            UIVisible = not UIVisible
            MainFrame.Visible = UIVisible
        end
    end)
    table.insert(connections, toggleConnection)
    
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

        local m1 = MobileToggle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = MobileToggle.Position
            end
        end)

        local m2 = UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                MobileToggle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)

        local m3 = UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
        
        local m4 = MobileToggle.MouseButton1Click:Connect(function()
            UIVisible = not UIVisible
            MainFrame.Visible = UIVisible
        end)
        table.insert(connections, m1)
        table.insert(connections, m2)
        table.insert(connections, m3)
        table.insert(connections, m4)
    end
    
    function Window:Destroy()
        for _, conn in ipairs(connections) do
            if conn then
                pcall(function() conn:Disconnect() end)
            end
        end
        ScreenGui:Destroy()
    end
    
    function Window:Notify(nOpts)
        print("[Ocel-hub]:", nOpts.Title, "-", nOpts.Content)
    end

    return Window
end

return OcelUI
end)()

local l_v0_Window_0 = v0:CreateWindow({
    Name = "🌟 Ocel Aimbot 🌟",
    ToggleUIKeybind = "RightShift", 
});

local l_l_v0_Window_0_Tab_0 = l_v0_Window_0:CreateTab("AimBot", nil);

-- ================= AIMBOT & SILENT AIM SYSTEM =================
_G.AimbotEnabled = true
_G.AimbotKey = "Left Click"
_G.AimbotSmoothness = 0.1
_G.AimbotFOV = 100
_G.AimbotTargetPart = "Head"
_G.AimbotShowFOV = false
_G.AimbotFOVColor = Color3.fromRGB(255, 255, 255)

_G.SilentAimEnabled = true
_G.SilentAimFOV = 150

_G.AimbotTargetPlayers = true
_G.AimbotTargetBots = true
_G.AimbotVisibleCheck = true

local fovCircle = nil
pcall(function()
    if Drawing and Drawing.new then
        local circle = Drawing.new("Circle")
        circle.Thickness = 1.5
        circle.NumSides = 64
        circle.Filled = false
        circle.Color = _G.AimbotFOVColor
        circle.Visible = false
        fovCircle = circle
    end
end)

local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")

-- Touch tracking for mobile/tablet devices
local isTouchingScreen = false
touchStartedConnection = uis.TouchStarted:Connect(function()
    isTouchingScreen = true
end)
touchEndedConnection = uis.TouchEnded:Connect(function()
    isTouchingScreen = false
end)

local function isKeyHeld(keyChoice)
    if not keyChoice or keyChoice == "None" then return true end
    local pressed = false
    pcall(function()
        if keyChoice == "Right Click" then
            pressed = uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
        elseif keyChoice == "Left Click" then
            pressed = uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or #uis:GetTouches() > 0 or isTouchingScreen
        elseif keyChoice == "Shift" then
            pressed = uis:IsKeyDown(Enum.KeyCode.LeftShift)
        else
            local success, keyCode = pcall(function() return Enum.KeyCode[keyChoice] end)
            if success and keyCode then
                pressed = uis:IsKeyDown(keyCode)
            end
        end
    end)
    return pressed
end

local function isTargetAlive(model)
    if not model or not model.Parent then return false end
    local head = model:FindFirstChild("Head")
    local torso = model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso") or model:FindFirstChild("LowerTorso")
    if not head or not torso then return false end
    
    -- Player vs Bot check
    local isPlayer = false
    local checkTorso = model:FindFirstChild("Torso")
    if checkTorso and checkTorso:FindFirstChild("LeftBooster") then
        isPlayer = true
    end
    
    if isPlayer and not _G.AimbotTargetPlayers then return false end
    if not isPlayer and not _G.AimbotTargetBots then return false end
    
    -- Sleeper Check
    local lowerTorso = model:FindFirstChild("LowerTorso")
    if lowerTorso then
        local rootRig = lowerTorso:FindFirstChild("RootRig")
        if rootRig and typeof(rootRig.CurrentAngle) == "number" and rootRig.CurrentAngle ~= 0 then
            return false
        end
    end
    return true
end

local touchStartedConnection = nil
local touchEndedConnection = nil
local fovConnection = nil

local originalGetX = nil
local originalGetY = nil
local originalSendTCP = nil
local originalCreateProjectile = nil

local function isVisible(part, targetModel)
    if not _G.AimbotVisibleCheck then return true end
    local camera = workspace.CurrentCamera
    local origin = camera.CFrame.Position
    local direction = part.Position - origin
    
    local raycastParams = RaycastParams.new()
    local filter = { targetModel }
    if workspace:FindFirstChild("Const") and workspace.Const:FindFirstChild("Ignore") then
        table.insert(filter, workspace.Const.Ignore)
    end
    if game:GetService("Players").LocalPlayer.Character then
        table.insert(filter, game:GetService("Players").LocalPlayer.Character)
    end
    raycastParams.FilterDescendantsInstances = filter
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.IgnoreWater = true
    
    local raycastResult = workspace:Raycast(origin, direction, raycastParams)
    if raycastResult then
        return false -- Something is blocking
    end
    return true -- Visible
end

local function unload()
    -- Disconnect Touch events
    if touchStartedConnection then
        pcall(function() touchStartedConnection:Disconnect() end)
    end
    if touchEndedConnection then
        pcall(function() touchEndedConnection:Disconnect() end)
    end
    
    -- Disconnect RenderStepped FOV connection
    if fovConnection then
        pcall(function() fovConnection:Disconnect() end)
    end
    
    -- Unbind RenderStep AimbotUpdate
    pcall(function()
        rs:UnbindFromRenderStep("AimbotUpdate")
    end)
    
    -- Destroy FOV Circle
    if fovCircle then
        pcall(function() fovCircle:Remove() end)
    end
    
    -- Restore original functions
    pcall(function()
        if originalGetX and _G.classes and _G.classes.Camera then
            _G.classes.Camera.GetX = originalGetX
        end
        if originalGetY and _G.classes and _G.classes.Camera then
            _G.classes.Camera.GetY = originalGetY
        end
    end)
    
    pcall(function()
        if originalSendTCP and _G.classes and _G.classes.NetClient then
            _G.classes.NetClient.SendTCP = originalSendTCP
        end
    end)
    
    pcall(function()
        if originalCreateProjectile and _G.classes and _G.classes.RangedWeaponClient then
            _G.classes.RangedWeaponClient.CreateProjectile = originalCreateProjectile
        end
    end)
    
    -- Destroy window UI
    if l_v0_Window_0 then
        pcall(function() l_v0_Window_0:Destroy() end)
    end
end

local function getClosestTarget(maxFOV)
    local closestTarget = nil
    local shortestDistance = maxFOV
    
    local camera = workspace.CurrentCamera
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    
    for _, model in ipairs(workspace:GetChildren()) do
        if model:IsA("Model") and model ~= localPlayer.Character and isTargetAlive(model) then
            local aimPartName = _G.AimbotTargetPart or "Head"
            local part = model:FindFirstChild(aimPartName)
            if not part then
                part = model:FindFirstChild("Head") or model:FindFirstChild("Torso") or model:FindFirstChild("UpperTorso") or model:FindFirstChild("LowerTorso") or model.PrimaryPart
            end
            
            if part and isVisible(part, model) then
                local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestTarget = part
                    end
                end
            end
        end
    end
    return closestTarget
end

-- UI Setup
local _ = l_l_v0_Window_0_Tab_0:CreateSection("Aimbot Settings")

local _ = l_l_v0_Window_0_Tab_0:CreateToggle({
    Name = "Aimbot",
    CurrentValue = true,
    Callback = function(val)
        _G.AimbotEnabled = val
    end
})

local _ = l_l_v0_Window_0_Tab_0:CreateToggle({
    Name = "Visible Check (Wall Check)",
    CurrentValue = true,
    Callback = function(val)
        _G.AimbotVisibleCheck = val
    end
})

local _ = l_l_v0_Window_0_Tab_0:CreateToggle({
    Name = "Target Players",
    CurrentValue = true,
    Callback = function(val)
        _G.AimbotTargetPlayers = val
    end
})

local _ = l_l_v0_Window_0_Tab_0:CreateToggle({
    Name = "Target Bots",
    CurrentValue = true,
    Callback = function(val)
        _G.AimbotTargetBots = val
    end
})

local _ = l_l_v0_Window_0_Tab_0:CreateDropdown({
    Name = "Aimbot Keybind",
    Options = {"Right Click", "Left Click", "E", "Q", "C", "Shift", "None"},
    CurrentOption = {"Left Click"},
    MultipleOptions = false,
    Callback = function(val)
        local choice = type(val) == "table" and val[1] or val
        _G.AimbotKey = choice
    end
})

local _ = l_l_v0_Window_0_Tab_0:CreateSlider({
    Name = "Aimbot Smoothness",
    Range = {0.01, 1},
    Increment = 0.01,
    CurrentValue = 0.1,
    Callback = function(val)
        _G.AimbotSmoothness = val
    end
})

local _ = l_l_v0_Window_0_Tab_0:CreateSlider({
    Name = "Aimbot FOV",
    Range = {10, 800},
    Increment = 5,
    CurrentValue = 100,
    Callback = function(val)
        _G.AimbotFOV = val
    end
})

local _ = l_l_v0_Window_0_Tab_0:CreateSection("Silent Aim Settings")

local _ = l_l_v0_Window_0_Tab_0:CreateToggle({
    Name = "Silent Aim",
    CurrentValue = true,
    Callback = function(val)
        _G.SilentAimEnabled = val
    end
})

local _ = l_l_v0_Window_0_Tab_0:CreateSlider({
    Name = "Silent Aim FOV",
    Range = {10, 800},
    Increment = 5,
    CurrentValue = 150,
    Callback = function(val)
        _G.SilentAimFOV = val
    end
})

local _ = l_l_v0_Window_0_Tab_0:CreateSection("Visual Settings")

local _ = l_l_v0_Window_0_Tab_0:CreateToggle({
    Name = "Show FOV Circle",
    CurrentValue = false,
    Callback = function(val)
        _G.AimbotShowFOV = val
    end
})

local _ = l_l_v0_Window_0_Tab_0:CreateColorPicker({
    Name = "FOV Circle Color",
    Color = Color3.fromRGB(255, 255, 255),
    Callback = function(val)
        _G.AimbotFOVColor = val
    end
})

local _ = l_l_v0_Window_0_Tab_0:CreateDropdown({
    Name = "Target Part",
    Options = {"Head", "Torso"},
    CurrentOption = {"Head"},
    MultipleOptions = false,
    Callback = function(val)
        if type(val) == "table" then
            _G.AimbotTargetPart = val[1]
        else
            _G.AimbotTargetPart = val
        end
    end
})

-- State angles for camera hooks (GetX/GetY) to align character body
local aimbotAngleX = nil
local aimbotAngleY = nil

-- Regular Aimbot Loop (Priority.Camera + 5 to run after game's ThirdPerson script)
pcall(function()
    rs:BindToRenderStep("AimbotUpdate", Enum.RenderPriority.Camera.Value + 5, function()
        if not _G.AimbotEnabled or not isKeyHeld(_G.AimbotKey) then
            aimbotAngleX = nil
            aimbotAngleY = nil
            return
        end
        
        local targetPart = getClosestTarget(_G.AimbotFOV)
        if targetPart then
            local camera = workspace.CurrentCamera
            local targetPos = targetPart.Position
            local currentCF = camera.CFrame
            local targetCF = CFrame.new(currentCF.Position, targetPos)
            
            -- Lerp the camera to face target
            camera.CFrame = currentCF:Lerp(targetCF, _G.AimbotSmoothness or 0.15)
            
            -- Store angles for Character Body Rotation Hooks
            local rx, ry, rz = targetCF:ToOrientation()
            aimbotAngleX = rx
            aimbotAngleY = ry
        else
            aimbotAngleX = nil
            aimbotAngleY = nil
        end
    end)
end)

-- FOV Circle Loop
fovConnection = rs.RenderStepped:Connect(function()
    if fovCircle then
        if _G.AimbotShowFOV and (_G.AimbotEnabled or _G.SilentAimEnabled) then
            local camera = workspace.CurrentCamera
            local viewportSize = camera.ViewportSize
            fovCircle.Position = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
            fovCircle.Radius = _G.SilentAimEnabled and _G.SilentAimFOV or _G.AimbotFOV
            fovCircle.Color = _G.AimbotFOVColor
            fovCircle.Visible = true
        else
            fovCircle.Visible = false
        end
    end
end)

-- Hook CameraMod when Camera is available
task.spawn(function()
    while not (_G.classes and _G.classes.Camera) do
        task.wait(0.5)
    end
    local CameraMod = _G.classes.Camera
    pcall(function()
        if CameraMod and CameraMod.GetX then
            originalGetX = CameraMod.GetX
            CameraMod.GetX = function(...)
                if _G.AimbotEnabled and isKeyHeld(_G.AimbotKey) and aimbotAngleX then
                    return aimbotAngleX
                end
                return originalGetX(...)
            end
        end
        if CameraMod and CameraMod.GetY then
            originalGetY = CameraMod.GetY
            CameraMod.GetY = function(...)
                if _G.AimbotEnabled and isKeyHeld(_G.AimbotKey) and aimbotAngleY then
                    return aimbotAngleY
                end
                return originalGetY(...)
            end
        end
    end)
end)

-- Hook NetClient when NetClient is available
task.spawn(function()
    while not (_G.classes and _G.classes.NetClient) do
        task.wait(0.5)
    end
    local NetClient = _G.classes.NetClient
    pcall(function()
        if NetClient and NetClient.SendTCP then
            originalSendTCP = NetClient.SendTCP
            NetClient.SendTCP = function(...)
                local args = {...}
                pcall(function()
                    if _G.SilentAimEnabled then
                        local offset = (args[1] == NetClient) and 1 or 0
                        local action = args[2 + offset]
                        
                        if action == "Fire" then
                            local targetPart = getClosestTarget(_G.SilentAimFOV)
                            if targetPart then
                                local origCF = args[4 + offset]
                                if typeof(origCF) == "CFrame" then
                                    args[4 + offset] = CFrame.new(origCF.Position, targetPart.Position)
                                end
                            end
                        elseif action == "MultiFire" then
                            local targetPart = getClosestTarget(_G.SilentAimFOV)
                            if targetPart then
                                local t = args[3 + offset]
                                if type(t) == "table" then
                                    for _, item in ipairs(t) do
                                        if type(item) == "table" and typeof(item[1]) == "CFrame" then
                                            item[1] = CFrame.new(item[1].Position, targetPart.Position)
                                        end
                                    end
                                end
                            end
                        elseif action == "Throw" then
                            local targetPart = getClosestTarget(_G.SilentAimFOV)
                            if targetPart then
                                local origCF = args[3 + offset]
                                if typeof(origCF) == "CFrame" then
                                    args[3 + offset] = CFrame.new(origCF.Position, targetPart.Position)
                                end
                            end
                        end
                    end
                end)
                return originalSendTCP(unpack(args))
            end
        end
    end)
end)

-- Hook RangedWeaponClient when RangedWeaponClient is available
task.spawn(function()
    while not (_G.classes and _G.classes.RangedWeaponClient) do
        task.wait(0.5)
    end
    local RangedWeapon = _G.classes.RangedWeaponClient
    pcall(function()
        if RangedWeapon and RangedWeapon.CreateProjectile then
            originalCreateProjectile = RangedWeapon.CreateProjectile
            RangedWeapon.CreateProjectile = function(...)
                local args = {...}
                pcall(function()
                    if _G.SilentAimEnabled then
                        local offset = (args[1] == RangedWeapon) and 1 or 0
                        local cf = args[1 + offset]
                        local targetPart = getClosestTarget(_G.SilentAimFOV)
                        if targetPart and typeof(cf) == "CFrame" then
                            args[1 + offset] = CFrame.new(cf.Position, targetPart.Position)
                        end
                    end
                end)
                return originalCreateProjectile(unpack(args))
            end
        end
    end)
end)

-- Settings Tab (Unload/Accent)
local SettingsTab = l_v0_Window_0:CreateTab("Settings", nil)
SettingsTab:CreateSection("System")
SettingsTab:CreateButton({
    Name = "Unload Menu", 
    Callback = function()
        unload()
    end
})
