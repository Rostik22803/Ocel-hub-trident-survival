--[[
  OCEL-HUB v2.0
  Local UI Library (OcelUI) - No HTTP requests
  Mobile Adapted - Touch Support
  Game: Trident Survival
  Themes: Dark, Ocean, Crimson, Forest, AmberGlow
]]

-- SERVICES
Players = game:GetService("Players")
RunService = game:GetService("RunService")
localPlayer = Players.LocalPlayer
ReplicatedStorage = game:GetService("ReplicatedStorage")
camera = workspace.CurrentCamera
Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local HttpService = game:GetService("HttpService")
local configFileName = "OcelHubStyleConfig.json"

local defaultStyle = {
    Theme = "Dark",
    AccentColor = {100, 160, 255}, -- RGB format
    ToggleKey = "K"
}

local currentStyle = {}
for k, v in pairs(defaultStyle) do
    currentStyle[k] = v
end

if isfile and isfile(configFileName) then
    pcall(function()
        local fileContent = readfile(configFileName)
        local loaded = HttpService:JSONDecode(fileContent)
        if loaded then
            if loaded.Theme then currentStyle.Theme = loaded.Theme end
            if loaded.AccentColor then currentStyle.AccentColor = loaded.AccentColor end
            if loaded.ToggleKey then currentStyle.ToggleKey = loaded.ToggleKey end
        end
    end)
end

local function saveStyle()
    if writefile then
        pcall(function()
            writefile(configFileName, HttpService:JSONEncode(currentStyle))
        end)
    end
end

-- MOBILE DETECTION AND ADAPTIVE SIZES
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local VP = workspace.CurrentCamera.ViewportSize
local S = {
    W=isMobile and math.min(VP.X-16,430) or 500, H=isMobile and math.min(VP.Y-80,550) or 590,
    ItemH=isMobile and 52 or 40, SliderH=isMobile and 64 or 50,
    FontSm=isMobile and 15 or 13, FontMd=isMobile and 17 or 14, FontLg=isMobile and 20 or 16,
    Pad=isMobile and 11 or 8, TitleH=isMobile and 56 or 44, TabBarH=isMobile and 50 or 38,
    TabH=isMobile and 42 or 30, TglW=isMobile and 58 or 44, TglH=isMobile and 30 or 24,
}

-- THEMES
local Themes = {
    Dark={Bg=Color3.fromRGB(13,13,20),Sec=Color3.fromRGB(20,20,30),Pan=Color3.fromRGB(28,28,42),Acc=Color3.fromRGB(100,160,255),Txt=Color3.fromRGB(235,235,248),Sub=Color3.fromRGB(130,130,160),TOn=Color3.fromRGB(72,200,115),TOff=Color3.fromRGB(50,50,72),Brd=Color3.fromRGB(42,42,65)},
    Ocean={Bg=Color3.fromRGB(6,16,30),Sec=Color3.fromRGB(10,26,48),Pan=Color3.fromRGB(14,36,62),Acc=Color3.fromRGB(0,195,175),Txt=Color3.fromRGB(195,230,255),Sub=Color3.fromRGB(110,155,195),TOn=Color3.fromRGB(0,195,175),TOff=Color3.fromRGB(15,48,78),Brd=Color3.fromRGB(25,55,95)},
    Crimson={Bg=Color3.fromRGB(16,7,10),Sec=Color3.fromRGB(26,10,16),Pan=Color3.fromRGB(36,14,22),Acc=Color3.fromRGB(215,55,75),Txt=Color3.fromRGB(248,218,222),Sub=Color3.fromRGB(175,125,135),TOn=Color3.fromRGB(215,55,75),TOff=Color3.fromRGB(52,22,32),Brd=Color3.fromRGB(65,28,42)},
    Forest={Bg=Color3.fromRGB(8,16,10),Sec=Color3.fromRGB(14,26,16),Pan=Color3.fromRGB(20,36,22),Acc=Color3.fromRGB(75,195,95),Txt=Color3.fromRGB(218,245,222),Sub=Color3.fromRGB(135,180,140),TOn=Color3.fromRGB(75,195,95),TOff=Color3.fromRGB(22,52,26),Brd=Color3.fromRGB(36,72,42)},
    AmberGlow={Bg=Color3.fromRGB(16,12,6),Sec=Color3.fromRGB(26,20,10),Pan=Color3.fromRGB(36,28,14),Acc=Color3.fromRGB(255,160,25),Txt=Color3.fromRGB(255,240,208),Sub=Color3.fromRGB(185,160,115),TOn=Color3.fromRGB(255,160,25),TOff=Color3.fromRGB(62,45,18),Brd=Color3.fromRGB(82,58,20)},
}
local T = Themes[currentStyle.Theme] or Themes.Dark

-- UTILITIES
local function Tw(obj,props,dur,style) TweenService:Create(obj,TweenInfo.new(dur or 0.2,style or Enum.EasingStyle.Quad,Enum.EasingDirection.Out),props):Play() end
local function Corner(f,r) local c=Instance.new("UICorner"); c.CornerRadius=UDim.new(0,r or 8); c.Parent=f; return c end
local function Stroke(f,col,th) local s=Instance.new("UIStroke"); s.Color=col or T.Brd; s.Thickness=th or 1; s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border; s.Parent=f; return s end
local function New(cls,props,parent)
    local i=Instance.new(cls)
    for k,v in pairs(props) do pcall(function() i[k]=v end) end
    if parent then i.Parent=parent end
    return i
