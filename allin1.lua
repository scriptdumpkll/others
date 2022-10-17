settings().Physics.PhysicsEnvironmentalThrottle = 1
settings().Rendering.QualityLevel = 'Level01'
for i,v in pairs(game:GetDescendants()) do
     if v:IsA("Part") then
          v.Material = Enum.Material.Plastic
     elseif v:IsA("Decal") then
          v:Destroy()
     elseif v:IsA("Texture") then
          v:Destroy()
     end
end

hookfunction(game.Players.LocalPlayer.IsInGroup, function() return true end)
hookfunction(game.Players.LocalPlayer.GetRankInGroup, function() return true end)
loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptdumpkll/others/main/crasher.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptdumpkll/others/main/hidecash.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptdumpkll/others/main/chatspy.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Crostide/cdhc/main/gui"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Crostide/Counter/main/Cash"))()

local plr = game.Players.LocalPlayer
local Mouse = plr:GetMouse()
        
Mouse.KeyDown:Connect(function(a)
    if a == "l" then
        if game.CoreGui:FindFirstChild("Redware") then
            game.CoreGui.Redware:Destroy()
        end
        Holder = Instance.new("ScreenGui")
        Frame = Instance.new("Frame")

        Holder.Name = "Redware"
        Holder.Parent = game.CoreGui
        Holder.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        Holder.IgnoreGuiInset = true
        
        Frame.Parent = Holder
        Frame.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame.BackgroundColor3 = Color3.fromRGB(27, 42, 53)
        Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
        Frame.Size = UDim2.new(1, 0, 1, 0)
        setfpscap(3)
    elseif a == "k" then
        setfpscap(60)
        if game.CoreGui:FindFirstChild("Redware") then
            game.CoreGui.Redware:Destroy()
        end
    end
end)

function saymsg(msg)
    game:service"ReplicatedStorage".DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, 'All')
end

local Players = game:GetService("Players")

function CMD(Str)
    local Cmd = (Str:lower():split(" "))
    if Cmd[1] == ((getgenv().Settings.prefix).."start") then
        saymsg((getgenv().Settings.prefix).."delcash on")
        if Cmd[2] == nil then
            wait(2)
            saymsg((getgenv().Settings.prefix).."setup admin")
            wait(2)
            saymsg((getgenv().Settings.prefix).."ground")
            wait(2)
            saymsg((getgenv().Settings.prefix).."god")
            wait(2)
            saymsg((getgenv().Settings.prefix).."drop")
        elseif Cmd[2] and not Cmd[3] then
            wait(2)
            saymsg((getgenv().Settings.prefix).."setup admin")
            wait(2)
            saymsg((getgenv().Settings.prefix).."ground")
            wait(2)
            saymsg((getgenv().Settings.prefix).."god")
            wait(2)
            saymsg((getgenv().Settings.prefix).."cdrop "..Cmd[2])
        elseif Cmd[3] and not Cmd[4] then
            wait(2)
            saymsg((getgenv().Settings.prefix).."setup "..Cmd[3])
            wait(2)
            saymsg((getgenv().Settings.prefix).."ground")
            wait(2)
            saymsg((getgenv().Settings.prefix).."god")
            wait(2)
            saymsg((getgenv().Settings.prefix).."cdrop "..Cmd[2])
        end
    elseif Cmd[1] == ((getgenv().Settings.prefix).."stop") then
        wait(2)
        saymsg("/unlock")
    end
end

game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Data) 
    if Players[Data.FromSpeaker].UserId == tonumber(getgenv().Settings.host) then
        CMD(Data.Message)
    end
end)
