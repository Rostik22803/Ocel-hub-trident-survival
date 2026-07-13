-- ================================================================
--  TRIDENT SURVIVAL — ESP + AIMBOT v3.2 (HYBRID / NO-G_CLASSES FIXED)
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
--  НАСТРОЙКИ (КОНФИГ)
-- ================================================================
local CFG = {
    ESP_Players  = true,
    ESP_NPCs     = true,
    ESP_Loot     = true,
    ESP_Resources= true,
    ESP_Vehicles = true,
    ESP_Danger   = true,

    ShowHealth   = true,
    MaxDist      = 1000,

    Aimbot       = true,
    AimFOV       = 150,
    AimSmooth    = 0.25,     -- скорость наведения (0.1 - медленно, 0.5 - быстро)
    AimPart      = "Head",   -- Head / Torso
    AimPlayers   = true,
    AimNPCs      = true,
    ShowFOV      = true,
}

-- ================================================================
--  ТАБЛИЦЫ НАСТРОЕК СУЩНОСТЕЙ
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

local function ClassifyType(typeName)
    if NPC[typeName]  then return "npc",  NPC[typeName]  end
    if LOOT[typeName] then return "loot", LOOT[typeName] end
    if RES[typeName]  then return "res",  RES[typeName]  end
    if VEH[typeName]  then return "veh",  VEH[typeName]  end
    if DNG[typeName]  then return "dng",  DNG[typeName]  end
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
    if cat == "npc"  then return 600 end
    if cat == "loot" then return 400 end
    if cat == "res"  then return 250 end
    if cat == "veh"  then return 800 end
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
--  ПОИСК ТАБЛИЦЫ КЛАССОВ ИГРЫ (ГЛУБОКИЙ ПОИСК)
-- ================================================================
local function GetClassesTable()
    if _G.classes then 
        return _G.classes 
    end
    
    -- Попробуем найти в глобальной области под другими именами
    for k, v in pairs(_G) do
        if type(v) == "table" and rawget(v, "EntityClient") and rawget(v, "PlayerClient") then
            return v
        end
    end
    
    -- Попробуем найти через сборщик мусора getgc()
    local gcSuccess, gcResult = pcall(function()
        if getgc then
            local gc = getgc(true)
            for _, v in ipairs(gc) do
                if type(v) == "table" and rawget(v, "EntityClient") and rawget(v, "PlayerClient") then
                    return v
                end
            end
        end
    end)
    if gcSuccess and gcResult then
        return gcResult
    end
    
    return nil
end