end
local function MakeDraggable(handle,target)
    local drag,ds,sp=false,nil,nil
    handle.InputBegan:Connect(function(inp,proc)
        if proc then return end
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            drag=true; ds=inp.Position; sp=target.Position
            inp.Changed:Connect(function() if inp.UserInputState==Enum.UserInputState.End then drag=false end end)
        end
    end)
    handle.InputChanged:Connect(function(inp)
        if drag and (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
            local d=inp.Position-ds
            target.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
        end
    end)
end

-- ================================================================
-- OCELUI LIBRARY - Full local UI library (Rayfield replacement)
-- ================================================================
local OcelUI = {}; OcelUI.__index = OcelUI
local _GUI=nil; local _ToggleKey=Enum.KeyCode.K; local _Visible=true
local _accentRefs={}; local _panelRefs={}; local _borderRefs={}

function OcelUI:Destroy() if _GUI then pcall(function() _GUI:Destroy() end); _GUI=nil end end

function OcelUI:CreateWindow(cfg)
    if _GUI then pcall(function() _GUI:Destroy() end) end
    _accentRefs={}; _panelRefs={}; _borderRefs={}
    local chosenThemeName = currentStyle.Theme or cfg.Theme or "Dark"
    if Themes[chosenThemeName] then
        T = {}
        for k, v in pairs(Themes[chosenThemeName]) do T[k] = v end
    else
        T = {}
        for k, v in pairs(Themes.Dark) do T[k] = v end
    end
    if currentStyle.AccentColor then
        T.Acc = Color3.fromRGB(currentStyle.AccentColor[1], currentStyle.AccentColor[2], currentStyle.AccentColor[3])
    end
    local keyName = currentStyle.ToggleKey or cfg.ToggleUIKeybind or "K"
    pcall(function() _ToggleKey = Enum.KeyCode[keyName] end)

    local gui=New("ScreenGui",{Name="OcelHub",ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,DisplayOrder=100,IgnoreGuiInset=true})
    local ok=pcall(function() gui.Parent=game:GetService("CoreGui") end)
    if not ok then gui.Parent=localPlayer:WaitForChild("PlayerGui") end
    _GUI=gui

    local shadowLbl=New("ImageLabel",{Name="Shadow",AnchorPoint=Vector2.new(0.5,0.5),Size=UDim2.new(0,S.W+60,0,S.H+60),Position=UDim2.new(0.5,0,0.5,0),BackgroundTransparency=1,Image="rbxassetid://6014261993",ImageColor3=Color3.fromRGB(0,0,0),ImageTransparency=0.5,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),ZIndex=0},gui)
    local main=New("Frame",{Name="Main",AnchorPoint=Vector2.new(0.5,0.5),Size=UDim2.new(0,S.W,0,S.H),Position=UDim2.new(0.5,0,0.5,0),BackgroundColor3=T.Bg,BorderSizePixel=0,ClipsDescendants=true,ZIndex=1},gui)
    Corner(main,12); local mainStroke=Stroke(main,T.Brd,1.5); table.insert(_borderRefs,mainStroke)

    local titleBar=New("Frame",{Name="TitleBar",Size=UDim2.new(1,0,0,S.TitleH),BackgroundColor3=T.Sec,BorderSizePixel=0,ZIndex=3},main)
    local accentLine=New("Frame",{Size=UDim2.new(1,0,0,2),Position=UDim2.new(0,0,1,-2),BackgroundColor3=T.Acc,BorderSizePixel=0,ZIndex=4},titleBar)
    table.insert(_accentRefs,{obj=accentLine,prop="BackgroundColor3"})
    New("UIGradient",{Color=ColorSequence.new({ColorSequenceKeypoint.new(0,T.Sec),ColorSequenceKeypoint.new(1,Color3.fromRGB(math.clamp(T.Sec.R*255+12,0,255)/255,math.clamp(T.Sec.G*255+12,0,255)/255,math.clamp(T.Sec.B*255+12,0,255)/255))}),Rotation=90},titleBar)
    local dot=New("Frame",{Size=UDim2.new(0,8,0,8),Position=UDim2.new(0,12,0.5,-4),BackgroundColor3=T.Acc,BorderSizePixel=0,ZIndex=5},titleBar)
    Corner(dot,4); table.insert(_accentRefs,{obj=dot,prop="BackgroundColor3"})
    local titleLbl=New("TextLabel",{Name="Title",Size=UDim2.new(1,-70,1,0),Position=UDim2.new(0,26,0,0),BackgroundTransparency=1,Text=cfg.Name or "Ocel-Hub",TextColor3=T.Txt,TextSize=S.FontLg,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Left,ZIndex=5},titleBar)
    local closeSz=isMobile and 40 or 30
    local closeBtn=New("TextButton",{Size=UDim2.new(0,closeSz,0,closeSz),Position=UDim2.new(1,-(closeSz+8),0.5,-closeSz/2),BackgroundColor3=Color3.fromRGB(200,55,55),Text="X",TextColor3=Color3.fromRGB(255,255,255),TextSize=isMobile and 15 or 12,Font=Enum.Font.GothamBold,BorderSizePixel=0,AutoButtonColor=false,ZIndex=6},titleBar)
    Corner(closeBtn,6); MakeDraggable(titleBar,main)

    local tabBar=New("ScrollingFrame",{Name="TabBar",Size=UDim2.new(1,0,0,S.TabBarH),Position=UDim2.new(0,0,0,S.TitleH),BackgroundColor3=T.Sec,BorderSizePixel=0,ScrollBarThickness=0,CanvasSize=UDim2.new(0,0,0,0),ScrollingDirection=Enum.ScrollingDirection.X,AutomaticCanvasSize=Enum.AutomaticSize.X,ZIndex=3},main)
    New("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,3),VerticalAlignment=Enum.VerticalAlignment.Center},tabBar)
    New("UIPadding",{PaddingLeft=UDim.new(0,6),PaddingRight=UDim.new(0,6),PaddingTop=UDim.new(0,5),PaddingBottom=UDim.new(0,5)},tabBar)
    New("Frame",{Size=UDim2.new(1,0,0,1),Position=UDim2.new(0,0,1,-1),BackgroundColor3=T.Brd,BorderSizePixel=0,ZIndex=4},tabBar)

    local contentArea=New("Frame",{Name="Content",Size=UDim2.new(1,0,1,-(S.TitleH+S.TabBarH)),Position=UDim2.new(0,0,0,S.TitleH+S.TabBarH),BackgroundTransparency=1,BorderSizePixel=0,ClipsDescendants=true,ZIndex=2},main)

    local floatSz=isMobile and 54 or 42
    local floatBtn=New("TextButton",{Name="FloatToggle",AnchorPoint=Vector2.new(0,0.5),Size=UDim2.new(0,floatSz,0,floatSz),Position=UDim2.new(0,12,0.5,0),BackgroundColor3=T.Acc,Text="M",TextColor3=Color3.fromRGB(255,255,255),TextSize=isMobile and 24 or 19,Font=Enum.Font.GothamBold,BorderSizePixel=0,ZIndex=500,Visible=false,AutoButtonColor=false},gui)
    Corner(floatBtn,11); Stroke(floatBtn,T.Brd,1.5); MakeDraggable(floatBtn,floatBtn)
    table.insert(_accentRefs,{obj=floatBtn,prop="BackgroundColor3"})

    local function showUI() _Visible=true; main.Visible=true; shadowLbl.Visible=true; floatBtn.Visible=false; Tw(main,{Position=UDim2.new(0.5,0,0.5,0)},0.25) end
    local function hideUI()
        _Visible=false; Tw(main,{Position=UDim2.new(0.5,0,1.5,0)},0.25)
        task.delay(0.28,function() if not _Visible then main.Visible=false; shadowLbl.Visible=false; floatBtn.Visible=true end end)
    end
    closeBtn.MouseButton1Click:Connect(hideUI); floatBtn.MouseButton1Click:Connect(showUI)
    UserInputService.InputBegan:Connect(function(inp,proc) if proc then return end; if inp.KeyCode==_ToggleKey then if _Visible then hideUI() else showUI() end end end)

    local tabs={}; local activeTab=nil
    local function activateTab(info)
        if activeTab then activeTab.content.Visible=false; Tw(activeTab.btn,{BackgroundColor3=T.Pan,TextColor3=T.Sub},0.15) end
        activeTab=info; info.content.Visible=true; Tw(info.btn,{BackgroundColor3=T.Acc,TextColor3=Color3.fromRGB(255,255,255)},0.15)
    end

    local Window={}
    function Window:UpdateTitle(txt) titleLbl.Text=txt or "Ocel-Hub" end
    function Window:ApplyTheme(name)
        local theme=Themes[name]; if not theme then return end
        T = {}
        for k, v in pairs(theme) do T[k] = v end
        currentStyle.Theme = name
        currentStyle.AccentColor = {math.floor(theme.Acc.R*255), math.floor(theme.Acc.G*255), math.floor(theme.Acc.B*255)}
        saveStyle()
        main.BackgroundColor3=T.Bg; titleBar.BackgroundColor3=T.Sec; tabBar.BackgroundColor3=T.Sec; titleLbl.TextColor3=T.Txt
        for _,r in pairs(_accentRefs) do r.obj[r.prop]=T.Acc end
        for _,s in pairs(_borderRefs) do s.Color=T.Brd end
        for _,p in pairs(_panelRefs) do p.obj[p.prop]=T[p.key] end
        if activeTab then Tw(activeTab.btn,{BackgroundColor3=T.Acc,TextColor3=Color3.fromRGB(255,255,255)},0.15) end
    end
    function Window:SetAccentColor(color)
        T.Acc=color
        currentStyle.AccentColor = {math.floor(color.R*255), math.floor(color.G*255), math.floor(color.B*255)}
        saveStyle()
        for _,r in pairs(_accentRefs) do r.obj[r.prop]=color end
        if activeTab then activeTab.btn.BackgroundColor3=color end
    end
    function Window:SetToggleKey(keyStr)
        pcall(function()
            _ToggleKey=Enum.KeyCode[keyStr]
            currentStyle.ToggleKey = keyStr
            saveStyle()
        end)
    end
    function Window:Destroy() if _GUI then _GUI:Destroy(); _GUI=nil end end

    function Window:CreateTab(name,_icon)
        local nameStr=tostring(name)
        local btnW=math.max(isMobile and 88 or 72,#nameStr*(isMobile and 10 or 8)+24)
        local tabBtn=New("TextButton",{Name="Tab_"..nameStr,Size=UDim2.new(0,btnW,0,S.TabH),BackgroundColor3=T.Pan,Text=nameStr,TextColor3=T.Sub,TextSize=S.FontSm,Font=Enum.Font.GothamSemibold,BorderSizePixel=0,LayoutOrder=#tabs+1,AutoButtonColor=false},tabBar)
        Corner(tabBtn,6)
        local tabContent=New("ScrollingFrame",{Name="TC_"..nameStr,Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=isMobile and 5 or 3,ScrollBarImageColor3=T.Acc,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,Visible=false,ZIndex=2},contentArea)
        New("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,S.Pad-2)},tabContent)
        New("UIPadding",{PaddingLeft=UDim.new(0,S.Pad),PaddingRight=UDim.new(0,S.Pad+(isMobile and 8 or 4)),PaddingTop=UDim.new(0,S.Pad),PaddingBottom=UDim.new(0,S.Pad+8)},tabContent)
        local tabInfo={btn=tabBtn,content=tabContent}; table.insert(tabs,tabInfo)
        tabBtn.MouseButton1Click:Connect(function() activateTab(tabInfo) end)
        if #tabs==1 then activateTab(tabInfo) end

        local Tab={}; local order=0; local function nxt() order=order+1; return order end

        local function MakeItem(label,h)
            local fr=New("Frame",{Size=UDim2.new(1,0,0,h or S.ItemH),BackgroundColor3=T.Pan,BorderSizePixel=0,LayoutOrder=nxt()},tabContent)
            Corner(fr,8); local st=Stroke(fr,T.Brd,1); table.insert(_borderRefs,st); table.insert(_panelRefs,{obj=fr,prop="BackgroundColor3",key="Pan"})
            local lbl=New("TextLabel",{Size=UDim2.new(0.58,0,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=label,TextColor3=T.Txt,TextSize=S.FontMd,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd},fr)
            table.insert(_panelRefs,{obj=lbl,prop="TextColor3",key="Txt"}); return fr,lbl
        end

        function Tab:CreateSection(sName)
            local sec=New("Frame",{Size=UDim2.new(1,0,0,isMobile and 28 or 22),BackgroundTransparency=1,BorderSizePixel=0,LayoutOrder=nxt()},tabContent)
            New("Frame",{Size=UDim2.new(0.35,-6,0,1),Position=UDim2.new(0,0,0.5,0),BackgroundColor3=T.Brd,BorderSizePixel=0},sec)
            New("Frame",{Size=UDim2.new(0.35,-6,0,1),Position=UDim2.new(0.65,6,0.5,0),BackgroundColor3=T.Brd,BorderSizePixel=0},sec)
            New("TextLabel",{Size=UDim2.new(0.3,0,1,0),Position=UDim2.new(0.35,0,0,0),BackgroundTransparency=1,Text=sName,TextColor3=T.Sub,TextSize=S.FontSm-1,Font=Enum.Font.GothamSemibold,TextXAlignment=Enum.TextXAlignment.Center},sec)
            return sec
        end

        function Tab:CreateToggle(cfg)
            local fr,_=MakeItem(cfg.Name,S.ItemH); local val=cfg.CurrentValue==true
            local tW,tH=S.TglW,S.TglH; local kSz=tH-6
            local track=New("Frame",{Size=UDim2.new(0,tW,0,tH),Position=UDim2.new(1,-(tW+12),0.5,-tH/2),BackgroundColor3=val and T.TOn or T.TOff,BorderSizePixel=0,ZIndex=3},fr)
            Corner(track,tH/2); Stroke(track,T.Brd,1)
            local knob=New("Frame",{Size=UDim2.new(0,kSz,0,kSz),Position=UDim2.new(0,val and (tW-kSz-3) or 3,0.5,-kSz/2),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,ZIndex=4},track)
            Corner(knob,kSz/2)
            local obj={CurrentValue=val}
            local function setVal(v) val=v; obj.CurrentValue=v; Tw(track,{BackgroundColor3=v and T.TOn or T.TOff},0.18); Tw(knob,{Position=UDim2.new(0,v and (tW-kSz-3) or 3,0.5,-kSz/2)},0.18); pcall(cfg.Callback,v) end
            fr.InputBegan:Connect(function(inp,proc) if proc then return end; if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then setVal(not val) end end)
            return obj
        end

        function Tab:CreateSlider(cfg)
            local fr,_=MakeItem(cfg.Name,S.SliderH); local mn,mx=cfg.Range[1],cfg.Range[2]
            local inc=cfg.Increment or 1; local suf=cfg.Suffix or ""; local val=math.clamp(cfg.CurrentValue or mn,mn,mx)
            local valLbl=New("TextLabel",{Size=UDim2.new(0,68,0,20),Position=UDim2.new(1,-80,0,(S.SliderH/2-20)/2),BackgroundTransparency=1,Text=tostring(val).." "..suf,TextColor3=T.Acc,TextSize=S.FontSm,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Right,ZIndex=3},fr)
            table.insert(_accentRefs,{obj=valLbl,prop="TextColor3"})
            local tPad=12; local tLineH=isMobile and 8 or 6; local tY=S.SliderH-(isMobile and 18 or 14)
            local trackBg=New("Frame",{Size=UDim2.new(1,-tPad*2,0,tLineH),Position=UDim2.new(0,tPad,0,tY),BackgroundColor3=T.TOff,BorderSizePixel=0,ZIndex=3},fr)
            Corner(trackBg,tLineH/2)
            local p0=(val-mn)/(mx-mn)
            local fill=New("Frame",{Size=UDim2.new(p0,0,1,0),BackgroundColor3=T.Acc,BorderSizePixel=0,ZIndex=4},trackBg)
            Corner(fill,tLineH/2); table.insert(_accentRefs,{obj=fill,prop="BackgroundColor3"})
            local thSz=isMobile and 20 or 16
            local thumb=New("Frame",{Size=UDim2.new(0,thSz,0,thSz),Position=UDim2.new(p0,-thSz/2,0.5,-thSz/2),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0,ZIndex=5},trackBg)
            Corner(thumb,thSz/2); local thStroke=Stroke(thumb,T.Acc,2); table.insert(_accentRefs,{obj=thStroke,prop="Color"})
            local obj={CurrentValue=val}; local sliding=false
            local function upd(pos)
                local rel=pos.X-trackBg.AbsolutePosition.X; local p=math.clamp(rel/trackBg.AbsoluteSize.X,0,1)
                local raw=mn+(mx-mn)*p; local dec=math.max(0,math.floor(-math.log10(math.max(inc,0.0001))+0.5))
                local snapped=math.clamp(math.floor(raw/inc+0.5)*inc,mn,mx); snapped=math.floor(snapped*10^dec+0.5)/10^dec
                val=snapped; obj.CurrentValue=snapped; local np=(snapped-mn)/(mx-mn)
                fill.Size=UDim2.new(np,0,1,0); thumb.Position=UDim2.new(np,-thSz/2,0.5,-thSz/2); valLbl.Text=tostring(snapped).." "..suf; pcall(cfg.Callback,snapped)
            end
            trackBg.InputBegan:Connect(function(inp,proc) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then sliding=true; upd(inp.Position) end end)
            UserInputService.InputChanged:Connect(function(inp) if sliding and (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then upd(inp.Position) end end)
            UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then sliding=false end end)
            return obj
        end

        function Tab:CreateButton(cfg)
            local fr=New("Frame",{Size=UDim2.new(1,0,0,S.ItemH),BackgroundTransparency=1,BorderSizePixel=0,LayoutOrder=nxt()},tabContent)
            local btn=New("TextButton",{Size=UDim2.new(1,0,1,0),BackgroundColor3=T.Acc,Text=cfg.Name,TextColor3=Color3.fromRGB(255,255,255),TextSize=S.FontMd,Font=Enum.Font.GothamBold,BorderSizePixel=0,AutoButtonColor=false},fr)
            Corner(btn,8); table.insert(_accentRefs,{obj=btn,prop="BackgroundColor3"})
            btn.MouseButton1Click:Connect(function()
                local orig=T.Acc; local dim=Color3.fromRGB(math.clamp(orig.R*255-35,0,255)/255,math.clamp(orig.G*255-35,0,255)/255,math.clamp(orig.B*255-35,0,255)/255)
                Tw(btn,{BackgroundColor3=dim},0.08); task.delay(0.14,function() Tw(btn,{BackgroundColor3=orig},0.1) end); pcall(cfg.Callback)
            end); return {Button=btn}
        end

        function Tab:CreateDropdown(cfg)
            local h=S.ItemH+(isMobile and 2 or 0)
            local fr=New("Frame",{Size=UDim2.new(1,0,0,h),BackgroundColor3=T.Pan,BorderSizePixel=0,LayoutOrder=nxt(),ClipsDescendants=false,ZIndex=2},tabContent)
            Corner(fr,8); local st2=Stroke(fr,T.Brd,1); table.insert(_borderRefs,st2); table.insert(_panelRefs,{obj=fr,prop="BackgroundColor3",key="Pan"})
            New("TextLabel",{Size=UDim2.new(0.52,0,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,Text=cfg.Name,TextColor3=T.Txt,TextSize=S.FontMd,Font=Enum.Font.Gotham,TextXAlignment=Enum.TextXAlignment.Left,TextTruncate=Enum.TextTruncate.AtEnd,ZIndex=3},fr)
            local curOpt=(cfg.CurrentOption and cfg.CurrentOption[1]) or (cfg.Options and cfg.Options[1]) or ""
            local dBW=isMobile and 0.44 or 0.42
            local dBtn=New("TextButton",{Size=UDim2.new(dBW,-4,0,h-10),Position=UDim2.new(1-dBW,2,0.5,-(h-10)/2),BackgroundColor3=T.Sec,Text=curOpt.." v",TextColor3=T.Txt,TextSize=S.FontSm,Font=Enum.Font.Gotham,BorderSizePixel=0,AutoButtonColor=false,ClipsDescendants=true,ZIndex=3},fr)
            Corner(dBtn,6); Stroke(dBtn,T.Brd,1); table.insert(_panelRefs,{obj=dBtn,prop="BackgroundColor3",key="Sec"})
            local obj={CurrentOption={curOpt}}; local open=false; local dropFr=nil
            dBtn.MouseButton1Click:Connect(function()
                if open then if dropFr then dropFr:Destroy(); dropFr=nil end; open=false; return end
                open=true; local optH=isMobile and 44 or 33; local showCnt=math.min(#cfg.Options,5)
                dropFr=New("Frame",{Size=UDim2.new(dBW,-4,0,showCnt*optH+6),Position=UDim2.new(1-dBW,2,0,h+2),BackgroundColor3=T.Sec,BorderSizePixel=0,ZIndex=30,ClipsDescendants=true},fr)
                Corner(dropFr,7); Stroke(dropFr,T.Brd,1)
                local sf=New("ScrollingFrame",{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=isMobile and 4 or 3,ScrollBarImageColor3=T.Acc,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.Y,ZIndex=31},dropFr)
                New("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder},sf)
                for i,opt in ipairs(cfg.Options) do
                    local isCur=(opt==curOpt)
                    local ob=New("TextButton",{Size=UDim2.new(1,0,0,optH),BackgroundColor3=isCur and T.Acc or T.Pan,BackgroundTransparency=isCur and 0 or 0.4,Text="  "..opt,TextColor3=isCur and Color3.fromRGB(255,255,255) or T.Txt,TextSize=S.FontSm,Font=isCur and Enum.Font.GothamSemibold or Enum.Font.Gotham,BorderSizePixel=0,LayoutOrder=i,TextXAlignment=Enum.TextXAlignment.Left,AutoButtonColor=false,ZIndex=32},sf)
                    ob.MouseButton1Click:Connect(function()
                        curOpt=opt; obj.CurrentOption={opt}; dBtn.Text=opt.." v"
                        if dropFr then dropFr:Destroy(); dropFr=nil end; open=false
                        if cfg.MultipleOptions then pcall(cfg.Callback,{opt}) else pcall(cfg.Callback,opt) end
                    end)
                end
            end); return obj
        end

        function Tab:CreateColorPicker(cfg)
            local fr,_=MakeItem(cfg.Name,S.ItemH); local curColor=cfg.Color or Color3.fromRGB(255,255,255)
            local pW=isMobile and 36 or 28; local pH=isMobile and 26 or 20
            local preview=New("Frame",{Size=UDim2.new(0,pW,0,pH),Position=UDim2.new(1,-(pW+12),0.5,-pH/2),BackgroundColor3=curColor,BorderSizePixel=0,ZIndex=3},fr)
            Corner(preview,6); Stroke(preview,T.Brd,1.5)
            local obj={Color=curColor}; local pickerOpen=false; local pickerFr=nil
            local function closePicker() if pickerFr then pcall(function() pickerFr:Destroy() end); pickerFr=nil end; pickerOpen=false end
            local function openPicker()
                if pickerOpen then closePicker(); return end; pickerOpen=true
                local pw=isMobile and (S.W-S.Pad*2-24) or 230; local hueH=isMobile and 34 or 24; local svH=isMobile and 140 or 105
                pickerFr=New("Frame",{Size=UDim2.new(0,pw,0,hueH+svH+38),Position=UDim2.new(0,0,0,S.ItemH+2),BackgroundColor3=T.Sec,BorderSizePixel=0,ZIndex=20,ClipsDescendants=true},fr)
                Corner(pickerFr,8); Stroke(pickerFr,T.Brd,1)
                local topPrev=New("Frame",{Size=UDim2.new(0,isMobile and 28 or 20,0,isMobile and 28 or 20),Position=UDim2.new(1,-(isMobile and 36 or 28),0,6),BackgroundColor3=curColor,BorderSizePixel=0,ZIndex=21},pickerFr)
                Corner(topPrev,4); Stroke(topPrev,T.Brd,1)
                local hueBar=New("Frame",{Size=UDim2.new(1,-16,0,hueH),Position=UDim2.new(0,8,0,7),BackgroundColor3=Color3.fromRGB(255,0,0),BorderSizePixel=0,ZIndex=21,ClipsDescendants=true},pickerFr)
                Corner(hueBar,hueH/2)
                local hKPs={}; for i=0,6 do table.insert(hKPs,ColorSequenceKeypoint.new(i/6,Color3.fromHSV(i/6,1,1))) end
                New("UIGradient",{Color=ColorSequence.new(hKPs)},hueBar)
                local svPicker=New("Frame",{Size=UDim2.new(1,-16,0,svH),Position=UDim2.new(0,8,0,hueH+15),BackgroundColor3=Color3.fromRGB(255,0,0),BorderSizePixel=0,ZIndex=21,ClipsDescendants=true},pickerFr)
                Corner(svPicker,6)
                local wGr=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.fromRGB(255,255,255),ZIndex=22},svPicker)
                New("UIGradient",{Color=ColorSequence.new(Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255)),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)})},wGr)
                local bGr=New("Frame",{Size=UDim2.new(1,0,1,0),BackgroundColor3=Color3.fromRGB(0,0,0),ZIndex=23},svPicker)
                New("UIGradient",{Color=ColorSequence.new(Color3.fromRGB(0,0,0),Color3.fromRGB(0,0,0)),Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0)}),Rotation=90},bGr)
                local h,s,v=Color3.toHSV(curColor); svPicker.BackgroundColor3=Color3.fromHSV(h,1,1)
                local hueCur=New("Frame",{Size=UDim2.new(0,6,1,6),Position=UDim2.new(h,-3,0,-3),BackgroundColor3=Color3.fromRGB(255,255,255),ZIndex=25,BorderSizePixel=0},hueBar)
                Corner(hueCur,3); Stroke(hueCur,Color3.fromRGB(0,0,0),1.5)
                local svCur=New("Frame",{Size=UDim2.new(0,10,0,10),Position=UDim2.new(s,-5,1-v,-5),BackgroundColor3=Color3.fromRGB(255,255,255),ZIndex=25,BorderSizePixel=0},svPicker)
                Corner(svCur,5); Stroke(svCur,Color3.fromRGB(0,0,0),1.5)
                local function applyColor() local nc=Color3.fromHSV(h,s,v); curColor=nc; obj.Color=nc; preview.BackgroundColor3=nc; topPrev.BackgroundColor3=nc; svPicker.BackgroundColor3=Color3.fromHSV(h,1,1); pcall(cfg.Callback,nc) end
                local hDrag,svDrag=false,false
                hueBar.InputBegan:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then hDrag=true; h=math.clamp((inp.Position.X-hueBar.AbsolutePosition.X)/hueBar.AbsoluteSize.X,0,1); hueCur.Position=UDim2.new(h,-3,0,-3); applyColor() end end)
                svPicker.InputBegan:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then svDrag=true; s=math.clamp((inp.Position.X-svPicker.AbsolutePosition.X)/svPicker.AbsoluteSize.X,0,1); v=1-math.clamp((inp.Position.Y-svPicker.AbsolutePosition.Y)/svPicker.AbsoluteSize.Y,0,1); svCur.Position=UDim2.new(s,-5,1-v,-5); applyColor() end end)
                UserInputService.InputChanged:Connect(function(inp)
                    if inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch then
                        if hDrag then h=math.clamp((inp.Position.X-hueBar.AbsolutePosition.X)/hueBar.AbsoluteSize.X,0,1); hueCur.Position=UDim2.new(h,-3,0,-3); applyColor() end
                        if svDrag then s=math.clamp((inp.Position.X-svPicker.AbsolutePosition.X)/svPicker.AbsoluteSize.X,0,1); v=1-math.clamp((inp.Position.Y-svPicker.AbsolutePosition.Y)/svPicker.AbsoluteSize.Y,0,1); svCur.Position=UDim2.new(s,-5,1-v,-5); applyColor() end
                    end
                end)
                UserInputService.InputEnded:Connect(function(inp) if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then hDrag=false; svDrag=false end end)
            end
            fr.InputBegan:Connect(function(inp,proc) if proc then return end; if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then local relX=inp.Position.X-fr.AbsolutePosition.X; if relX>fr.AbsoluteSize.X*0.54 then openPicker() end end end)
            return obj
        end

        function Tab:CreateKeybind(cfg)
            local fr,_=MakeItem(cfg.Name,S.ItemH); local curKey=cfg.CurrentKeybind or "None"; local holdIntr=cfg.HoldToInteract==true
            local isHeld=false; local listening=false; local kBW=isMobile and 72 or 60; local kBH=isMobile and 34 or 26
            local kBtn=New("TextButton",{Size=UDim2.new(0,kBW,0,kBH),Position=UDim2.new(1,-(kBW+12),0.5,-kBH/2),BackgroundColor3=T.Sec,Text=isMobile and (holdIntr and "HOLD" or "TAP") or "["..curKey.."]",TextColor3=T.Acc,TextSize=S.FontSm,Font=Enum.Font.GothamBold,BorderSizePixel=0,AutoButtonColor=false,ZIndex=3},fr)
            Corner(kBtn,6); Stroke(kBtn,T.Brd,1); table.insert(_accentRefs,{obj=kBtn,prop="TextColor3"})
            local obj={CurrentKeybind=curKey}
            if isMobile then
                local tapState=false; kBtn.BackgroundColor3=T.TOff
                kBtn.MouseButton1Click:Connect(function()
                    if holdIntr then tapState=not tapState; pcall(cfg.Callback,tapState); Tw(kBtn,{BackgroundColor3=tapState and T.TOn or T.TOff},0.15); kBtn.Text=tapState and "ON" or "HOLD"
                    else pcall(cfg.Callback); Tw(kBtn,{BackgroundColor3=T.Acc},0.08); task.delay(0.18,function() Tw(kBtn,{BackgroundColor3=T.TOff},0.1) end) end
                end)
            else
                kBtn.MouseButton1Click:Connect(function() listening=true; kBtn.Text="[...]"; kBtn.TextColor3=Color3.fromRGB(255,200,50) end)
                UserInputService.InputBegan:Connect(function(inp,proc)
                    if listening and not proc then if inp.UserInputType==Enum.UserInputType.Keyboard then curKey=inp.KeyCode.Name; obj.CurrentKeybind=curKey; kBtn.Text="["..curKey.."]"; kBtn.TextColor3=T.Acc; listening=false end
                    elseif not listening and not proc then if inp.KeyCode.Name==curKey then if holdIntr then isHeld=true; pcall(cfg.Callback,true) else pcall(cfg.Callback) end end end
                end)
                if holdIntr then UserInputService.InputEnded:Connect(function(inp) if inp.KeyCode.Name==curKey and isHeld then isHeld=false; pcall(cfg.Callback,false) end end) end
            end
            return obj
        end

        return Tab
    end
    return Window
