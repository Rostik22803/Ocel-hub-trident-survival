-- ================================================================
--  TRIDENT SURVIVAL — ESP + AIMBOT v3
--  100% Roblox UI — без Drawing API — работает везде
--  Мобильный + ПК
-- ================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local Cam = workspace.CurrentCamera
local MOBILE = UIS.TouchEnabled

-- ================================================================
--  НАСТРОЙКИ
-- ================================================================
local CFG = {
    ESP_Players  = true,
    ESP_NPCs     = true,
    ESP_Loot     = true,
    ESP_Resources= false,
    ESP_Vehicles = true,
    ESP_Danger   = true,

    Aimbot       = true,
    AimFOV       = 150,
    AimSmooth    = 0.2,
    AimPlayers   = true,
    AimNPCs      = true,
    ShowFOV      = true,
}

-- ================================================================
--  ТАБЛИЦЫ СУЩНОСТЕЙ
-- ================================================================
local NPC = {
    Ghoul           = {n="Ghoul",           c=Color3.fromRGB(120,255,50), hp=200},
    Soldier         = {n="Soldier",         c=Color3.fromRGB(255,165,0),  hp=125},
    Officer         = {n="Officer",         c=Color3.fromRGB(255,100,100),hp=150},
    General         = {n="General",         c=Color3.fromRGB(255,50,50),  hp=200},
    GasMaskSoldier  = {n="Gas Mask Soldier",c=Color3.fromRGB(255,220,0),  hp=150},
    LabWorker       = {n="Lab Worker",      c=Color3.fromRGB(180,180,255),hp=100},
    Merchant        = {n="Merchant",        c=Color3.fromRGB(100,255,255),hp=100},
    EventHelicopter = {n="Event Heli",      c=Color3.fromRGB(255,80,80),  hp=500},
}
local LOOT = {
    DroppedItem           ={n="Dropped Item",   c=Color3.fromRGB(255,255,80), md=300},
    SupplyDrop            ={n="Supply Drop",     c=Color3.fromRGB(255,50,255), md=1500},
    SupplyDrop2           ={n="Supply Drop",     c=Color3.fromRGB(255,50,255), md=1500},
    MetalCrate            ={n="Metal Crate",     c=Color3.fromRGB(200,200,255),md=400},
    TransportCrate        ={n="Transport Crate", c=Color3.fromRGB(255,150,50), md=400},
    LootSafe              ={n="Loot Safe",       c=Color3.fromRGB(255,215,0),  md=400},
    LootVaultDoor         ={n="Vault Door",      c=Color3.fromRGB(255,215,0),  md=300},
    LootVaultDoor2        ={n="Vault Door",      c=Color3.fromRGB(255,215,0),  md=300},
    LootVaultDoor3        ={n="Vault Door",      c=Color3.fromRGB(255,215,0),  md=300},
    ElectricLootVaultDoor ={n="Electric Vault",  c=Color3.fromRGB(200,255,80), md=300},
    ScrapBucket           ={n="Scrap Bucket",    c=Color3.fromRGB(180,180,180),md=300},
    PartsBox              ={n="Parts Box",       c=Color3.fromRGB(150,200,255),md=300},
}
local RES = {
    IronOre   ={n="Iron Ore",   c=Color3.fromRGB(210,210,210)},
    NitrateOre={n="Nitrate Ore",c=Color3.fromRGB(255,255,200)},
    StoneOre  ={n="Stone Ore",  c=Color3.fromRGB(160,160,160)},
    Tree1     ={n="Tree",       c=Color3.fromRGB(50,200,50)},
    Tree2     ={n="Tree",       c=Color3.fromRGB(50,200,50)},
    Tree3     ={n="Tree",       c=Color3.fromRGB(50,200,50)},
    Tree4     ={n="Tree",       c=Color3.fromRGB(50,200,50)},
    BerryBush ={n="Berry Bush", c=Color3.fromRGB(200,50,200)},
    GasCan    ={n="Gas Can",    c=Color3.fromRGB(255,100,0)},
    Cactus1   ={n="Cactus",     c=Color3.fromRGB(0,180,0)},
    Cactus2   ={n="Cactus",     c=Color3.fromRGB(0,180,0)},
}
local VEH = {
    ATV       ={n="ATV",       c=Color3.fromRGB(0,200,255)},
    Boat      ={n="Boat",      c=Color3.fromRGB(50,150,255)},
    Helicopter={n="Helicopter",c=Color3.fromRGB(100,200,255)},
    Trolly    ={n="Trolly",    c=Color3.fromRGB(0,200,255)},
}
local DNG = {
    BearTrap  ={n="Bear Trap",  c=Color3.fromRGB(255,0,0)},
    TeslaPylon={n="Tesla Pylon",c=Color3.fromRGB(255,255,0)},
    GasTrap   ={n="Gas Trap",   c=Color3.fromRGB(0,255,100)},
}