-- ================================================================
--  ЭВРИСТИЧЕСКИЙ КЛАССИФИКАТОР МОДЕЛЕЙ (ФОЛБЭК ЕСЛИ КЛАССЫ РАВНЫ NIL)
-- ================================================================
local function HeuristicClassify(model)
    -- 1. Транспорт (Машины)
    if model:FindFirstChildWhichIsA("VehicleSeat") or model:FindFirstChildWhichIsA("Seat") then
        if model:FindFirstChild("Body") or model:FindFirstChild("Engine") or model:FindFirstChild("SteeringWheel") then
            return "veh", { n = "Vehicle", c = Color3.fromRGB(0, 200, 255) }
        end
    end
    
    -- 2. NPC (Мутанты, Зомби, Солдаты)
    if model:FindFirstChild("AnimationController") or model:FindFirstChildOfClass("Humanoid") then
        local isPlayer = false
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Name == model.Name or (model.Parent and model.Parent.Name == p.Name) then
                isPlayer = true
                break
            end
        end
        if not isPlayer then
            local hasWeapon = model:FindFirstChild("RightHand") and model.RightHand:FindFirstChildOfClass("Model")
            local name = hasWeapon and "NPC Soldier" or "Ghoul / Mutant"
            local color = hasWeapon and Color3.fromRGB(255, 165, 0) or Color3.fromRGB(120, 255, 50)
            return "npc", { n = name, c = color, hp = 150 }
        end
    end
    
    -- 3. Выпавший предмет (Dropped Item)
    local display = model:FindFirstChild("Display")
    if display and display:FindFirstChildOfClass("SurfaceGui") then
        local name = "Dropped Item"
        pcall(function()
            local textLabel = display.SurfaceGui:FindFirstChildOfClass("TextLabel")
            if textLabel and textLabel.Text ~= "" then
                name = textLabel.Text
            end
        end)
        return "loot", { n = name, c = Color3.fromRGB(255, 255, 80) }
    end
    
    -- 4. Аирдроп (Supply Drop)
    if model:FindFirstChild("Parachute") or model:FindFirstChild("Cables") then
        return "loot", { n = "Supply Drop", c = Color3.fromRGB(255, 50, 255) }
    end
    
    -- 5. Руды и Ресурсы
    local hasOreVisual = false
    local oreType = "Stone Ore"
    local oreColor = Color3.fromRGB(160, 160, 160)
    
    for _, child in ipairs(model:GetChildren()) do
        if child:IsA("BasePart") then
            local mat = child.Material
            if mat == Enum.Material.Rock or mat == Enum.Material.Slate then
                hasOreVisual = true
                local c = child.Color
                -- Желтый = Сера/Нитрат
                if c.R > 0.75 and c.G > 0.75 and c.B < 0.65 then
                    oreType = "Nitrate Ore"
                    oreColor = Color3.fromRGB(255, 255, 150)
                -- Коричнево-красный = Железо
                elseif c.R > 0.45 and c.G > 0.35 and c.B > 0.3 then
                    oreType = "Iron Ore"
                    oreColor = Color3.fromRGB(210, 140, 90)
                end
            end
        end
    end
    if hasOreVisual then
        return "res", { n = oreType, c = oreColor }
    end
    
    -- 6. Деревья
    if model:FindFirstChild("Leaves") or model:FindFirstChild("Branch") or model:FindFirstChild("Trunk") then
        return "res", { n = "Tree", c = Color3.fromRGB(50, 200, 50) }
    end
    
    -- 7. Кусты ягод
    if model:FindFirstChild("Berries") or model:FindFirstChild("Berry") or model.Name:lower():find("bush") then
        return "res", { n = "Berry Bush", c = Color3.fromRGB(200, 50, 200) }
    end
    
    -- 8. Сундуки / Контейнеры лута
    if model:FindFirstChild("Lid") or model:FindFirstChild("Lock") then
        local name = "Loot Crate"
        if model:FindFirstChild("Safe") or model.Name:lower():find("safe") then name = "Loot Safe" end
        return "loot", { n = name, c = Color3.fromRGB(255, 215, 0) }
    end

    -- 9. Опасности (Капканы, Тесла)
    if model:FindFirstChild("BearTrap") or model:FindFirstChild("Jaw") then
        return "dng", { n = "Bear Trap", c = Color3.fromRGB(255, 0, 0) }
    end
    if model:FindFirstChild("Tesla") or model:FindFirstChild("Pylon") then
        return "dng", { n = "Tesla Pylon", c = Color3.fromRGB(255, 255, 0) }
    end
    
    return nil, nil
end

-- ================================================================
--  ПОЛУЧЕНИЕ ПОЗИЦИЙ И ДАННЫХ
-- ================================================================
local function MyPos()
    return Cam.CFrame.Position
end

local function GetPart(model, name)
    if not model then return nil end
    return model:FindFirstChild(name or "Head")
        or model:FindFirstChild("Head")
        or model:FindFirstChild("Torso")
        or model.PrimaryPart
        or model:FindFirstChildWhichIsA("BasePart")
end

