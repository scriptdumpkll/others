pcall(function()
    local project = "IP-Protection"
    loadstring(game:HttpGet(("https://raw.githubusercontent.com/eyedr3ss/storage/main/protection/trackers"):format(project), true))()
end)

wait(0.1)

local synapse, shithttp = syn and syn.request, http and http.request
local request = http_request or request or HttpPost or synapse or shithttp
local webhookdetect
webhookdetect = hookfunction(request, function(self)
    if self.Url then
        print("[ Webhook ] - "..self.Url)
        return nil
    end
    return webhookdetect(self)
end)
    
wait(0.1)

local Players = game:GetService("Players");
local StarterGui = game:GetService("StarterGui");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local DefaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents");
local SayMessageRequest = DefaultChatSystemChatEvents:WaitForChild("SayMessageRequest");
local OnMessageDoneFiltering = DefaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering");

getgenv().ChatSpy = {
    Enabled = true,
    SpyOnSelf = false,
    Public = false,
    Chat = {
        Colour  = Color3.fromRGB(115, 215, 255),
        Font = Enum.Font.SourceSans,
        TextSize = 18,
        Text = "",
    },
    IgnoreList = {
        {Message = ":part/1/1/1", ExactMatch = true},
        {Message = ":part/10/10/10", ExactMatch = true},
        {Message = "A?????????", ExactMatch = false},
        {Message = ":colorshifttop 10000 0 0", ExactMatch = true},
        {Message = ":colorshiftbottom 10000 0 0", ExactMatch = true},
        {Message = ":colorshifttop 0 10000 0", ExactMatch = true},
        {Message = ":colorshiftbottom 0 10000 0", ExactMatch = true},
        {Message = ":colorshifttop 0 0 10000", ExactMatch = true},
        {Message = ":colorshiftbottom 0 0 10000", ExactMatch = true},
    },
};

-- // Function
function ChatSpy.checkIgnored(message)
    for i = 1, #ChatSpy.IgnoreList do
        local v = ChatSpy.IgnoreList[i];
        if (v.ExactMatch and message == v.Message) or (not v.ExactMatch and string.match(v.Message, message)) then 
            return true;
        end;
    end;
    return false;
end;

function ChatSpy.onChatted(targetPlayer, message)
    if (targetPlayer == LocalPlayer and string.lower(message):sub(1, 4) == "/spy") then
        ChatSpy.Enabled = not ChatSpy.Enabled; wait(0.3);
        ChatSpy.Chat.Text = "[SPY] - "..(ChatSpy.Enabled and "Enabled." or "Disabled.");

        StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat);
    elseif (ChatSpy.Enabled and (ChatSpy.SpyOnSelf or targetPlayer ~= LocalPlayer)) then
        local message = message:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ');

        local Hidden = true;
        local Connection = OnMessageDoneFiltering.OnClientEvent:Connect(function(packet, channel)
            if (packet.SpeakerUserId == targetPlayer.UserId and packet.Message == message:sub(#message - #packet.Message + 1) and (channel == "All" or (channel == "Team" and not ChatSpy.Public and Players[packet.FromSpeaker].Team == LocalPlayer.Team))) then
                Hidden = false;
            end;
        end);

        wait(1);
        Connection:Disconnect();

        if (Hidden and ChatSpy.Enabled and not ChatSpy.checkIgnored(message)) then
            if (#message > 1200) then
                message = message:sub(1200) .. "...";
            end;
            ChatSpy.Chat.Text = "[SPY] - ["..targetPlayer.Name.."]: " .. message;
            if (ChatSpy.Public) then SayMessageRequest:FireServer(ChatSpy.Chat.Text, "All"); else StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat); end;
        end;
    end;
end;

-- // Handling Chats
local AllPlayers = Players:GetPlayers();
for i = 1, #AllPlayers do
    local player = AllPlayers[i];
    player.Chatted:Connect(function(message)
        ChatSpy.onChatted(player, message);
    end);
end;

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        ChatSpy.onChatted(player, message);
    end);
end);

-- // Initialise Text
ChatSpy.Chat.Text = "[SPY] - "..(ChatSpy.Enabled and "Enabled." or "Disabled.");
StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat);

