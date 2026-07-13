--[[
    ████████╗██████╗ ██╗██████╗ ███████╗███╗   ██╗████████╗    ███████╗███████╗██████╗ 
    ╚══██╔══╝██╔══██╗██║██╔══██╗██╔════╝████╗  ██║╚══██╔══╝    ██╔════╝██╔════╝██╔══██╗
       ██║   ██████╔╝██║██║  ██║█████╗  ██╔██╗ ██║   ██║       █████╗  ███████╗██████╔╝
       ██║   ██╔══██╗██║██║  ██║██╔══╝  ██║╚██╗██║   ██║       ██╔══╝  ╚════██║██╔═══╝ 
       ██║   ██║  ██║██║██████╔╝███████╗██║ ╚████║   ██║       ███████╗███████║██║     
       ╚═╝   ╚═╝  ╚═╝╚═╝╚═════╝ ╚══════╝╚═╝  ╚═══╝   ╚═╝       ╚══════╝╚══════╝╚═╝     
    
    Trident Survival — Advanced ESP + Mobile Aimbot
    
    Полная адаптация под мобильные устройства:
      • Мобильное GUI с крупными кнопками
      • Aimbot с FOV кругом привязанным к ЦЕНТРУ экрана (не к пальцу!)
      • Silent Aim — подкручивает камеру плавно к цели
      • Кнопка-тригер аима на экране (удержание = аим активен)
      • ESP для: игроков, NPC, лута, ресурсов, транспорта, ловушек
]]

-- ═══════════════════════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════════════════════
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Определяем платформу
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- ═══════════════════════════════════════════════════════════════════
-- КОНФИГУРАЦИЯ
-- ═══════════════════════════════════════════════════════════════════
local Config = {
    -- Горячие клавиши (ПК)
    ToggleKey = Enum.KeyCode.RightShift,
    GUIToggleKey = Enum.KeyCode.Insert,
    AimKey = Enum.KeyCode.Q, -- на ПК

    -- Максимальные дистанции
    MaxPlayerDist = 1000,
    MaxNPCDist = 500,
    MaxLootDist = 400,
    MaxResourceDist = 300,
    MaxVehicleDist = 600,

    -- Переключатели категорий
    PlayersEnabled = true,
    NPCsEnabled = true,
    LootEnabled = true,
    ResourcesEnabled = false, -- выкл по умолчанию чтобы не засорять экран на телефоне
    VehiclesEnabled = true,
    DangerEnabled = true,

    -- Визуал игроков
    PlayerBoxes = true,
    PlayerNames = true,
    PlayerHealth = true,
    PlayerDistance = true,
    PlayerTracers = false,
    PlayerEquippedItem = true,

    NPCHealth = true,
    NPCDistance = true,

    -- ═══ AIMBOT ═══
    AimbotEnabled = true,
    AimFOV = 120,              -- радиус FOV круга в пикселях
    AimSmoothing = 8,          -- плавность (чем больше — тем мягче)
    AimPart = "Head",          -- куда целиться: "Head", "Torso", "HumanoidRootPart"
    AimAtNPCs = true,          -- аимить по NPC тоже
    AimAtPlayers = true,       -- аимить по игрокам
    ShowFOVCircle = true,      -- показывать круг FOV
    FOVCircleColor = Color3.fromRGB(255, 255, 255),
    FOVCircleTransparency = 0.7,
    AimMaxDistance = 500,       -- макс дистанция аима

    -- Цвета
    Colors = {
        PlayerFriendly = Color3.fromRGB(0, 255, 100),
        PlayerEnemy = Color3.fromRGB(255, 50, 50),
        PlayerDefault = Color3.fromRGB(255, 255, 255),

        Ghoul = Color3.fromRGB(120, 255, 50),
        Soldier = Color3.fromRGB(255, 165, 0),
        Officer = Color3.fromRGB(255, 100, 100),
        General = Color3.fromRGB(255, 50, 50),
        GasMaskSoldier = Color3.fromRGB(255, 200, 0),
        LabWorker = Color3.fromRGB(180, 180, 255),
        Merchant = Color3.fromRGB(100, 255, 255),
        NPCDefault = Color3.fromRGB(255, 180, 0),

        DroppedItem = Color3.fromRGB(255, 255, 100),
        SupplyDrop = Color3.fromRGB(255, 50, 255),
        MetalCrate = Color3.fromRGB(200, 200, 255),
        TransportCrate = Color3.fromRGB(255, 150, 50),
        LootSafe = Color3.fromRGB(255, 215, 0),
        ScrapBucket = Color3.fromRGB(180, 180, 180),
        PartsBox = Color3.fromRGB(150, 200, 255),

        IronOre = Color3.fromRGB(200, 200, 200),
        NitrateOre = Color3.fromRGB(255, 255, 200),
        StoneOre = Color3.fromRGB(160, 160, 160),
        Tree = Color3.fromRGB(50, 200, 50),
        BerryBush = Color3.fromRGB(200, 50, 200),
        GasCan = Color3.fromRGB(255, 100, 0),
        Cactus = Color3.fromRGB(0, 180, 0),

        Vehicle = Color3.fromRGB(0, 200, 255),
        Helicopter = Color3.fromRGB(100, 200, 255),
        Boat = Color3.fromRGB(50, 150, 255),

        BearTrap = Color3.fromRGB(255, 0, 0),
        TeslaPylon = Color3.fromRGB(255, 255, 0),
        GasTrap = Color3.fromRGB(0, 255, 0),
    },

    NameTextSize = IsMobile and 12 or 14,
    InfoTextSize = IsMobile and 10 or 12,
    DistTextSize = IsMobile and 9 or 11,
}

-- ═══════════════════════════════════════════════════════════════════
-- СОСТОЯНИЕ
-- ═══════════════════════════════════════════════════════════════════
local ESPEnabled = true
local GUIVisible = true
local AimActive = false -- зажата ли кнопка аима
local CurrentAimTarget = nil -- текущая цель аима
local PlayerESPData = {}
local EntityESPData = {}