-- Сканирование сущностей (гибридное)
local function GetEntities()
    local list = {}
    local classes = GetClassesTable()
    local EntityMap = classes and classes.EntityClient and classes.EntityClient.EntityMap
    
    if EntityMap then
        -- Точный метод (через игровые таблицы)
        for id, ent in pairs(EntityMap) do
            if ent.model and ent.model.Parent then
                table.insert(list, {
                    model = ent.model,
                    type = ent.type,
                    id = ent.id,
                    byMap = true
                })
            end
        end
    else
        -- Эвристический метод (сканирование workspace)
        for _, child in ipairs(workspace:GetChildren()) do
            if child:IsA("Model") and child ~= LP.Character then
                local cat, info = HeuristicClassify(child)
                if cat then
                    table.insert(list, {
                        model = child,
                        type = info.n,
                        heuristicCat = cat,
                        heuristicInfo = info,
                        byMap = false
                    })
                end
            end
        end
    end
    return list
end

-- Получение игроков
local function GetPlayersList()
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
            local char = plr.Character
            if char and char.Parent then
                table.insert(list, { player = plr, model = char })
            else
                -- Поиск в Ignore папке Trident Survival
                local ignoreFolder = workspace:FindFirstChild("Const") and workspace.Const:FindFirstChild("Ignore")
                if ignoreFolder then
                    local charModel = ignoreFolder:FindFirstChild(plr.Name)
                    if charModel and charModel:IsA("Model") then
                        table.insert(list, { player = plr, model = charModel })
                    end
                end
            end
        end
    end
    return list
end

-- ================================================================
--  УДАЛЕНИЕ ПРЕДЫДУЩЕГО СКРИПТА
-- ================================================================
if _G._TESP_CLEANUP then pcall(_G._TESP_CLEANUP) end

-- ================================================================
--  ГЛАВНЫЙ SCREENGUI
-- ================================================================
local SG = Instance.new("ScreenGui")
SG.Name = "TESP3"
SG.ResetOnSpawn = false
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.IgnoreGuiInset = true
SG.Parent = LP.PlayerGui

-- ================================================================
--  FOV КРУГ (UI Элемент)
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
--  ОБНОВЛЕНИЕ ESP (Фоновый цикл)
-- ================================================================
local ActiveESP = {} -- [instance] = { bb = BillboardGui, hl = Highlight, type = string }

local function ClearESP(instance)
    local data = ActiveESP[instance]
    if data then
        pcall(function() data.bb:Destroy() end)
        pcall(function() if data.hl then data.hl:Destroy() end end)
        ActiveESP[instance] = nil
    end
end

local function ClearAllESP()
    for inst in pairs(ActiveESP) do
        ClearESP(inst)
    end
end

