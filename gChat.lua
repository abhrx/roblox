local G2L = {}
local H = game:GetService("HttpService")
local C = game:GetService("CoreGui")
local U = game:GetService("UserInputService")
local T = game:GetService("TweenService")
local P = game:GetService("Players")
local N = P.LocalPlayer.Name

local function mk(c, p, pa)
    local i = Instance.new(c)
    for k, v in pairs(p or {}) do i[k] = v end
    if pa then i.Parent = pa end
    return i
end

local function tw(i, t, g)
    local info = TweenInfo.new(t, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local a = T:Create(i, info, g)
    a:Play()
    return a
end

function G2L.Init(cfg)
    cfg = cfg or {}
    local URL = (cfg.SupabaseBase or "https://dbsjsvncnnmewregcnwg.supabase.co/rest/v1/") .. "global_chat"
    local KEY = cfg.AnonKey or "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRic2pzdm5jbm5tZXdyZWdjbndnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUyMDkyNzksImV4cCI6MjA5MDc4NTI3OX0.d9o1x2WhKibg01bvkz1Sd-zk3s65inec4wVibmSEJ3k"
    local HD = {["apikey"] = KEY, ["Authorization"] = "Bearer " .. KEY, ["Content-Type"] = "application/json"}
    local CD = 5
    local AC = {}

    local sg = mk("ScreenGui", {Name="gChat", IgnoreGuiInset=true, ScreenInsets=Enum.ScreenInsets.DeviceSafeInsets})
    pcall(function() sg.Parent = C end)
    if not sg.Parent then sg.Parent = P:WaitForChild("PlayerGui") end

    local bg = mk("Frame", {Name="backGround", Size=UDim2.new(0,476,0,333), Position=UDim2.new(0.5,-238,0.5,-120), BackgroundColor3=Color3.fromRGB(10,10,10), BackgroundTransparency=1, BorderSizePixel=0}, sg)
    mk("UICorner", {CornerRadius=UDim.new(0,4)}, bg)
    local st = mk("UIStroke", {Color=Color3.fromRGB(27,27,27), ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Transparency=1}, bg)

    local sh = mk("Frame", {Name="shadowHolder", Size=UDim2.new(1.027,0,1.042,0), Position=UDim2.new(-0.014,0,-0.018,0), BackgroundTransparency=1, ZIndex=0}, bg)
    local sha = {}
    for i=1,3 do table.insert(sha, mk("ImageLabel", {Image="rbxassetid://1316045217", Size=UDim2.new(1,4,1,4), Position=UDim2.new(0.5,0,0.5,2), AnchorPoint=Vector2.new(0.5,0.5), BackgroundTransparency=1, ImageColor3=Color3.new(0,0,0), ImageTransparency=1, ScaleType=Enum.ScaleType.Slice, SliceCenter=Rect.new(10,10,118,118), ZIndex=0}, sh)) end

    local tb = mk("Frame", {Size=UDim2.new(1,0,0,35), BackgroundTransparency=1, Active=true, ZIndex=5}, bg)
    local cb = mk("TextButton", {Size=UDim2.new(0,35,0,35), Position=UDim2.new(1,-35,0,0), BackgroundTransparency=1, Text="/", TextColor3=Color3.fromRGB(200,200,200), TextSize=14, Font=Enum.Font.GothamMedium, TextTransparency=1}, tb)

    local gr = mk("Frame", {Size=UDim2.new(1,-2,0,45), Position=UDim2.new(0,1,0,1), BackgroundColor3=Color3.fromRGB(10,10,10), BorderSizePixel=0, ZIndex=4}, bg)
    mk("UIGradient", {Rotation=90, Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,0), NumberSequenceKeypoint.new(1,1)})}, gr)

    local ib = mk("Frame", {Name="inputBar", Size=UDim2.new(0,460,0,38), Position=UDim2.new(0.5,-230,0.86,0), BackgroundColor3=Color3.fromRGB(7,7,7), BorderSizePixel=0, ZIndex=3, BackgroundTransparency=1}, bg)
    mk("UICorner", {CornerRadius=UDim.new(0,2)}, ib)
    local is = mk("UIStroke", {Color=Color3.fromRGB(31,31,31), ApplyStrokeMode=Enum.ApplyStrokeMode.Border, Transparency=1}, ib)
    local bx = mk("TextBox", {Size=UDim2.new(1,-20,1,0), Position=UDim2.new(0,10,0,0), BackgroundTransparency=1, Text="", PlaceholderText="start typing on gChat", TextColor3=Color3.fromRGB(204,204,204), PlaceholderColor3=Color3.fromRGB(41,41,41), Font=Enum.Font.Gotham, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left, TextWrapped=true, ClearTextOnFocus=false, TextTransparency=1}, ib)

    local sf = mk("ScrollingFrame", {Size=UDim2.new(1,0,1,-85), Position=UDim2.new(0,0,0,5), BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=2, ScrollBarImageColor3=Color3.fromRGB(31,31,31), CanvasSize=UDim2.new(0,0,0,0), ZIndex=2}, bg)
    mk("UIPadding", {PaddingTop=UDim.new(0,40), PaddingBottom=UDim.new(0,10), PaddingLeft=UDim.new(0,15), PaddingRight=UDim.new(0,15)}, sf)
    local ly = mk("UIListLayout", {Padding=UDim.new(0,16), SortOrder=Enum.SortOrder.LayoutOrder}, sf)

    tw(bg, 0.6, {BackgroundTransparency=0.05, Position=UDim2.new(0.5,-238,0.5,-166)})
    tw(st, 0.6, {Transparency=0})
    tw(is, 0.6, {Transparency=0})
    tw(cb, 0.6, {TextTransparency=0})
    tw(bx, 0.6, {TextTransparency=0})
    tw(ib, 0.6, {BackgroundTransparency=0})
    for _, s in pairs(sha) do tw(s, 0.8, {ImageTransparency=0.86}) end

    local dr, di, ds, sp
    tb.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dr, ds, sp = true, i.Position, bg.Position
            i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then dr = false end end)
        end
    end)
    U.InputChanged:Connect(function(i) 
        if i.UserInputType == Enum.UserInputType.MouseMovement then di = i end
        if i == di and dr then 
            local d = i.Position - ds
            bg.Position = UDim2.new(sp.X.Scale, sp.X.Offset + d.X, sp.Y.Scale, sp.Y.Offset + d.Y) 
        end 
    end)

    local function getAv(u, img)
        if AC[u] then img.Image = AC[u] return end
        task.spawn(function()
            local s, id = pcall(P.GetUserIdFromNameAsync, P, u)
            if s then
                local t = P:GetUserThumbnailAsync(id, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
                AC[u] = t
                img.Image = t
            end
        end)
    end

    local function mkMsg(usr, txt, ord)
        local f = mk("Frame", {BackgroundTransparency=1, LayoutOrder=ord, Size=UDim2.new(1,0,0,0)}, sf)
        local av = mk("ImageLabel", {Size=UDim2.new(0,34,0,34), BackgroundColor3=Color3.fromRGB(20,20,20), BorderSizePixel=0, ImageTransparency=1}, f)
        mk("UICorner", {CornerRadius=UDim.new(1,0)}, av)
        getAv(usr, av)
        
        local nl = mk("TextLabel", {Size=UDim2.new(1,-44,0,14), Position=UDim2.new(0,44,0,0), BackgroundTransparency=1, Text=usr, TextColor3=Color3.fromRGB(255,255,255), Font=Enum.Font.GothamMedium, TextSize=13, TextXAlignment=Enum.TextXAlignment.Left, TextTransparency=1}, f)
        local tl = mk("TextLabel", {Size=UDim2.new(1,-44,0,0), Position=UDim2.new(0,44,0,16), BackgroundTransparency=1, Text=txt, TextColor3=Color3.fromRGB(180,180,180), Font=Enum.Font.Gotham, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left, TextWrapped=true, TextTransparency=1}, f)
        
        tl.Size = UDim2.new(1,-44,0,tl.TextBounds.Y)
        f.Size = UDim2.new(1,0,0,math.max(34, 16 + tl.TextBounds.Y))

        tw(av, 0.4, {ImageTransparency=0})
        tw(nl, 0.4, {TextTransparency=0})
        tw(tl, 0.4, {TextTransparency=0})
    end

    local run, lId, snd, lSt = true, "", false, 0
    cb.MouseButton1Click:Connect(function() 
        run = false 
        tw(bg, 0.4, {BackgroundTransparency=1, Position=UDim2.new(0.5,-238,0.5,-120)})
        tw(st, 0.4, {Transparency=1})
        tw(is, 0.4, {Transparency=1})
        tw(cb, 0.4, {TextTransparency=1})
        tw(bx, 0.4, {TextTransparency=1})
        for _, s in pairs(sha) do tw(s, 0.4, {ImageTransparency=1}) end
        task.wait(0.4)
        sg:Destroy() 
    end)

    local function ftc()
        local res = request({Url = URL .. "?select=*&order=created_at.desc&limit=30", Method = "GET", Headers = HD})
        if res.StatusCode == 200 then
            local d = H:JSONDecode(res.Body)
            if #d > 0 and d[1].id ~= lId then
                lId = d[1].id
                for _, c in pairs(sf:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
                for i = #d, 1, -1 do mkMsg(d[i].username, d[i].message, #d - i) end
                sf.CanvasSize = UDim2.new(0, 0, 0, ly.AbsoluteContentSize.Y + 50)
                sf.CanvasPosition = Vector2.new(0, sf.CanvasSize.Y.Offset)
            end
        end
    end

    local function push()
        local txt = bx.Text:gsub("^%s*(.-)%s*$", "%1")
        if txt == "" or snd then return end
        local cur = tick()
        if cur - lSt < CD then
            bx.Text = ""
            bx.PlaceholderText = "wait " .. math.ceil(CD - (cur - lSt)) .. "s"
            task.wait(1.5)
            bx.PlaceholderText = "start typing on gChat"
            return
        end
        snd, lSt = true, cur
        bx.Text, bx.PlaceholderText = "", "..."
        request({Url = URL, Method = "POST", Headers = HD, Body = H:JSONEncode({username = N, message = txt})})
        ftc()
        bx.PlaceholderText = "start typing on gChat"
        task.wait(0.2)
        snd = false
    end

    bx.FocusLost:Connect(function(e) if e then push() end end)
    task.spawn(function() while run do ftc() task.wait(2.5) end end)
end

return G2L
