if not game:IsLoaded() then
	game.Loaded:Wait()
end

if game:service"CoreGui":FindFirstChild("JMANbyJared") then
	game:service"CoreGui":FindFirstChild("JMANbyJared"):Destroy()
end

game.StarterGui:SetCore("SendNotification", {
	Title = "JMAN CRASHER";
	Text = "loading...";
	Icon = "http://www.roblox.com/asset/?id=11160325159";
	Duration = 3;
})

repeat wait(0.001) until workspace.Players:FindFirstChild(game:service"Players".LocalPlayer.Name)

local remotes = {
	"CHECKER_1",
	"CHECKER_2",
	"TeleportDetect",
	"OneMoreTime",
	"BreathingHAMON",
	"VirusCough",
}

local __namecall
__namecall = hookmetamethod(game, "__namecall", function(...)
	local args = {...}
	local method = getnamecallmethod()
	if (method == "FireServer" and args[1].Name == "MainEvent" and table.find(remotes, args[2])) then
		return
	end
	return __namecall(table.unpack(args))
end)

game.StarterGui:SetCore("SendNotification", {
	Title = "JMAN CRASHER";
	Text = "loaded";
	Icon = "http://www.roblox.com/asset/?id=11160325159";
	Duration = 3;
})

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Start = Instance.new("TextButton")
local Pause = Instance.new("TextButton")
local ForceCrash = Instance.new("TextButton")
local Status = Instance.new("TextLabel")

ScreenGui.Name = "JMANbyJared"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(144, 238, 144)
Frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.043636363, 0, 0.667286217, 0)
Frame.Size = UDim2.new(0, 100, 0, 132)

Start.Name = "Start"
Start.Parent = Frame
Start.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Start.BorderSizePixel = 0
Start.Position = UDim2.new(0.129999995, 0, 0.0938339531, 0)
Start.Size = UDim2.new(0, 74, 0, 20)
Start.Font = Enum.Font.SourceSans
Start.Text = "Start"
Start.TextColor3 = Color3.fromRGB(0, 0, 0)
Start.TextSize = 14.000

Pause.Name = "Pause"
Pause.Parent = Frame
Pause.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pause.BorderSizePixel = 0
Pause.Position = UDim2.new(0.129999995, 0, 0.305955112, 0)
Pause.Size = UDim2.new(0, 74, 0, 20)
Pause.Font = Enum.Font.SourceSans
Pause.Text = "Pause"
Pause.TextColor3 = Color3.fromRGB(0, 0, 0)
Pause.TextSize = 14.000

ForceCrash.Name = "ForceCrash"
ForceCrash.Parent = Frame
ForceCrash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ForceCrash.BorderSizePixel = 0
ForceCrash.Position = UDim2.new(0.129999995, 0, 0.51807636, 0)
ForceCrash.Size = UDim2.new(0, 74, 0, 20)
ForceCrash.Font = Enum.Font.SourceSans
ForceCrash.Text = "Force Crash"
ForceCrash.TextColor3 = Color3.fromRGB(0, 0, 0)
ForceCrash.TextSize = 14.000

local maxitems = 1400
Status.Name = "Status"
Status.Parent = Frame
Status.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Status.BackgroundTransparency = 1.000
Status.BorderSizePixel = 0
Status.Position = UDim2.new(0, 0, 0.734848499, 0)
Status.Size = UDim2.new(0, 100, 0, 28)
Status.Font = Enum.Font.SourceSans
Status.Text = "Status: 0 / "..tostring(maxitems).." \nPercent: 0%"
Status.TextColor3 = Color3.fromRGB(0, 0, 0)
Status.TextSize = 14.000

local av1 = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
	av1:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	av1:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

Frame.Active = true
Frame.Draggable = true

local player = game:service"Players".LocalPlayer
local ws = workspace
local shop = ws.Ignored:FindFirstChild("Shop")

player:GetMouse().KeyDown:Connect(function(key)
	if key:lower() == "v" then
		Frame.Visible = not Frame.Visible
	end
end)