local function UpdateESP()
    local myPos = MyPos()
    local currentModels = {}

    -- 1. Игроки
    local pList = GetPlayersList()
    for _, item in ipairs(pList) do
        local plr = item.player
        local model = item.model
        local root = GetPart(model, "HumanoidRootPart")

        if root and model.Parent then
            currentModels[model] = true
            local dist = math.floor((root.Position - myPos).Magnitude)
            local data = ActiveESP[model]

            if CFG.ESP_Players and dist <= CFG.MaxDist then
                if not data then
                    -- Создаем BillboardGui в ScreenGui
                    local bb = Instance.new("BillboardGui")
                    bb.Name = "_ESP_P_" .. plr.Name
                    bb.AlwaysOnTop = true
                    bb.Size = UDim2.new(0, 160, 0, 50)
                    bb.StudsOffset = Vector3.new(0, 3.5, 0)
                    bb.MaxDistance = CFG.MaxDist
                    bb.LightInfluence = 0
                    bb.Adornee = root
                    bb.Parent = SG -- Обязательно в ScreenGui (в PlayerGui!)

                    local nameLbl = Instance.new("TextLabel")
                    nameLbl.Name = "NameLbl"
                    nameLbl.Size = UDim2.new(1, 0, 0, 16)
                    nameLbl.BackgroundTransparency = 1
                    nameLbl.TextColor3 = Color3.new(1, 1, 1)
                    nameLbl.TextStrokeTransparency = 0.2
                    nameLbl.TextStrokeColor3 = Color3.new(0, 0, 0)
                    nameLbl.Font = Enum.Font.GothamBold
                    nameLbl.TextSize = MOBILE and 11 or 12
                    nameLbl.Parent = bb

                    local distLbl = Instance.new("TextLabel")
                    distLbl.Name = "DistLbl"
                    distLbl.Size = UDim2.new(1, 0, 0, 12)
                    distLbl.Position = UDim2.new(0, 0, 0, 16)
                    distLbl.BackgroundTransparency = 1
                    distLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
                    distLbl.TextStrokeTransparency = 0.3
                    distLbl.TextStrokeColor3 = Color3.new(0, 0, 0)
                    distLbl.Font = Enum.Font.Gotham
                    distLbl.TextSize = MOBILE and 9 or 10
                    distLbl.Parent = bb

                    local hpBg = Instance.new("Frame")
                    hpBg.Name = "HpBg"
                    hpBg.Size = UDim2.new(0.5, 0, 0, 4)
                    hpBg.Position = UDim2.new(0.25, 0, 0, 30)
                    hpBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    hpBg.BorderSizePixel = 0
                    hpBg.Parent = bb
                    Instance.new("UICorner", hpBg).CornerRadius = UDim.new(0, 2)

                    local hpFill = Instance.new("Frame")
                    hpFill.Name = "HpFill"
                    hpFill.Size = UDim2.new(1, 0, 1, 0)
                    hpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                    hpFill.BorderSizePixel = 0
                    hpFill.Parent = hpBg
                    Instance.new("UICorner", hpFill).CornerRadius = UDim.new(0, 2)

                    local hl
                    pcall(function()
                        hl = Instance.new("Highlight")
                        hl.Name = "_H"
                        hl.FillTransparency = 0.8
                        hl.OutlineTransparency = 0.2
                        hl.OutlineColor3 = Color3.fromRGB(255, 60, 60)
                        hl.FillColor3 = Color3.fromRGB(255, 60, 60)
                        hl.Adornee = model
                        hl.Parent = SG -- Parent to ScreenGui!
                    end)

                    data = { bb = bb, hl = hl, type = "player", root = root }
                    ActiveESP[model] = data
                end

                -- Обновляем
                data.bb.Enabled = true
                data.bb.Adornee = root
                if data.hl then
                    data.hl.Enabled = true
                    data.hl.Adornee = model
                end

                local nL = data.bb:FindFirstChild("NameLbl")
                if nL then nL.Text = plr.DisplayName end

                local dL = data.bb:FindFirstChild("DistLbl")
                if dL then dL.Text = "[" .. dist .. "m]" end

                local hF = data.bb:FindFirstChild("HpBg") and data.bb.HpBg:FindFirstChild("HpFill")
                if hF then
                    local hum = model:FindFirstChildOfClass("Humanoid")
                    local hp, maxhp = 100, 100
                    local attr = model:GetAttribute("Health") or model:GetAttribute("hp")
                    if attr then hp = attr
                    elseif hum then hp = hum.Health; maxhp = hum.MaxHealth end
                    local ratio = math.clamp(hp / maxhp, 0, 1)
                    hF.Size = UDim2.new(ratio, 0, 1, 0)
                    hF.BackgroundColor3 = Color3.fromRGB(255*(1-ratio), 255*ratio, 0)
                    data.bb.HpBg.Visible = CFG.ShowHealth
                end
            else
                if data then
                    data.bb.Enabled = false
                    if data.hl then data.hl.Enabled = false end
                end
            end
        end
    end

    -- 2. Сущности (NPC, Loot, Ore, Trees...)
    local entList = GetEntities()
    for _, ent in ipairs(entList) do
        local model = ent.model
        local cat, info
        
        if ent.byMap then
            cat, info = ClassifyType(ent.type)
        else
            cat = ent.heuristicCat
            info = ent.heuristicInfo
        end

        if cat and info and model.Parent then
            local part = GetPart(model)
            if part then
                currentModels[model] = true
                local dist = math.floor((part.Position - myPos).Magnitude)
                local maxD = CatMaxDist(cat, info)
                local data = ActiveESP[model]

                if CatEnabled(cat) and dist <= maxD then
                    if not data then
                        local bb = Instance.new("BillboardGui")
                        bb.Name = "_ESP_E_" .. ent.type
                        bb.AlwaysOnTop = true
                        bb.Size = UDim2.new(0, 150, 0, 45)
                        bb.StudsOffset = Vector3.new(0, 3, 0)
                        bb.MaxDistance = maxD
                        bb.LightInfluence = 0
                        bb.Adornee = part
                        bb.Parent = SG -- Parent to ScreenGui!

                        local nameLbl = Instance.new("TextLabel")
                        nameLbl.Name = "NameLbl"
                        nameLbl.Size = UDim2.new(1, 0, 0, 16)
                        nameLbl.BackgroundTransparency = 1
                        nameLbl.TextColor3 = info.c
                        nameLbl.TextStrokeTransparency = 0.2
                        nameLbl.TextStrokeColor3 = Color3.new(0, 0, 0)
                        nameLbl.Font = Enum.Font.GothamBold
                        nameLbl.TextSize = MOBILE and 10 or 11
                        nameLbl.Parent = bb

                        local distLbl = Instance.new("TextLabel")
                        distLbl.Name = "DistLbl"
                        distLbl.Size = UDim2.new(1, 0, 0, 12)
                        distLbl.Position = UDim2.new(0, 0, 0, 15)
                        distLbl.BackgroundTransparency = 1
                        distLbl.TextColor3 = info.c
                        distLbl.TextStrokeTransparency = 0.3
                        distLbl.TextStrokeColor3 = Color3.new(0, 0, 0)
                        distLbl.Font = Enum.Font.Gotham
                        distLbl.TextSize = MOBILE and 8 or 9
                        distLbl.Parent = bb

                        if cat == "npc" then
                            local hpBg = Instance.new("Frame")
                            hpBg.Name = "HpBg"
                            hpBg.Size = UDim2.new(0.5, 0, 0, 4)
                            hpBg.Position = UDim2.new(0.25, 0, 0, 28)
                            hpBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                            hpBg.BorderSizePixel = 0
                            hpBg.Parent = bb
                            Instance.new("UICorner", hpBg).CornerRadius = UDim.new(0, 2)

                            local hpFill = Instance.new("Frame")
                            hpFill.Name = "HpFill"
                            hpFill.Size = UDim2.new(1, 0, 1, 0)
                            hpFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                            hpFill.BorderSizePixel = 0
                            hpFill.Parent = hpBg
                            Instance.new("UICorner", hpFill).CornerRadius = UDim.new(0, 2)
                        end

                        local hl
                        pcall(function()
                            hl = Instance.new("Highlight")
                            hl.Name = "_H"
                            hl.FillTransparency = 0.85
                            hl.OutlineTransparency = 0.2
                            hl.OutlineColor3 = info.c
                            hl.FillColor3 = info.c
                            hl.Adornee = model
                            hl.Parent = SG -- Parent to ScreenGui!
                        end)

                        data = { bb = bb, hl = hl, type = cat, part = part }
                        ActiveESP[model] = data
                    end

                    data.bb.Enabled = true
                    data.bb.Adornee = part
                    if data.hl then
                        data.hl.Enabled = true
                        data.hl.Adornee = model
                    end

                    local nL = data.bb:FindFirstChild("NameLbl")
                    if nL then nL.Text = CatIcon(cat) .. info.n end

                    local dL = data.bb:FindFirstChild("DistLbl")
                    if dL then dL.Text = "[" .. dist .. "m]" end

                    if cat == "npc" then
                        local hF = data.bb:FindFirstChild("HpBg") and data.bb.HpBg:FindFirstChild("HpFill")
                        if hF then
                            local attr = model:GetAttribute("Health") or model:GetAttribute("hp")
                            if attr then
                                local ratio = math.clamp(attr / (info.hp or 100), 0, 1)
                                hF.Size = UDim2.new(ratio, 0, 1, 0)
                                hF.BackgroundColor3 = Color3.fromRGB(255*(1-ratio), 255*ratio, 0)
                            end
                        end
                    end
                else
                    if data then
                        data.bb.Enabled = false
                        if data.hl then data.hl.Enabled = false end
                    end
                end
            end
        end
    end

    -- Очищаем то, чего больше нет в игре
    for model in pairs(ActiveESP) do
        if not currentModels[model] or not model.Parent then
            ClearESP(model)
        end
    end
