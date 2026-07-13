-- ============================================================
--  TRIDENT SURVIVAL — ESP + AIMBOT
--  Мобильный + ПК | Aimbot всегда активен когда включён
-- ============================================================

local Players       = game:GetService("Players")
local RunService    = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer   = Players.LocalPlayer
local Camera        = workspace.CurrentCamera

-- ============================================================
-- НАСТРОЙКИ
-- ============================================================
local CFG = {
    -- ESP
    ESP_Players   = true,
    ESP_NPCs      = true,
    ESP_Loot      = true,
    ESP_Resources = true,
    ESP_Vehicles  = true,
    ESP_Danger    = true,

    ShowBox       = true,
    ShowName      = true,
    ShowHealth    = true,
    ShowDist      = true,
    ShowTracer    = false,
    MaxDist       = 800,

    -- AIMBOT
    Aimbot        = true,     -- включён = всегда работает
    AimFOV        = 150,      -- радиус круга в пикселях
    AimSmooth     = 0.25,     -- 0.0 - мгновенно, 1.0 - очень плавно (рекомендую 0.15-0.35)
    AimPart       = "Head",   -- Head / Torso / HumanoidRootPart
    AimPlayers    = true,
    AimNPCs       = true,
    ShowFOVCircle = true,
}

-- ============================================================
-- ДАННЫЕ СУЩНОСТЕЙ
-- ============================================================
local NPC_INFO = {
    Ghoul          = { name = "Ghoul",           hp = 200, color = Color3.fromRGB(120,255,50)  },
    Soldier        = { name = "Soldier",          hp = 125, color = Color3.fromRGB(255,165,0)   },
    Officer        = { name = "Officer",          hp = 150, color = Color3.fromRGB(255,100,100) },
    General        = { name = "General",          hp = 200, color = Color3.fromRGB(255,50,50)   },
    GasMaskSoldier = { name = "Gas Mask Soldier", hp = 150, color = Color3.fromRGB(255,220,0)   },
    LabWorker      = { name = "Lab Worker",       hp = 100, color = Color3.fromRGB(180,180,255) },
    Merchant       = { name = "Merchant",         hp = 100, color = Color3.fromRGB(100,255,255) },
}

local LOOT_INFO = {
    DroppedItem          = { name = "Dropped Item",    color = Color3.fromRGB(255,255,80)  },
    SupplyDrop           = { name = "Supply Drop",     color = Color3.fromRGB(255,50,255)  },
    SupplyDrop2          = { name = "Supply Drop",     color = Color3.fromRGB(255,50,255)  },
    MetalCrate           = { name = "Metal Crate",     color = Color3.fromRGB(200,200,255) },
    TransportCrate       = { name = "Transport Crate", color = Color3.fromRGB(255,150,50)  },
    LootSafe             = { name = "Loot Safe",       color = Color3.fromRGB(255,215,0)   },
    LootVaultDoor        = { name = "Vault Door",      color = Color3.fromRGB(255,215,0)   },
    LootVaultDoor2       = { name = "Vault Door",      color = Color3.fromRGB(255,215,0)   },
    LootVaultDoor3       = { name = "Vault Door",      color = Color3.fromRGB(255,215,0)   },
    ElectricLootVaultDoor= { name = "Electric Vault",  color = Color3.fromRGB(200,255,80)  },
    ScrapBucket          = { name = "Scrap Bucket",    color = Color3.fromRGB(180,180,180) },
    PartsBox             = { name = "Parts Box",       color = Color3.fromRGB(150,200,255) },
}

local RES_INFO = {
    IronOre   = { name = "Iron Ore",   color = Color3.fromRGB(210,210,210) },
    NitrateOre= { name = "Nitrate Ore",color = Color3.fromRGB(255,255,200) },
    StoneOre  = { name = "Stone Ore",  color = Color3.fromRGB(160,160,160) },
    Tree1     = { name = "Tree",       color = Color3.fromRGB(50,200,50)   },
    Tree2     = { name = "Tree",       color = Color3.fromRGB(50,200,50)   },
    Tree3     = { name = "Tree",       color = Color3.fromRGB(50,200,50)   },
    Tree4     = { name = "Tree",       color = Color3.fromRGB(50,200,50)   },
    BerryBush = { name = "Berry Bush", color = Color3.fromRGB(200,50,200)  },
    GasCan    = { name = "Gas Can",    color = Color3.fromRGB(255,100,0)   },
    Cactus1   = { name = "Cactus",     color = Color3.fromRGB(0,180,0)     },
    Cactus2   = { name = "Cactus",     color = Color3.fromRGB(0,180,0)     },
}