-- ═══════════════════════════════════════════════════════════════════
-- КЛАССИФИКАЦИЯ СУЩНОСТЕЙ
-- ═══════════════════════════════════════════════════════════════════
local NPC_TYPES = {
    ["Ghoul"] = { color = Config.Colors.Ghoul, name = "Ghoul", maxHP = 200 },
    ["Soldier"] = { color = Config.Colors.Soldier, name = "Soldier", maxHP = 125 },
    ["Officer"] = { color = Config.Colors.Officer, name = "Officer", maxHP = 150 },
    ["General"] = { color = Config.Colors.General, name = "General", maxHP = 200 },
    ["GasMaskSoldier"] = { color = Config.Colors.GasMaskSoldier, name = "Gas Mask Soldier", maxHP = 150 },
    ["LabWorker"] = { color = Config.Colors.LabWorker, name = "Lab Worker", maxHP = 100 },
    ["Merchant"] = { color = Config.Colors.Merchant, name = "Merchant", maxHP = 100 },
}

local LOOT_TYPES = {
    ["DroppedItem"] = { color = Config.Colors.DroppedItem, name = "Dropped Item" },
    ["SupplyDrop"] = { color = Config.Colors.SupplyDrop, name = "Supply Drop" },
    ["SupplyDrop2"] = { color = Config.Colors.SupplyDrop, name = "Supply Drop" },
    ["MetalCrate"] = { color = Config.Colors.MetalCrate, name = "Metal Crate" },
    ["TransportCrate"] = { color = Config.Colors.TransportCrate, name = "Transport Crate" },
    ["LootSafe"] = { color = Config.Colors.LootSafe, name = "Loot Safe" },
    ["LootVaultDoor"] = { color = Config.Colors.LootSafe, name = "Vault Door" },
    ["LootVaultDoor2"] = { color = Config.Colors.LootSafe, name = "Vault Door" },
    ["LootVaultDoor3"] = { color = Config.Colors.LootSafe, name = "Vault Door" },
    ["ElectricLootVaultDoor"] = { color = Config.Colors.LootSafe, name = "Electric Vault" },
    ["ScrapBucket"] = { color = Config.Colors.ScrapBucket, name = "Scrap Bucket" },
    ["PartsBox"] = { color = Config.Colors.PartsBox, name = "Parts Box" },
}

local RESOURCE_TYPES = {
    ["IronOre"] = { color = Config.Colors.IronOre, name = "Iron Ore" },
    ["NitrateOre"] = { color = Config.Colors.NitrateOre, name = "Nitrate Ore" },
    ["StoneOre"] = { color = Config.Colors.StoneOre, name = "Stone Ore" },
    ["Tree1"] = { color = Config.Colors.Tree, name = "Tree" },
    ["Tree2"] = { color = Config.Colors.Tree, name = "Tree" },
    ["Tree3"] = { color = Config.Colors.Tree, name = "Tree" },
    ["Tree4"] = { color = Config.Colors.Tree, name = "Tree" },
    ["BerryBush"] = { color = Config.Colors.BerryBush, name = "Berry Bush" },
    ["GasCan"] = { color = Config.Colors.GasCan, name = "Gas Can" },
    ["Cactus1"] = { color = Config.Colors.Cactus, name = "Cactus" },
    ["Cactus2"] = { color = Config.Colors.Cactus, name = "Cactus" },
}

local VEHICLE_TYPES = {
    ["ATV"] = { color = Config.Colors.Vehicle, name = "ATV" },
    ["Boat"] = { color = Config.Colors.Boat, name = "Boat" },
    ["Helicopter"] = { color = Config.Colors.Helicopter, name = "Helicopter" },
    ["Trolly"] = { color = Config.Colors.Vehicle, name = "Trolly" },
}

local DANGER_TYPES = {
    ["BearTrap"] = { color = Config.Colors.BearTrap, name = "⚠ Bear Trap" },
    ["TeslaPylon"] = { color = Config.Colors.TeslaPylon, name = "⚡ Tesla Pylon" },
    ["GasTrap"] = { color = Config.Colors.GasTrap, name = "☣ Gas Trap" },
}

-- ═══════════════════════════════════════════════════════════════════
-- DRAWING УТИЛИТЫ
-- ═══════════════════════════════════════════════════════════════════
local function CreateDrawing(drawType, properties)
    local d = Drawing.new(drawType)
    for k, v in pairs(properties) do
        d[k] = v
    end
    return d
end

local function WorldToScreen(position)
    local screenPos, onScreen = Camera:WorldToViewportPoint(position)
    return Vector2.new(screenPos.X, screenPos.Y), onScreen, screenPos.Z
end

local function GetScreenCenter()
    local vpSize = Camera.ViewportSize
    return Vector2.new(vpSize.X / 2, vpSize.Y / 2)
end

-- ═══════════════════════════════════════════════════════════════════
-- FOV КРУГ (ВСЕГДА ПО ЦЕНТРУ ЭКРАНА!)
-- ═══════════════════════════════════════════════════════════════════
local FOVCircle = CreateDrawing("Circle", {
    Radius = Config.AimFOV,
    Color = Config.FOVCircleColor,
    Thickness = 1.5,
    Filled = false,
    Transparency = Config.FOVCircleTransparency,
    Visible = false,
    NumSides = 64,
    Position = GetScreenCenter(),
})

-- ═══════════════════════════════════════════════════════════════════
-- ESP ОБЪЕКТЫ
-- ═══════════════════════════════════════════════════════════════════
local function CreateESP_Player()
    return {
        BoxTopLine = CreateDrawing("Line", { Thickness = 1, Color = Color3.new(1,1,1), Visible = false }),
        BoxBottomLine = CreateDrawing("Line", { Thickness = 1, Color = Color3.new(1,1,1), Visible = false }),
        BoxLeftLine = CreateDrawing("Line", { Thickness = 1, Color = Color3.new(1,1,1), Visible = false }),
        BoxRightLine = CreateDrawing("Line", { Thickness = 1, Color = Color3.new(1,1,1), Visible = false }),
        NameText = CreateDrawing("Text", { Size = Config.NameTextSize, Center = true, Outline = true, Font = 2, Visible = false }),
        HealthBarBG = CreateDrawing("Line", { Thickness = 3, Color = Color3.fromRGB(40, 40, 40), Visible = false }),
        HealthBar = CreateDrawing("Line", { Thickness = 1, Color = Color3.fromRGB(0, 255, 0), Visible = false }),
        DistText = CreateDrawing("Text", { Size = Config.DistTextSize, Center = true, Outline = true, Font = 2, Visible = false }),
        Tracer = CreateDrawing("Line", { Thickness = 1, Color = Color3.new(1,1,1), Visible = false }),
        ItemText = CreateDrawing("Text", { Size = Config.InfoTextSize, Center = true, Outline = true, Font = 2, Visible = false }),
    }