local Paused, Stopped, Running = false, false, false

function notify(a,b,c)
	game:service"StarterGui":SetCore("SendNotification",{
		Title = a;
		Text = b;
		Icon = "http://www.roblox.com/asset/?id=11160325159";
		Duration = c;
	})
end

local function GatherItems()
	local plr = game:service"Players".LocalPlayer
	local cnt = 0
	for i,v in pairs(plr.Character:GetChildren()) do
		if v:IsA("Tool") then
			cnt = cnt + 1
			if v:FindFirstChild("Handle") then
				v:FindFirstChild("Handle").Transparency = 100
			end
		end
	end
	for i,v in pairs(plr.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			cnt = cnt + 1
			if v:FindFirstChild("Handle") then
				v:FindFirstChild("Handle").Transparency = 100
			end
		end
	end
	return cnt
end

local ItemCnt = GatherItems()
local old = 0
coroutine.resume(coroutine.create(function()
	while wait(1) do
		if Running == true then
			ItemCnt = GatherItems()
			local tot = ItemCnt/maxitems*100
			tot = tonumber(string.format("%.2f",tot))
			Status.Text = "Progess: "..tostring(ItemCnt).."/"..tostring(maxitems).." \nPercent: "..tostring(tot).."%"
		end
	end
end))

local function equipall()
	for i,v in pairs(player.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			v.Parent = player.Character
		end
	end
end

local function uneqipall()
	for i,v in pairs(player.Character:GetChildren()) do
		if v:IsA("Tool") then
			v.Parent = player.Backpack
		end
	end
end

local function check_grenade()
	local cnt = 0
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v.Name == '[Grenade]' then
			cnt = cnt + 1
		end
	end
	for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v.Name == '[Grenade]' then
			cnt = cnt + 1
		end
	end
	return cnt
end

local function check_lockpicks()
	local cnt = 0
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v.Name == '[LockPicker]' then
			cnt = cnt + 1
		end
	end
	for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v.Name == '[LockPicker]' then
			cnt = cnt + 1
		end
	end
	return cnt
end

local function DeleteChar()
	for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA('MeshPart') or v:IsA('Part') or v:IsA('Accessory') then
			v:Destroy()
		end
	end
	game.Players.LocalPlayer.Character.Name = 'Deleted'
end

local GoodOverride = false
local oldcash = player.DataFolder.Currency.Value
player.DataFolder.Currency.Changed:Connect(function()
	if tonumber(player.DataFolder.Currency.Value) ~= tonumber(oldcash) then
		oldcash = player.DataFolder.Currency.Value
		GoodOverride = true
	end
end)

Start.MouseButton1Down:Connect(function()
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

	game.StarterGui:SetCore("SendNotification", {
		Title = "JMAN CRASHER";
		Text = "Made By jaredd#0995";
		Icon = "http://www.roblox.com/asset/?id=11160325159";
		Duration = 9e9;
	})

	if game.Players.LocalPlayer.Character:FindFirstChild("BodyEffects"):FindFirstChild('Attacking') then
		game.Players.LocalPlayer.Character:FindFirstChild("BodyEffects"):FindFirstChild('Attacking'):Destroy()
	end

	Animate = game.Players.LocalPlayer.Character.Animate
	Animate.idle.Animation1.AnimationId = "http://www.roblox.com/asset/?id=10921301576"
	Animate.idle.Animation2.AnimationId = "http://www.roblox.com/asset/?id=10921301576"
	Animate.fall.FallAnim.AnimationId = "http://www.roblox.com/asset/?id=10921301576"
		
	if Running == false then
		notify("JMAN CRASHER","started",5)
		notify("JMAN CRASHER","this will take awhile..",10)

		Running = true

		local Items = {
			"[Flowers] - $5", "[Glock] - $515", "[Cranberry] - $3", "[TacticalShotgun] - $1803", 
			"[P90] - $1030", "[AUG] - $2009", "[PepperSpray] - $77", "[Silencer] - $567", "[Donut] - $5", 
			"[SMG] - $773", "[AR] - $1030", "[Shotgun] - $1288", "[Taser] - $1030", "[Weights] - $124", 
			"[HeavyWeights] - $258", "[Popcorn] - $7", "[Camera] - $103", "[Chicken] - $7", "[Pizza] - $5", 
			"[Flashlight] - $10", "[Bat] - $283", "[Lettuce] - $5", "[Pitchfork] - $330", "[Taco] - $2", 
			"[Hamburger] - $5", "[Lemonade] - $3", "[SledgeHammer] - $361", "[LMG] - $3863", 
			"[Starblox Latte] - $5", "[StopSign] - $309", "[SilencerAR] - $1288", "[AK47] - $2318", 
			"[DrumGun] - $3090", "[Money Gun] - $800", "[Shovel] - $330", "[BrownBag] - $26", "[Shotgun] - $1288", 
			"[Flashbang] - $567", "[Double-Barrel SG] - $1442", "[Revolver] - $1339", "[Donut] - $10", "[Pencil] - $180", 
			"[Popcorn] - $14", "[Nunchucks] - $464", "[HotDog] - $8", "[Taser] - $1288", "[Key] - $129", 
			"[Meat] - $12", "[Da Milk] - $7", "[Rifle] - $1597", 
		}

		uneqipall()

		repeat
			if Paused == true then
				repeat wait(0.001) until Paused == false
			end
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").Ignored.Shop["[Grenade] - $721"].Head.Position.X, game:GetService("Workspace").Ignored.Shop["[Grenade] - $721"].Head.Position.Y - 7, game:GetService("Workspace").Ignored.Shop["[Grenade] - $721"].Head.Position.Z)
			fireclickdetector(game.Workspace.Ignored.Shop["[Grenade] - $721"].ClickDetector)
			task.wait()
		until check_grenade() >= 11

		repeat
			if Paused == true then
				repeat wait(0.001) until Paused == false
			end
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").Ignored.Shop["[LockPicker] - $129"].Head.Position.X, game:GetService("Workspace").Ignored.Shop["[LockPicker] - $129"].Head.Position.Y - 7, game:GetService("Workspace").Ignored.Shop["[LockPicker] - $129"].Head.Position.Z)
			fireclickdetector(game.Workspace.Ignored.Shop["[LockPicker] - $129"].ClickDetector)
			task.wait()
		until check_lockpicks() >= 11

		local function equipallcans()
			for i,v in pairs(player.Backpack:GetChildren()) do
				if v:IsA("Tool") and v.Name == "[SprayCan]" then
					v.Parent = player.Character
				end
			end
		end

		game:service"RunService":BindToRenderStep("RUNNNER_1",1,function()
			pcall(function()
				game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.Crew.CrewFrame.Visible = false
			end)
			pcall(function()
				game:GetService("Players").LocalPlayer.PlayerGui.GoThruGui.RecordingFrame.Visible = false
			end)
			pcall(function()
				game:GetService("Players").LocalPlayer.PlayerGui.MainScreenGui.PhoneCalls.Visible = false
			end)

			game:service"ReplicatedStorage".MainEvent:FireServer("JoinCrew", 13388079)
		end)

		for i,v in pairs(Items) do
			equipall()
			local place = shop:FindFirstChild(v)
			GoodOverride = false
			if Paused == true then
				repeat wait(0.001) until Paused == false
			end
			repeat
				player.Character.HumanoidRootPart.CFrame = CFrame.new(place.Head.Position.X, place.Head.Position.Y - 6, place.Head.Position.Z)
				fireclickdetector(place.ClickDetector)
				task.wait()
			until GoodOverride == true
		end

		for i,v in pairs(Items) do
			equipall()
			local place = shop:FindFirstChild(v)
			GoodOverride = false
			if Paused == true then
				repeat wait(0.001) until Paused == false
			end
			repeat
				player.Character.HumanoidRootPart.CFrame = CFrame.new(place.Head.Position.X, place.Head.Position.Y - 6, place.Head.Position.Z)
				fireclickdetector(place.ClickDetector)
				task.wait()
			until GoodOverride == true
		end
		uneqipall()
		game:service"RunService":BindToRenderStep("CANNER",1,function()
			equipallcans()
		end)

		repeat
			if Paused == true then
				repeat wait(0.001) until Paused == false
			end
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").Ignored.Shop["[Flowers] - $5"].Head.Position.X, game:GetService("Workspace").Ignored.Shop["[Flowers] - $5"].Head.Position.Y - 5, game:GetService("Workspace").Ignored.Shop["[Flowers] - $5"].Head.Position.Z)
			fireclickdetector(game:GetService("Workspace").Ignored.Shop["[Flowers] - $5"].ClickDetector)
			Count = 0 
			for i,v in pairs(game:GetService("Workspace").Ignored.ItemsDrop:GetDescendants()) do
				local s,e = pcall(function()
					if v:IsA('Tool') then
						repeat 
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Parent.Position) * CFrame.new(0, 2, 0) 
							task.wait()
						until not v
					end
				end)
			end

			for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
				if v:IsA('Tool') then
					Count = Count + 1
				end
			end

			for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
				if v:IsA('Tool') then
					Count = Count + 1
				end   
			end
			task.wait()
		until ItemCnt >= maxitems

		pcall(function() game:service"RunService":UnBindToRenderStep("CANNER") end)

		equipall()

		if ItemCnt >= maxitems then
			equipall()
			local Player = game.Players.LocalPlayer
			local Lit = false
			
			coroutine.resume(coroutine.create(function()
				while not Lit do 
					game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
					task.wait()
				end
			end))

			for i,v in pairs(Player.Backpack:GetChildren()) do
				if v:IsA('Tool') then
					v.Parent = Player.Character
				end
			end

			local T = 0
			repeat
				for i,v in pairs(Player.Backpack:GetChildren()) do
					if v:IsA('Tool') then
						v.Parent = Player.Character
					end
				end
				T = T + 1
			until T >= 35
			wait(3)
			Lit = true
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-305.804443, 21.2549915, -420.076233, -0.00985035207, -9.21506214e-08, -0.999951482, -5.95487482e-09, 1, -9.20964354e-08, 0.999951482, 5.04740338e-09, -0.00985035207) * CFrame.new(0, 1000, 0)
			wait(.5)
			DeleteChar()
		end
	else
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		notify("JMAN CRASHER", "already started",5)
	end
end)