end

-- ================================================================
-- GAME SCRIPT - TRIDENT SURVIVAL
-- ================================================================
local v0 = OcelUI

local l_v0_Window_0 = v0:CreateWindow({
    Name="Ocel-Hub", Theme="Dark", ToggleUIKeybind="K",
    ConfigurationSaving={Enabled=false,FolderName=nil,FileName="Ocel-Hub"}, KeySystem=false,
})

-- ==================== AIMBOT TAB ====================
local AimTab=l_v0_Window_0:CreateTab("AimBot",nil)
AimTab:CreateSection("Big Head")
Players=game:GetService("Players"); RunService=game:GetService("RunService")
localPlayer=Players.LocalPlayer; HeadSizeEnabled=false
local v4=0; local v5=25; headScale=Vector3.new(2,2,2); headTransparency=0; local v6={}
local function v9(v7) local l_Head_0=v7:FindFirstChild("Head"); if l_Head_0 and l_Head_0:IsA("BasePart") then if HeadSizeEnabled then if not v6[l_Head_0] then v6[l_Head_0]={Size=l_Head_0.Size,Transparency=l_Head_0.Transparency} end; l_Head_0.Size=headScale; l_Head_0.Transparency=headTransparency elseif v6[l_Head_0] then l_Head_0.Size=v6[l_Head_0].Size; l_Head_0.Transparency=v6[l_Head_0].Transparency; v6[l_Head_0]=nil end end end
RunService.RenderStepped:Connect(function() v4=v4+1; if v5<=v4 then v4=0; for _,v11 in pairs(workspace:GetChildren()) do if v11:IsA("Model") and v11~=localPlayer.Character then v9(v11) end end end end)
AimTab:CreateToggle({Name="Big Head",CurrentValue=false,Flag="HeadToggle",Callback=function(v12) HeadSizeEnabled=v12; if not v12 then for v13,v14 in pairs(v6) do if v13 and v13.Parent then v13.Size=v14.Size; v13.Transparency=v14.Transparency end end; v6={} end end})
AimTab:CreateSlider({Name="Head Size",Range={1,10},Increment=1,Suffix="x",CurrentValue=2,Flag="HeadSizeSlider",Callback=function(v16) headScale=Vector3.new(v16,v16,v16) end})
AimTab:CreateSlider({Name="Head Transparency",Range={0,1},Increment=0.1,CurrentValue=0,Flag="HeadTransparencySlider",Callback=function(v18) headTransparency=v18 end})

