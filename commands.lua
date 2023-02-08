local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/eyedr3ss/storage/main/libraries/cattoware"))()
Library.theme.topheight = 50
Library.theme.accentcolor = Color3.fromRGB(173, 223, 173)
Library.theme.accentcolor2 = Color3.fromRGB(144, 238, 144)
Library.theme.fontsize = 15
Library.theme.titlesize = 17

local Window = Library:CreateWindow("eyedress", Vector2.new(400, 300), Enum.KeyCode.RightControl)

local AimingTab = Window:CreateTab("Commands")

local SilentAimSection = AimingTab:CreateSector("Main Commands", "left")

SilentAimSection:AddToggle('Drop', false, function(State)
    if State then
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."drop")
	else
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."stop")
	end
end)

SilentAimSection:AddToggle('Delcash', false, function(State)
    if State then
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."delcash on")
	else
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."delcash off")
	end
end)

SilentAimSection:AddToggle('Wallet', false, function(State)
    if State then
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."money show")
	else
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."money hide")
	end
end)


SilentAimSection:AddToggle('Airlock', false, function(State)
    if State then
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."airlock")
	else
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."unlock")
	end
end)

SilentAimSection:AddToggle('Ground', false, function(State)
    if State then
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."ground")
	else
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."unground")
	end
end)

SilentAimSection:AddToggle('Hide', false, function(State)
    if State then
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."hide")
	else
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."unhide")
	end
end)

SilentAimSection:AddToggle('Dance', false, function(State)
    if State then
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."vibe")
	else
		local prefix = getgenv().Settings.prefix
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
		local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
		x.MessagePosted:fire(prefix.."unvibe")
	end
end)

local CameraLockSection = AimingTab:CreateSector("Setup", "right")

CameraLockSection:AddButton('Admin', function(State)
	local prefix = getgenv().Settings.prefix
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
	local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
	x.MessagePosted:fire(prefix.."setup admin")
end)

CameraLockSection:AddButton('Bank', function(State)
	local prefix = getgenv().Settings.prefix
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
	local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
	x.MessagePosted:fire(prefix.."setup bank")
end)

CameraLockSection:AddButton('Club', function(State)
	local prefix = getgenv().Settings.prefix
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
	local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
	x.MessagePosted:fire(prefix.."setup club")
end)

CameraLockSection:AddButton('Train', function(State)
	local prefix = getgenv().Settings.prefix
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
	local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
	x.MessagePosted:fire(prefix.."setup train")
end)

CameraLockSection:AddButton('School', function(State)
	local prefix = getgenv().Settings.prefix
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
	local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
	x.MessagePosted:fire(prefix.."setup school")
end)

CameraLockSection:AddButton('Basketball', function(State)
	local prefix = getgenv().Settings.prefix
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
	local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
	x.MessagePosted:fire(prefix.."setup basketball")
end)

CameraLockSection:AddButton('Jail', function(State)
	local prefix = getgenv().Settings.prefix
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
	local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
	x.MessagePosted:fire(prefix.."setup jail")
end)

local TargetAimSection = AimingTab:CreateSector("Target Commands", "left")

TargetAimSection:AddTextbox('Bring',  nil, function(Text)
	local prefix = getgenv().Settings.prefix
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
	local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
	x.MessagePosted:fire(prefix.."bring "..Text)
end)

TargetAimSection:AddTextbox('Custom Drop', nil, function(Text)
	local prefix = getgenv().Settings.prefix
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
	local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
	x.MessagePosted:fire(prefix.."cdrop "..Text)
end)

TargetAimSection:AddTextbox('Surround', nil, function(Text)
	local prefix = getgenv().Settings.prefix
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
	local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
	x.MessagePosted:fire(prefix.."to "..Text)
end)

TargetAimSection:AddTextbox('Dupe', nil, function(Text)
	local prefix = getgenv().Settings.prefix
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
	local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
	x.MessagePosted:fire(prefix.."dupe "..Text)
end)

TargetAimSection:AddTextbox('Say', nil, function(Text)
	local prefix = getgenv().Settings.prefix
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
	local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
	x.MessagePosted:fire(prefix.."say "..Text)
end)

TargetAimSection:AddTextbox('Fps', nil, function(Text)
	local prefix = getgenv().Settings.prefix
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("", "System")
	local x = require(game.Players.LocalPlayer.PlayerScripts.ChatScript.ChatMain)
	x.MessagePosted:fire(prefix.."fps "..Text)
end)