local function Classify(model)
    local nm = model.Name
    if NPC[nm]  then return "npc",  NPC[nm]  end
    if LOOT[nm] then return "loot", LOOT[nm] end
    if RES[nm]  then return "res",  RES[nm]  end
    if VEH[nm]  then return "veh",  VEH[nm]  end
    if DNG[nm]  then return "dng",  DNG[nm]  end
    return nil, nil
end

local function CatEnabled(cat)
    if cat == "npc"  then return CFG.ESP_NPCs end
    if cat == "loot" then return CFG.ESP_Loot end
    if cat == "res"  then return CFG.ESP_Resources end
    if cat == "veh"  then return CFG.ESP_Vehicles end
    if cat == "dng"  then return CFG.ESP_Danger end
    return false
end

local function CatMaxDist(cat, info)
    if info and info.md then return info.md end
    if cat == "npc"  then return 500 end
    if cat == "loot" then return 400 end
    if cat == "res"  then return 200 end
    if cat == "veh"  then return 600 end
    if cat == "dng"  then return 300 end
    return 400
end

local function CatIcon(cat)
    if cat == "npc"  then return "☠ " end
    if cat == "loot" then return "◆ " end
    if cat == "res"  then return "⛏ " end
    if cat == "veh"  then return "⊕ " end
    if cat == "dng"  then return "⚠ " end
    return ""
end

-- ================================================================
--  УТИЛИТЫ
-- ================================================================
local function MyRoot()
    local ch = LP.Character
    return ch and (ch:FindFirstChild("HumanoidRootPart") or ch.PrimaryPart)
end

local function GetPart(model, name)
    return model:FindFirstChild(name or "Head")
        or model:FindFirstChild("Head")
        or model:FindFirstChild("Torso")
        or model.PrimaryPart
        or model:FindFirstChildWhichIsA("BasePart")
end

-- ================================================================
--  CLEANUP OLD
-- ================================================================
if _G._TESP_CLEANUP then pcall(_G._TESP_CLEANUP) end

-- ================================================================
--  ГЛАВНЫЙ SCREENGUI
-- ================================================================
local SG = Instance.new("ScreenGui")
SG.Name = "TESP3"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.IgnoreGuiInset = false
SG.Parent = LP.PlayerGui

-- ================================================================
--  FOV CIRCLE (чистый UI — не Drawing!)
-- ================================================================
local FovFrame = Instance.new("Frame")
FovFrame.Name = "FOV"
FovFrame.AnchorPoint = Vector2.new(0.5, 0.5)
FovFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
FovFrame.Size = UDim2.new(0, CFG.AimFOV*2, 0, CFG.AimFOV*2)
FovFrame.BackgroundTransparency = 1
FovFrame.BorderSizePixel = 0
FovFrame.Parent = SG

local fovCorner = Instance.new("UICorner", FovFrame)
fovCorner.CornerRadius = UDim.new(0.5, 0)

local fovStroke = Instance.new("UIStroke", FovFrame)
fovStroke.Color = Color3.fromRGB(255, 255, 255)
fovStroke.Thickness = 1.5
fovStroke.Transparency = 0.4

-- ================================================================
--  ESP — BILLBOARDGUI (работает ВЕЗДЕ, через стены, на любом экзекуторе)
-- ================================================================
local Tracked = {} -- [model] = { bb=BillboardGui, lbl=TextLabel, hpBg=Frame, hpFill=Frame, hl=Highlight?, cat=str, info=tbl }

