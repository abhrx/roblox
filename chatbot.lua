local G2L = {};

-- StarterGui.chatbotNotice
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["IgnoreGuiInset"] = true;
G2L["1"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
G2L["1"]["Name"] = [[chatbotNotice]];


-- StarterGui.chatbotNotice.backGround
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(3, 3, 3);
G2L["2"]["Size"] = UDim2.new(0.42162, 0, 0.2869, 0);
G2L["2"]["Position"] = UDim2.new(0.26366, 0, 0.29314, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Name"] = [[backGround]];


-- StarterGui.chatbotNotice.backGround.topNav
G2L["3"] = Instance.new("Frame", G2L["2"]);
G2L["3"]["BorderSizePixel"] = 0;
G2L["3"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3"]["Size"] = UDim2.new(1, 0, 0.22828, 0);
G2L["3"]["Position"] = UDim2.new(0, 0, -0.08182, 0);
G2L["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3"]["Name"] = [[topNav]];


-- StarterGui.chatbotNotice.backGround.topNav.UIStroke
G2L["4"] = Instance.new("UIStroke", G2L["3"]);
G2L["4"]["Thickness"] = 0.9;
G2L["4"]["Color"] = Color3.fromRGB(31, 31, 31);


-- StarterGui.chatbotNotice.backGround.topNav.Title
G2L["5"] = Instance.new("TextLabel", G2L["3"]);
G2L["5"]["BorderSizePixel"] = 0;
G2L["5"]["TextSize"] = 14;
G2L["5"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["5"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["5"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["5"]["TextColor3"] = Color3.fromRGB(213, 213, 213);
G2L["5"]["BackgroundTransparency"] = 1;
G2L["5"]["Size"] = UDim2.new(0.27606, 0, 1, 0);
G2L["5"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["5"]["Text"] = [[Discontinued]];
G2L["5"]["Name"] = [[Title]];
G2L["5"]["Position"] = UDim2.new(0.03099, 0, 0, 0);


-- StarterGui.chatbotNotice.backGround.Content
G2L["6"] = Instance.new("Frame", G2L["2"]);
G2L["6"]["BorderSizePixel"] = 0;
G2L["6"]["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6"]["Size"] = UDim2.new(0.94366, 0, 0.70021, 0);
G2L["6"]["Position"] = UDim2.new(0.02817, 0, 0.18687, 0);
G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6"]["Name"] = [[Content]];


-- StarterGui.chatbotNotice.backGround.Content.Text
G2L["7"] = Instance.new("TextLabel", G2L["6"]);
G2L["7"]["TextWrapped"] = true;
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["TextSize"] = 14;
G2L["7"]["TextXAlignment"] = Enum.TextXAlignment.Left;
G2L["7"]["TextYAlignment"] = Enum.TextYAlignment.Top;
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["7"]["TextColor3"] = Color3.fromRGB(196, 196, 196);
G2L["7"]["BackgroundTransparency"] = 1;
G2L["7"]["RichText"] = true;
G2L["7"]["Size"] = UDim2.new(0.93731, 0, 0.51574, 0);
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["Text"] = [["Chatbot" has been <b>discontinued</b>, i lost the original code and accidentally replaced the code in github lmao]];
G2L["7"]["Name"] = [[Text]];
G2L["7"]["Position"] = UDim2.new(0.0209, 0, 0.06, 0);


-- StarterGui.chatbotNotice.backGround.Content.UIStroke
G2L["8"] = Instance.new("UIStroke", G2L["6"]);
G2L["8"]["Thickness"] = 0.9;
G2L["8"]["Color"] = Color3.fromRGB(31, 31, 31);


-- StarterGui.chatbotNotice.backGround.Content.Close
G2L["9"] = Instance.new("TextButton", G2L["6"]);
G2L["9"]["BorderSizePixel"] = 0;
G2L["9"]["TextSize"] = 14;
G2L["9"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9"]["BackgroundColor3"] = Color3.fromRGB(222, 222, 222);
G2L["9"]["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["9"]["Size"] = UDim2.new(0, 136, 0, 19);
G2L["9"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["9"]["Text"] = [[kys]];
G2L["9"]["Name"] = [[Close]];
G2L["9"]["Position"] = UDim2.new(0.28657, 0, 0.66232, 0);


-- StarterGui.chatbotNotice.backGround.Content.Close.UICorner
G2L["a"] = Instance.new("UICorner", G2L["9"]);
G2L["a"]["CornerRadius"] = UDim.new(1, 0);


-- StarterGui.chatbotNotice.backGround.Content.Close.LocalScript
G2L["b"] = Instance.new("LocalScript", G2L["9"]);



-- StarterGui.chatbotNotice.backGround.shadowHolder
G2L["c"] = Instance.new("Frame", G2L["2"]);
G2L["c"]["ZIndex"] = 0;
G2L["c"]["Size"] = UDim2.new(1.02014, 0, 1.19308, 0);
G2L["c"]["Position"] = UDim2.new(-0.00725, 0, -0.1496, 0);
G2L["c"]["Name"] = [[shadowHolder]];
G2L["c"]["BackgroundTransparency"] = 1;


-- StarterGui.chatbotNotice.backGround.shadowHolder.umbraShadow
G2L["d"] = Instance.new("ImageLabel", G2L["c"]);
G2L["d"]["ZIndex"] = 0;
G2L["d"]["SliceCenter"] = Rect.new(10, 10, 118, 118);
G2L["d"]["ScaleType"] = Enum.ScaleType.Slice;
G2L["d"]["ImageTransparency"] = 0.86;
-- [ERROR] cannot convert ImageContent, please report to "https://github.com/uniquadev/GuiToLuaConverter/issues"
G2L["d"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["d"]["Image"] = [[rbxassetid://1316045217]];
G2L["d"]["Size"] = UDim2.new(1, 4, 1, 4);
G2L["d"]["BackgroundTransparency"] = 1;
G2L["d"]["Name"] = [[umbraShadow]];
G2L["d"]["Position"] = UDim2.new(0.5, 0, 0.5, 2);


-- StarterGui.chatbotNotice.backGround.shadowHolder.penumbraShadow
G2L["e"] = Instance.new("ImageLabel", G2L["c"]);
G2L["e"]["ZIndex"] = 0;
G2L["e"]["SliceCenter"] = Rect.new(10, 10, 118, 118);
G2L["e"]["ScaleType"] = Enum.ScaleType.Slice;
G2L["e"]["ImageTransparency"] = 0.88;
-- [ERROR] cannot convert ImageContent, please report to "https://github.com/uniquadev/GuiToLuaConverter/issues"
G2L["e"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["e"]["Image"] = [[rbxassetid://1316045217]];
G2L["e"]["Size"] = UDim2.new(1, 4, 1, 4);
G2L["e"]["BackgroundTransparency"] = 1;
G2L["e"]["Name"] = [[penumbraShadow]];
G2L["e"]["Position"] = UDim2.new(0.5, 0, 0.5, 2);


-- StarterGui.chatbotNotice.backGround.shadowHolder.ambientShadow
G2L["f"] = Instance.new("ImageLabel", G2L["c"]);
G2L["f"]["ZIndex"] = 0;
G2L["f"]["SliceCenter"] = Rect.new(10, 10, 118, 118);
G2L["f"]["ScaleType"] = Enum.ScaleType.Slice;
G2L["f"]["ImageTransparency"] = 0.48;
-- [ERROR] cannot convert ImageContent, please report to "https://github.com/uniquadev/GuiToLuaConverter/issues"
G2L["f"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["f"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
G2L["f"]["Image"] = [[rbxassetid://1316045217]];
G2L["f"]["Size"] = UDim2.new(1, 4, 1, 4);
G2L["f"]["BackgroundTransparency"] = 1;
G2L["f"]["Name"] = [[ambientShadow]];
G2L["f"]["Position"] = UDim2.new(0.5, 0, 0.5, 2);


-- StarterGui.chatbotNotice.backGround.Content.Close.LocalScript
local function C_b()
local script = G2L["b"];
	local closeBtn = script.Parent
	local gui = closeBtn.Parent.Parent.Parent
	
	closeBtn.MouseButton1Click:Connect(function()
		for i, d in gui:GetDescendants() do
			if d ~= script then d:Destroy() end
			gui:Destroy()
		end
	end)
end;
task.spawn(C_b);

return G2L["1"], require;