end

local function CreateESP_Entity()
    return {
        NameText = CreateDrawing("Text", { Size = Config.NameTextSize, Center = true, Outline = true, Font = 2, Visible = false }),
        DistText = CreateDrawing("Text", { Size = Config.DistTextSize, Center = true, Outline = true, Font = 2, Visible = false }),
        HealthBarBG = CreateDrawing("Line", { Thickness = 3, Color = Color3.fromRGB(40, 40, 40), Visible = false }),
        HealthBar = CreateDrawing("Line", { Thickness = 1, Color = Color3.fromRGB(0, 255, 0), Visible = false }),
    }
end

local function DestroyESP(espData)
    if not espData then return end
    for _, drawing in pairs(espData) do
        pcall(function() drawing:Remove() end)
    end
end

local function HideESP(espData)
    if not espData then return end
    for _, drawing in pairs(espData) do
        pcall(function() drawing.Visible = false end)
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- УТИЛИТЫ ПОЗИЦИИ
-- ═══════════════════════════════════════════════════════════════════
local function GetLocalPosition()
    local char = LocalPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
    if root then return root.Position end
    return nil
end

local function GetLocalRootPart()
    local char = LocalPlayer.Character
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart
end

-- ═══════════════════════════════════════════════════════════════════
-- КЛАССИФИКАЦИЯ
-- ═══════════════════════════════════════════════════════════════════
local function ClassifyEntity(model)
    local name = model.Name
    if NPC_TYPES[name] then return "NPC", NPC_TYPES[name] end
    if LOOT_TYPES[name] then return "Loot", LOOT_TYPES[name] end
    if RESOURCE_TYPES[name] then return "Resource", RESOURCE_TYPES[name] end
    if VEHICLE_TYPES[name] then return "Vehicle", VEHICLE_TYPES[name] end
    if DANGER_TYPES[name] then return "Danger", DANGER_TYPES[name] end
    return nil, nil
end

local function GetMaxDistForCategory(category)
    if category == "NPC" then return Config.MaxNPCDist end
    if category == "Loot" then return Config.MaxLootDist end
    if category == "Resource" then return Config.MaxResourceDist end
    if category == "Vehicle" then return Config.MaxVehicleDist end
    if category == "Danger" then return Config.MaxLootDist end
    return 300
end

local function IsCategoryEnabled(category)
    if category == "NPC" then return Config.NPCsEnabled end
    if category == "Loot" then return Config.LootEnabled end
    if category == "Resource" then return Config.ResourcesEnabled end
    if category == "Vehicle" then return Config.VehiclesEnabled end
    if category == "Danger" then return Config.DangerEnabled end
    return false
end

-- ═══════════════════════════════════════════════════════════════════
-- AIMBOT — ЯДРО
-- Ключевое отличие: FOV считается от ЦЕНТРА ЭКРАНА, не от тача!
-- ═══════════════════════════════════════════════════════════════════

local function GetAimPart(model)
    -- Trident Survival использует кастомные риги
    -- Приоритет: Head > Torso > PrimaryPart > любой BasePart
    local partName = Config.AimPart
    local part = model:FindFirstChild(partName)
    if part and part:IsA("BasePart") then return part end

    -- Фоллбэки
    part = model:FindFirstChild("Head")
    if part and part:IsA("BasePart") then return part end

    part = model:FindFirstChild("Torso")
    if part and part:IsA("BasePart") then return part end

    part = model.PrimaryPart
    if part then return part end

    return model:FindFirstChildWhichIsA("BasePart")
end

local function IsValidAimTarget(model)
    if not model or not model.Parent then return false end

    local part = GetAimPart(model)
    if not part then return false end

    local localPos = GetLocalPosition()
    if not localPos then return false end

    local dist = (part.Position - localPos).Magnitude
    if dist > Config.AimMaxDistance then return false end

    return true
end

local function GetClosestTargetFromScreenCenter()
    local screenCenter = GetScreenCenter()
    local closestTarget = nil
    local closestDist = Config.AimFOV -- ищем только внутри FOV круга
    local closestModel = nil

    local localPos = GetLocalPosition()
    if not localPos then return nil, nil end

    -- Проверяем ИГРОКОВ
    if Config.AimAtPlayers then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local character = player.Character
                local part = GetAimPart(character)
                if part then
                    local screenPos, onScreen, depth = WorldToScreen(part.Position)
                    if onScreen and depth > 0 then
                        local dist3D = (part.Position - localPos).Magnitude
                        if dist3D <= Config.AimMaxDistance then
                            -- Считаем дистанцию от ЦЕНТРА ЭКРАНА, не от тача!
                            local screenDist = (screenPos - screenCenter).Magnitude
                            if screenDist < closestDist then
                                closestDist = screenDist
                                closestTarget = part
                                closestModel = character
                            end
                        end
                    end
                end
            end
        end
    end

    -- Проверяем NPC
    if Config.AimAtNPCs then
        for model, data in pairs(EntityESPData) do
            if data.category == "NPC" and model.Parent then
                local part = GetAimPart(model)
                if part then
                    local screenPos, onScreen, depth = WorldToScreen(part.Position)
                    if onScreen and depth > 0 then
                        local dist3D = (part.Position - localPos).Magnitude
                        if dist3D <= Config.AimMaxDistance then
                            local screenDist = (screenPos - screenCenter).Magnitude
                            if screenDist < closestDist then
                                closestDist = screenDist
                                closestTarget = part
                                closestModel = model
                            end
                        end
                    end
                end
            end
        end
    end

    return closestTarget, closestModel
end