local VEH_INFO = {
    ATV        = { name = "ATV",        color = Color3.fromRGB(0,200,255)   },
    Boat       = { name = "Boat",       color = Color3.fromRGB(50,150,255)  },
    Helicopter = { name = "Helicopter", color = Color3.fromRGB(100,200,255) },
    Trolly     = { name = "Trolly",     color = Color3.fromRGB(0,200,255)   },
}

local DNG_INFO = {
    BearTrap   = { name = "Bear Trap",  color = Color3.fromRGB(255,0,0)   },
    TeslaPylon = { name = "Tesla Pylon",color = Color3.fromRGB(255,255,0) },
    GasTrap    = { name = "Gas Trap",   color = Color3.fromRGB(0,255,100) },
}

-- ============================================================
-- HELPERS
-- ============================================================
local function W2S(pos)
    local p, vis = Camera:WorldToViewportPoint(pos)
    return Vector2.new(p.X, p.Y), vis, p.Z
end

local function ScreenCenter()
    local v = Camera.ViewportSize
    return Vector2.new(v.X/2, v.Y/2)
end

local function LocalRoot()
    local ch = LocalPlayer.Character
    return ch and (ch:FindFirstChild("HumanoidRootPart") or ch.PrimaryPart)
end

local function GetModelInfo(model)
    local n = model.Name
    if NPC_INFO[n]  then return "npc",  NPC_INFO[n]  end
    if LOOT_INFO[n] then return "loot", LOOT_INFO[n] end
    if RES_INFO[n]  then return "res",  RES_INFO[n]  end
    if VEH_INFO[n]  then return "veh",  VEH_INFO[n]  end
    if DNG_INFO[n]  then return "dng",  DNG_INFO[n]  end
    return nil, nil
end

local function CategoryEnabled(cat)
    if cat == "npc"  then return CFG.ESP_NPCs      end
    if cat == "loot" then return CFG.ESP_Loot       end
    if cat == "res"  then return CFG.ESP_Resources  end
    if cat == "veh"  then return CFG.ESP_Vehicles   end
    if cat == "dng"  then return CFG.ESP_Danger     end
    return false
end

-- ============================================================
-- DRAWING HELPERS
-- ============================================================
local function NewLine(color, thick)
    local d = Drawing.new("Line")
    d.Visible   = false
    d.Color     = color or Color3.new(1,1,1)
    d.Thickness = thick or 1
    return d
end

local function NewText(size, color)
    local d = Drawing.new("Text")
    d.Visible  = false
    d.Size     = size or 14
    d.Color    = color or Color3.new(1,1,1)
    d.Center   = true
    d.Outline  = true
    d.Font     = Drawing.Fonts.UI
    return d
end

local function NewCircle()
    local d = Drawing.new("Circle")
    d.Visible      = false
    d.Color        = Color3.new(1,1,1)
    d.Thickness    = 1.5
    d.NumSides     = 64
    d.Filled       = false
    d.Transparency = 1
    return d
end

local function HideAll(t)
    for _, v in pairs(t) do pcall(function() v.Visible = false end) end
end

local function RemoveAll(t)
    for _, v in pairs(t) do pcall(function() v:Remove() end) end
end

-- ============================================================
-- FOV CIRCLE  (всегда по центру экрана)
-- ============================================================
local FovCircle = NewCircle()
FovCircle.Radius   = CFG.AimFOV
FovCircle.Position = ScreenCenter()
FovCircle.Visible  = CFG.Aimbot and CFG.ShowFOVCircle

-- ============================================================
-- ESP ОБЪЕКТЫ
-- ============================================================
local function MakePlayerESP()
    return {
        tl = NewLine(), tr = NewLine(), bl = NewLine(), br = NewLine(), -- box corners
        bx_t = NewLine(), bx_b = NewLine(), bx_l = NewLine(), bx_r = NewLine(),
        name = NewText(14, Color3.new(1,1,1)),
        dist = NewText(11, Color3.fromRGB(200,200,200)),
        item = NewText(11, Color3.fromRGB(255,200,80)),
        hpbg = NewLine(Color3.fromRGB(30,30,30), 3),
        hp   = NewLine(Color3.fromRGB(0,255,0),  3),
        trc  = NewLine(Color3.fromRGB(255,255,255), 1),
    }
end

local function MakeEntityESP()
    return {
        name = NewText(13, Color3.new(1,1,1)),
        dist = NewText(11, Color3.fromRGB(200,200,200)),
        hpbg = NewLine(Color3.fromRGB(30,30,30), 3),
        hp   = NewLine(Color3.fromRGB(0,255,0),  3),
    }