local function CreateESPTag(model, cat, info)
    if Tracked[model] then return end

    local part = GetPart(model)
    if not part then return end

    local color = info.c
    local maxDist = CatMaxDist(cat, info)

    -- BillboardGui
    local bb = Instance.new("BillboardGui")
    bb.Name = "_E"
    bb.AlwaysOnTop = true
    bb.Size = UDim2.new(0, 200, 0, 50)
    bb.StudsOffset = Vector3.new(0, 3.5, 0)
    bb.MaxDistance = maxDist
    bb.LightInfluence = 0
    bb.Adornee = part
    bb.Active = false

    -- Имя + дистанция
    local lbl = Instance.new("TextLabel")
    lbl.Name = "T"
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.Position = UDim2.new(0, 0, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = color
    lbl.TextStrokeTransparency = 0.3
    lbl.TextStrokeColor3 = Color3.new(0, 0, 0)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = MOBILE and 13 or 14
    lbl.Text = CatIcon(cat) .. info.n
    lbl.TextScaled = false
    lbl.Parent = bb

    -- HP бар (только для NPC)
    local hpBg, hpFill
    if cat == "npc" then
        hpBg = Instance.new("Frame")
        hpBg.Size = UDim2.new(0.5, 0, 0, MOBILE and 5 or 4)
        hpBg.Position = UDim2.new(0.25, 0, 0, 22)
        hpBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        hpBg.BorderSizePixel = 0
        hpBg.Parent = bb
        Instance.new("UICorner", hpBg).CornerRadius = UDim.new(0, 2)

        hpFill = Instance.new("Frame")
        hpFill.Size = UDim2.new(1, 0, 1, 0)
        hpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        hpFill.BorderSizePixel = 0
        hpFill.Parent = hpBg
        Instance.new("UICorner", hpFill).CornerRadius = UDim.new(0, 2)
    end

    bb.Parent = LP.PlayerGui

    -- Highlight (опционально, с pcall если не поддерживается)
    local hl = nil
    pcall(function()
        hl = Instance.new("Highlight")
        hl.FillTransparency = 0.75
        hl.OutlineTransparency = 0.1
        hl.OutlineColor3 = color
        hl.FillColor3 = color
        hl.Adornee = model
        hl.Parent = SG
    end)

    Tracked[model] = {
        bb = bb, lbl = lbl, hpBg = hpBg, hpFill = hpFill,
        hl = hl, cat = cat, info = info, part = part,
    }
end

local function RemoveESPTag(model)
    local t = Tracked[model]
    if not t then return end
    pcall(function() t.bb:Destroy() end)
    if t.hl then pcall(function() t.hl:Destroy() end) end
    Tracked[model] = nil
end

-- ================================================================
--  ESP ИГРОКОВ
-- ================================================================
local PlrTracked = {} -- [player] = { bb, lbl, hpBg, hpFill, hl }

local function CreatePlayerESP(plr)
    if plr == LP or PlrTracked[plr] then return end

    local function Setup()
        local ch = plr.Character
        if not ch then return end
        local root = ch:FindFirstChild("HumanoidRootPart") or ch.PrimaryPart
        if not root then return end

        -- Удалить старое если есть
        if PlrTracked[plr] then
            pcall(function() PlrTracked[plr].bb:Destroy() end)
            if PlrTracked[plr].hl then pcall(function() PlrTracked[plr].hl:Destroy() end) end
        end

        local bb = Instance.new("BillboardGui")
        bb.Name = "_P"
        bb.AlwaysOnTop = true
        bb.Size = UDim2.new(0, 220, 0, 60)
        bb.StudsOffset = Vector3.new(0, 3.5, 0)
        bb.MaxDistance = 1000
        bb.LightInfluence = 0
        bb.Adornee = root
        bb.Active = false

        -- Имя
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 0, 18)
        lbl.BackgroundTransparency = 1
        lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
        lbl.TextStrokeTransparency = 0.2
        lbl.TextStrokeColor3 = Color3.new(0, 0, 0)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = MOBILE and 14 or 15
        lbl.Text = plr.DisplayName
        lbl.Parent = bb

        -- HP бар
        local hpBg = Instance.new("Frame")
        hpBg.Size = UDim2.new(0.6, 0, 0, MOBILE and 5 or 4)
        hpBg.Position = UDim2.new(0.2, 0, 0, 20)
        hpBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        hpBg.BorderSizePixel = 0
        hpBg.Parent = bb
        Instance.new("UICorner", hpBg).CornerRadius = UDim.new(0, 2)

        local hpFill = Instance.new("Frame")
        hpFill.Size = UDim2.new(1, 0, 1, 0)
        hpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        hpFill.BorderSizePixel = 0
        hpFill.Parent = hpBg
        Instance.new("UICorner", hpFill).CornerRadius = UDim.new(0, 2)

        -- Дистанция
        local distLbl = Instance.new("TextLabel")
        distLbl.Size = UDim2.new(1, 0, 0, 14)
        distLbl.Position = UDim2.new(0, 0, 0, 27)
        distLbl.BackgroundTransparency = 1
        distLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
        distLbl.TextStrokeTransparency = 0.4
        distLbl.TextStrokeColor3 = Color3.new(0, 0, 0)
        distLbl.Font = Enum.Font.Gotham
        distLbl.TextSize = MOBILE and 11 or 12
        distLbl.Text = ""
        distLbl.Parent = bb

        bb.Parent = LP.PlayerGui

        -- Highlight
        local hl = nil
        pcall(function()
            hl = Instance.new("Highlight")
            hl.FillTransparency = 0.8
            hl.OutlineTransparency = 0
            hl.OutlineColor3 = Color3.fromRGB(255, 60, 60)
            hl.FillColor3 = Color3.fromRGB(255, 60, 60)
            hl.Adornee = ch
            hl.Parent = SG
        end)

        PlrTracked[plr] = {
            bb = bb, lbl = lbl, hpBg = hpBg, hpFill = hpFill,
            distLbl = distLbl, hl = hl, root = root,
        }
    end

    -- Подключить к текущему персонажу
    if plr.Character then task.spawn(Setup) end
    -- И к будущим
    plr.CharacterAdded:Connect(function()
        task.wait(0.5)
        Setup()
    end)