-- Плавное наведение камеры на цель
local function AimAtTarget(targetPart, dt)
    if not targetPart or not targetPart.Parent then
        CurrentAimTarget = nil
        return
    end

    local rootPart = GetLocalRootPart()
    if not rootPart then return end

    local targetPos = targetPart.Position
    local camPos = Camera.CFrame.Position

    -- Рассчитываем желаемый CFrame камеры
    local direction = (targetPos - camPos).Unit
    local targetCFrame = CFrame.lookAt(camPos, camPos + direction)

    -- Плавная интерполяция камеры
    local smoothFactor = math.clamp(dt * Config.AimSmoothing, 0, 1)
    Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, smoothFactor)
end

-- ═══════════════════════════════════════════════════════════════════
-- ОБНОВЛЕНИЕ ESP ИГРОКОВ
-- ═══════════════════════════════════════════════════════════════════
local function UpdatePlayerESP(player, espData)
    if player == LocalPlayer then HideESP(espData); return end
    if not ESPEnabled or not Config.PlayersEnabled then HideESP(espData); return end

    local character = player.Character
    if not character then HideESP(espData); return end

    local rootPart = character:FindFirstChild("HumanoidRootPart") or character.PrimaryPart
    if not rootPart then HideESP(espData); return end

    local localPos = GetLocalPosition()
    if not localPos then HideESP(espData); return end

    local distance = (rootPart.Position - localPos).Magnitude
    if distance > Config.MaxPlayerDist then HideESP(espData); return end

    local headPos = rootPart.Position + Vector3.new(0, 3, 0)
    local footPos = rootPart.Position - Vector3.new(0, 3, 0)
    local headScreen, headOnScreen = WorldToScreen(headPos)
    local footScreen, footOnScreen = WorldToScreen(footPos)

    if not headOnScreen and not footOnScreen then HideESP(espData); return end

    local color = Config.Colors.PlayerDefault
    local boxHeight = math.abs(headScreen.Y - footScreen.Y)
    local boxWidth = boxHeight * 0.55

    local topLeft = Vector2.new(headScreen.X - boxWidth / 2, headScreen.Y)
    local topRight = Vector2.new(headScreen.X + boxWidth / 2, headScreen.Y)
    local botLeft = Vector2.new(footScreen.X - boxWidth / 2, footScreen.Y)
    local botRight = Vector2.new(footScreen.X + boxWidth / 2, footScreen.Y)

    -- Боксы
    if Config.PlayerBoxes then
        espData.BoxTopLine.From = topLeft; espData.BoxTopLine.To = topRight
        espData.BoxTopLine.Color = color; espData.BoxTopLine.Visible = true
        espData.BoxBottomLine.From = botLeft; espData.BoxBottomLine.To = botRight
        espData.BoxBottomLine.Color = color; espData.BoxBottomLine.Visible = true
        espData.BoxLeftLine.From = topLeft; espData.BoxLeftLine.To = botLeft
        espData.BoxLeftLine.Color = color; espData.BoxLeftLine.Visible = true
        espData.BoxRightLine.From = topRight; espData.BoxRightLine.To = botRight
        espData.BoxRightLine.Color = color; espData.BoxRightLine.Visible = true
    else
        espData.BoxTopLine.Visible = false; espData.BoxBottomLine.Visible = false
        espData.BoxLeftLine.Visible = false; espData.BoxRightLine.Visible = false
    end

    -- Имя
    if Config.PlayerNames then
        espData.NameText.Text = player.DisplayName
        espData.NameText.Position = Vector2.new(headScreen.X, headScreen.Y - 18)
        espData.NameText.Color = color; espData.NameText.Visible = true
    else
        espData.NameText.Visible = false
    end

    -- Хелсбар
    if Config.PlayerHealth then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local health, maxHealth = 100, 100
        local hpAttr = character:GetAttribute("Health") or character:GetAttribute("hp")
        if hpAttr then
            health = hpAttr
        elseif humanoid then
            health = humanoid.Health; maxHealth = humanoid.MaxHealth
        end
        local ratio = math.clamp(health / maxHealth, 0, 1)
        local barHeight = boxHeight
        local barX = topLeft.X - 4
        espData.HealthBarBG.From = Vector2.new(barX, topLeft.Y)
        espData.HealthBarBG.To = Vector2.new(barX, topLeft.Y + barHeight)
        espData.HealthBarBG.Visible = true
        espData.HealthBar.From = Vector2.new(barX, topLeft.Y + barHeight * (1 - ratio))
        espData.HealthBar.To = Vector2.new(barX, topLeft.Y + barHeight)
        espData.HealthBar.Color = Color3.fromRGB(255 * (1 - ratio), 255 * ratio, 0)
        espData.HealthBar.Visible = true
    else
        espData.HealthBarBG.Visible = false; espData.HealthBar.Visible = false
    end

    -- Дистанция
    if Config.PlayerDistance then
        espData.DistText.Text = string.format("[%dm]", math.floor(distance))
        espData.DistText.Position = Vector2.new(footScreen.X, footScreen.Y + 2)
        espData.DistText.Color = color; espData.DistText.Visible = true
    else
        espData.DistText.Visible = false
    end

    -- Трейсер
    if Config.PlayerTracers then
        local screenSize = Camera.ViewportSize
        espData.Tracer.From = Vector2.new(screenSize.X / 2, screenSize.Y)
        espData.Tracer.To = footScreen; espData.Tracer.Color = color; espData.Tracer.Visible = true
    else
        espData.Tracer.Visible = false
    end

    -- Экипировка
    if Config.PlayerEquippedItem then
        local tool = character:FindFirstChildOfClass("Tool")
        local itemName = tool and tool.Name
        if not itemName then
            local attr = character:GetAttribute("EquippedItem") or character:GetAttribute("equippedItem")
            if attr then itemName = tostring(attr) end
        end
        if itemName then
            espData.ItemText.Text = itemName
            espData.ItemText.Position = Vector2.new(headScreen.X, headScreen.Y - 32)
            espData.ItemText.Color = Color3.fromRGB(255, 200, 100); espData.ItemText.Visible = true
        else
            espData.ItemText.Visible = false
        end
    else
        espData.ItemText.Visible = false
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- ОБНОВЛЕНИЕ ESP СУЩНОСТЕЙ
-- ═══════════════════════════════════════════════════════════════════
local function UpdateEntityESP(model, espData, category, typeInfo)
    if not ESPEnabled or not IsCategoryEnabled(category) then HideESP(espData); return end

    local primaryPart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
    if not primaryPart then HideESP(espData); return end

    local localPos = GetLocalPosition()
    if not localPos then HideESP(espData); return end

    local distance = (primaryPart.Position - localPos).Magnitude
    if distance > GetMaxDistForCategory(category) then HideESP(espData); return end

    local abovePos = primaryPart.Position + Vector3.new(0, 3, 0)
    local screenPos, onScreen = WorldToScreen(abovePos)
    if not onScreen then HideESP(espData); return end

    local color = typeInfo.color
    local displayName = typeInfo.name

    -- Иконки по категориям
    if category == "NPC" then displayName = "💀 " .. displayName
    elseif category == "Loot" then displayName = "📦 " .. displayName
    elseif category == "Resource" then displayName = "⛏ " .. displayName
    elseif category == "Vehicle" then displayName = "🚗 " .. displayName end

    espData.NameText.Text = displayName
    espData.NameText.Position = Vector2.new(screenPos.X, screenPos.Y - 10)
    espData.NameText.Color = color; espData.NameText.Visible = true

    espData.DistText.Text = string.format("[%dm]", math.floor(distance))
    espData.DistText.Position = Vector2.new(screenPos.X, screenPos.Y + 5)
    espData.DistText.Color = color; espData.DistText.Visible = true

    -- HP бар для NPC
    if category == "NPC" and Config.NPCHealth then
        local healthAttr = model:GetAttribute("Health") or model:GetAttribute("hp")
        if healthAttr then
            local maxHP = typeInfo.maxHP or 100
            local ratio = math.clamp(healthAttr / maxHP, 0, 1)
            local barWidth = 40
            local barX = screenPos.X - barWidth / 2
            local barY = screenPos.Y + 18
            espData.HealthBarBG.From = Vector2.new(barX, barY)
            espData.HealthBarBG.To = Vector2.new(barX + barWidth, barY)
            espData.HealthBarBG.Visible = true
            espData.HealthBar.From = Vector2.new(barX, barY)
            espData.HealthBar.To = Vector2.new(barX + barWidth * ratio, barY)
            espData.HealthBar.Color = Color3.fromRGB(255 * (1 - ratio), 255 * ratio, 0)
            espData.HealthBar.Visible = true
        else
            espData.HealthBarBG.Visible = false; espData.HealthBar.Visible = false
        end
    else
        espData.HealthBarBG.Visible = false; espData.HealthBar.Visible = false
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- СКАНИРОВАНИЕ И ТРЕКИНГ
-- ═══════════════════════════════════════════════════════════════════
local function AddPlayerESP(player)
    if PlayerESPData[player] then return end
    PlayerESPData[player] = CreateESP_Player()