end

-- ============================================================
-- ХРАНИЛИЩА
-- ============================================================
local PlrESP = {}   -- [player] = {drawings}
local EntESP = {}   -- [model]  = {cat, info, drawings}

-- ============================================================
-- ОБНОВЛЕНИЕ ESP ИГРОКА
-- ============================================================
local function UpdatePlayerESP(plr, d)
    if plr == LocalPlayer then HideAll(d); return end
    if not CFG.ESP_Players then HideAll(d); return end

    local ch = plr.Character
    local root = ch and (ch:FindFirstChild("HumanoidRootPart") or ch.PrimaryPart)
    if not root then HideAll(d); return end

    local myRoot = LocalRoot()
    if not myRoot then HideAll(d); return end

    local dist3 = (root.Position - myRoot.Position).Magnitude
    if dist3 > CFG.MaxDist then HideAll(d); return end

    local top3 = root.Position + Vector3.new(0, 3.2, 0)
    local bot3 = root.Position - Vector3.new(0, 3.2, 0)
    local topS, topV = W2S(top3)
    local botS, botV = W2S(bot3)

    if not topV and not botV then HideAll(d); return end

    local h = math.abs(topS.Y - botS.Y)
    local w = h * 0.5
    local col = Color3.new(1,1,1)

    -- Box
    if CFG.ShowBox then
        local tl = Vector2.new(topS.X - w/2, topS.Y)
        local tr = Vector2.new(topS.X + w/2, topS.Y)
        local bl = Vector2.new(botS.X - w/2, botS.Y)
        local br = Vector2.new(botS.X + w/2, botS.Y)

        d.bx_t.From = tl; d.bx_t.To = tr; d.bx_t.Color = col; d.bx_t.Visible = true
        d.bx_b.From = bl; d.bx_b.To = br; d.bx_b.Color = col; d.bx_b.Visible = true
        d.bx_l.From = tl; d.bx_l.To = bl; d.bx_l.Color = col; d.bx_l.Visible = true
        d.bx_r.From = tr; d.bx_r.To = br; d.bx_r.Color = col; d.bx_r.Visible = true
    else
        d.bx_t.Visible = false; d.bx_b.Visible = false
        d.bx_l.Visible = false; d.bx_r.Visible = false
    end

    -- Name
    if CFG.ShowName then
        d.name.Text     = plr.DisplayName
        d.name.Position = Vector2.new(topS.X, topS.Y - 16)
        d.name.Visible  = true
    else d.name.Visible = false end

    -- Distance
    if CFG.ShowDist then
        d.dist.Text     = math.floor(dist3) .. "m"
        d.dist.Position = Vector2.new(botS.X, botS.Y + 2)
        d.dist.Visible  = true
    else d.dist.Visible = false end

    -- Health bar (слева от бокса)
    if CFG.ShowHealth then
        local hum = ch and ch:FindFirstChildOfClass("Humanoid")
        local hp, maxhp = 100, 100
        local attr = ch and (ch:GetAttribute("Health") or ch:GetAttribute("hp"))
        if attr then hp = attr
        elseif hum then hp = hum.Health; maxhp = hum.MaxHealth end

        local ratio = math.clamp(hp / maxhp, 0, 1)
        local bx = topS.X - w/2 - 5
        d.hpbg.From = Vector2.new(bx, topS.Y); d.hpbg.To = Vector2.new(bx, botS.Y); d.hpbg.Visible = true

        local topHP = botS.Y - (botS.Y - topS.Y) * ratio
        d.hp.Color = Color3.fromRGB(255*(1-ratio), 255*ratio, 0)
        d.hp.From  = Vector2.new(bx, topHP); d.hp.To = Vector2.new(bx, botS.Y); d.hp.Visible = true
    else
        d.hpbg.Visible = false; d.hp.Visible = false
    end

    -- Equipped item
    if CFG.ShowName then
        local tool = ch and ch:FindFirstChildOfClass("Tool")
        local itemName = tool and tool.Name
        if not itemName then
            local a = ch and (ch:GetAttribute("equippedItem") or ch:GetAttribute("EquippedItem"))
            if a then itemName = tostring(a) end
        end
        if itemName then
            d.item.Text     = "[" .. itemName .. "]"
            d.item.Position = Vector2.new(topS.X, topS.Y - 28)
            d.item.Visible  = true
        else d.item.Visible = false end
    else d.item.Visible = false end

    -- Tracer
    if CFG.ShowTracer then
        local sc = ScreenCenter()
        d.trc.From = sc; d.trc.To = botS; d.trc.Color = col; d.trc.Visible = true
    else d.trc.Visible = false end

    -- Unused box corner lines
    d.tl.Visible = false; d.tr.Visible = false
    d.bl.Visible = false; d.br.Visible = false