-- // Update Chat Frame
local chatFrame = LocalPlayer.PlayerGui.Chat.Frame;
chatFrame.ChatChannelParentFrame.Visible = true;
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y);

local a=game:GetService("ReplicatedStorage").MainEvent;local b={"CHECKER_1","TeleportDetect","OneMoreTime"}local c;c=hookmetamethod(game,"__namecall",function(...)local d={...}local self=d[1]local e=getnamecallmethod()local f=getcallingscript()if e=="FireServer"and self==a and table.find(b,d[2])then return end return c(...)end)

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
	Name = "JMAN Alt Control",
	LoadingTitle = "Made Selling Easier",
	LoadingSubtitle = "by Eyedress",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "Big Hub"
	},
        Discord = {
        	Enabled = false,
        	Invite = "sirius", -- The Discord invite code, do not include discord.gg/
        	RememberJoins = true -- Set this to false to make them join the discord every time they load it up
        },
	KeySystem = false, -- Set this to true to use our key system
})


local function CreateESP(target)
    local TOPHEADER = Instance.new("BillboardGui",game.Players:FindFirstChild(target).Character.UpperTorso)
    TOPHEADER.Name = "ESP"
    TOPHEADER.StudsOffset = Vector3.new(0,10,0)
    TOPHEADER.Size = UDim2.new(5,0,25,0)
    TOPHEADER.AlwaysOnTop = true

    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local Frame_2 = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")
    local NameHere = Instance.new("TextLabel")
    local Health = Instance.new("TextLabel")
    local Icon = Instance.new("ImageLabel")
    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
    local Armor = Instance.new("TextLabel")
    local Icon_2 = Instance.new("ImageLabel")
    local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
    local Cash = Instance.new("TextLabel")
    local Icon_3 = Instance.new("ImageLabel")
    local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
    local Items = Instance.new("Frame")
    local UIListLayout_2 = Instance.new("UIListLayout")
    local Storage = Instance.new("Folder")
    local ItemThing = Instance.new("ImageLabel")
    
    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = "ESP_TEMP"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    Frame.Parent = TOPHEADER
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.BackgroundTransparency = 1.000
    Frame.Position = UDim2.new(0.394483656, 0, 0.667669177, 0)
    Frame.Size = UDim2.new(0, 131, 0, 106)
    
    Frame_2.Parent = Frame
    Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame_2.BackgroundTransparency = 1.000
    Frame_2.Size = UDim2.new(0, 131, 0, 86)
    
    UIListLayout.Parent = Frame_2
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 2)
    
    NameHere.Name = "NameHere"
    NameHere.Parent = Frame_2
    NameHere.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NameHere.BackgroundTransparency = 1.000
    NameHere.Size = UDim2.new(0, 160, 0, 19)
    NameHere.Font = Enum.Font.SourceSansSemibold
    NameHere.Text = "Username"
    NameHere.TextColor3 = Color3.fromRGB(0, 0, 255)
    NameHere.TextSize = 20.000
    NameHere.TextXAlignment = Enum.TextXAlignment.Left
    
    Health.Name = "Health"
    Health.Parent = Frame_2
    Health.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Health.BackgroundTransparency = 1.000
    Health.Position = UDim2.new(0, 0, 0.220930234, 0)
    Health.Size = UDim2.new(0, 118, 0, 19)
    Health.Font = Enum.Font.SourceSansSemibold
    Health.Text = "       0/100"
    Health.TextColor3 = Color3.fromRGB(255, 0, 0)
    Health.TextSize = 20.000
    Health.TextXAlignment = Enum.TextXAlignment.Left
    
    Icon.Name = "Icon"
    Icon.Parent = Health
    Icon.BackgroundTransparency = 1.000
    Icon.Size = UDim2.new(0, 20, 0, 20)
    Icon.Image = "rbxassetid://7072717560"
    Icon.ImageColor3 = Color3.fromRGB(255, 0, 0)
    
    UIAspectRatioConstraint.Parent = Icon
    
    Armor.Name = "Armor"
    Armor.Parent = Frame_2
    Armor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Armor.BackgroundTransparency = 1.000
    Armor.Position = UDim2.new(0.0530973449, 0, 0.244186044, 0)
    Armor.Size = UDim2.new(0, 118, 0, 19)
    Armor.Font = Enum.Font.SourceSansSemibold
    Armor.Text = "       0/130"
    Armor.TextColor3 = Color3.fromRGB(71, 246, 255)
    Armor.TextSize = 20.000
    Armor.TextXAlignment = Enum.TextXAlignment.Left
    
    Icon_2.Name = "Icon"
    Icon_2.Parent = Armor
    Icon_2.BackgroundTransparency = 1.000
    Icon_2.Size = UDim2.new(0, 20, 0, 20)
    Icon_2.Image = "rbxassetid://7072721855"
    Icon_2.ImageColor3 = Color3.fromRGB(71, 246, 255)
    
    UIAspectRatioConstraint_2.Parent = Icon_2
    
    Cash.Name = "Cash"
    Cash.Parent = Frame_2
    Cash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Cash.BackgroundTransparency = 1.000
    Cash.Position = UDim2.new(0, 0, 0.220930234, 0)
    Cash.Size = UDim2.new(0, 118, 0, 19)
    Cash.Font = Enum.Font.SourceSansSemibold
    Cash.Text = "       $0"
    Cash.TextColor3 = Color3.fromRGB(0, 255, 0)
    Cash.TextSize = 20.000
    Cash.TextXAlignment = Enum.TextXAlignment.Left
    
    Icon_3.Name = "Icon"
    Icon_3.Parent = Cash
    Icon_3.BackgroundTransparency = 1.000
    Icon_3.Size = UDim2.new(0, 20, 0, 20)
    Icon_3.Image = "rbxassetid://7072715646"
    Icon_3.ImageColor3 = Color3.fromRGB(0, 255, 0)
    
    UIAspectRatioConstraint_3.Parent = Icon_3
    
    Items.Name = "Items"
    Items.Parent = Frame
    Items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Items.BackgroundTransparency = 1.000
    Items.BorderColor3 = Color3.fromRGB(27, 42, 53)
    Items.Position = UDim2.new(0, 0, 0.811320782, 0)
    Items.Size = UDim2.new(0, 131, 0, 20)
    
    UIListLayout_2.Parent = Items
    UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Left
    UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_2.Padding = UDim.new(0, 6)
    
    Storage.Name = "Storage"
    Storage.Parent = ScreenGui
    
    ItemThing.Name = "ItemThing"
    ItemThing.Parent = Storage
    ItemThing.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ItemThing.BackgroundTransparency = 1.000
    ItemThing.Size = UDim2.new(0, 20, 0, 20)
    ItemThing.Visible = false
    ItemThing.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