-- ==================== ESP TAB ====================
local EspTab=l_v0_Window_0:CreateTab("ESP",nil)
EspTab:CreateSection("Players")
local l_RunService_0=game:GetService("RunService"); local l_Workspace_0=game:GetService("Workspace"); local l_CurrentCamera_0=l_Workspace_0.CurrentCamera
local v25={}; local v26=false; local v27=true; local v28=true; local v29=true; local v30=false; local v31=true; local v32=false
local v33=Color3.fromRGB(255,255,255); local v34=Color3.fromRGB(255,255,255); local v35=Color3.fromRGB(255,255,255)
EspTab:CreateToggle({Name="Box Esp",CurrentValue=false,Flag="BoxEspToggle",Callback=function(v37) ToggleBoxes(v37) end})
EspTab:CreateToggle({Name="Distance Esp",CurrentValue=false,Flag="DistanceEspToggle",Callback=function(v38) ToggleDistance(v38) end})
EspTab:CreateToggle({Name="Player/Bot Esp",CurrentValue=false,Flag="BotEspToggle",Callback=function(v39) ToggleType(v39) end})
EspTab:CreateToggle({Name="Sleeper Check",CurrentValue=false,Flag="SleeperCheckToggle",Callback=function(v40) ToggleSleeperCheck(v40) end})
EspTab:CreateToggle({Name="Weapon Esp",CurrentValue=false,Flag="WeaponEspToggle",Callback=function(v41) ToggleWeaponESP(v41) end})
EspTab:CreateToggle({Name="Skeleton Esp",CurrentValue=false,Flag="SkeletonEspToggle",Callback=function(v42) ToggleSkeletonESP(v42) end})
EspTab:CreateColorPicker({Name="Box Color",Color=Color3.fromRGB(255,255,255),Flag="BoxColorPicker1",Callback=function(v43) v33=v43 end})
EspTab:CreateColorPicker({Name="Skeleton Color",Color=Color3.fromRGB(255,255,255),Flag="SkeletonColorPicker1",Callback=function(v44) v35=v44 end})
EspTab:CreateColorPicker({Name="Text Color",Color=Color3.fromRGB(255,255,255),Flag="TextColorPicker1",Callback=function(v45) v34=v45 end})
local v46={{"Head","Torso"},{"Torso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"Torso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"Torso","LowerTorso"},{"RightUpperLeg","RightLowerLeg"},{"LowerTorso","RightUpperLeg"},{"LeftLowerLeg","LeftFoot"},{"RightLowerLeg","RightFoot"},{"RightLowerArm","RightHand"},{"LeftLowerArm","LeftHand"}}
local v48={}
local function v52(v49) local l_Head_1=v49:FindFirstChild("Head"); local v51=v49:FindFirstChild("Torso") or v49:FindFirstChild("UpperTorso") or v49:FindFirstChild("LowerTorso"); if l_Head_1 and v51 then return l_Head_1,v51 else return end end
local function v55(v53) local l_Torso_0=v53:FindFirstChild("Torso"); if l_Torso_0 and l_Torso_0:FindFirstChild("LeftBooster") then return true else return false end end
local function v80(v66)
    if v25[v66] then return end; local v67,v68=v52(v66); if not v67 or not v68 then return end
    local v69=Drawing.new("Square"); v69.Thickness=1; v69.Filled=false; v69.Color=v33; v69.Visible=false
    local v70=Drawing.new("Square"); v70.Thickness=1; v70.Filled=false; v70.Color=Color3.fromRGB(0,0,0); v70.Visible=false
    local v71=Drawing.new("Text"); v71.Size=16; v71.Center=true; v71.Outline=true; v71.OutlineColor=Color3.new(0,0,0); v71.Visible=false
    local v72=Drawing.new("Text"); v72.Size=16; v72.Center=true; v72.Outline=true; v72.OutlineColor=Color3.new(0,0,0); v72.Visible=false
    local v73={}
    for _,v75 in ipairs(v46) do local v76=Drawing.new("Line"); v76.Color=v55(v66) and v35 or Color3.fromRGB(0,150,255); v76.Thickness=1.5; v76.Visible=false; table.insert(v73,{line=v76,a=v75[1],b=v75[2]}) end
    v25[v66]={box=v69,outline=v70,text=v71,weaponText=v72,head=v67,torso=v68,skeletonLines=v73}
    v66.Destroying:Connect(function() pcall(function() v69:Remove() end); pcall(function() v70:Remove() end); pcall(function() v71:Remove() end); pcall(function() v72:Remove() end); for _,v78 in ipairs(v73) do pcall(function() v78.line:Remove() end) end; v25[v66]=nil end)