end

-- ============================================================
-- ОБНОВЛЕНИЕ ESP СУЩНОСТИ
-- ============================================================
local function UpdateEntityESP(model, d, cat, info)
    if not CategoryEnabled(cat) then HideAll(d); return end

    local pp = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
    if not pp then HideAll(d); return end

    local myRoot = LocalRoot()
    if not myRoot then HideAll(d); return end

    local dist3 = (pp.Position - myRoot.Position).Magnitude
    local maxD = (cat == "npc" or cat == "veh") and CFG.MaxDist or (CFG.MaxDist * 0.5)
    if dist3 > maxD then HideAll(d); return end

    local above = pp.Position + Vector3.new(0, 3, 0)
    local sPos, sVis = W2S(above)
    if not sVis then HideAll(d); return end

    -- Иконки
    local icons = { npc="☠ ", loot="⬡ ", res="⛏ ", veh="⊕ ", dng="⚠ " }
    d.name.Text     = (icons[cat] or "") .. info.name
    d.name.Position = Vector2.new(sPos.X, sPos.Y - 8)
    d.name.Color    = info.color
    d.name.Visible  = true

    d.dist.Text     = math.floor(dist3) .. "m"
    d.dist.Position = Vector2.new(sPos.X, sPos.Y + 6)
    d.dist.Color    = info.color
    d.dist.Visible  = true

    -- HP только для NPC
    if cat == "npc" then
        local attr = model:GetAttribute("Health") or model:GetAttribute("hp")
        if attr then
            local ratio = math.clamp(attr / (info.hp or 100), 0, 1)
            local bw = 36
            local bx = sPos.X - bw/2
            local by = sPos.Y + 16
            d.hpbg.From = Vector2.new(bx, by); d.hpbg.To = Vector2.new(bx+bw, by); d.hpbg.Visible = true
            d.hp.Color  = Color3.fromRGB(255*(1-ratio), 255*ratio, 0)
            d.hp.From   = Vector2.new(bx, by); d.hp.To = Vector2.new(bx + bw*ratio, by); d.hp.Visible = true
        else
            d.hpbg.Visible = false; d.hp.Visible = false
        end
    else
        d.hpbg.Visible = false; d.hp.Visible = false
    end
end

-- ============================================================
-- ДОБАВИТЬ / УДАЛИТЬ СУЩНОСТЬ
-- ============================================================
local function AddPlayer(plr)
    if plr == LocalPlayer or PlrESP[plr] then return end
    PlrESP[plr] = MakePlayerESP()
end

local function RemPlayer(plr)
    if PlrESP[plr] then
        RemoveAll(PlrESP[plr])
        PlrESP[plr] = nil
    end
end

local function AddModel(model)
    if EntESP[model] then return end
    local cat, info = GetModelInfo(model)
    if not cat then return end
    EntESP[model] = { cat = cat, info = info, d = MakeEntityESP() }
end

local function RemModel(model)
    if EntESP[model] then
        RemoveAll(EntESP[model].d)
        EntESP[model] = nil
    end
end

-- ============================================================
-- ИНИЦИАЛИЗАЦИЯ
-- ============================================================
for _, plr in ipairs(Players:GetPlayers()) do AddPlayer(plr) end
Players.PlayerAdded:Connect(AddPlayer)
Players.PlayerRemoving:Connect(RemPlayer)

local function ScanWorkspace()
    for _, ch in ipairs(workspace:GetChildren()) do
        if ch:IsA("Model") and ch ~= LocalPlayer.Character then
            AddModel(ch)
        end
    end
end
ScanWorkspace()

workspace.ChildAdded:Connect(function(ch)
    if ch:IsA("Model") then
        task.wait(0.1)
        AddModel(ch)
    end
end)
workspace.ChildRemoved:Connect(function(ch)
    RemModel(ch)
end)

-- Периодический рескан
task.spawn(function()
    while true do
        task.wait(4)
        ScanWorkspace()
        for m in pairs(EntESP) do
            if not m.Parent then RemModel(m) end
        end
    end
end)

-- ============================================================
-- AIMBOT  — работает автоматически когда CFG.Aimbot = true
-- Ищет ближайшего к ЦЕНТРУ ЭКРАНА (не к пальцу!)
-- ============================================================
local function GetAimPartFromModel(model)
    return model:FindFirstChild(CFG.AimPart)
        or model:FindFirstChild("Head")
        or model:FindFirstChild("Torso")
        or model.PrimaryPart
        or model:FindFirstChildWhichIsA("BasePart")