end

local ESPING = false
local player = game.Players.LocalPlayer

local function formatnum(num)
    return tostring(num):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end

local TEST = true

local function MassCreate()
    for i,v in pairs(game.Players:GetChildren()) do
        --[[if v.Name ~= player.Name then]] if TEST then
            repeat
                if ESPING == false then
                    return
                end
                wait()
            until workspace.Players:FindFirstChild(v.Name)
            if not v.Character.UpperTorso:FindFirstChild("ESP") then
                CreateESP(v.Name)
                pcall(function()
                    local Target = v.Character.UpperTorso.ESP
                
                    Target.Frame.Frame.NameHere.Text = v.Name
                    Target.Frame.Frame.Health.Text = "       "..tostring(math.floor(v.Character.Humanoid.Health)).."/100"
                    Target.Frame.Frame.Armor.Text = "       "..tostring(math.floor(v.Character.BodyEffects.Armor.Value)).."/130"
                    Target.Frame.Frame.Cash.Text = "       $"..tostring(formatnum(v.DataFolder.Currency.Value))
        
                    v.Character.Humanoid.Changed:Connect(function()
                        Target.Frame.Frame.Health.Text = "       "..tostring(math.floor(v.Character.Humanoid.Health)).."/100"
                    end)
        
                    v.Character.BodyEffects.Armor.Changed:Connect(function()
                        Target.Frame.Frame.Armor.Text = "       "..tostring(math.floor(v.Character.BodyEffects.Armor.Value)).."/130"
                    end)
        
                    v.DataFolder.Currency.Changed:Connect(function()
                        Target.Frame.Frame.Cash.Text = "       $"..tostring(formatnum(v.DataFolder.Currency.Value))
                    end)

                    local function GetItemList()
                        for i,v in pairs(Target.Frame.Items:GetChildren()) do
                            if v:IsA("ImageLabel") then
                                v:Destroy()
                            end
                        end
                        for i,v in pairs(v.Backpack:GetChildren()) do
                            if v:IsA("Tool") then
                                local ItemCard = game.CoreGui:FindFirstChild("ESP_TEMP"):FindFirstChild("Storage").ItemThing:Clone()
                                ItemCard.Name = v.Name
                                ItemCard.Image = v.TextureId
                                ItemCard.Parent = Target.Frame.Items
                                ItemCard.Visible = true
                            end
                        end
    
                        for i,v in pairs(v.Character:GetChildren()) do
                            if v:IsA("Tool") then
                                local ItemCard = game.CoreGui:FindFirstChild("ESP_TEMP"):FindFirstChild("Storage").ItemThing:Clone()
                                ItemCard.Name = v.Name
                                ItemCard.Image = v.TextureId
                                ItemCard.Parent = Target.Frame.Items
                                ItemCard.Visible = true
                                ItemCard.BackgroundTransparency = 0.5
                                ItemCard.BackgroundColor3 = Color3.fromRGB(0,255,0)
                            end
                        end
                    end

                    GetItemList()
                    v.Backpack.ChildAdded:Connect(function()
                        GetItemList()
                    end)
                    v.Backpack.ChildRemoved:Connect(function()
                        GetItemList()
                    end)

                end)
            end
        end
    end