end
for _,v82 in ipairs(l_Workspace_0:GetChildren()) do if v82:IsA("Model") then v80(v82) end end
l_Workspace_0.ChildAdded:Connect(function(v83) if v83:IsA("Model") then v80(v83) end end)
ToggleESP=function(v85) v26=v85 end; ToggleBoxes=function(v86) v29=v86 end; ToggleDistance=function(v87) v27=v87 end
ToggleType=function(v88) v28=v88 end; ToggleSleeperCheck=function(v89) v30=v89 end
ToggleWeaponESP=function(v90) v31=v90 end; ToggleSkeletonESP=function(v91) v32=v91 end; SetESPColor=function(v92) v33=v92 end

l_RunService_0.RenderStepped:Connect(function()
    if not v26 then return end
    local l_Position_0=l_CurrentCamera_0.CFrame.Position
    for v94,v95 in pairs(v25) do
        local v96=true; local l_head_0=v95.head; local l_torso_0=v95.torso
        if not l_head_0 or not l_torso_0 or not l_head_0.Parent or not l_torso_0.Parent then
            local v99,v100=v52(v94); l_torso_0=v100; l_head_0=v99; v95.torso=l_torso_0; v95.head=l_head_0
            if not l_head_0 or not l_torso_0 then v96=false end
        end
        if v96 and v30 then local l_LowerTorso_0=v94:FindFirstChild("LowerTorso"); if l_LowerTorso_0 then local l_RootRig_0=l_LowerTorso_0:FindFirstChild("RootRig"); if l_RootRig_0 and typeof(l_RootRig_0.CurrentAngle)=="number" and l_RootRig_0.CurrentAngle~=0 then v96=false end end end
        local v103,v104=nil,nil
        if v96 then v103=(l_head_0.Position+l_torso_0.Position)*0.5; v104=(v103-l_Position_0).Magnitude; if v104>=3000 then v96=false end end
        local v105,v106=nil,nil
        if v96 then local v107,v108=l_CurrentCamera_0:WorldToViewportPoint(v103); v106=v108; v105=v107; if not v106 then v96=false end end
        if not v96 then v95.box.Visible=false; v95.outline.Visible=false; v95.text.Visible=false; v95.weaponText.Visible=false; for _,v110 in ipairs(v95.skeletonLines) do v110.line.Visible=false end
        else
            local v111=1000/(v104*2)/math.tan(math.rad(l_CurrentCamera_0.FieldOfView/1.7)); local v112=math.clamp(math.floor(6.5*v111),10,600); local v113=math.clamp(math.floor(9.5*v111),14,800)
            local v114=v105.X-v112/2; local v115=v105.Y-v113/3.5
            if v29 then local v116=2; v95.outline.Size=Vector2.new(v112+v116,v113+v116); v95.outline.Position=Vector2.new(v114-v116/2,v115-v116/2); v95.outline.Visible=true; v95.box.Size=Vector2.new(v112,v113); v95.box.Position=Vector2.new(v114,v115); v95.box.Color=v55(v94) and v33 or Color3.fromRGB(0,150,255); v95.box.Visible=true else v95.outline.Visible=false; v95.box.Visible=false end
            local v117={}; if v28 then table.insert(v117,v55(v94) and "Player" or "Bot") end; if v27 then table.insert(v117,math.floor(v104).."m") end
            local v118=table.concat(v117," | ")
            if v118~="" then v95.text.Color=v55(v94) and v34 or Color3.fromRGB(0,150,255); v95.text.Text=v118; v95.text.Position=Vector2.new(v105.X,v115-16); v95.text.Visible=true else v95.text.Visible=false end
            if v31 then local v119=v48[v94] or "None"; v95.weaponText.Color=v55(v94) and v34 or Color3.fromRGB(0,150,255); v95.weaponText.Text=v119; v95.weaponText.Position=Vector2.new(v105.X,v115+v113); v95.weaponText.Visible=true else v95.weaponText.Visible=false end
            if v32 then for _,v121 in ipairs(v95.skeletonLines) do local l_A=v94:FindFirstChild(v121.a); local l_B=v94:FindFirstChild(v121.b); if l_A and l_B then local v124,v125=l_CurrentCamera_0:WorldToViewportPoint(l_A.Position); local v126,v127=l_CurrentCamera_0:WorldToViewportPoint(l_B.Position); if v125 and v127 then v121.line.From=Vector2.new(v124.X,v124.Y); v121.line.To=Vector2.new(v126.X,v126.Y); v121.line.Visible=true else v121.line.Visible=false end else v121.line.Visible=false end end else for _,v129 in ipairs(v95.skeletonLines) do v129.line.Visible=false end end
        end
    end
end)
ToggleESP(true); ToggleBoxes(false); ToggleDistance(false); ToggleType(false); ToggleSleeperCheck(false); ToggleWeaponESP(false); ToggleSkeletonESP(false)

-- Ore ESP
EspTab:CreateSection("Ore ESP")
EspTab:CreateToggle({Name="Stone Esp",CurrentValue=false,Flag="StoneToggle",Callback=function(v255) ESP_ENABLED.Stone=v255 end})
EspTab:CreateToggle({Name="Iron Esp",CurrentValue=false,Flag="IronToggle",Callback=function(v257) ESP_ENABLED.Iron=v257 end})
EspTab:CreateToggle({Name="Nitrate Esp",CurrentValue=false,Flag="NitrateToggle",Callback=function(v259) ESP_ENABLED.Nitrate=v259 end})
EspTab:CreateToggle({Name="Show Distance",CurrentValue=false,Flag="ShowDistanceToggle",Callback=function(v261) ESP_ENABLED.ShowDistance=v261 end})
EspTab:CreateSlider({Name="Ore Distance",Range={10,1000},Increment=1,Suffix="m",CurrentValue=750,Flag="DistanceSlider",Callback=function(v263) renderDistance=v263 end})
local l_RunService_1=game:GetService("RunService"); local l_Workspace_1=game:GetService("Workspace"); local l_CurrentCamera_1=l_Workspace_1.CurrentCamera
ESP_ENABLED={Stone=false,Iron=false,Nitrate=false,ShowDistance=false}; oreESP={}; renderDistance=750
local v269={Stone={Color3.fromRGB(72,72,72)},Iron={Color3.fromRGB(72,72,72),Color3.fromRGB(199,172,120)},Nitrate={Color3.fromRGB(248,248,248),Color3.fromRGB(72,72,72)}}
local v270={Stone=Color3.fromRGB(120,120,120),Iron=Color3.fromRGB(255,215,0),Nitrate=Color3.fromRGB(200,255,200)}
local function v273(v271,v272) return math.abs(v271.R-v272.R)<0.02 and math.abs(v271.G-v272.G)<0.02 and math.abs(v271.B-v272.B)<0.02 end
local function v281(v274)
    local v275={}; for _,v277 in ipairs(v274:GetChildren()) do if v277:IsA("MeshPart") then table.insert(v275,v277) end end
    if #v275==1 then if v273(v275[1].Color,v269.Stone[1]) then return "Stone",v275[1] end
    elseif #v275==2 then local l_Color_1=v275[1].Color; local l_Color_2=v275[2].Color
        if v273(l_Color_1,v269.Iron[1]) and v273(l_Color_2,v269.Iron[2]) or v273(l_Color_1,v269.Iron[2]) and v273(l_Color_2,v269.Iron[1]) then return "Iron",v275[1]
        elseif v273(l_Color_1,v269.Nitrate[1]) and v273(l_Color_2,v269.Nitrate[2]) or v273(l_Color_1,v269.Nitrate[2]) and v273(l_Color_2,v269.Nitrate[1]) then return "Nitrate",v275[1] end end
    return nil
end
local function v286(v282,v283,v284) local v285=Drawing.new("Text"); v285.Text=v283; v285.Size=16; v285.Center=true; v285.Outline=true; v285.Color=v270[v283]; v285.Visible=true; oreESP[v282]={Text=v285,OreType=v283,Part=v284} end
local function v288(v287) if oreESP[v287] then oreESP[v287].Text:Remove(); oreESP[v287]=nil end end
task.spawn(function() while true do for _,v290 in ipairs(l_Workspace_1:GetChildren()) do if v290:IsA("Model") and not oreESP[v290] then local v291,v292=v281(v290); if v291 and ESP_ENABLED[v291] then v286(v290,v291,v292) end end end; for v293 in pairs(oreESP) do if not v293.Parent then v288(v293) end end; task.wait(2) end end)
l_RunService_1.RenderStepped:Connect(function() for v294,v295 in pairs(oreESP) do local l_Part_1=v295.Part; if l_Part_1 and l_Part_1.Parent then local l_Magnitude_1=(l_CurrentCamera_1.CFrame.Position-l_Part_1.Position).Magnitude; local v298,v299=l_CurrentCamera_1:WorldToViewportPoint(l_Part_1.Position); if v299 and l_Magnitude_1<=renderDistance and ESP_ENABLED[v295.OreType] then local l_Text_0=v295.Text; if ESP_ENABLED.ShowDistance then l_Text_0.Text=string.format("%s | %.0fm",v295.OreType,l_Magnitude_1) else l_Text_0.Text=v295.OreType end; l_Text_0.Position=Vector2.new(v298.X,v298.Y); l_Text_0.Visible=true else v295.Text.Visible=false end else v288(v294) end end end)