end

local function FindBestTarget()
    local sc  = ScreenCenter()
    local myRoot = LocalRoot()
    if not myRoot then return nil end

    local best, bestPart, bestDist = nil, nil, CFG.AimFOV

    -- Игроки
    if CFG.AimPlayers then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local part = GetAimPartFromModel(plr.Character)
                if part then
                    local sPos, vis, depth = W2S(part.Position)
                    if vis and depth > 0 then
                        local d2 = (myRoot.Position - part.Position).Magnitude
                        if d2 <= CFG.MaxDist then
                            local sd = (sPos - sc).Magnitude
                            if sd < bestDist then
                                bestDist = sd
                                bestPart = part
                                best = plr.Character
                            end
                        end
                    end
                end
            end
        end
    end

    -- NPC
    if CFG.AimNPCs then
        for model, entry in pairs(EntESP) do
            if entry.cat == "npc" and model.Parent then
                local part = GetAimPartFromModel(model)
                if part then
                    local sPos, vis, depth = W2S(part.Position)
                    if vis and depth > 0 then
                        local d2 = (myRoot.Position - part.Position).Magnitude
                        if d2 <= CFG.MaxDist then
                            local sd = (sPos - sc).Magnitude
                            if sd < bestDist then
                                bestDist = sd
                                bestPart = part
                                best = model
                            end
                        end
                    end
                end
            end
        end
    end

    return bestPart
end

-- ============================================================
-- ГЛАВНЫЙ ЛУП
-- ============================================================
RunService.RenderStepped:Connect(function()
    -- FOV круг
    FovCircle.Visible  = CFG.Aimbot and CFG.ShowFOVCircle
    FovCircle.Position = ScreenCenter()
    FovCircle.Radius   = CFG.AimFOV

    -- Aimbot
    if CFG.Aimbot then
        local target = FindBestTarget()
        if target and target.Parent then
            local tPos = target.Position
            local camCF = Camera.CFrame
            local dir   = (tPos - camCF.Position).Unit
            local goal  = CFrame.lookAt(camCF.Position, camCF.Position + dir)
            Camera.CFrame = camCF:Lerp(goal, CFG.AimSmooth)
        end
    end

    -- ESP игроки
    for plr, d in pairs(PlrESP) do
        pcall(UpdatePlayerESP, plr, d)
    end

    -- ESP сущности
    for model, entry in pairs(EntESP) do
        if model.Parent then
            pcall(UpdateEntityESP, model, entry.d, entry.cat, entry.info)
        else
            HideAll(entry.d)
        end
    end
end)