end

local function RemovePlayerESP(player)
    local data = PlayerESPData[player]
    if data then DestroyESP(data); PlayerESPData[player] = nil end
end

local function AddEntityESP(model)
    if EntityESPData[model] then return end
    local category, typeInfo = ClassifyEntity(model)
    if not category then return end
    EntityESPData[model] = { drawings = CreateESP_Entity(), category = category, typeInfo = typeInfo }
end

local function RemoveEntityESP(model)
    local data = EntityESPData[model]
    if data then DestroyESP(data.drawings); EntityESPData[model] = nil end
end

local function ScanWorkspace()
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA("Model") and child ~= LocalPlayer.Character then
            local category = ClassifyEntity(child)
            if category then AddEntityESP(child) end
        end
    end
end

-- Инициализация игроков
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then AddPlayerESP(player) end
end
Players.PlayerAdded:Connect(function(p) AddPlayerESP(p) end)
Players.PlayerRemoving:Connect(function(p) RemovePlayerESP(p) end)

-- Инициализация сущностей
ScanWorkspace()
workspace.ChildAdded:Connect(function(child)
    task.wait(0.1)
    if child:IsA("Model") then AddEntityESP(child) end
end)
workspace.ChildRemoved:Connect(function(child)
    if child:IsA("Model") then RemoveEntityESP(child) end
end)