end

local function RemovePlayerESP(plr)
    local t = PlrTracked[plr]
    if not t then return end
    pcall(function() t.bb:Destroy() end)
    if t.hl then pcall(function() t.hl:Destroy() end) end
    PlrTracked[plr] = nil
end

-- Инициализация игроков
for _, p in ipairs(Players:GetPlayers()) do CreatePlayerESP(p) end
Players.PlayerAdded:Connect(CreatePlayerESP)
Players.PlayerRemoving:Connect(RemovePlayerESP)

-- ================================================================
--  СКАНЕР СУЩНОСТЕЙ
-- ================================================================
local function ScanWorld()
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("Model") and child ~= LP.Character then
            local cat, info = Classify(child)
            if cat and not Tracked[child] then
                CreateESPTag(child, cat, info)
            end
        end
    end

    -- Удалить мёртвые
    for model in pairs(Tracked) do
        if not model.Parent then
            RemoveESPTag(model)
        end
    end
end

ScanWorld()

workspace.ChildAdded:Connect(function(ch)
    if not ch:IsA("Model") then return end
    task.wait(0.2)
    local cat, info = Classify(ch)
    if cat then CreateESPTag(ch, cat, info) end
end)

workspace.ChildRemoved:Connect(function(ch)
    RemoveESPTag(ch)
end)

-- Периодический рескан
task.spawn(function()
    while task.wait(3) do
        pcall(ScanWorld)
    end
end)