-- ============================================================
-- GUI — компактный, мобильный
-- ============================================================
local function BuildGUI()
    local old = LocalPlayer.PlayerGui:FindFirstChild("TESP")
    if old then old:Destroy() end

    local sg = Instance.new("ScreenGui")
    sg.Name           = "TESP"
    sg.ResetOnSpawn   = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.Parent         = LocalPlayer.PlayerGui

    -- Авто-размер по платформе
    local MOBILE = UserInputService.TouchEnabled
    local BH     = MOBILE and 40  or 28   -- высота строки
    local TXS    = MOBILE and 14  or 12   -- размер текста
    local PW     = MOBILE and 290 or 250  -- ширина панели

    -- ═══ Панель ═══
    local panel = Instance.new("Frame")
    panel.Name                  = "Panel"
    panel.Size                  = UDim2.new(0, PW, 0, 50) -- авто-размер через UIListLayout
    panel.Position              = UDim2.new(0, 8, 0, 8)
    panel.BackgroundColor3      = Color3.fromRGB(10, 10, 20)
    panel.BackgroundTransparency= 0.15
    panel.BorderSizePixel       = 0
    panel.AutomaticSize         = Enum.AutomaticSize.Y
    panel.Parent                = sg
    do
        local c = Instance.new("UICorner", panel); c.CornerRadius = UDim.new(0, 8)
        local s = Instance.new("UIStroke",  panel)
        s.Color = Color3.fromRGB(90, 90, 200); s.Thickness = 1.2
    end

    -- Список
    local list = Instance.new("UIListLayout", panel)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding   = UDim.new(0, 1)

    local pad = Instance.new("UIPadding", panel)
    pad.PaddingTop    = UDim.new(0, 6)
    pad.PaddingBottom = UDim.new(0, 6)
    pad.PaddingLeft   = UDim.new(0, 6)
    pad.PaddingRight  = UDim.new(0, 6)

    local order = 0
    local function O() order = order + 1; return order end

    -- Заголовок + кнопка скрыть
    local titleRow = Instance.new("Frame")
    titleRow.Size            = UDim2.new(1, 0, 0, MOBILE and 36 or 26)
    titleRow.BackgroundColor3= Color3.fromRGB(25, 25, 65)
    titleRow.BorderSizePixel = 0
    titleRow.LayoutOrder     = O()
    titleRow.Parent          = panel
    do Instance.new("UICorner", titleRow).CornerRadius = UDim.new(0, 5) end

    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size                = UDim2.new(1, -45, 1, 0)
    titleLbl.Position            = UDim2.new(0, 8, 0, 0)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text                = "⚔ TRIDENT ESP"
    titleLbl.TextColor3          = Color3.fromRGB(180,180,255)
    titleLbl.TextSize            = MOBILE and 16 or 13
    titleLbl.Font                = Enum.Font.GothamBold
    titleLbl.TextXAlignment      = Enum.TextXAlignment.Left
    titleLbl.Parent              = titleRow

    local hideBtn = Instance.new("TextButton")
    hideBtn.Size             = UDim2.new(0, MOBILE and 36 or 28, 0, MOBILE and 28 or 20)
    hideBtn.Position         = UDim2.new(1, MOBILE and -38 or -30, 0.5, MOBILE and -14 or -10)
    hideBtn.BackgroundColor3 = Color3.fromRGB(180,40,40)
    hideBtn.BorderSizePixel  = 0
    hideBtn.Text             = "–"
    hideBtn.TextSize         = MOBILE and 20 or 15
    hideBtn.TextColor3       = Color3.new(1,1,1)
    hideBtn.Font             = Enum.Font.GothamBold
    hideBtn.Parent           = titleRow
    Instance.new("UICorner", hideBtn).CornerRadius = UDim.new(0, 4)

    local hidden    = false
    local contentFrames = {}

    hideBtn.MouseButton1Click:Connect(function()
        hidden = not hidden
        for _, f in ipairs(contentFrames) do f.Visible = not hidden end
        hideBtn.Text = hidden and "+" or "–"
    end)

    -- Разделитель
    local function Sep()
        local s = Instance.new("Frame")
        s.Size             = UDim2.new(1, 0, 0, 1)
        s.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
        s.BorderSizePixel  = 0
        s.LayoutOrder      = O()
        s.Parent           = panel
        table.insert(contentFrames, s)
    end

    -- Заголовок секции
    local function Sec(txt)
        Sep()
        local lbl = Instance.new("TextLabel")
        lbl.Size                = UDim2.new(1, 0, 0, MOBILE and 22 or 16)
        lbl.BackgroundTransparency = 1
        lbl.Text                = txt
        lbl.TextColor3          = Color3.fromRGB(120, 120, 220)
        lbl.TextSize            = MOBILE and 13 or 11
        lbl.Font                = Enum.Font.GothamBold
        lbl.TextXAlignment      = Enum.TextXAlignment.Left
        lbl.LayoutOrder         = O()
        lbl.Parent              = panel
        table.insert(contentFrames, lbl)
    end

    -- Тогл
    local function Toggle(txt, getVal, setVal)
        local row = Instance.new("Frame")
        row.Size             = UDim2.new(1, 0, 0, BH)
        row.BackgroundColor3 = Color3.fromRGB(18, 18, 35)
        row.BorderSizePixel  = 0
        row.LayoutOrder      = O()
        row.Parent           = panel
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)
        table.insert(contentFrames, row)

        local lbl = Instance.new("TextLabel")
        lbl.Size                = UDim2.new(1, -54, 1, 0)
        lbl.Position            = UDim2.new(0, 8, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text                = txt
        lbl.TextColor3          = Color3.fromRGB(210,210,220)
        lbl.TextSize            = TXS
        lbl.Font                = Enum.Font.Gotham
        lbl.TextXAlignment      = Enum.TextXAlignment.Left
        lbl.TextTruncate        = Enum.TextTruncate.AtEnd
        lbl.Parent              = row

        local TW, TH = MOBILE and 44 or 34, MOBILE and 22 or 16
        local btn = Instance.new("TextButton")
        btn.Size             = UDim2.new(0, TW, 0, TH)
        btn.Position         = UDim2.new(1, -(TW+4), 0.5, -TH/2)
        btn.BorderSizePixel  = 0
        btn.Text             = ""
        btn.Parent           = row
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, TH/2)

        local CW = TH - 6
        local knob = Instance.new("Frame")
        knob.Size             = UDim2.new(0, CW, 0, CW)
        knob.BackgroundColor3 = Color3.new(1,1,1)
        knob.BorderSizePixel  = 0
        knob.Parent           = btn
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

        local function Refresh()
            local on = getVal()
            btn.BackgroundColor3 = on and Color3.fromRGB(60,190,90) or Color3.fromRGB(60,60,80)
            knob.Position = on
                and UDim2.new(1, -(CW+3), 0.5, -CW/2)
                or  UDim2.new(0, 3,       0.5, -CW/2)
        end
        Refresh()

        btn.MouseButton1Click:Connect(function()
            setVal(not getVal())
            Refresh()
            -- Обновить видимость FOV круга
            FovCircle.Visible = CFG.Aimbot and CFG.ShowFOVCircle
        end)
    end

    -- ══ Слайдер ══
    local function Slider(txt, min, max, getVal, setVal)
        local row = Instance.new("Frame")
        row.Size             = UDim2.new(1, 0, 0, MOBILE and 52 or 44)
        row.BackgroundColor3 = Color3.fromRGB(18, 18, 35)
        row.BorderSizePixel  = 0
        row.LayoutOrder      = O()
        row.Parent           = panel
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 5)
        table.insert(contentFrames, row)

        local topLbl = Instance.new("TextLabel")
        topLbl.Size                = UDim2.new(1, -50, 0, MOBILE and 22 or 18)
        topLbl.Position            = UDim2.new(0, 8, 0, 3)
        topLbl.BackgroundTransparency = 1
        topLbl.Text                = txt
        topLbl.TextColor3          = Color3.fromRGB(210,210,220)
        topLbl.TextSize            = TXS
        topLbl.Font                = Enum.Font.Gotham
        topLbl.TextXAlignment      = Enum.TextXAlignment.Left
        topLbl.Parent              = row

        local valLbl = Instance.new("TextLabel")
        valLbl.Size                = UDim2.new(0, 44, 0, MOBILE and 22 or 18)
        valLbl.Position            = UDim2.new(1, -50, 0, 3)
        valLbl.BackgroundTransparency = 1
        valLbl.Text                = tostring(getVal())
        valLbl.TextColor3          = Color3.fromRGB(180,180,255)
        valLbl.TextSize            = TXS
        valLbl.Font                = Enum.Font.GothamBold
        valLbl.TextXAlignment      = Enum.TextXAlignment.Right
        valLbl.Parent              = row

        local trackH = MOBILE and 12 or 8
        local trackY = MOBILE and 30 or 26

        local track = Instance.new("Frame")
        track.Size             = UDim2.new(1, -16, 0, trackH)
        track.Position         = UDim2.new(0, 8, 0, trackY)
        track.BackgroundColor3 = Color3.fromRGB(40,40,60)
        track.BorderSizePixel  = 0
        track.Parent           = row
        Instance.new("UICorner", track).CornerRadius = UDim.new(0, trackH/2)

        local function ratio() return (getVal() - min) / (max - min) end

        local fill = Instance.new("Frame")
        fill.Size             = UDim2.new(ratio(), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(80,80,220)
        fill.BorderSizePixel  = 0
        fill.Parent           = track
        Instance.new("UICorner", fill).CornerRadius = UDim.new(0, trackH/2)

        local KW = MOBILE and 20 or 14
        local knob = Instance.new("Frame")
        knob.Size             = UDim2.new(0, KW, 0, KW)
        knob.AnchorPoint      = Vector2.new(0.5, 0.5)
        knob.Position         = UDim2.new(ratio(), 0, 0.5, 0)
        knob.BackgroundColor3 = Color3.fromRGB(180,180,255)
        knob.BorderSizePixel  = 0
        knob.Parent           = track
        Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)

        -- Невидимая область ввода шире трека
        local hitbox = Instance.new("TextButton")
        hitbox.Size             = UDim2.new(1, 0, 0, MOBILE and 40 or 28)
        hitbox.Position         = UDim2.new(0, 0, 0.5, MOBILE and -20 or -14)
        hitbox.BackgroundTransparency = 1
        hitbox.Text             = ""
        hitbox.Parent           = track

        local sliding = false

        local function Apply(inputX)
            local abs  = track.AbsolutePosition
            local size = track.AbsoluteSize
            local r    = math.clamp((inputX - abs.X) / size.X, 0, 1)
            local val  = math.floor(min + (max - min) * r)
            setVal(val)
            fill.Size     = UDim2.new(r, 0, 1, 0)
            knob.Position = UDim2.new(r, 0, 0.5, 0)
            valLbl.Text   = tostring(val)
            FovCircle.Radius = CFG.AimFOV
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
        UserInputService.InputChanged:Connect(function(inp)
            if sliding and (
                inp.UserInputType == Enum.UserInputType.MouseMovement
             or inp.UserInputType == Enum.UserInputType.Touch
            ) then Apply(inp.Position.X) end
        end)
    end

    -- ══ Строим меню ══
    Sec("MASTER")
    Toggle("ESP On/Off",
        function() return true end,  -- начальное
        function(v)
            if not v then
                for _, d  in pairs(PlrESP) do HideAll(d) end
                for _, en in pairs(EntESP) do HideAll(en.d) end
            end
        end)

    Sec("AIMBOT")
    Toggle("Aimbot",       function() return CFG.Aimbot         end, function(v) CFG.Aimbot         = v end)
    Toggle("Aim Players",  function() return CFG.AimPlayers     end, function(v) CFG.AimPlayers     = v end)
    Toggle("Aim NPCs",     function() return CFG.AimNPCs        end, function(v) CFG.AimNPCs        = v end)
    Toggle("Show FOV Circle", function() return CFG.ShowFOVCircle end, function(v) CFG.ShowFOVCircle = v end)
    Slider("FOV Radius", 30, 350, function() return CFG.AimFOV end, function(v) CFG.AimFOV = v end)

    Sec("PLAYERS")
    Toggle("Players",      function() return CFG.ESP_Players  end, function(v) CFG.ESP_Players  = v end)
    Toggle("Box",          function() return CFG.ShowBox      end, function(v) CFG.ShowBox      = v end)
    Toggle("Name",         function() return CFG.ShowName     end, function(v) CFG.ShowName     = v end)
    Toggle("Health Bar",   function() return CFG.ShowHealth   end, function(v) CFG.ShowHealth   = v end)
    Toggle("Distance",     function() return CFG.ShowDist     end, function(v) CFG.ShowDist     = v end)
    Toggle("Tracer",       function() return CFG.ShowTracer   end, function(v) CFG.ShowTracer   = v end)

    Sec("ENTITIES")
    Toggle("NPCs",         function() return CFG.ESP_NPCs       end, function(v) CFG.ESP_NPCs      = v end)
    Toggle("Loot",         function() return CFG.ESP_Loot       end, function(v) CFG.ESP_Loot      = v end)
    Toggle("Resources",    function() return CFG.ESP_Resources  end, function(v) CFG.ESP_Resources = v end)
    Toggle("Vehicles",     function() return CFG.ESP_Vehicles   end, function(v) CFG.ESP_Vehicles  = v end)
    Toggle("Danger",       function() return CFG.ESP_Danger     end, function(v) CFG.ESP_Danger    = v end)

    -- ══ Перетаскивание панели ══
    local drag, dragStart, panStart
    titleRow.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            drag = true; dragStart = inp.Position; panStart = panel.Position
            inp.Changed:Connect(function()
                if inp.UserInputState == Enum.UserInputState.End then drag = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if drag and (
            inp.UserInputType == Enum.UserInputType.MouseMovement
         or inp.UserInputType == Enum.UserInputType.Touch
        ) then
            local d = inp.Position - dragStart
            panel.Position = UDim2.new(
                panStart.X.Scale, panStart.X.Offset + d.X,
                panStart.Y.Scale, panStart.Y.Offset + d.Y
            )
        end
    end)
end

BuildGUI()

-- ============================================================
-- КЛАВИАТУРА (ПК)
-- ============================================================
UserInputService.InputBegan:Connect(function(inp, gp)
    if gp then return end
    if inp.KeyCode == Enum.KeyCode.RightShift then
        CFG.Aimbot = not CFG.Aimbot
        FovCircle.Visible = CFG.Aimbot and CFG.ShowFOVCircle
    end
    if inp.KeyCode == Enum.KeyCode.Insert then
        local gui = LocalPlayer.PlayerGui:FindFirstChild("TESP")
        if gui then gui.Enabled = not gui.Enabled end
    end
end)

-- ============================================================
-- ВЫГРУЗКА
-- ============================================================
_G.TESP_Unload = function()
    for _, d  in pairs(PlrESP) do RemoveAll(d) end
    for _, en in pairs(EntESP) do RemoveAll(en.d) end
    pcall(function() FovCircle:Remove() end)
    local gui = LocalPlayer.PlayerGui:FindFirstChild("TESP")
    if gui then gui:Destroy() end
    print("[TESP] Unloaded")
end

print("[TESP] Loaded | RightShift = Aim toggle | Insert = GUI | _G.TESP_Unload()")