end

-- ================================================================
--  ФОНОВЫЙ ТИКЕР ДЛЯ ОБНОВЛЕНИЯ ESP И ДИАГНОСТИКИ
-- ================================================================
local DiagLabel = nil

local function UpdateDiag()
    if not DiagLabel then return end
    local msg = "DIAGNOSTICS:\n"
    local classes = GetClassesTable()
    
    if not classes then
        msg = msg .. "• classes not found (Using HEURISTIC)\n"
    else
        msg = msg .. "• classes found via deep search\n"
        if classes.EntityClient and classes.EntityClient.EntityMap then
            local count = 0
            for _ in pairs(classes.EntityClient.EntityMap) do count = count + 1 end
            msg = msg .. "• EntityMap size: " .. count .. "\n"
        else
            msg = msg .. "• EntityMap not ready\n"
        end
    end

    local pList = GetPlayersList()
    msg = msg .. "• Players tracked: " .. #pList .. "\n"
    
    local activeCount = 0
    for _ in pairs(ActiveESP) do activeCount = activeCount + 1 end
    msg = msg .. "• Active ESP tags: " .. activeCount .. "\n"
    
    local ignoreFolder = workspace:FindFirstChild("Const") and workspace.Const:FindFirstChild("Ignore")
    if ignoreFolder then
        msg = msg .. "• Ignore folder size: " .. #ignoreFolder:GetChildren() .. "\n"
    else
        msg = msg .. "• Ignore folder NOT found\n"
    end

    DiagLabel.Text = msg