-- ================================================================
--  ЦИКЛ ОБНОВЛЕНИЯ ESP (каждые ~0.25с)
-- ================================================================
task.spawn(function()
    while task.wait(0.25) do
        local myRoot = MyRoot()
        if not myRoot then continue end
        local myPos = myRoot.Position

        -- Обновить ESP игроков
        for plr, t in pairs(PlrTracked) do
            local ok = pcall(function()
                if not CFG.ESP_Players then
                    t.bb.Enabled = false
                    if t.hl then t.hl.Enabled = false end
                    return
                end

                local ch = plr.Character
                local root = ch and (ch:FindFirstChild("HumanoidRootPart") or ch.PrimaryPart)
                if not root then
                    t.bb.Enabled = false
                    if t.hl then t.hl.Enabled = false end
                    return
                end

                t.bb.Adornee = root
                t.bb.Enabled = true
                if t.hl then t.hl.Adornee = ch; t.hl.Enabled = true end

                -- Дистанция
                local dist = math.floor((root.Position - myPos).Magnitude)
                t.lbl.Text = plr.DisplayName
                t.distLbl.Text = "[" .. dist .. "m]"

                -- HP
                local hum = ch:FindFirstChildOfClass("Humanoid")
                local hp, maxhp = 100, 100
                local attr = ch:GetAttribute("Health") or ch:GetAttribute("hp")
                if attr then hp = attr
                elseif hum then hp = hum.Health; maxhp = hum.MaxHealth end
                local ratio = math.clamp(hp / maxhp, 0, 1)
                t.hpFill.Size = UDim2.new(ratio, 0, 1, 0)
                t.hpFill.BackgroundColor3 = Color3.fromRGB(255*(1-ratio), 255*ratio, 0)
            end)
            if not ok then
                pcall(function() t.bb.Enabled = false end)
            end
        end

        -- Обновить ESP сущностей
        for model, t in pairs(Tracked) do
            local ok = pcall(function()
                if not CatEnabled(t.cat) or not model.Parent then
                    t.bb.Enabled = false
                    if t.hl then t.hl.Enabled = false end
                    return
                end

                local part = GetPart(model)
                if not part then
                    t.bb.Enabled = false
                    if t.hl then t.hl.Enabled = false end
                    return
                end

                t.bb.Adornee = part
                t.bb.Enabled = true
                if t.hl then t.hl.Enabled = true end

                -- Дистанция
                local dist = math.floor((part.Position - myPos).Magnitude)
                t.lbl.Text = CatIcon(t.cat) .. t.info.n .. "  [" .. dist .. "m]"

                -- HP для NPC
                if t.cat == "npc" and t.hpFill then
                    local attr = model:GetAttribute("Health") or model:GetAttribute("hp")
                    if attr then
                        local ratio = math.clamp(attr / (t.info.hp or 100), 0, 1)
                        t.hpFill.Size = UDim2.new(ratio, 0, 1, 0)
                        t.hpFill.BackgroundColor3 = Color3.fromRGB(255*(1-ratio), 255*ratio, 0)
                    end
                end
            end)
            if not ok then
                pcall(function() t.bb.Enabled = false end)
            end
        end
    end
end)

-- ================================================================
--  AIMBOT  (RenderStepped — каждый кадр)
--  Ищет цель от ЦЕНТРА ЭКРАНА, не от тача
--  Работает автоматически когда CFG.Aimbot = true
-- ================================================================
RunService.RenderStepped:Connect(function()
    -- Обновить FOV круг
    FovFrame.Visible = CFG.Aimbot and CFG.ShowFOV
    FovFrame.Size = UDim2.new(0, CFG.AimFOV * 2, 0, CFG.AimFOV * 2)

    if not CFG.Aimbot then return end

    local myRoot = MyRoot()
    if not myRoot then return end
    local myPos = myRoot.Position

    local vpSize = Cam.ViewportSize
    local center = Vector2.new(vpSize.X / 2, vpSize.Y / 2)

    local bestPart = nil
    local bestScreenDist = CFG.AimFOV

    -- Поиск среди игроков
    if CFG.AimPlayers then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LP and plr.Character then
                local part = GetPart(plr.Character, CFG.AimPart or "Head")
                if part then
                    local sp, vis, depth = Cam:WorldToViewportPoint(part.Position)
                    if vis and depth > 0 then
                        local d3 = (part.Position - myPos).Magnitude
                        if d3 < 800 then
                            local sd = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                            if sd < bestScreenDist then
                                bestScreenDist = sd
                                bestPart = part
                            end
                        end
                    end
                end
            end
        end
    end

    -- Поиск среди NPC
    if CFG.AimNPCs then
        for model, t in pairs(Tracked) do
            if t.cat == "npc" and model.Parent then
                local part = GetPart(model, "Head")
                if part then
                    local sp, vis, depth = Cam:WorldToViewportPoint(part.Position)
                    if vis and depth > 0 then
                        local d3 = (part.Position - myPos).Magnitude
                        if d3 < 500 then
                            local sd = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                            if sd < bestScreenDist then
                                bestScreenDist = sd
                                bestPart = part
                            end
                        end
                    end
                end
            end
        end
    end

    -- Наведение
    if bestPart and bestPart.Parent then
        local camPos = Cam.CFrame.Position
        local dir = (bestPart.Position - camPos).Unit
        local goal = CFrame.lookAt(camPos, camPos + dir)
        Cam.CFrame = Cam.CFrame:Lerp(goal, CFG.AimSmooth)
    end
end)