-- Периодический рескан
task.spawn(function()
    while task.wait(5) do
        ScanWorkspace()
        for model in pairs(EntityESPData) do
            if not model.Parent then RemoveEntityESP(model) end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════
-- ГЛАВНЫЙ РЕНДЕР-ЛУП
-- ═══════════════════════════════════════════════════════════════════
RunService.RenderStepped:Connect(function(dt)
    -- Обновляем FOV круг — всегда по центру экрана!
    local screenCenter = GetScreenCenter()
    FOVCircle.Position = screenCenter
    FOVCircle.Radius = Config.AimFOV
    FOVCircle.Visible = ESPEnabled and Config.AimbotEnabled and Config.ShowFOVCircle

    -- Аимбот
    if ESPEnabled and Config.AimbotEnabled and AimActive then
        local target, targetModel = GetClosestTargetFromScreenCenter()
        CurrentAimTarget = targetModel
        if target then
            AimAtTarget(target, dt)
        end
    else
        CurrentAimTarget = nil
    end

    -- Обновляем ESP игроков
    for player, espData in pairs(PlayerESPData) do
        local ok = pcall(UpdatePlayerESP, player, espData)
        if not ok then HideESP(espData) end
    end

    -- Обновляем ESP сущностей
    for model, data in pairs(EntityESPData) do
        if model.Parent then
            local ok = pcall(UpdateEntityESP, model, data.drawings, data.category, data.typeInfo)
            if not ok then HideESP(data.drawings) end
        else
            HideESP(data.drawings)
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════
-- ВВОД С КЛАВИАТУРЫ (ПК)
-- ═══════════════════════════════════════════════════════════════════
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Config.ToggleKey then
        ESPEnabled = not ESPEnabled
        if not ESPEnabled then
            for _, data in pairs(PlayerESPData) do HideESP(data) end
            for _, data in pairs(EntityESPData) do HideESP(data.drawings) end
        end
    end
    if input.KeyCode == Config.GUIToggleKey then
        GUIVisible = not GUIVisible
    end
    -- На ПК: зажатие Q активирует аим
    if input.KeyCode == Config.AimKey then
        AimActive = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Config.AimKey then
        AimActive = false
        CurrentAimTarget = nil
    end
end)

-- ═══════════════════════════════════════════════════════════════════
-- МОБИЛЬНОЕ GUI
-- ═══════════════════════════════════════════════════════════════════
local function CreateGUI()
    local oldGui = LocalPlayer.PlayerGui:FindFirstChild("TridentESP")
    if oldGui then oldGui:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "TridentESP"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent = LocalPlayer.PlayerGui

    -- ═══ Размеры адаптируются под платформу ═══
    local btnSize = IsMobile and 44 or 28
    local fontSize = IsMobile and 15 or 13
    local titleSize = IsMobile and 18 or 16
    local toggleW = IsMobile and 46 or 36
    local toggleH = IsMobile and 24 or 18
    local circleSize = IsMobile and 18 or 14
    local panelWidth = IsMobile and 300 or 260
    local rowHeight = IsMobile and 38 or 28

    -- ═══════════════════════════════════════════
    -- КНОПКА ОТКРЫТИЯ МЕНЮ (мобильная)
    -- ═══════════════════════════════════════════
    local MenuToggleBtn = Instance.new("TextButton")
    MenuToggleBtn.Name = "MenuToggle"
    MenuToggleBtn.Size = UDim2.new(0, IsMobile and 50 or 40, 0, IsMobile and 50 or 40)
    MenuToggleBtn.Position = UDim2.new(0, 8, 0, IsMobile and 120 or 10)
    MenuToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 60)
    MenuToggleBtn.BackgroundTransparency = 0.2
    MenuToggleBtn.Text = "⚔"
    MenuToggleBtn.TextSize = IsMobile and 24 or 18
    MenuToggleBtn.TextColor3 = Color3.fromRGB(180, 180, 255)
    MenuToggleBtn.Font = Enum.Font.GothamBold
    MenuToggleBtn.BorderSizePixel = 0
    MenuToggleBtn.Parent = ScreenGui
    local menuBtnCorner = Instance.new("UICorner", MenuToggleBtn)
    menuBtnCorner.CornerRadius = UDim.new(0, IsMobile and 12 or 8)
    local menuBtnStroke = Instance.new("UIStroke", MenuToggleBtn)
    menuBtnStroke.Color = Color3.fromRGB(80, 80, 180)
    menuBtnStroke.Thickness = 1.5

    -- ═══════════════════════════════════════════
    -- КНОПКА АИМА (мобильная) — ПРАВАЯ СТОРОНА ЭКРАНА
    -- Удержание = аим активен
    -- ═══════════════════════════════════════════
    local AimButton = Instance.new("TextButton")
    AimButton.Name = "AimButton"
    AimButton.Size = UDim2.new(0, IsMobile and 70 or 55, 0, IsMobile and 70 or 55)
    AimButton.Position = UDim2.new(1, IsMobile and -85 or -65, 0.5, IsMobile and -35 or -28)
    AimButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    AimButton.BackgroundTransparency = 0.3
    AimButton.Text = "🎯"
    AimButton.TextSize = IsMobile and 30 or 22
    AimButton.TextColor3 = Color3.new(1, 1, 1)
    AimButton.Font = Enum.Font.GothamBold
    AimButton.BorderSizePixel = 0
    AimButton.Parent = ScreenGui
    local aimCorner = Instance.new("UICorner", AimButton)
    aimCorner.CornerRadius = UDim.new(1, 0) -- круглая кнопка
    local aimStroke = Instance.new("UIStroke", AimButton)
    aimStroke.Color = Color3.fromRGB(100, 100, 200)
    aimStroke.Thickness = 2

    -- Подпись под кнопкой аима
    local AimLabel = Instance.new("TextLabel")
    AimLabel.Size = UDim2.new(0, IsMobile and 70 or 55, 0, 16)
    AimLabel.Position = UDim2.new(1, IsMobile and -85 or -65, 0.5, IsMobile and 40 or 30)
    AimLabel.BackgroundTransparency = 1
    AimLabel.Text = "HOLD AIM"
    AimLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
    AimLabel.TextSize = IsMobile and 11 or 9
    AimLabel.Font = Enum.Font.GothamBold
    AimLabel.TextXAlignment = Enum.TextXAlignment.Center
    AimLabel.Parent = ScreenGui

    -- Логика кнопки аима — УДЕРЖАНИЕ
    AimButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            AimActive = true
            AimButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
            aimStroke.Color = Color3.fromRGB(255, 80, 80)
            AimLabel.Text = "AIMING..."
            AimLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    AimButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            AimActive = false
            CurrentAimTarget = nil
            AimButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            aimStroke.Color = Color3.fromRGB(100, 100, 200)
            AimLabel.Text = "HOLD AIM"
            AimLabel.TextColor3 = Color3.fromRGB(150, 150, 200)
        end
    end)

    -- ═══════════════════════════════════════════
    -- ГЛАВНАЯ ПАНЕЛЬ
    -- ═══════════════════════════════════════════
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, panelWidth, 0, IsMobile and 480 or 420)
    MainFrame.Position = UDim2.new(0, 10, 0.5, IsMobile and -240 or -210)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = false -- скрыта по умолчанию
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    local mainStroke = Instance.new("UIStroke", MainFrame)
    mainStroke.Color = Color3.fromRGB(80, 80, 180)
    mainStroke.Thickness = 1.5; mainStroke.Transparency = 0.2

    -- Тайтл бар
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, IsMobile and 44 or 35)
    TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 60)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame
    Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 10)

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -60, 1, 0)
    TitleLabel.Position = UDim2.new(0, 12, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = "⚔ TRIDENT ESP"
    TitleLabel.TextColor3 = Color3.fromRGB(180, 180, 255)
    TitleLabel.TextSize = titleSize
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleBar

    -- Кнопка закрытия
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, IsMobile and 40 or 30, 0, IsMobile and 40 or 30)
    CloseBtn.Position = UDim2.new(1, IsMobile and -42 or -32, 0.5, IsMobile and -20 or -15)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseBtn.BackgroundTransparency = 0.5
    CloseBtn.Text = "✕"
    CloseBtn.TextSize = IsMobile and 18 or 14
    CloseBtn.TextColor3 = Color3.new(1, 1, 1)
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = TitleBar
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)

    -- Драг
    local dragging, dragInput, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    TitleBar.InputChanged:Connect(function(input)
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

    -- Контент (скролл)
    local ContentFrame = Instance.new("ScrollingFrame")
    ContentFrame.Size = UDim2.new(1, -16, 1, -(IsMobile and 54 or 45))
    ContentFrame.Position = UDim2.new(0, 8, 0, IsMobile and 48 or 40)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarThickness = IsMobile and 5 or 3
    ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 200)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ContentFrame.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout", ContentFrame)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, IsMobile and 5 or 4)

    local layoutOrder = 0
    local function NextOrder() layoutOrder = layoutOrder + 1; return layoutOrder end

    -- ═══ Создатель секций ═══
    local function CreateSection(parent, text)
        local SectionLabel = Instance.new("TextLabel")
        SectionLabel.Size = UDim2.new(1, 0, 0, IsMobile and 26 or 22)
        SectionLabel.BackgroundTransparency = 1
        SectionLabel.Text = text
        SectionLabel.TextColor3 = Color3.fromRGB(130, 130, 255)
        SectionLabel.TextSize = IsMobile and 14 or 13
        SectionLabel.Font = Enum.Font.GothamBold
        SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
        SectionLabel.LayoutOrder = NextOrder()
        SectionLabel.Parent = parent
    end

    -- ═══ Создатель тоглов ═══
    local function CreateToggle(parent, text, default, callback)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Size = UDim2.new(1, 0, 0, rowHeight)
        ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
        ToggleFrame.BackgroundTransparency = 0.3
        ToggleFrame.BorderSizePixel = 0
        ToggleFrame.LayoutOrder = NextOrder()
        ToggleFrame.Parent = parent
        Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 6)

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -(toggleW + 20), 1, 0)
        Label.Position = UDim2.new(0, 12, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(200, 200, 220)
        Label.TextSize = fontSize
        Label.Font = Enum.Font.Gotham
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.TextTruncate = Enum.TextTruncate.AtEnd
        Label.Parent = ToggleFrame

        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Size = UDim2.new(0, toggleW, 0, toggleH)
        ToggleBtn.Position = UDim2.new(1, -(toggleW + 8), 0.5, -toggleH / 2)
        ToggleBtn.BorderSizePixel = 0
        ToggleBtn.Text = ""
        ToggleBtn.Parent = ToggleFrame
        Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, toggleH / 2)

        local Circle = Instance.new("Frame")
        Circle.Size = UDim2.new(0, circleSize, 0, circleSize)
        Circle.BorderSizePixel = 0
        Circle.BackgroundColor3 = Color3.new(1, 1, 1)
        Circle.Parent = ToggleBtn
        Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

        local enabled = default
        local function UpdateVisual()
            if enabled then
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 180, 100)
                Circle.Position = UDim2.new(1, -(circleSize + 3), 0.5, -circleSize / 2)
            else
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
                Circle.Position = UDim2.new(0, 3, 0.5, -circleSize / 2)
            end
        end
        UpdateVisual()

        ToggleBtn.MouseButton1Click:Connect(function()
            enabled = not enabled; UpdateVisual(); callback(enabled)
        end)
    end

    -- ═══ Слайдер FOV ═══
    local function CreateSlider(parent, text, min, max, default, callback)
        local SliderFrame = Instance.new("Frame")
        SliderFrame.Size = UDim2.new(1, 0, 0, IsMobile and 58 or 48)
        SliderFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
        SliderFrame.BackgroundTransparency = 0.3
        SliderFrame.BorderSizePixel = 0
        SliderFrame.LayoutOrder = NextOrder()
        SliderFrame.Parent = parent
        Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 6)

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -60, 0, IsMobile and 24 or 20)
        Label.Position = UDim2.new(0, 12, 0, 2)
        Label.BackgroundTransparency = 1
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(200, 200, 220)
        Label.TextSize = fontSize
        Label.Font = Enum.Font.Gotham
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = SliderFrame

        local ValueLabel = Instance.new("TextLabel")
        ValueLabel.Size = UDim2.new(0, 50, 0, IsMobile and 24 or 20)
        ValueLabel.Position = UDim2.new(1, -58, 0, 2)
        ValueLabel.BackgroundTransparency = 1
        ValueLabel.Text = tostring(math.floor(default))
        ValueLabel.TextColor3 = Color3.fromRGB(180, 180, 255)
        ValueLabel.TextSize = fontSize
        ValueLabel.Font = Enum.Font.GothamBold
        ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
        ValueLabel.Parent = SliderFrame

        local SliderBG = Instance.new("Frame")
        SliderBG.Size = UDim2.new(1, -24, 0, IsMobile and 14 or 10)
        SliderBG.Position = UDim2.new(0, 12, 1, IsMobile and -22 or -16)
        SliderBG.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
        SliderBG.BorderSizePixel = 0
        SliderBG.Parent = SliderFrame
        Instance.new("UICorner", SliderBG).CornerRadius = UDim.new(0, 5)

        local SliderFill = Instance.new("Frame")
        local ratio = (default - min) / (max - min)
        SliderFill.Size = UDim2.new(ratio, 0, 1, 0)
        SliderFill.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
        SliderFill.BorderSizePixel = 0
        SliderFill.Parent = SliderBG
        Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 5)

        -- Кнопка-слайдер (крупная для мобилки)
        local SliderKnob = Instance.new("Frame")
        SliderKnob.Size = UDim2.new(0, IsMobile and 22 or 16, 0, IsMobile and 22 or 16)
        SliderKnob.Position = UDim2.new(ratio, IsMobile and -11 or -8, 0.5, IsMobile and -11 or -8)
        SliderKnob.BackgroundColor3 = Color3.fromRGB(180, 180, 255)
        SliderKnob.BorderSizePixel = 0
        SliderKnob.Parent = SliderBG
        Instance.new("UICorner", SliderKnob).CornerRadius = UDim.new(1, 0)

        -- Невидимая кнопка для ввода (работает и с тачем)
        local SliderButton = Instance.new("TextButton")
        SliderButton.Size = UDim2.new(1, 0, 1, IsMobile and 20 or 10)
        SliderButton.Position = UDim2.new(0, 0, 0, IsMobile and -10 or -5)
        SliderButton.BackgroundTransparency = 1
        SliderButton.Text = ""
        SliderButton.Parent = SliderBG

        local sliding = false

        local function UpdateSlider(inputPos)
            local absPos = SliderBG.AbsolutePosition
            local absSize = SliderBG.AbsoluteSize
            local relX = math.clamp((inputPos.X - absPos.X) / absSize.X, 0, 1)
            local value = math.floor(min + (max - min) * relX)
            SliderFill.Size = UDim2.new(relX, 0, 1, 0)
            SliderKnob.Position = UDim2.new(relX, IsMobile and -11 or -8, 0.5, IsMobile and -11 or -8)
            ValueLabel.Text = tostring(value)
            callback(value)
        end

        SliderButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                sliding = true
                UpdateSlider(input.Position)
            end
        end)

        SliderButton.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                sliding = false
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                UpdateSlider(input.Position)
            end
        end)
    end

    -- ═══════════════════════════════════════
    -- ЗАПОЛНЯЕМ GUI
    -- ═══════════════════════════════════════

    CreateSection(ContentFrame, "── MASTER ──")
    CreateToggle(ContentFrame, "ESP Enabled", ESPEnabled, function(v)
        ESPEnabled = v
        if not v then
            for _, data in pairs(PlayerESPData) do HideESP(data) end
            for _, data in pairs(EntityESPData) do HideESP(data.drawings) end
        end
    end)

    CreateSection(ContentFrame, "── AIMBOT ──")
    CreateToggle(ContentFrame, "Aimbot", Config.AimbotEnabled, function(v) Config.AimbotEnabled = v end)
    CreateToggle(ContentFrame, "Aim at Players", Config.AimAtPlayers, function(v) Config.AimAtPlayers = v end)
    CreateToggle(ContentFrame, "Aim at NPCs", Config.AimAtNPCs, function(v) Config.AimAtNPCs = v end)
    CreateToggle(ContentFrame, "Show FOV Circle", Config.ShowFOVCircle, function(v) Config.ShowFOVCircle = v end)
    CreateSlider(ContentFrame, "FOV Radius", 30, 300, Config.AimFOV, function(v) Config.AimFOV = v end)
    CreateSlider(ContentFrame, "Smoothing", 1, 30, Config.AimSmoothing, function(v) Config.AimSmoothing = v end)

    CreateSection(ContentFrame, "── PLAYERS ──")
    CreateToggle(ContentFrame, "Players", Config.PlayersEnabled, function(v) Config.PlayersEnabled = v end)
    CreateToggle(ContentFrame, "Boxes", Config.PlayerBoxes, function(v) Config.PlayerBoxes = v end)
    CreateToggle(ContentFrame, "Names", Config.PlayerNames, function(v) Config.PlayerNames = v end)
    CreateToggle(ContentFrame, "Health Bars", Config.PlayerHealth, function(v) Config.PlayerHealth = v end)
    CreateToggle(ContentFrame, "Distance", Config.PlayerDistance, function(v) Config.PlayerDistance = v end)
    CreateToggle(ContentFrame, "Tracers", Config.PlayerTracers, function(v) Config.PlayerTracers = v end)
    CreateToggle(ContentFrame, "Equipped Item", Config.PlayerEquippedItem, function(v) Config.PlayerEquippedItem = v end)

    CreateSection(ContentFrame, "── ENTITIES ──")
    CreateToggle(ContentFrame, "NPCs", Config.NPCsEnabled, function(v) Config.NPCsEnabled = v end)
    CreateToggle(ContentFrame, "NPC Health", Config.NPCHealth, function(v) Config.NPCHealth = v end)

    CreateSection(ContentFrame, "── LOOT ──")
    CreateToggle(ContentFrame, "Loot", Config.LootEnabled, function(v) Config.LootEnabled = v end)

    CreateSection(ContentFrame, "── WORLD ──")
    CreateToggle(ContentFrame, "Resources", Config.ResourcesEnabled, function(v) Config.ResourcesEnabled = v end)
    CreateToggle(ContentFrame, "Vehicles", Config.VehiclesEnabled, function(v) Config.VehiclesEnabled = v end)
    CreateToggle(ContentFrame, "Danger", Config.DangerEnabled, function(v) Config.DangerEnabled = v end)

    -- ═══ Кнопка меню — открытие/закрытие ═══
    MenuToggleBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    -- Привязка к GUIVisible
    task.spawn(function()
        while task.wait(0.2) do
            -- Синхронизируем видимость аим-кнопки с аимботом
            AimButton.Visible = Config.AimbotEnabled and ESPEnabled
            AimLabel.Visible = Config.AimbotEnabled and ESPEnabled
        end
    end)

    return ScreenGui