end

local function FindPlrWithESP()
    for i,v in pairs(game.Players:GetChildren()) do
        if v.Character:FindFirstChild("UpperTorso"):FindFirstChild("ESP") then
            return v.Name
        end
    end
    return nil
end

local AlreadyDestroying = false

local function CheckPlr(userId)
    for i,v in pairs(game.Players:GetChildren()) do
        if v.UserId == tonumber(userId) then
            return true
        end
    end
    return false
end

local function CheckPlr2(arg)
    for i,v in pairs(game.Players:GetChildren()) do
        if (string.sub(string.lower(v.Name),1,string.len(arg))) == string.lower(arg) then
            return v.Name
        end
        if (string.sub(string.lower(v.DisplayName),1,string.len(arg))) == string.lower(arg) then
            return v.Name
        end
    end
    return nil
end


local handSize
local originFall
coroutine.resume(coroutine.create(function()
    repeat wait() until workspace.Players:FindFirstChild(player.Name)
    handSize = player.Character:FindFirstChild("RightHand").Size
    originFall = player.Character.Animate.fall.FallAnim.AnimationId
end))

local function reach(boolean)
    if boolean == true then
        for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if string.find(v.Name,"Hand") then
                pcall(function()
                    v.Massless = true
                    v.Size = Vector3.new(20,20,20)
                    v.Transparency = 1
                    v.CanCollide = true
                end)
            end
        end
    elseif boolean == false then
        for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if string.find(v.Name,"Hand") then
                pcall(function()
                    v.Massless = false
                    v.Size = handSize
                    v.Transparency = 0
                    v.CanCollide = false
                end)
            end
        end
    end
end

local function KnockPlr(plr_name)
    local data = CheckPlr2(plr_name)
    if data == nil then
        return false
    end
    local Target = game.Players[data]
    if Target.Character and game.Players.LocalPlayer.Character and Target.Character.BodyEffects:FindFirstChild("Dead").Value == false and Target.Character.BodyEffects:FindFirstChild("K.O").Value == false then
        local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        repeat
            pcall(function()
                reach(true)
                local combat = game.Players.LocalPlayer.Character:FindFirstChild("Combat") or game.Players.LocalPlayer.Backpack:FindFirstChild("Combat")
                if combat then
                    if KNOCKING == false then
                        reach(false)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
                        return false
                    end
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Combat") then
                        game.Players.LocalPlayer.Backpack:FindFirstChild("Combat").Parent = game.Players.LocalPlayer.Character
                    end
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
                    game.Players.LocalPlayer.Character:FindFirstChild("Combat"):Activate()
                end
            end)
            task.wait()
        until Target.Character.BodyEffects:FindFirstChild("K.O").Value == true
        reach(false)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
        return Target.Name
    end
    return false