-- ================================================================
--  GUI МЕНЮ — СКРОЛЛИРУЕМОЕ
-- ================================================================
local BH = MOBILE and 42 or 30
local FS = MOBILE and 14 or 12
local PW = MOBILE and 280 or 240

-- Панель
local Panel = Instance.new("Frame")
Panel.Name = "Panel"
Panel.Size = UDim2.new(0, PW, 0, MOBILE and 420 or 380)
Panel.Position = UDim2.new(0, 10, 0, MOBILE and 80 or 10)
Panel.BackgroundColor3 = Color3.fromRGB(12, 12, 24)
Panel.BackgroundTransparency = 0.08
Panel.BorderSizePixel = 0
Panel.Parent = SG
Instance.new("UICorner", Panel).CornerRadius = UDim.new(0, 10)
local ps = Instance.new("UIStroke", Panel)
ps.Color = Color3.fromRGB(80, 80, 200); ps.Thickness = 1.2

-- Тайтл бар (НЕ в скролле, для перетаскивания)
local TBar = Instance.new("Frame")
TBar.Size = UDim2.new(1, 0, 0, MOBILE and 40 or 32)
TBar.BackgroundColor3 = Color3.fromRGB(20, 20, 55)
TBar.BorderSizePixel = 0
TBar.Parent = Panel
Instance.new("UICorner", TBar).CornerRadius = UDim.new(0, 10)

local TTitle = Instance.new("TextLabel")
TTitle.Size = UDim2.new(1, -50, 1, 0)
TTitle.Position = UDim2.new(0, 10, 0, 0)
TTitle.BackgroundTransparency = 1
TTitle.Text = "⚔ TRIDENT ESP"
TTitle.TextColor3 = Color3.fromRGB(170, 170, 255)
TTitle.TextSize = MOBILE and 16 or 14
TTitle.Font = Enum.Font.GothamBold
TTitle.TextXAlignment = Enum.TextXAlignment.Left
TTitle.Parent = TBar

-- Кнопка свернуть
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, MOBILE and 36 or 28, 0, MOBILE and 28 or 22)
MinBtn.Position = UDim2.new(1, MOBILE and -40 or -32, 0.5, MOBILE and -14 or -11)
MinBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
MinBtn.BorderSizePixel = 0
MinBtn.Text = "−"
MinBtn.TextSize = MOBILE and 22 or 16
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Parent = TBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

-- СКРОЛЛИРУЕМАЯ ОБЛАСТЬ (вот это было сломано раньше)
local Scroll = Instance.new("ScrollingFrame")
Scroll.Name = "Scroll"
Scroll.Size = UDim2.new(1, -10, 1, -(MOBILE and 48 or 38))
Scroll.Position = UDim2.new(0, 5, 0, MOBILE and 44 or 34)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = MOBILE and 6 or 4
Scroll.ScrollBarImageColor3 = Color3.fromRGB(120, 120, 220)
Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.ElasticBehavior = Enum.ElasticBehavior.Always
Scroll.Parent = Panel

local SList = Instance.new("UIListLayout", Scroll)
SList.SortOrder = Enum.SortOrder.LayoutOrder
SList.Padding = UDim.new(0, 3)

local SPad = Instance.new("UIPadding", Scroll)
SPad.PaddingTop = UDim.new(0, 2); SPad.PaddingBottom = UDim.new(0, 8)