Pause.MouseButton1Click:Connect(function()
	if not Running then return end
	Paused = not Paused
	if Paused then
		Pause.Text = "Paused"
		uneqipall()
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0)
		Load:Stop()
		notify("JMAN CRASHER","paused",3)
	else
		Pause.Text = "Pause"
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		Load:Play()
		notify("JMAN CRASHER", "resumed",3)
	end
end)

ForceCrash.MouseButton1Down:Connect(function()
	local Player = game.Players.LocalPlayer

	local Lit = false
	coroutine.resume(coroutine.create(function()
		while not Lit do 
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
			task.wait()
		end
	end))

	for i,v in pairs(Player.Backpack:GetChildren()) do
		if v:IsA('Tool') then
			v.Parent = Player.Character
		end
	end
	local T = 0
	repeat
		for i,v in pairs(Player.Backpack:GetChildren()) do
			if v:IsA('Tool') then
				v.Parent = Player.Character
			end
		end
		T = T + 1
	until T >= 35
	wait(3)
	Lit = true
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-305.804443, 21.2549915, -420.076233, -0.00985035207, -9.21506214e-08, -0.999951482, -5.95487482e-09, 1, -9.20964354e-08, 0.999951482, 5.04740338e-09, -0.00985035207) * CFrame.new(0, 1000, 0)
	wait(.5)
	DeleteChar()
end)