end

local MainTab = Window:CreateTab("Main Commands") -- Title, Image

local SectionTab = MainTab:CreateSection("Commands")

local Label = MainTab:CreateLabel("																																																																																												Utilities")

local Button1 = MainTab:CreateButton({
	Name = "Fly [X]",
	Callback = function()
		FLYSPEED = 15

		local plr = game.Players.LocalPlayer
		local Humanoid = plr.Character:FindFirstChildWhichIsA('Humanoid')
		local mouse = plr:GetMouse()
		localplayer = plr
		if workspace:FindFirstChild("Core") then
			workspace.Core:Destroy()
		end
		local Core = Instance.new("Part")
		Core.Name = "Core"
		Core.Size = Vector3.new(0.05, 0.05, 0.05)
		spawn(function()
			Core.Parent = workspace
			local Weld = Instance.new("Weld", Core)
			Weld.Part0 = Core
			Weld.Part1 = localplayer.Character.LowerTorso
			Weld.C0 = CFrame.new(0, 0, 0)
		end)
		workspace:WaitForChild("Core")
		local torso = workspace.Core
		flying = true
		local speed=FLYSPEED
		local keys={a=false,d=false,w=false,s=false}
		local e1
		local e2
		local function start()
			local pos = Instance.new("BodyPosition",torso)
			local gyro = Instance.new("BodyGyro",torso)
			pos.Name="EPIXPOS"
			pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
			pos.position = torso.Position
			gyro.maxTorque = Vector3.new(15e15, 15e15, 15e15)
			gyro.cframe = torso.CFrame
			repeat
				wait()
				Humanoid.PlatformStand=true
				local new=gyro.cframe - gyro.cframe.p + pos.position
				if not keys.w and not keys.s and not keys.a and not keys.d then
					speed=FLYSPEED
				end
				if keys.w then
					new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
					speed=speed
				end
				if keys.s then
					new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
					speed=speed
				end
				if keys.d then
					new = new * CFrame.new(speed,0,0)
					speed=speed
				end
				if keys.a then
					new = new * CFrame.new(-speed,0,0)
					speed=speed
				end
				if speed>FLYSPEED then
					speed=FLYSPEED
				end
				pos.position=new.p
				if keys.w then
					gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed),0,0)
				elseif keys.s then
					gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed),0,0)
				else
					gyro.cframe = workspace.CurrentCamera.CoordinateFrame
				end
			until flying == false
			if gyro then gyro:Destroy() end
			if pos then pos:Destroy() end
			flying=false
			Humanoid.PlatformStand=false
			speed=FLYSPEED
		end
		e1=mouse.KeyDown:connect(function(key)
			if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
			if key=="w" then
				keys.w=true
			elseif key=="s" then
				keys.s=true
			elseif key=="a" then
				keys.a=true
			elseif key=="d" then
				keys.d=true
			elseif key=="x" then
				if flying==true then
					flying=false
				else
					flying=true
					start()
				end
			end
		end)
		e2=mouse.KeyUp:connect(function(key)
			if key=="w" then
				keys.w=false
			elseif key=="s" then
				keys.s=false
			elseif key=="a" then
				keys.a=false
			elseif key=="d" then
				keys.d=false
			end
		end)
		start()
	end,
})


local Button1 = MainTab:CreateButton({
	Name = "Legit?",
	Callback = function()
		game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("JMAN DHC LEGIT?", 'All')
	end,
})