-- Свернуть/развернуть
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Scroll.Visible = not minimized
    MinBtn.Text = minimized and "+" or "−"
    if minimized then
        Panel.Size = UDim2.new(0, PW, 0, MOBILE and 44 or 36)
    else
        Panel.Size = UDim2.new(0, PW, 0, MOBILE and 420 or 380)
    end
end)

-- Перетаскивание
do
    local drag, dStart, pStart
    TBar.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            drag = true; dStart = inp.Position; pStart = Panel.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then drag = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if drag and (inp.UserInputType == Enum.UserInputType.MouseMovement
        or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - dStart
            Panel.Position = UDim2.new(pStart.X.Scale, pStart.X.Offset + d.X,
                                       pStart.Y.Scale, pStart.Y.Offset + d.Y)
        end
    end)
end

-- ================================================================
--  GUI — КОМПОНЕНТЫ
-- ================================================================
local layoutOrder = 0

local function Sec(text)
    layoutOrder += 1
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, 0, 0, MOBILE and 24 or 18)
    f.BackgroundTransparency = 1
    f.LayoutOrder = layoutOrder
    f.Parent = Scroll

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.Text = "  " .. text
    l.TextColor3 = Color3.fromRGB(120, 120, 230)
    l.TextSize = MOBILE and 13 or 11
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
end

local function Toggle(text, get, set)
    layoutOrder += 1

    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, BH)
    row.BackgroundColor3 = Color3.fromRGB(20, 20, 38)
    row.BorderSizePixel = 0
    row.LayoutOrder = layoutOrder
    row.Parent = Scroll
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -55, 1, 0)
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(210, 210, 225)
    lbl.TextSize = FS
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextTruncate = Enum.TextTruncate.AtEnd
    lbl.Parent = row

    local TW = MOBILE and 46 or 36
    local TH = MOBILE and 24 or 18

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, TW, 0, TH)
    btn.Position = UDim2.new(1, -(TW+6), 0.5, -TH/2)
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = row
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, TH/2)

    local CW = TH - 6
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, CW, 0, CW)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.BorderSizePixel = 0
    knob.Parent = btn
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local function Ref()
        local on = get()
        btn.BackgroundColor3 = on and Color3.fromRGB(50, 190, 80) or Color3.fromRGB(55, 55, 75)
        knob.Position = on
            and UDim2.new(1, -(CW+3), 0.5, -CW/2)
            or  UDim2.new(0, 3, 0.5, -CW/2)
    end
    Ref()

    btn.MouseButton1Click:Connect(function()
        set(not get())
        Ref()
    end)
end

local function Slider(text, min, max, get, set)
    layoutOrder += 1

    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, MOBILE and 56 or 46)
    row.BackgroundColor3 = Color3.fromRGB(20, 20, 38)
    row.BorderSizePixel = 0
    row.LayoutOrder = layoutOrder
    row.Parent = Scroll
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

    local topLbl = Instance.new("TextLabel")
    topLbl.Size = UDim2.new(1, -48, 0, MOBILE and 22 or 18)
    topLbl.Position = UDim2.new(0, 10, 0, 2)
    topLbl.BackgroundTransparency = 1
    topLbl.Text = text
    topLbl.TextColor3 = Color3.fromRGB(210, 210, 225)
    topLbl.TextSize = FS
    topLbl.Font = Enum.Font.Gotham
    topLbl.TextXAlignment = Enum.TextXAlignment.Left
    topLbl.Parent = row

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0, 40, 0, MOBILE and 22 or 18)
    valLbl.Position = UDim2.new(1, -46, 0, 2)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(get())
    valLbl.TextColor3 = Color3.fromRGB(170, 170, 255)
    valLbl.TextSize = FS
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = row

    local tH = MOBILE and 12 or 8
    local tY = MOBILE and 32 or 28

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -20, 0, tH)
    track.Position = UDim2.new(0, 10, 0, tY)
    track.BackgroundColor3 = Color3.fromRGB(40, 40, 65)
    track.BorderSizePixel = 0
    track.Parent = row
    Instance.new("UICorner", track).CornerRadius = UDim.new(0, tH/2)

    local fill = Instance.new("Frame")
    fill.BackgroundColor3 = Color3.fromRGB(80, 80, 220)
    fill.BorderSizePixel = 0
    fill.Parent = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0, tH/2)

    local KW = MOBILE and 22 or 16
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, KW, 0, KW)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.BackgroundColor3 = Color3.fromRGB(180, 180, 255)
    knob.BorderSizePixel = 0
    knob.Parent = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local function SetVisual(r)
        fill.Size = UDim2.new(r, 0, 1, 0)
        knob.Position = UDim2.new(r, 0, 0.5, 0)
    end
    SetVisual((get() - min) / (max - min))

    -- Зона ввода (расширенная для пальцев)
    local hitbox = Instance.new("TextButton")
    hitbox.Size = UDim2.new(1, 10, 0, MOBILE and 40 or 28)
    hitbox.Position = UDim2.new(0, -5, 0.5, MOBILE and -20 or -14)
    hitbox.BackgroundTransparency = 1
    hitbox.Text = ""
    hitbox.Parent = track

    local sliding = false

    local function Apply(x)
        local absP = track.AbsolutePosition
        local absS = track.AbsoluteSize
        local r = math.clamp((x - absP.X) / absS.X, 0, 1)
        local v = math.floor(min + (max - min) * r)
        set(v)
        SetVisual(r)
        valLbl.Text = tostring(v)
    end

    hitbox.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            sliding = true; Apply(inp.Position.X)
        end
    end)
    hitbox.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            sliding = false
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if sliding and (inp.UserInputType == Enum.UserInputType.MouseMovement
        or inp.UserInputType == Enum.UserInputType.Touch) then
            Apply(inp.Position.X)
        end
    end)
