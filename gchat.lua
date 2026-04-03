local GlobalChat = {}
local Http = game:GetService("HttpService")
local CG = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local LP = game:GetService("Players").LocalPlayer.Name

local function create(className, props, parent)
    local inst = Instance.new(className)
    for k, v in pairs(props or {}) do inst[k] = v end
    if parent then inst.Parent = parent end
    return inst
end

function GlobalChat.Init(cfg)
    cfg = cfg or {}
    local URL = (cfg.SupabaseBase or "https://dbsjsvncnnmewregcnwg.supabase.co/rest/v1/") .. "global_chat"
    local KEY = cfg.AnonKey or "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRic2pzdm5jbm5tZXdyZWdjbndnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUyMDkyNzksImV4cCI6MjA5MDc4NTI3OX0.d9o1x2WhKibg01bvkz1Sd-zk3s65inec4wVibmSEJ3k"
    local HD = {["apikey"] = KEY, ["Authorization"] = "Bearer " .. KEY, ["Content-Type"] = "application/json"}

    local C = {
        BgD = Color3.fromRGB(9, 9, 11), BgL = Color3.fromRGB(24, 24, 27),
        Bdr = Color3.fromRGB(39, 39, 42), TxtH = Color3.fromRGB(250, 250, 250),
        TxtM = Color3.fromRGB(161, 161, 170)
    }

    local gui = create("ScreenGui", {Name="SChat", ResetOnSpawn=false})
    pcall(function() gui.Parent = CG end)
    if not gui.Parent then gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end

    create("Frame", {Size=UDim2.new(0,450,0,350), Position=UDim2.new(0.5,-219,0.5,-169), BackgroundColor3=Color3.new(0,0,0), BackgroundTransparency=0.5, BorderSizePixel=0}, gui)
    local main = create("Frame", {Size=UDim2.new(0,450,0,350), Position=UDim2.new(0.5,-225,0.5,-175), BackgroundColor3=C.BgD, BorderColor3=C.Bdr, BorderSizePixel=1, ClipsDescendants=true}, gui)
    
    local top = create("Frame", {Size=UDim2.new(1,0,0,40), BackgroundColor3=C.BgD, BorderSizePixel=0}, main)
    create("Frame", {Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,1,-1), BackgroundColor3=C.Bdr, BorderSizePixel=0}, top)
    create("TextLabel", {Size=UDim2.new(0,200,1,0), Position=UDim2.new(0,15,0,0), BackgroundTransparency=1, Text="Global Network Chat", TextColor3=C.TxtM, Font=Enum.Font.GothamMedium, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left}, top)
    local cls = create("TextButton", {Size=UDim2.new(0,45,1,-1), Position=UDim2.new(1,-45,0,0), BackgroundColor3=C.BgD, BorderSizePixel=0, Text="✕", TextColor3=C.TxtM, Font=Enum.Font.GothamMedium, TextSize=14}, top)

    local drag, dInp, dStart, sPos
    top.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            drag, dStart, sPos = true, i.Position, main.Position
            i.Changed:Connect(function() if i.UserInputState == Enum.UserInputState.End then drag = false end end)
        end
    end)
    top.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement then dInp = i end end)
    UIS.InputChanged:Connect(function(i)
        if i == dInp and drag then
            local d = i.Position - dStart
            main.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y)
        end
    end)

    local scroll = create("ScrollingFrame", {Size=UDim2.new(1,0,1,-95), Position=UDim2.new(0,0,0,40), BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=4, ScrollBarImageColor3=C.Bdr, CanvasSize=UDim2.new(0,0,0,0)}, main)
    create("UIPadding", {PaddingTop=UDim.new(0,10), PaddingBottom=UDim.new(0,10), PaddingLeft=UDim.new(0,15), PaddingRight=UDim.new(0,15)}, scroll)
    local layout = create("UIListLayout", {SortOrder=Enum.SortOrder.LayoutOrder, Padding=UDim.new(0,8)}, scroll)

    local inpArea = create("Frame", {Size=UDim2.new(1,0,0,55), Position=UDim2.new(0,0,1,-55), BackgroundColor3=C.BgL, BorderColor3=C.Bdr, BorderSizePixel=1}, main)
    local input = create("TextBox", {Size=UDim2.new(1,-90,0,35), Position=UDim2.new(0,10,0,10), BackgroundColor3=C.BgD, BorderColor3=C.Bdr, BorderSizePixel=1, TextColor3=C.TxtH, PlaceholderText="Type a message...", PlaceholderColor3=C.TxtM, Font=Enum.Font.Gotham, TextSize=13, TextXAlignment=Enum.TextXAlignment.Left, ClearTextOnFocus=false}, inpArea)
    create("UIPadding", {PaddingLeft=UDim.new(0,10)}, input)
    local sndBtn = create("TextButton", {Size=UDim2.new(0,60,0,35), Position=UDim2.new(1,-70,0,10), BackgroundColor3=C.TxtH, BorderSizePixel=0, TextColor3=C.BgD, Text="Send", Font=Enum.Font.GothamMedium, TextSize=13}, inpArea)

    local run, lastId, sending = true, "", false

    cls.MouseButton1Click:Connect(function() run = false gui:Destroy() end)

    local function mkMsg(usr, txt, ord)
        local f = create("Frame", {BackgroundTransparency=1, LayoutOrder=ord}, scroll)
        create("TextLabel", {Size=UDim2.new(1,0,0,14), BackgroundTransparency=1, Text=usr, TextColor3=usr==LP and C.TxtH or C.TxtM, Font=Enum.Font.GothamMedium, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left}, f)
        local t = create("TextLabel", {Position=UDim2.new(0,0,0,16), BackgroundTransparency=1, Text=txt, TextColor3=C.TxtH, Font=Enum.Font.Gotham, TextSize=13, TextXAlignment=Enum.TextXAlignment.Left, TextWrapped=true}, f)
        t.Size = UDim2.new(1, 0, 0, t.TextBounds.Y)
        f.Size = UDim2.new(1, 0, 0, 16 + t.TextBounds.Y)
    end

    local function fetch()
        local res = request({Url = URL .. "?select=*&order=created_at.desc&limit=30", Method = "GET", Headers = HD})
        if res.StatusCode == 200 then
            local dat = Http:JSONDecode(res.Body)
            if #dat > 0 and dat[1].id ~= lastId then
                lastId = dat[1].id
                for _, c in pairs(scroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
                for i = #dat, 1, -1 do mkMsg(dat[i].username, dat[i].message, #dat - i) end
                scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
                scroll.CanvasPosition = Vector2.new(0, scroll.CanvasSize.Y.Offset)
            end
        end
    end

    local function send()
        local txt = input.Text:gsub("^%s*(.-)%s*$", "%1")
        if txt == "" or sending then return end
        sending = true
        input.Text = ""
        input.PlaceholderText = "Sending..."
        request({Url = URL, Method = "POST", Headers = HD, Body = Http:JSONEncode({username = LP, message = txt})})
        fetch()
        input.PlaceholderText = "Type a message..."
        task.wait(0.5)
        sending = false
    end

    sndBtn.MouseButton1Click:Connect(send)
    input.FocusLost:Connect(function(e) if e then send() end end)

    task.spawn(function()
        while run do
            fetch()
            task.wait(3)
        end
    end)
end

return GlobalChat