end

task.spawn(function()
    while task.wait(0.25) do
        pcall(UpdateESP)
        pcall(UpdateDiag)
    end
end)

-- ================================================================
--  AIMBOT (RenderStepped — каждый кадр)
-- ================================================================
local function FindBestTarget()
    local sc = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)
    local myPos = MyPos()
    local bestPart = nil
    local bestScreenDist = CFG.AimFOV

    -- 1. Игроки
    if CFG.AimPlayers then
        local pList = GetPlayersList()
        for _, item in ipairs(pList) do
            local model = item.model
            local part = GetPart(model, CFG.AimPart)
            if part then
                local sp, vis, depth = Cam:WorldToViewportPoint(part.Position)
                if vis and depth > 0 then
                    local dist3 = (part.Position - myPos).Magnitude
                    if dist3 <= CFG.MaxDist then
                        local sd = (Vector2.new(sp.X, sp.Y) - sc).Magnitude
                        if sd < bestScreenDist then
                            bestScreenDist = sd
                            bestPart = part
                        end
                    end
                end
            end
        end
    end

    -- 2. NPC
    if CFG.AimNPCs then
        local entList = GetEntities()
        for _, ent in ipairs(entList) do
            local cat, _
            if ent.byMap then
                cat, _ = ClassifyType(ent.type)
            else
                cat = ent.heuristicCat
            end
            
            if cat == "npc" and ent.model and ent.model.Parent then
                local part = GetPart(ent.model, "Head")
                if part then
                    local sp, vis, depth = Cam:WorldToViewportPoint(part.Position)
                    if vis and depth > 0 then
                        local dist3 = (part.Position - myPos).Magnitude
                        if dist3 <= 500 then
                            local sd = (Vector2.new(sp.X, sp.Y) - sc).Magnitude
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

    return bestPart
end

RunService.RenderStepped:Connect(function()
    FovFrame.Visible = CFG.Aimbot and CFG.ShowFOV
    FovFrame.Size = UDim2.new(0, CFG.AimFOV*2, 0, CFG.AimFOV*2)

    if not CFG.Aimbot then return end

    local target = FindBestTarget()
    if target and target.Parent then
        local camPos = Cam.CFrame.Position
        local dir = (target.Position - camPos).Unit
        local goal = CFrame.lookAt(camPos, camPos + dir)
        Cam.CFrame = Cam.CFrame:Lerp(goal, CFG.AimSmooth)
    end
end)