end

-- ================================================================
--  ЗАПОЛНЕНИЕ МЕНЮ
-- ================================================================

Sec("AIMBOT")
Toggle("Aimbot",         function() return CFG.Aimbot    end, function(v) CFG.Aimbot    = v end)
Toggle("Aim Players",   function() return CFG.AimPlayers end, function(v) CFG.AimPlayers = v end)
Toggle("Aim NPCs",      function() return CFG.AimNPCs   end, function(v) CFG.AimNPCs    = v end)
Toggle("Show FOV",       function() return CFG.ShowFOV   end, function(v) CFG.ShowFOV    = v end)
Slider("FOV Radius", 30, 350,
    function() return CFG.AimFOV end,
    function(v) CFG.AimFOV = v end)

Sec("PLAYERS")
Toggle("Players ESP",   function() return CFG.ESP_Players end, function(v) CFG.ESP_Players = v end)

Sec("ENTITIES")
Toggle("NPCs",          function() return CFG.ESP_NPCs       end, function(v) CFG.ESP_NPCs      = v end)
Toggle("Loot",          function() return CFG.ESP_Loot       end, function(v) CFG.ESP_Loot      = v end)
Toggle("Resources",     function() return CFG.ESP_Resources  end, function(v) CFG.ESP_Resources = v end)
Toggle("Vehicles",      function() return CFG.ESP_Vehicles   end, function(v) CFG.ESP_Vehicles  = v end)
Toggle("Danger",        function() return CFG.ESP_Danger     end, function(v) CFG.ESP_Danger    = v end)

-- ================================================================
--  ГОРЯЧИЕ КЛАВИШИ (ПК)
-- ================================================================
UIS.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.KeyCode == Enum.KeyCode.RightShift then
        CFG.Aimbot = not CFG.Aimbot
    end
    if inp.KeyCode == Enum.KeyCode.Insert then
        Panel.Visible = not Panel.Visible
    end
end)

-- ================================================================
--  CLEANUP
-- ================================================================
_G._TESP_CLEANUP = function()
    for model in pairs(Tracked) do RemoveESPTag(model) end
    for plr in pairs(PlrTracked) do RemovePlayerESP(plr) end
    pcall(function() SG:Destroy() end)
    print("[TESP] Unloaded")
end

print("==========================================")
print(" ⚔ TRIDENT ESP v3 — Loaded!")
print(MOBILE and " 📱 Mobile Mode" or " 💻 PC Mode")
print(" Aimbot: ON (автоматически)")
print(" RightShift = toggle aim | Insert = menu")
print(" _G._TESP_CLEANUP() — выгрузить")
print("==========================================")