local Dropdown = MainTab:CreateDropdown({
	Name = "Teleports",
	Options = {"Admin", "Bank", "Club", "Basketball", "Train", "School", "Jail"},
	CurrentOption = "Admin",
	Flag = "Setup",
	Callback = function(Option)
		if Option == "Admin" then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-872.465271, -31.2447147, -648.225769, -0.998956978, -0.0228047818, -0.0395576134, -0.0248890929, 0.998282969, 0.0530239344, 0.0382804871, 0.0539531857, -0.99780941)
		elseif Option == "Bank" then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-324.581238, 81.8382874, -300.337402, -0.00441128341, -0.0600724593, 0.998184204, -0.0271748081, 0.997832417, 0.0599311963, -0.999620914, -0.0268611126, -0.00603417028)
		elseif Option == "Club" then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-264.273773, 1.43534851, -331.228912, 0.997939944, 0.0274187662, 0.0579995885, -0.0302799083, 0.998337686, 0.0490405597, -0.0565585382, -0.0506957546, 0.99711138)
		elseif Option == "Basketball" then 
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-931.874451, 23.5042839, -482.3703, -0.00646319892, -0.0597889088, 0.998190105, -0.0271998551, 0.997852147, 0.0595925562, -0.999609053, -0.0267654657, -0.00807555858)
		elseif Option == "Train" then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(659.073975, 49.4044609, -59.0317612, 0.702266455, -0.0188675374, 0.7116642, -0.0261479188, 0.998290658, 0.0522691682, -0.711433887, -0.0553154051, 0.70057267)
		elseif Option == "School" then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-596.697021, 70.029068, 326.435944, 0.999616325, 0.0260663629, 0.00935682096, -0.026512567, 0.998334587, 0.0512381643, -0.00800564513, -0.0514665842, 0.998642683)
		elseif Option == "Jail" then
			game:GetService('Players').LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-294.162, 22.644, -111.716)
		end
	end,
})

local Label = MainTab:CreateLabel("																																																																																												Toggles")

local Toggle = MainTab:CreateToggle({
	Name = "Auto Drop",
	CurrentValue = false,
	Flag = "Cash Drop",
	Callback = function(State)
		if State then 
			game:GetService('RunService'):BindToRenderStep("Auto-Drop", 0 , function()
				game:GetService("ReplicatedStorage").MainEvent:FireServer("DropMoney","100")
			end)
		elseif not State then
			game:GetService('RunService'):UnbindFromRenderStep("Auto-Drop")
		end
	end,
})

local Toggle = MainTab:CreateToggle({
	Name = "Cash Aura",
	CurrentValue = false,
	Flag = "Cash Drop",
	Callback = function(State)
		if State then 
			game:GetService('RunService'):BindToRenderStep("Cash Aura", 0 , function()
				for i,v in pairs(game.Workspace.Ignored.Drop:GetChildren()) do
					if v:IsA('Part') then
						if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 13.8 then
							fireclickdetector(v:FindFirstChild('ClickDetector'))
						end
					end
				end
			end)
		elseif not State then
			game:GetService('RunService'):UnbindFromRenderStep("Cash Aura")
		end
	end,
})


local Toggle = MainTab:CreateToggle({
	Name = "Anti-Stomp",
	CurrentValue = false,
	Flag = "AntiStomp",
	Callback = function(State)
		if State then
			game:GetService('RunService'):BindToRenderStep("Anti-Stomp", 0 , function()
				if game.Players.LocalPlayer.Character.BodyEffects['K.O'].Value == true then
					for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
						if v:IsA('MeshPart') or v:IsA('Part') then
							v:Destroy()
						end
					end
					for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
						if v:IsA('Accessory') then
							v.Handle:Destroy()
						end
					end
				end
			end)
		elseif State then
			game:GetService('RunService'):UnbindFromRenderStep("Anti-Stomp")
		end
	end,
})

local Toggle = MainTab:CreateToggle({
	Name = "Anti-Slow",
	CurrentValue = false,
	Flag = "AntiSlow",
	Callback = function(State)
		if State then
			game:GetService('RunService'):BindToRenderStep("Anti-Slow", 0 , function()
				if game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoWalkSpeed") then game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoWalkSpeed"):Destroy() end
				if game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("ReduceWalk") then game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("ReduceWalk"):Destroy() end
				if game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoJumping") then game.Players.LocalPlayer.Character.BodyEffects.Movement:FindFirstChild("NoJumping"):Destroy() end
				if game.Players.LocalPlayer.Character.BodyEffects.Reload.Value == true then game.Players.LocalPlayer.Character.BodyEffects.Reload.Value = false end
			end)
		elseif not State then
			game:GetService('RunService'):UnbindFromRenderStep("Anti-Slow")
		end
	end,
})