-- Other ESP
EspTab:CreateSection("Other")
local l_RunService_2=game:GetService("RunService"); local l_CurrentCamera_2=workspace.CurrentCamera
local ItemESP_Enabled=false; local ItemESP={}; local itemFrameCounter=0
local CorpseESPEnabled=false; local CorpseESP={}
local RaidESP_Enabled=false; local RaidESP={}; local hitSoundNames={Explosion=true,Explosion_Muffled=true}
local AirdropESP_Enabled=false; local AirdropESP={}
local function makeDrawText(txt,col) local d=Drawing.new("Text"); d.Text=txt; d.Size=16; d.Center=true; d.Outline=true; d.OutlineColor=Color3.new(0,0,0); d.Color=col; d.Visible=false; return d end
local function scanItems() if not ItemESP_Enabled then return end; for _,v in ipairs(l_Workspace_0:GetChildren()) do if v:IsA("Model") and not ItemESP[v] then local u=v:FindFirstChild("Union"); local d2=v:FindFirstChild("Display"); local p=v:FindFirstChild("Part"); if u or d2 or p then local pt=u or d2 or p; ItemESP[v]={drawing=makeDrawText("Item",Color3.new(1,1,0)),part=pt} end end end end
local function clearItems() for _,v in pairs(ItemESP) do v.drawing:Remove() end; ItemESP={} end
local function isCorpse(m) local parts={}; for _,v in ipairs(m:GetChildren()) do if v:IsA("BasePart") then table.insert(parts,v) end end; if #parts~=2 then return false end; local m1=parts[1].Material; local m2=parts[2].Material; return (m1==Enum.Material.Fabric and m2==Enum.Material.Metal) or (m1==Enum.Material.Metal and m2==Enum.Material.Fabric) end
local function addCorpse(m) if CorpseESP[m] then return end; local d=makeDrawText("Corpse",Color3.fromRGB(255,0,0)); CorpseESP[m]={drawing=d,model=m}; m.Destroying:Connect(function() d:Remove(); CorpseESP[m]=nil end) end
local function scanCorpses() for _,v in ipairs(l_Workspace_0:GetChildren()) do if v:IsA("Model") and isCorpse(v) then addCorpse(v) end end end
l_Workspace_0.ChildAdded:Connect(function(v) if v:IsA("Model") and isCorpse(v) then addCorpse(v) end end)
local function addRaidSound(s) s.Played:Connect(function() local pos=s.Parent and s.Parent.Position; if pos then table.insert(RaidESP,{text=makeDrawText("Raid",Color3.fromRGB(255,0,0)),position=pos,startTime=tick()}) end end) end
for _,v in ipairs(l_Workspace_0:GetDescendants()) do if v:IsA("Sound") and hitSoundNames[v.Name] then addRaidSound(v) end end
l_Workspace_0.DescendantAdded:Connect(function(v) if v:IsA("Sound") and hitSoundNames[v.Name] then addRaidSound(v) end end)
l_RunService_2.RenderStepped:Connect(function()
    if ItemESP_Enabled then itemFrameCounter=itemFrameCounter+1; if itemFrameCounter>=10 then scanItems(); itemFrameCounter=0 end; for k,v in pairs(ItemESP) do if v.part and v.part.Parent then local p,vis=l_CurrentCamera_2:WorldToViewportPoint(v.part.Position); v.drawing.Visible=vis; if vis then v.drawing.Position=Vector2.new(p.X,p.Y-20) end else v.drawing:Remove(); ItemESP[k]=nil end end end
    if CorpseESPEnabled then for k,v in pairs(CorpseESP) do local bp=k.PrimaryPart or k:FindFirstChildWhichIsA("BasePart"); if bp then local p,vis=l_CurrentCamera_2:WorldToViewportPoint(bp.Position); v.drawing.Visible=vis; if vis then v.drawing.Position=Vector2.new(p.X,p.Y-20) end else v.drawing.Visible=false end end else for _,v in pairs(CorpseESP) do v.drawing.Visible=false end end
    if RaidESP_Enabled then for i=#RaidESP,1,-1 do local r=RaidESP[i]; local t=tick()-r.startTime; if t>300 then r.text:Remove(); table.remove(RaidESP,i) else local p,vis=l_CurrentCamera_2:WorldToViewportPoint(r.position); r.text.Visible=vis; if vis then r.text.Text="Raid | "..math.floor((r.position-l_CurrentCamera_2.CFrame.Position).Magnitude).."m | "..math.floor(t); r.text.Position=Vector2.new(p.X,p.Y) end end end end
    if AirdropESP_Enabled then for _,m in ipairs(l_Workspace_0:GetChildren()) do if m:IsA("Model") and not AirdropESP[m] then local c=m:FindFirstChild("Crates") or m:FindFirstChild("Cables"); if c then AirdropESP[m]={drawing=makeDrawText("Airdrop",Color3.fromRGB(255,255,0)),part=c} end end end; for k,v in pairs(AirdropESP) do if not k or not k.Parent then v.drawing:Remove(); AirdropESP[k]=nil else local p,vis=l_CurrentCamera_2:WorldToViewportPoint(v.part.Position); v.drawing.Visible=vis; if vis then v.drawing.Position=Vector2.new(p.X,p.Y-20) end end end end
end)
EspTab:CreateToggle({Name="Item ESP",CurrentValue=false,Flag="ToggleItemESP",Callback=function(v246) ItemESP_Enabled=v246; if v246 then scanItems() else clearItems() end end})
EspTab:CreateToggle({Name="Corpse ESP",CurrentValue=false,Flag="ToggleCorpseESP",Callback=function(v247) CorpseESPEnabled=v247; if v247 then scanCorpses() end end})
EspTab:CreateToggle({Name="Raid ESP",CurrentValue=false,Flag="ToggleRaidESP",Callback=function(v248) RaidESP_Enabled=v248; if not v248 then for _,v in pairs(RaidESP) do v.text:Remove() end; RaidESP={} end end})
EspTab:CreateToggle({Name="Airdrop ESP",CurrentValue=false,Flag="ToggleAirdropESP",Callback=function(v252) AirdropESP_Enabled=v252; if not v252 then for _,v in pairs(AirdropESP) do v.drawing:Remove() end; AirdropESP={} end end})

-- Vehicle ESP
EspTab:CreateSection("Vehicles")
local l_vehicles_0=game:GetService("ReplicatedStorage").Shared.entities.vehicles
local VehicleBlueprints={ATV=l_vehicles_0.ATV.Model,Boat=l_vehicles_0.Boat.Model,Helicopter=l_vehicles_0.Helicopter.Model,Trolly=l_vehicles_0.Trolly.Model}
local VehicleESP={}; local EspEnabled={ATV=false,Boat=false,Helicopter=false,Trolly=false}; local VehicleDistESP=false
local function vehicleMatch(m,bp) for _,c in ipairs(bp:GetChildren()) do if not m:FindFirstChild(c.Name) then return false end end; return true end
local function addVehicle(m,n) local d=Drawing.new("Text"); d.Size=18; d.Color=Color3.fromRGB(0,255,0); d.Center=true; d.Outline=true; d.Visible=true; VehicleESP[m]={Drawing=d,Name=n} end
local vTimer=0
l_RunService_2.RenderStepped:Connect(function()
    vTimer=vTimer+1
    if vTimer%500==0 then for _,m in ipairs(workspace:GetChildren()) do if m:IsA("Model") and not VehicleESP[m] then for n,bp in pairs(VehicleBlueprints) do if EspEnabled[n] and vehicleMatch(m,bp) then addVehicle(m,n); break end end end end; for m,_ in pairs(VehicleESP) do if not m.Parent then VehicleESP[m].Drawing:Remove(); VehicleESP[m]=nil end end end
    for m,v in pairs(VehicleESP) do local d=v.Drawing; local n=v.Name; if EspEnabled[n] and m.PrimaryPart then local pos,vis=l_CurrentCamera_2:WorldToViewportPoint(m.PrimaryPart.Position); if vis then local dist=math.floor((m.PrimaryPart.Position-l_CurrentCamera_2.CFrame.Position).Magnitude); d.Text=VehicleDistESP and string.format("%s | %dm",n,dist) or n; d.Position=Vector2.new(pos.X,pos.Y); d.Visible=true else d.Visible=false end else d.Visible=false end end
end)
EspTab:CreateToggle({Name="ATV",CurrentValue=false,Flag="ATV_ESP",Callback=function(v) EspEnabled.ATV=v end})
EspTab:CreateToggle({Name="Boat",CurrentValue=false,Flag="Boat_ESP",Callback=function(v) EspEnabled.Boat=v end})
EspTab:CreateToggle({Name="Helicopter",CurrentValue=false,Flag="Heli_ESP",Callback=function(v) EspEnabled.Helicopter=v end})
EspTab:CreateToggle({Name="Trolly",CurrentValue=false,Flag="Trolly_ESP",Callback=function(v) EspEnabled.Trolly=v end})
EspTab:CreateToggle({Name="Distance",CurrentValue=false,Flag="Vehicle_Distance_ESP",Callback=function(v) VehicleDistESP=v end})