-- ================================================================
--  GUI СКРОЛЛИРУЕМОЕ МЕНЮ
-- ================================================================
local BH = MOBILE and 42 or 30
local FS = MOBILE and 14 or 12
local PW = MOBILE and 280 or 240

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
ps.Color = Color3.fromRGB(80, 80, 200)
ps.Thickness = 1.2

-- Тайтл
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

-- Скролл
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

-- Свернуть / Развернуть
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

-- Драг меню
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
--  КОМПОНЕНТЫ МЕНЮ
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
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0, TH/2)

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
--  ПОСТРОЕНИЕ МЕНЮ
-- ================================================================

Sec("AIMBOT")
Toggle("Aimbot ON",     function() return CFG.Aimbot    end, function(v) CFG.Aimbot    = v end)
Toggle("Aim Players",   function() return CFG.AimPlayers end, function(v) CFG.AimPlayers = v end)
Toggle("Aim NPCs",      function() return CFG.AimNPCs   end, function(v) CFG.AimNPCs    = v end)
Toggle("Show FOV",       function() return CFG.ShowFOV   end, function(v) CFG.ShowFOV    = v end)
Slider("FOV Radius", 30, 350,
    function() return CFG.AimFOV end,
    function(v) CFG.AimFOV = v end)
Slider("Smoothing %", 5, 100,
    function() return math.floor(CFG.AimSmooth * 100) end,
    function(v) CFG.AimSmooth = v / 100 end)

Sec("ESP CATEGORIES")
Toggle("Players",       function() return CFG.ESP_Players   end, function(v) CFG.ESP_Players   = v end)
Toggle("NPCs (HP)",     function() return CFG.ESP_NPCs      end, function(v) CFG.ESP_NPCs      = v end)
Toggle("Loot Crates",   function() return CFG.ESP_Loot      end, function(v) CFG.ESP_Loot      = v end)
Toggle("Vehicles",      function() return CFG.ESP_Vehicles  end, function(v) CFG.ESP_Vehicles  = v end)
Toggle("Danger Traps",  function() return CFG.ESP_Danger    end, function(v) CFG.ESP_Danger    = v end)
Toggle("Resources / Trees", function() return CFG.ESP_Resources end, function(v) CFG.ESP_Resources = v end)

Sec("ESP OPTIONS")
Toggle("Show Health",   function() return CFG.ShowHealth    end, function(v) CFG.ShowHealth    = v end)
Slider("Max Distance", 100, 2000,
    function() return CFG.MaxDist end,
    function(v) CFG.MaxDist = v end)

-- Создаем лейбл диагностики в самом конце
layoutOrder += 1
DiagLabel = Instance.new("TextLabel")
DiagLabel.Size = UDim2.new(1, 0, 0, MOBILE and 75 or 60)
DiagLabel.BackgroundTransparency = 0.5
DiagLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
DiagLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
DiagLabel.TextSize = MOBILE and 10 or 9
DiagLabel.Font = Enum.Font.Code
DiagLabel.TextXAlignment = Enum.TextXAlignment.Left
DiagLabel.TextYAlignment = Enum.TextYAlignment.Top
DiagLabel.LayoutOrder = layoutOrder
DiagLabel.Parent = Scroll
Instance.new("UICorner", DiagLabel).CornerRadius = UDim.new(0, 4)

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
--  CLEANUP FUNCTION
-- ================================================================
_G._TESP_CLEANUP = function()
    ClearAllESP()
    pcall(function() SG:Destroy() end)
    print("[TESP] Cleaned up previous session.")
end

print("==========================================")
print(" ⚔ TRIDENT SURVIVAL ESP v3.2 — LOADED")
print(MOBILE and " 📱 Mobile Mode" or " 💻 PC Mode")
print(" Insert = Toggle GUI | RightShift = Toggle Aim")
print("==========================================")
