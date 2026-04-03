local KeySystem = {}
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

function KeySystem.Init(config)
    config = config or {}

    -- Defaults
    local SUPABASE_URL = config.SupabaseUrl or "https://dbsjsvncnnmewregcnwg.supabase.co/rest/v1/script_keys"
    local ANON_KEY = config.AnonKey or "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRic2pzdm5jbm5tZXdyZWdjbndnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUyMDkyNzksImV4cCI6MjA5MDc4NTI3OX0.d9o1x2WhKibg01bvkz1Sd-zk3s65inec4wVibmSEJ3k"
    local HOST_URL = config.WebsiteUrl or "https://www.shlua.ct.ws"
    
    local OnComplete = config.OnComplete or function() warn("Authenticated, but no callback provided.") end

    -- ==========================================
    -- SHADCN / WEBSITE AESTHETIC (SHARP, 2-COLUMN)
    -- ==========================================
    
    -- Zinc Palette
    local C_BgDark = Color3.fromRGB(9, 9, 11)      -- Zinc 950 (Left Panel)
    local C_BgLight = Color3.fromRGB(24, 24, 27)   -- Zinc 900 (Right Panel)
    local C_Border = Color3.fromRGB(39, 39, 42)    -- Zinc 800
    local C_TextHead = Color3.fromRGB(250, 250, 250) -- Zinc 50
    local C_TextMuted = Color3.fromRGB(161, 161, 170) -- Zinc 400
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "EditorialKeyAuth"
    ScreenGui.ResetOnSpawn = false

    local success = pcall(function() ScreenGui.Parent = CoreGui end)
    if not success then ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end

    -- Main Container (Sharp edges, 1px border)
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 560, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -280, 0.5, -150)
    MainFrame.BackgroundColor3 = C_BgDark
    MainFrame.BorderSizePixel = 1
    MainFrame.BorderColor3 = C_Border
    MainFrame.Parent = ScreenGui

    -- ==============================
    -- LEFT PANEL (Info)
    -- ==============================
    local LeftPanel = Instance.new("Frame")
    LeftPanel.Size = UDim2.new(0, 220, 1, 0)
    LeftPanel.Position = UDim2.new(0, 0, 0, 0)
    LeftPanel.BackgroundColor3 = C_BgDark
    LeftPanel.BorderSizePixel = 0
    LeftPanel.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -48, 0, 30)
    Title.Position = UDim2.new(0, 24, 0, 30)
    Title.BackgroundTransparency = 1
    Title.Text = "Secure Session"
    Title.TextColor3 = C_TextHead
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = LeftPanel

    local Desc = Instance.new("TextLabel")
    Desc.Size = UDim2.new(1, -48, 0, 80)
    Desc.Position = UDim2.new(0, 24, 0, 65)
    Desc.BackgroundTransparency = 1
    Desc.Text = "This key is bound to your execution environment. Generating this key requires verifying your session integrity."
    Desc.TextColor3 = C_TextMuted
    Desc.Font = Enum.Font.Gotham
    Desc.TextSize = 12
    Desc.TextWrapped = true
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    Desc.TextYAlignment = Enum.TextYAlignment.Top
    Desc.Parent = LeftPanel

    local StatusBadge = Instance.new("Frame")
    StatusBadge.Size = UDim2.new(1, -48, 0, 30)
    StatusBadge.Position = UDim2.new(0, 24, 1, -54)
    StatusBadge.BackgroundColor3 = C_BgDark
    StatusBadge.BorderColor3 = C_Border
    StatusBadge.BorderSizePixel = 1
    StatusBadge.Parent = LeftPanel

    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, -20, 1, 0)
    StatusText.Position = UDim2.new(0, 10, 0, 0)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "Status: Awaiting Input"
    StatusText.TextColor3 = C_TextHead
    StatusText.Font = Enum.Font.Gotham
    StatusText.TextSize = 11
    StatusText.TextXAlignment = Enum.TextXAlignment.Left
    StatusText.Parent = StatusBadge

    -- ==============================
    -- RIGHT PANEL (Action)
    -- ==============================
    local RightPanel = Instance.new("Frame")
    RightPanel.Size = UDim2.new(0, 340, 1, 0)
    RightPanel.Position = UDim2.new(0, 220, 0, 0)
    RightPanel.BackgroundColor3 = C_BgLight
    RightPanel.BorderColor3 = C_Border
    RightPanel.BorderSizePixel = 1
    RightPanel.Parent = MainFrame

    local ActionTitle = Instance.new("TextLabel")
    ActionTitle.Size = UDim2.new(1, -60, 0, 20)
    ActionTitle.Position = UDim2.new(0, 30, 0, 60)
    ActionTitle.BackgroundTransparency = 1
    ActionTitle.Text = "Your Execution Key"
    ActionTitle.TextColor3 = C_TextHead
    ActionTitle.Font = Enum.Font.GothamMedium
    ActionTitle.TextSize = 14
    ActionTitle.TextXAlignment = Enum.TextXAlignment.Left
    ActionTitle.Parent = RightPanel

    local ActionSub = Instance.new("TextLabel")
    ActionSub.Size = UDim2.new(1, -60, 0, 20)
    ActionSub.Position = UDim2.new(0, 30, 0, 85)
    ActionSub.BackgroundTransparency = 1
    ActionSub.Text = "Paste the payload to authenticate."
    ActionSub.TextColor3 = C_TextMuted
    ActionSub.Font = Enum.Font.Gotham
    ActionSub.TextSize = 12
    ActionSub.TextXAlignment = Enum.TextXAlignment.Left
    ActionSub.Parent = RightPanel

    local KeyInput = Instance.new("TextBox")
    KeyInput.Size = UDim2.new(1, -60, 0, 40)
    KeyInput.Position = UDim2.new(0, 30, 0, 115)
    KeyInput.BackgroundColor3 = C_BgDark
    KeyInput.BorderColor3 = C_Border
    KeyInput.BorderSizePixel = 1
    KeyInput.TextColor3 = C_TextHead
    KeyInput.PlaceholderText = "---------"
    KeyInput.PlaceholderColor3 = C_TextMuted
    KeyInput.Font = Enum.Font.Code
    KeyInput.TextSize = 13
    KeyInput.TextXAlignment = Enum.TextXAlignment.Left
    KeyInput.Parent = RightPanel

    local InputPadding = Instance.new("UIPadding")
    InputPadding.PaddingLeft = UDim.new(0, 15)
    InputPadding.Parent = KeyInput

    -- Buttons
    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0, 130, 0, 36)
    SubmitBtn.Position = UDim2.new(0, 30, 0, 175)
    SubmitBtn.BackgroundColor3 = C_TextHead -- Primary White
    SubmitBtn.BorderSizePixel = 0
    SubmitBtn.TextColor3 = C_BgDark
    SubmitBtn.Text = "Execute"
    SubmitBtn.Font = Enum.Font.GothamMedium
    SubmitBtn.TextSize = 13
    SubmitBtn.Parent = RightPanel

    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Size = UDim2.new(0, 130, 0, 36)
    GetKeyBtn.Position = UDim2.new(0, 175, 0, 175)
    GetKeyBtn.BackgroundColor3 = C_BgLight
    GetKeyBtn.BorderColor3 = C_Border
    GetKeyBtn.BorderSizePixel = 1
    GetKeyBtn.TextColor3 = C_TextHead
    GetKeyBtn.Text = "Get Key"
    GetKeyBtn.Font = Enum.Font.GothamMedium
    GetKeyBtn.TextSize = 13
    GetKeyBtn.Parent = RightPanel

    -- ==========================================
    -- Logic
    -- ==========================================
    local function generateRandomKey()
        local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        local randomKey = ""
        for i = 1, 10 do
            local rand = math.random(1, #chars)
            randomKey = randomKey .. string.sub(chars, rand, rand)
        end
        return "PREMIUM-" .. randomKey
    end

    GetKeyBtn.MouseButton1Click:Connect(function()
        StatusText.Text = "Status: Generating..."
        
        local newKey = generateRandomKey()
        local payload = HttpService:JSONEncode({ key_value = newKey, is_used = false })

        local response = request({
            Url = SUPABASE_URL,
            Method = "POST",
            Headers = {
                ["apikey"] = ANON_KEY,
                ["Authorization"] = "Bearer " .. ANON_KEY,
                ["Content-Type"] = "application/json",
                ["Prefer"] = "return=representation"
            },
            Body = payload
        })

        if response.StatusCode == 201 then
            local data = HttpService:JSONDecode(response.Body)
            local generatedId = data[1].id
            local linkToCopy = HOST_URL .. "/?id=" .. generatedId
            
            if setclipboard then
                setclipboard(linkToCopy)
                StatusText.Text = "Status: Copied to clipboard"
                StatusText.TextColor3 = Color3.fromRGB(167, 243, 208)
            else
                StatusText.Text = "Status: Check dev console (F9)"
                print("Copy this link to get your key: " .. linkToCopy)
            end
        else
            StatusText.Text = "Status: Server Error"
            StatusText.TextColor3 = Color3.fromRGB(254, 202, 202)
        end
    end)

    SubmitBtn.MouseButton1Click:Connect(function()
        local providedKey = KeyInput.Text
        if providedKey == "" then
            StatusText.Text = "Status: Please enter a key"
            StatusText.TextColor3 = Color3.fromRGB(254, 202, 202)
            return
        end

        StatusText.Text = "Status: Authenticating..."
        StatusText.TextColor3 = C_TextHead

        local response = request({
            Url = SUPABASE_URL .. "?key_value=eq." .. providedKey .. "&select=*",
            Method = "GET",
            Headers = {
                ["apikey"] = ANON_KEY,
                ["Authorization"] = "Bearer " .. ANON_KEY,
                ["Content-Type"] = "application/json"
            }
        })
        
        if response.StatusCode == 200 then
            local data = HttpService:JSONDecode(response.Body)
            if #data > 0 then
                local keyData = data[1]
                if keyData.is_used then
                    StatusText.Text = "Status: Key already consumed"
                    StatusText.TextColor3 = Color3.fromRGB(254, 202, 202)
                else
                    StatusText.Text = "Status: Access Granted"
                    StatusText.TextColor3 = Color3.fromRGB(167, 243, 208)
                    
                    -- Burn the key (THE PATCH FIX: Using POST with Override Header)
                    request({
                        Url = SUPABASE_URL .. "?id=eq." .. keyData.id,
                        Method = "POST",
                        Headers = {
                            ["apikey"] = ANON_KEY,
                            ["Authorization"] = "Bearer " .. ANON_KEY,
                            ["Content-Type"] = "application/json",
                            ["X-HTTP-Method-Override"] = "PATCH"
                        },
                        Body = HttpService:JSONEncode({ is_used = true })
                    })
                    
                    task.wait(1)
                    ScreenGui:Destroy()
                    
                    task.spawn(function()
                        OnComplete()
                    end)
                end
            else
                StatusText.Text = "Status: Invalid key"
                StatusText.TextColor3 = Color3.fromRGB(254, 202, 202)
            end
        else
            StatusText.Text = "Status: Connection failed"
            StatusText.TextColor3 = Color3.fromRGB(254, 202, 202)
        end
    end)
end

return KeySystem