-- ==================== WORLD TAB ====================
local WorldTab=l_v0_Window_0:CreateTab("World",nil)
WorldTab:CreateSection("Water")
WorldTab:CreateColorPicker({Name="Water Color",Color=Color3.fromRGB(12,84,92),Flag="ColorPicker1",Callback=function(v339) game.Workspace.Terrain.WaterColor=v339 end})
WorldTab:CreateToggle({Name="Water Reflectance",CurrentValue=true,Flag="Toggle1",Callback=function(v341) game.Workspace.Terrain.WaterReflectance=v341 and 1 or 0 end})
WorldTab:CreateSlider({Name="Water speed",Range={1,100},Increment=1,Suffix="Speed",CurrentValue=10,Flag="Slider1",Callback=function(v343) game.Workspace.Terrain.WaterWaveSpeed=v343 end})
WorldTab:CreateSlider({Name="Wave size",Range={0,1},Increment=0.1,Suffix="Size",CurrentValue=0.5,Flag="Slider2",Callback=function(v345) game.Workspace.Terrain.WaterWaveSize=v345 end})
WorldTab:CreateSection("Clouds")
WorldTab:CreateColorPicker({Name="Cloud Color",Color=Color3.fromRGB(255,255,255),Flag="ColorPicker2",Callback=function(v348) game.Workspace.Terrain.Clouds.Color=v348 end})
WorldTab:CreateSlider({Name="Cloud Cover",Range={0,1},Increment=0.1,Suffix="Cover",CurrentValue=0.6,Flag="Slider3",Callback=function(v350) game.Workspace.Terrain.Clouds.Cover=v350 end})
WorldTab:CreateSection("SkyBox")
WorldTab:CreateDropdown({Name="Sky Changer",Options={"Default","Magma","Water","Obsidian","Galaxy","Void"},CurrentOption={"Default"},MultipleOptions=false,Flag="Dropdown1",
    Callback=function(v353)
        if type(v353)=="table" then v353=v353[1] end
        local l_Lighting_0=game:GetService("Lighting"); for _,v356 in ipairs(l_Lighting_0:GetChildren()) do if v356:IsA("Sky") then v356:Destroy() end end
        if v353=="Default" then return end
        local v357={Magma="rbxassetid://16468735533",Water="rbxassetid://17253866105",Obsidian="rbxassetid://17253878595",Galaxy="rbxassetid://13726625670",Void="rbxassetid://16666915143"}
        local l_Sky_0=Instance.new("Sky"); l_Sky_0.Name="ExecutorSky"; l_Sky_0.Parent=l_Lighting_0
        local v359=v357[v353]; if v359 then l_Sky_0.SkyboxBk=v359; l_Sky_0.SkyboxDn=v359; l_Sky_0.SkyboxFt=v359; l_Sky_0.SkyboxLf=v359; l_Sky_0.SkyboxRt=v359; l_Sky_0.SkyboxUp=v359 end
    end
})
WorldTab:CreateSection("Other")
WorldTab:CreateToggle({Name="Shadows",CurrentValue=true,Flag="Toggle2",Callback=function(v362) game:GetService("Lighting").GlobalShadows=v362 end})
WorldTab:CreateToggle({Name="Grass",CurrentValue=true,Flag="GrassToggle",Callback=function(v364) setGrass(v364) end})
if not game:IsLoaded() then repeat task.wait() until game:IsLoaded() end
local v366=nil; repeat v366=workspace:FindFirstChildOfClass("Terrain"); task.wait() until v366
setGrass=function(v367) if not sethiddenproperty then warn("sethiddenproperty not supported"); return end; if not pcall(function() sethiddenproperty(v366,"Decoration",v367) end) then warn("Failed to change grass") end end
setGrass(true)
local l_Workspace_2=game:GetService("Workspace"); local v369={"Fir3_Leaves","Elm1_Leaves","Birch1_Leaves"}
local function v373(v370) for _,v372 in ipairs(l_Workspace_2:GetDescendants()) do if v372:IsA("BasePart") and table.find(v369,v372.Name) then v372.Transparency=v370 and 0 or 1; v372.CanCollide=v370 end end end
WorldTab:CreateToggle({Name="Tree Leaves",CurrentValue=true,Flag="Toggle3",Callback=function(v374) v373(v374) end})
local l_Lighting_1=game:GetService("Lighting"); local l_RunService_3=game:GetService("RunService")
local v378=false; local v379=2.5; local v380=18.5; local v381=6.5
local function v387() local v382,v383,v384=string.match(l_Lighting_1.TimeOfDay,"(%d+):(%d+):(%d+)"); return tonumber(v382)+tonumber(v383)/60+tonumber(v384)/3600 end
l_RunService_3.RenderStepped:Connect(function() if not v378 then l_Lighting_1.ExposureCompensation=0; return end; local v388=v387(); local v389=0; if v380<=v388 or v388<v381 then if v380<=v388 then v388=v388-24 end; if v388<0 then v389=v379*((v388+3)/3) else v389=v379*math.clamp(1-v388/v381,0,1) end end; l_Lighting_1.ExposureCompensation=v389 end)
WorldTab:CreateToggle({Name="Bright Night",CurrentValue=false,Flag="BrightNightToggle",Callback=function(v390) v378=v390; if not v390 then l_Lighting_1.ExposureCompensation=0 end end})
WorldTab:CreateSection("Lighting")
WorldTab:CreateToggle({Name="Lighting",CurrentValue=false,Flag="Toggle4",Callback=function(v393) game:GetService("Lighting").StimEffect.Enabled=v393 end})
WorldTab:CreateColorPicker({Name="TintColor",Color=Color3.fromRGB(255,255,255),Flag="ColorPicker3",Callback=function(v395) game:GetService("Lighting").StimEffect.TintColor=v395 end})
WorldTab:CreateSlider({Name="Brightness",Range={0.1,100},Increment=0.1,Suffix="Brightness",CurrentValue=0.1,Flag="Slider4",Callback=function(v397) game:GetService("Lighting").StimEffect.Brightness=v397 end})
WorldTab:CreateSlider({Name="Contrast",Range={0,20},Increment=0.1,Suffix="Contrast",CurrentValue=1,Flag="Slider5",Callback=function(v399) game:GetService("Lighting").StimEffect.Contrast=v399 end})
WorldTab:CreateSlider({Name="Saturation",Range={0,100},Increment=1,Suffix="Saturation",CurrentValue=10,Flag="Slider6",Callback=function(v401) game:GetService("Lighting").StimEffect.Saturation=v401 end})

-- ==================== PLAYER TAB ====================
local PlayerTab=l_v0_Window_0:CreateTab("Player",nil)
PlayerTab:CreateSection("Other")
local l_Workspace_3=game:GetService("Workspace"); local v407=false
local v408={Enum.Material.Cobblestone,Enum.Material.WoodPlanks,Enum.Material.Metal,Enum.Material.CorrodedMetal}; local v409={}
local function v413(v410) for _,v412 in ipairs(v408) do if v412==v410 then return true end end; return false end
local function v419(v414) for _,v416 in ipairs(l_Workspace_3:GetChildren()) do if v416:IsA("Model") then for _,v418 in ipairs(v416:GetDescendants()) do if v418:IsA("BasePart") and v413(v418.Material) then if v414 then if v409[v418]==nil then v409[v418]=v418.Transparency end; v418.Transparency=0.5 elseif v409[v418]~=nil then v418.Transparency=v409[v418] end end end end end end
PlayerTab:CreateKeybind({Name="Xray",CurrentKeybind="V",HoldToInteract=false,Flag="Keybind1",Callback=function() v407=not v407; v419(v407) end})
local v423=workspace.CurrentCamera or workspace:WaitForChild("Camera"); local v424=70; local v425=70; local v426=20; local v427=false
PlayerTab:CreateKeybind({Name="Zoom",CurrentKeybind="X",HoldToInteract=true,Flag="Zoom1",Callback=function(v428) v427=v428 end})
PlayerTab:CreateSlider({Name="FOV Changer",Range={50,120},Increment=1,Suffix="FOV",CurrentValue=v424,Flag="FOVSlider",Callback=function(v430) v424=v430 end})
local v432=getrawmetatable(game); setreadonly(v432,false)
local l___index_0=v432.__index; local l___newindex_0=v432.__newindex
v432.__index=newcclosure(function(v435,v436) if v435==v423 and v436=="FieldOfView" then return v425 else return l___index_0(v435,v436) end end)
v432.__newindex=newcclosure(function(v437,v438,v439) if v437==v423 and v438=="FieldOfView" then if v427 then l___newindex_0(v437,v438,v426) else l___newindex_0(v437,v438,v424) end; return else return l___newindex_0(v437,v438,v439) end end)
setreadonly(v432,true)
l_RunService_3.RenderStepped:Connect(function() if v427 then v423.FieldOfView=v426 else v423.FieldOfView=v424 end end)
PlayerTab:CreateSection("HitSounds")
local v441={Default="rbxassetid://9119561046",Rust="rbxassetid://5043539486",Gamesense="rbxassetid://4817809188",Magic="rbxassetid://182765513",Firework="rbxassetid://269146157",Lazer="rbxassetid://360661189",Pop="rbxassetid://127231141534262",Zap="rbxassetid://9119594928"}
PlayerTab:CreateDropdown({Name="Hit sound",Options={"Default","Rust","Gamesense","Magic","Firework","Lazer","Pop","Zap"},CurrentOption={"Default"},MultipleOptions=false,Flag="HitSoundDropdown",
    Callback=function(v442) local l=v442; if type(l)=="table" then l=l[1] end; local s=game:GetService("SoundService"):FindFirstChild("PlayerHitHeadshot"); if s then s.SoundId=v441[l] or v441.Default; s:Play() end end})
PlayerTab:CreateSlider({Name="Hit sound Volume",Range={0.1,5},Increment=0.1,Suffix="Volume",CurrentValue=1,Flag="HitSoundVolume",
    Callback=function(v446) local s=game:GetService("SoundService"):FindFirstChild("PlayerHitHeadshot"); if s then s.Volume=v446 end end})
PlayerTab:CreateSection("Weapon Trail")
PlayerTab:CreateColorPicker({Name="Arrow Trailcolor",Color=Color3.fromRGB(255,255,255),Flag="ArrowTrailColor",
    Callback=function(v450) local t=game:GetService("ReplicatedStorage").Arrow:FindFirstChild("Trail"); if not t then return end; t.Color=ColorSequence.new(v450) end})
PlayerTab:CreateSlider({Name="Arrow Trail lifespan",Range={0.15,20},Increment=0.1,Suffix="s",CurrentValue=0.15,Flag="ArrowTrailLifespan",
    Callback=function(v453) game:GetService("ReplicatedStorage").Arrow.Trail.Lifetime=v453 end})
l_RunService_3=game:GetService("RunService"); l_Workspace_3=game:GetService("Workspace")
local l_Debris_0=game:GetService("Debris"); ReplicatedStorage=game:GetService("ReplicatedStorage")
BulletTrailEnabled=false; BulletTrailColor=Color3.fromRGB(255,255,255); BulletTrailThickness=0.2; BulletTrailLength=10; BulletTrailLifetime=0.1
local function v464(v456)
    local v457={bullet=v456,points={}}; local v458=nil
    v458=l_RunService_3.RenderStepped:Connect(function()
        if not BulletTrailEnabled then return elseif not v456 or not v456.Parent then v458:Disconnect(); return end
        local v459=v456.Position or v456.CFrame.Position; table.insert(v457.points,1,v459)
        if #v457.points>BulletTrailLength then table.remove(v457.points) end
        for v460=1,#v457.points-1 do
            local v461=v457.points[v460]; local v462=v457.points[v460+1]
            local l_Part_2=Instance.new("Part"); l_Part_2.Anchored=true; l_Part_2.CanCollide=false
            l_Part_2.Size=Vector3.new(BulletTrailThickness,BulletTrailThickness,(v461-v462).Magnitude)
            l_Part_2.CFrame=CFrame.new(v461,v462)*CFrame.new(0,0,-l_Part_2.Size.Z/2)
            l_Part_2.Color=BulletTrailColor; l_Part_2.Material=Enum.Material.ForceField; l_Part_2.Parent=l_Workspace_3; l_Debris_0:AddItem(l_Part_2,BulletTrailLifetime)
        end
    end)