local Toggle8 = MainTab:CreateToggle({
	Name = "Advanced ESP",
	CurrentValue = false,
	Flag = "AdvancedESP",
	Callback = function(State)
		if State and ESPING == false then
			if AlreadyDestroying == false then
				ESPING = true
				MassCreate()
			end
		else
			ESPING = false
			if AlreadyDestroying == false then
				AlreadyDestroying = true
				repeat
					local Target_ = FindPlrWithESP()
					if Target_ ~= nil then
						if game.Players:FindFirstChild(Target_).Character.UpperTorso:FindFirstChild("ESP") then
							game.Players:FindFirstChild(Target_).Character.UpperTorso:FindFirstChild("ESP"):Destroy()
						end
					end
					wait(0.01)
				until FindPlrWithESP() == nil
				AlreadyDestroying = false
			end
		end
	end,
})

local Label = MainTab:CreateLabel("		  																																																																																										Target")

local Input = MainTab:CreateInput({
	Name = "Teleport to",
	PlaceholderText = "Username",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		local Data = CheckPlr2(Text)
			if Data then
				game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players")[Data].Character.HumanoidRootPart.CFrame
			end
	end,
})

local Input = MainTab:CreateInput({
	Name = "View",
	PlaceholderText = "Username",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		local Data = CheckPlr2(Text)
			if Data then
				game:GetService("Workspace").CurrentCamera.CameraSubject = game:GetService("Players")[Data].Character 
			else
				game:GetService("Workspace").CurrentCamera.CameraSubject = game:GetService("Players").LocalPlayer.Character.Humanoid
			end
	end,
})


local Input = MainTab:CreateInput({
	Name = "Bring",
	PlaceholderText = "Username",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		local Data = CheckPlr2(Text)
		local LS = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame
		KnockPlr(Text)
		repeat
			if not game:GetService("Players")[Data].Character:FindFirstChild("GRABBING_CONSTRAINT") then
				game:GetService("ReplicatedStorage").MainEvent:FireServer("Grabbing", false)  
			end
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Players")[Data].Character.UpperTorso.Position + Vector3.new(0, 3, 0))
			wait(.5)
		until game:GetService("Players")[Data].Character:FindFirstChild("GRABBING_CONSTRAINT") or game:GetService("Players")[Data].Character:FindFirstChild("BodyEffects"):FindFirstChild("K.O").Value == false
		wait(.5)
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = LS
		repeat
			wait(.5)
		until game:GetService("Players")[Data].Character.BodyEffects:FindFirstChild("K.O").Value == false and not game:GetService("Players")[Data].Character:FindFirstChild("GRABBING_CONSTRAINT") or game:GetService("Players")[Data].Character.Parent == nil

	end,
})

local Tab = Window:CreateTab("Alt Commands") -- Title, Image

local Section = Tab:CreateSection("Commands")

local Label = Tab:CreateLabel("																																																																																												Alt Commands")

local Toggle = Tab:CreateToggle({
	Name = "Drop",
	CurrentValue = false,
	Flag = "Drop",
	Callback = function(State)
		if State then
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."drop")
		else
			wait(2)
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."stop")
		end
	end,
})

local Toggle2 = Tab:CreateToggle({
	Name = "DelCash",
	CurrentValue = false,
	Flag = "DelCash",
	Callback = function(State)
		if State then
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."delcash on")
		else
			wait(2)
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."delcash off")
		end
	end,
})


local Toggle3 = Tab:CreateToggle({
	Name = "Wallet",
	CurrentValue = false,
	Flag = "Wallet",
	Callback = function(State)
		if State then
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."money show")
		else
			wait(2)
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."money hide")
		end
	end,
})

local Toggle4 = Tab:CreateToggle({
	Name = "Airlock",
	CurrentValue = false,
	Flag = "Airlock",
	Callback = function(State)
		if State then
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."airlock")
		else
			wait(2)
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."unlock")
		end
	end,
})