end

local GUI = CreateGUI()

-- Привязка GUIToggleKey
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Config.GUIToggleKey then
        GUIVisible = not GUIVisible
        GUI.Enabled = GUIVisible
    end
end)

-- ═══════════════════════════════════════════════════════════════════
-- CLEANUP
-- ═══════════════════════════════════════════════════════════════════
_G.TridentESP_Cleanup = function()
    ESPEnabled = false; AimActive = false

    for _, data in pairs(PlayerESPData) do DestroyESP(data) end
    PlayerESPData = {}

    for _, data in pairs(EntityESPData) do DestroyESP(data.drawings) end
    EntityESPData = {}

    pcall(function() FOVCircle:Remove() end)
    if GUI then GUI:Destroy() end

    print("[Trident ESP] Cleaned up")
end

-- ═══════════════════════════════════════════════════════════════════
print("═══════════════════════════════════════════")
print("  ⚔ TRIDENT ESP + AIM — Loaded!")
if IsMobile then
    print("  📱 Mobile Mode — Touch Optimized")
    print("  🎯 Hold AIM button to lock on")
else
    print("  💻 PC Mode")
    print("  RightShift — Toggle ESP")
    print("  Insert — Toggle GUI")
    print("  Q (hold) — Aimbot")
end
print("  _G.TridentESP_Cleanup() — Unload")
print("═══════════════════════════════════════════")