end
l_Workspace_3.DescendantAdded:Connect(function(v465) if v465.Name=="Bullet" and not v465:IsDescendantOf(ReplicatedStorage) and BulletTrailEnabled then v464(v465) end end)
PlayerTab:CreateToggle({Name="Bullet Trail",CurrentValue=false,Flag="BulletTrailToggle",Callback=function(v466) BulletTrailEnabled=v466 end})
PlayerTab:CreateColorPicker({Name="Bullet Trail Color",Color=Color3.fromRGB(255,255,255),Flag="BulletTrailColor",Callback=function(v468) BulletTrailColor=v468 end})
PlayerTab:CreateSlider({Name="Trail Thickness",Range={0.1,1},Increment=0.1,Suffix="Size",CurrentValue=0.2,Flag="BulletTrailThick",Callback=function(v470) BulletTrailThickness=v470 end})
PlayerTab:CreateSlider({Name="Bullet Trail Length",Range={1,25},Increment=1,Suffix="Length",CurrentValue=10,Flag="BulletTrailLen",Callback=function(v472) BulletTrailLength=v472 end})
PlayerTab:CreateSlider({Name="Trail LifeTime",Range={0.01,5},Increment=0.01,Suffix="LifeTime",CurrentValue=0.1,Flag="BulletTrailLife",Callback=function(v474) BulletTrailLifetime=v474 end})
PlayerTab:CreateSection("Hand and Weapon Chams")
Player=game:GetService("Players").LocalPlayer
local v483={}; local v484={}; local v485=Color3.fromRGB(255,255,255)
local function v489()
    v483={}
    local paths={{"Const","Ignore","FPSArms","RightHand"},{"Const","Ignore","FPSArms","RightLowerArm"},{"Const","Ignore","FPSArms","LeftLowerArm"},{"Const","Ignore","FPSArms","LeftHand"}}
    for _,path in ipairs(paths) do local t=workspace; for _,p in ipairs(path) do t=t and t:FindFirstChild(p) end; if t and t:IsA("BasePart") then table.insert(v483,t); if not v484[t] then v484[t]=t.Material end end end
end
local function v500(v490) if v490=="Default" then for _,v492 in ipairs(v483) do if v492 and v492.Parent then v492.Material=v484[v492] or Enum.Material.Plastic end end; return end; local ok,mat=pcall(function() return Enum.Material[v490] end); if ok and mat then for _,v496 in ipairs(v483) do if v496 and v496.Parent then v496.Material=mat end end else for _,v498 in ipairs(v483) do if v498 and v498.Parent then pcall(function() v498.MaterialVariant=v490 end) end end end end
v489()
local l_l_l_v0_Window_0_Tab_3_Dropdown_1=PlayerTab:CreateDropdown({Name="Hand",Options={"Default","ForceField","Neon","Asphalt"},CurrentOption={"Default"},MultipleOptions=false,Flag="Dropdown_HandMaterial",Callback=function(v503) local l=v503; if type(l)=="table" then l=l[1] end; v489(); v500(l) end})
local l_l_l_v0_Window_0_Tab_3_ColorPicker_2=PlayerTab:CreateColorPicker({Name="Hand cham color",Color=v485,Flag="ColorPicker_Hand",Callback=function(v506) v485=v506; for _,v508 in ipairs(v483) do if v508 and v508.Parent then v508.Color=v506 end end end})
task.spawn(function() while true do v489(); for _,v511 in ipairs(v483) do if v511 and v511.Parent then v511.Color=v485 end end; task.wait(0.1) end end)
Player=game:GetService("Players").LocalPlayer; ReplicatedStorage=game:GetService("ReplicatedStorage"); local l_HandModels_0=ReplicatedStorage:WaitForChild("HandModels")
local function v520(v513) local v514={}; local v515={}; local function v516(v517) if v517:IsA("BasePart") then table.insert(v514,v517); if not v515[v517] then v515[v517]=v517.Material end end; for _,v519 in ipairs(v517:GetChildren()) do v516(v519) end end; v516(v513); return v514,v515 end
local v521={}; local v522={}
local function v529() v521={}; for _,v524 in ipairs(l_HandModels_0:GetChildren()) do local v525,v526=v520(v524); v521[v524]=v525; for v527,v528 in pairs(v526) do v522[v527]=v528 end end end
local function v546(v530) if v530=="Default" then for _,v532 in pairs(v521) do for _,v534 in ipairs(v532) do if v534 and v534.Parent then v534.Material=v522[v534] or Enum.Material.Plastic end end end; return end; local ok,mat=pcall(function() return Enum.Material[v530] end); if ok and mat then for _,v538 in pairs(v521) do for _,v540 in ipairs(v538) do if v540 and v540.Parent then v540.Material=mat end end end else for _,v542 in pairs(v521) do for _,v544 in ipairs(v542) do if v544 and v544.Parent then pcall(function() v544.MaterialVariant=v530 end) end end end end end
local function v552(v547) for _,v549 in pairs(v521) do for _,v551 in ipairs(v549) do if v551 and v551.Parent then v551.Color=v547 end end end end
v529()
l_HandModels_0.ChildAdded:Connect(function() task.wait(0.5); v529(); v546(l_l_l_v0_Window_0_Tab_3_Dropdown_1.CurrentOption[1]); v552(l_l_l_v0_Window_0_Tab_3_ColorPicker_2.Color) end)
PlayerTab:CreateDropdown({Name="Weapon Chams",Options={"Default","ForceField","Neon","Asphalt"},CurrentOption={"Default"},MultipleOptions=false,Flag="Dropdown_WeaponMaterial",Callback=function(v553) local l=v553; if type(l)=="table" then l=l[1] end; v529(); v546(l) end})
PlayerTab:CreateColorPicker({Name="Weapon Cham Color",Color=Color3.fromRGB(255,255,255),Flag="ColorPicker_Weapon",Callback=function(v556) v552(v556) end})

-- ==================== MISC TAB ====================
local MiscTab=l_v0_Window_0:CreateTab("Misc",nil)
MiscTab:CreateSection("FreeCam")
local l_UserInputService_3=game:GetService("UserInputService")
FreeCamEnabled=false; PITCH_LIMIT=math.rad(80)
local v561=nil; local v562=0; local v563=0; local v564=nil; local v565=nil
local v566={[Enum.KeyCode.W]=Vector3.new(0,0,-1),[Enum.KeyCode.S]=Vector3.new(0,0,1),[Enum.KeyCode.A]=Vector3.new(-1,0,0),[Enum.KeyCode.D]=Vector3.new(1,0,0),[Enum.KeyCode.Space]=Vector3.new(0,1,0),[Enum.KeyCode.LeftShift]=Vector3.new(0,-1,0)}
local v567={}; FreeCamSpeed=150
MiscTab:CreateKeybind({Name="Free Cam",CurrentKeybind="Z",HoldToInteract=false,Flag="FreeCamKey",
    Callback=function(_)
        if FreeCamEnabled then
            FreeCamEnabled=false; l_RunService_3:UnbindFromRenderStep("FreeCam"); l_CurrentCamera_2.CameraType=Enum.CameraType.Custom
            local c=Player.Character; if c then local h=c:FindFirstChildOfClass("Humanoid"); if h then if v564 then h.WalkSpeed=v564 end; if v565 then h.JumpPower=v565 end end end
        else
            FreeCamEnabled=true; local cf=l_CurrentCamera_2.CFrame; v561=cf.Position; local lv=cf.LookVector; v562=math.asin(-lv.Y); v563=math.atan2(-lv.X,-lv.Z)
            l_CurrentCamera_2.CameraType=Enum.CameraType.Scriptable
            local c=Player.Character; if c then local h=c:FindFirstChildOfClass("Humanoid"); if h then v564=h.WalkSpeed; v565=h.JumpPower; h.WalkSpeed=0; h.JumpPower=0 end end
            l_RunService_3:BindToRenderStep("FreeCam",Enum.RenderPriority.Camera.Value+1,function(v575)
                local d=l_UserInputService_3:GetMouseDelta(); v563=v563-d.X*0.002; v562=math.clamp(v562-d.Y*0.002,-PITCH_LIMIT,PITCH_LIMIT)
                local v577=CFrame.Angles(0,v563,0)*CFrame.Angles(v562,0,0); local l_zero_0=Vector3.zero
                for v579,v580 in pairs(v566) do if v567[v579] then l_zero_0=l_zero_0+v580 end end
                if l_zero_0.Magnitude>0 then l_zero_0=v577:VectorToWorldSpace(l_zero_0).Unit; v561=v561+l_zero_0*FreeCamSpeed*v575 end
                l_CurrentCamera_2.CFrame=CFrame.new(v561)*v577
            end)
        end
    end
})
MiscTab:CreateSlider({Name="FreeCam Speed",Range={1,500},Increment=1,CurrentValue=150,Flag="FreeCamSpeed",Callback=function(v582) FreeCamSpeed=v582 end})
l_UserInputService_3.InputBegan:Connect(function(v584,v585) if v585 then return end; if v566[v584.KeyCode] then v567[v584.KeyCode]=true end end)
l_UserInputService_3.InputEnded:Connect(function(v586) if v566[v586.KeyCode] then v567[v586.KeyCode]=false end end)
MiscTab:CreateSection("Other")
MiscTab:CreateButton({Name="Close Menu",Callback=function() v0:Destroy() end})

-- ==================== STYLE/CUSTOMIZE TAB ====================
local StyleTab=l_v0_Window_0:CreateTab("Style",nil)
StyleTab:CreateSection("Theme")
StyleTab:CreateDropdown({Name="Menu Theme",Options={"Dark","Ocean","Crimson","Forest","AmberGlow"},CurrentOption={currentStyle.Theme},MultipleOptions=false,Flag="ThemeDropdown",
    Callback=function(sel) if type(sel)=="table" then sel=sel[1] end; l_v0_Window_0:ApplyTheme(sel) end})
StyleTab:CreateColorPicker({Name="Accent Color",Color=Color3.fromRGB(currentStyle.AccentColor[1], currentStyle.AccentColor[2], currentStyle.AccentColor[3]),Flag="AccentColor",
    Callback=function(color) l_v0_Window_0:SetAccentColor(color) end})
StyleTab:CreateSection("Toggle Key")
StyleTab:CreateDropdown({Name="Toggle Key (PC)",Options={"K","L","M","P","O","I","J","H","N","B"},CurrentOption={currentStyle.ToggleKey},MultipleOptions=false,Flag="ToggleKeyDropdown",
    Callback=function(sel) if type(sel)=="table" then sel=sel[1] end; l_v0_Window_0:SetToggleKey(sel) end})
StyleTab:CreateSection("Quick Presets")
StyleTab:CreateButton({Name="Ocean Theme",   Callback=function() l_v0_Window_0:ApplyTheme("Ocean")    end})
StyleTab:CreateButton({Name="Crimson Theme", Callback=function() l_v0_Window_0:ApplyTheme("Crimson")  end})
StyleTab:CreateButton({Name="Forest Theme",  Callback=function() l_v0_Window_0:ApplyTheme("Forest")   end})
StyleTab:CreateButton({Name="Dark Theme",    Callback=function() l_v0_Window_0:ApplyTheme("Dark")     end})
StyleTab:CreateButton({Name="Amber Theme",   Callback=function() l_v0_Window_0:ApplyTheme("AmberGlow") end})
StyleTab:CreateSection("Device Info")
StyleTab:CreateButton({Name=isMobile and ">> Mobile Mode ACTIVE <<" or ">> Desktop Mode ACTIVE <<",Callback=function() end})