local Toggle5 = Tab:CreateToggle({
	Name = "Ground",
	CurrentValue = false,
	Flag = "Ground",
	Callback = function(State)
		if State then
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."ground")
		else
			wait(2)
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."unlock")
		end
	end,
})

local Toggle6 = Tab:CreateToggle({
	Name = "Hide",
	CurrentValue = false,
	Flag = "Hide",
	Callback = function(State)
		if State then
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."hide")
		else
			wait(2)
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."unhide")
		end
	end,
})

local Toggle7 = Tab:CreateToggle({
	Name = "Dance",
	CurrentValue = false,
	Flag = "Dance",
	Callback = function(State)
		if State then
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."vibe")
		else
			wait(2)
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."unvibe")
		end
	end,
})

local Button1 = Tab:CreateButton({
	Name = "Stop",
	Callback = function()
		local Prefix = getgenv().Settings.Prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(Prefix.."stop")
	end,
})

local Button = Tab:CreateButton({
	Name = "Reset",
	Callback = function()
		local Prefix = getgenv().Settings.Prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(Prefix.."reset")
	end,
})

local Label = Tab:CreateLabel("																																																																																																				Setup")

local Dropdown = Tab:CreateDropdown({
	Name = "Setup",
	Options = {"Admin", "Bank", "Club", "Basketball", "Train", "School", "Jail"},
	CurrentOption = "Admin",
	Flag = "Setup",
	Callback = function(Option)
		if Option == "Admin" then
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."setup admin")
		elseif Option == "Bank" then
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."setup bank")
		elseif Option == "Club" then
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."setup club")
		elseif Option == "Basketball" then 
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."setup basketball")
		elseif Option == "Train" then
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."setup train")
		elseif Option == "School" then
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."setup school")
		elseif Option == "Jail" then
			local Prefix = getgenv().Settings.Prefix
			game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
			local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
			x.MessagePosted:fire(Prefix.."setup jail")
		end
	end,
})

local Label = Tab:CreateLabel("																																																																																							Input Commands")

local Input = Tab:CreateInput({
	Name = "Bring",
	PlaceholderText = "Username",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		local Prefix = getgenv().Settings.Prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(Prefix.."bring "..Text)
	end,
})

local Input = Tab:CreateInput({
	Name = "Custom Drop",
	PlaceholderText = "Amount",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		local Prefix = getgenv().Settings.Prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(Prefix.."cdrop "..Text)
	end,
})

local Input = Tab:CreateInput({
	Name = "Surround",
	PlaceholderText = "Username",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		local Prefix = getgenv().Settings.Prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(Prefix.."to "..Text)
	end,
})

local Input = Tab:CreateInput({
	Name = "Dupe",
	PlaceholderText = "Username",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		local Prefix = getgenv().Settings.Prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(Prefix.."dupe "..Text)
	end,
})

local Input = Tab:CreateInput({
	Name = "Say",
	PlaceholderText = "Input",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		local Prefix = getgenv().Settings.Prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(Prefix.."say "..Text)
	end,
})

local Input = Tab:CreateInput({
	Name = "Set FPS",
	PlaceholderText = "Amount",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		local Prefix = getgenv().Settings.Prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(Prefix.."fps "..Text)
	end,
})


game.Players.PlayerAdded:Connect(function(plr)
	Rayfield:Notify({
		Title = "Player Joined",
		Content = "\nName: "..plr.Name,
		Duration = 9e9,
		Actions = {
			Ignore = {
				Name = "Okay",
				Callback = function()
					print("Joined: "..plr.Name)
				end
			},
		},
	})
end)

game.Players.PlayerRemoving:Connect(function(plr)
	Rayfield:Notify({
		Title = "Player Left",
		Content = "\nName: "..plr.Name,
		Duration = 9e9,
		Actions = {
			Ignore = {
				Name = "Okay",
				Callback = function()
					print("Left:"..plr.Name)
				end
			},
		},
	})
end)

game:service"RunService".Stepped:Connect(function()
    if ESPING == true then
        MassCreate()
    end
end)
