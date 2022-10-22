settings().Physics.PhysicsEnvironmentalThrottle = 1
settings().Rendering.QualityLevel = 'Level01'
UserSettings():GetService("UserGameSettings").MasterVolume = 0
for i,v in pairs(game:GetDescendants()) do
    if v:IsA("Part") then
        v.Material = Enum.Material.Pavement
        v.Transparency = 1
    elseif v:IsA("Decal") then
        v:Destroy()
    elseif v:IsA("Texture") then
        v:Destroy()
    elseif v:IsA("MeshPart") then
        v.TextureID = 0
        v.Transparency = 1
    elseif v.Name == "Terrian" then
        v.WaterReflectace = 1
        v.WaterTransparency = 1
    elseif v:IsA("SpotLight") then
        v.Range = 0
        v.Enabled = false
    elseif v:IsA("WedgePart") then
        v.Transparency = 1
    elseif v:IsA("UnionOperation") then
        v.Transparency = 1
    end
end

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local CurrAnim

local S = {
    Found = false,
    Loaded = true,
    IsGrabber = false,
    Duping = false,
    Cashaura = false,
    Target = nil,
}

local TPAREAS = {
    Admin = "-870.7142944335938, -32.64921188354492, -654.3141479492188",
    Bank = "-375.7147216796875, 21.24999237060547, -364.8031311035156",
    Club = "-265.0559387207031, 0.02806040644645691, -429.0494384765625",
    Train = "608.0512084960938, 47.9999885559082, -104.57772064208984",
    Void = "62.828392028808594, 22362.8828125, 7235.142578125"
}

for i,v in pairs(getgenv().Alts) do 
    if v == Player.UserId then 
        S.Found = true
    end
end

if S.Found == false then 
    return
end

function saymsg(msg)
    game:service"ReplicatedStorage".DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, 'All')
end

function CheckPlayer(userid)
    for i,v in pairs(game:service"Players":GetChildren()) do
        if v.UserId == userid then
            return true
        end
    end
    return false
end

function ReSort(table_)
    local k = {}
    for i,v in pairs(table_) do
        if CheckPlayer(v) == true then
            table.insert(k,v)
        end
    end
    return k
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
local player = game.Players.LocalPlayer
coroutine.resume(coroutine.create(function()
    repeat wait() until workspace.Players:FindFirstChild(game.Players.LocalPlayer.Name)
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
                    v.Transparency = .99
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
                fps(20)
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
                    game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame + Vector3.new(0,7,0)
                    game.Players.LocalPlayer.Character:FindFirstChild("Combat"):Activate()
                    task.wait()
                end
            end)
            task.wait()
        until Target.Character.BodyEffects:FindFirstChild("K.O").Value == true
        reach(false)
        setfpscap(Settings['fps'])
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
        return Target.Name
    end
    return false
end

workspace.Gravity = 0

spawn(function()
    repeat task.wait(0.2) until Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid") and Player.Character:FindFirstChild("FULLY_LOADED_CHAR")
    task.wait(0.1)
    S.Loaded = true
    saymsg("loaded")
    task.wait(0.5)
    local a=game:GetService("ReplicatedStorage").MainEvent;local b={"CHECKER_1","TeleportDetect","OneMoreTime"}local c;c=hookmetamethod(game,"__namecall",function(...)local d={...}local self=d[1]local e=getnamecallmethod()local f=getcallingscript()if e=="FireServer"and self==a and table.find(b,d[2])then return end return c(...)end)
end)

function CMD(Str)
    if S.Loaded == false then 
        return
    end
    local Cmd = (Str:lower():split(" "))
    if Cmd[1] == ((getgenv().Settings.prefix).."dupe") then 
        for i,v in pairs(Players:GetChildren()) do
            if (string.sub(string.lower(v.Name),1,string.len(Cmd[2]))) == string.lower(Cmd[2]) then
                S.Target = v
            end
        end
        
        if S.Target.UserId == Player.UserId then 
            S.IsGrabber = true
        end
        
        Velocity(true)
        
        if S.IsGrabber == false then 
            task.wait(0.1)
            S.Duping = true
            saymsg("[dupe] started")
            spawn(function()
                repeat
                    game:GetService("ReplicatedStorage").MainEvent:FireServer("DropMoney", "10000")
                    game:GetService("ReplicatedStorage").MainEvent:FireServer("Block", true)
                    task.wait(2.5)
                until S.Duping == false
                game:GetService("ReplicatedStorage").MainEvent:FireServer("Block", false)
                saymsg("[dupe] stopped duping")
            end)
        end
        
        if S.IsGrabber == true then 
            Say("[dupe] picking up cash")
            game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
            S.Cashaura = true
            local players = game.Players
            local host = players:GetPlayerByUserId(Settings['host'])
            players.LocalPlayer.Backpack:FindFirstChild("Wallet").Parent = plr.Character
            spawn(function()
                repeat
                    players.LocalPlayer.Character.HumanoidRootPart.CFrame = host.Character.HumanoidRootPart.CFrame+Vector3.new(0,0,3)
                    for i,v in pairs(game:GetService('Workspace')['Ignored']['Drop']:GetChildren()) do
                        if v:IsA('Part') then
                            if (v.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 13 then
                                fireclickdetector(v:FindFirstChild('ClickDetector'))
                            end
                        end
                    end
                    task.wait(0.5)
                until S.Cashaura == false
                saymsg("[dupe] stopped picking up")
                players.LocalPlayer.Backpack:FindFirstChild("Wallet").Parent = plr.Backpack
            end)
        end
    elseif Cmd[1] == ((getgenv().Settings.prefix).."stopdupe") then
        S.Duping = false 
        S.IsGrabber = false
        S.Target = nil
        S.Cashaura = false
        Velocity(false)
    elseif Cmd[1] == ((getgenv().Settings.prefix).."line") then
        Freeze(true)
        local g = 4
        local function ReverseRotation(x)
            return x-(x*2)
        end
        local function CreateSet()
            local k = {}
            local g = 4
            for i=1,20 do
                local c = ReverseRotation(g)
                local f = ReverseRotation(c)
                g = g + 4
                table.insert(k,f)
                table.insert(k,c)
            end
            return k
        end
        local Alts_ = ReSort(Alts)
        local BaseAnchor = game:service"Players":GetPlayerByUserId(Settings['host'])
        local Set = CreateSet()
        for i=1,40 do
            if Alts_[i] == player.UserId then
                player.Character.HumanoidRootPart.CFrame = BaseAnchor.Character.HumanoidRootPart.CFrame * CFrame.new(Set[i],0,0)
                break
            end
        end
        Freeze(false)
        wait(0.5)
        Freeze(true)
    elseif Cmd[1] == ((getgenv().Settings.prefix).."dance") then
        if CurrAnim and CurrAnim.IsPlaying then
            CurrAnim:Stop()
        end
        local Anim = Instance.new("Animation")
        Anim.AnimationId = "http://www.roblox.com/asset/?id=7422527690"
        CurrAnim = game.Players.LocalPlayer.Character.Humanoid.Animator:LoadAnimation(Anim)
        CurrAnim:Play()
        CurrAnim:AdjustSpeed()
    elseif Cmd[1] == ((getgenv().Settings.prefix).."stopdance") then
        if CurrAnim and CurrAnim.IsPlaying then
            CurrAnim:Stop()
        end
    elseif Cmd[1] == ((getgenv().Settings.prefix).."who") then
        local plr = game:service"Players".LocalPlayer
        for _, v in pairs(getgenv().Alts) do
            if tonumber(v) == plr.UserId then
                saymsg("["..tostring(_).."] "..game.Players.LocalPlayer.Name)
            end
        end
    elseif Cmd[1] == ((getgenv().Settings.prefix).."hlock") then
        local plr = game:service"Players".LocalPlayer
        plr.Character.HumanoidRootPart.Anchored = false
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 300, 0)
        wait(0.25)
        plr.Character.HumanoidRootPart.Anchored = true
    elseif Cmd[1] == ((getgenv().Settings.prefix).."unhlock") then
        local plr = game:service"Players".LocalPlayer
        plr.Character.HumanoidRootPart.Anchored = false
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -300, 0)
        wait(0.25)
        plr.Character.HumanoidRootPart.Anchored = true
    elseif Cmd[1] == ((getgenv().Settings.prefix).."say") then
            saymsg("["..Cmd[2].."]")
    elseif Cmd[1] == ((getgenv().Settings.prefix).."hide") then
        local plr = game:service"Players".LocalPlayer
        local player = game:service"Players".LocalPlayer
        player.Character.HumanoidRootPart.Anchored = false
        local pos = CFrame.new(-163,54,216)
        player.Character.HumanoidRootPart.CFrame = pos
        wait(0.25)
        player.Character.HumanoidRootPart.Anchored = true
    elseif Cmd[1] == ((getgenv().Settings.prefix).."unhide") then
        local players = game:service"Players"
        local plr = players:GetPlayerByUserId(Settings['host'])
        players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
        wait(0.25)
        if plr then
            players.LocalPlayer.Character.HumanoidRootPart.CFrame=plr.Character.HumanoidRootPart.CFrame+Vector3.new(0,10,0)
        end
    elseif Cmd[1] == ((getgenv().Settings.prefix).."god") then
        local plr = game:service"Players".LocalPlayer
        if plr.Character:FindFirstChild("BodyEffects"):FindFirstChild("Attacking") then
            saymsg("[god]")
            plr.Character:FindFirstChild("BodyEffects"):FindFirstChild("Attacking"):Destroy()
        end
    elseif Cmd[1] == ((getgenv().Settings.prefix).."tp") then
        local player = game.Players.LocalPlayer
        if player.UserId == getgenv().Alts.Alt1 then
            player.Character.HumanoidRootPart.Anchored = false
            local theplace = ""
            if Cmd[3] == nil or string.lower(Cmd[3]) == "host" then
                theplace = "HOST"
            elseif string.lower(Cmd[3]) == "admin" then
                theplace = "Admin"
            elseif string.lower(Cmd[3]) == "train" then
                theplace = "Train"
            elseif string.lower(Cmd[3]) == "club" then
                theplace = "Club"
            elseif string.lower(Cmd[3]) == "bank" then
                theplace = "Bank"
            elseif string.lower(Cmd[3]) == "void" then
                theplace = "Void"
            end
            if theplace then
                local ko_data = KnockPlr(Cmd[2])
                if ko_data then
                    local Target = game.Players[ko_data]
                    local oldpos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                    if Target.Character and game.Players.LocalPlayer.Character then
                        repeat
                            pcall(function()
                                if not Target.Character:FindFirstChild("GRABBING_CONSTRAINT") then
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Target.Character.UpperTorso.Position.X,Target.Character.UpperTorso.Position.Y+1.3,Target.Character.UpperTorso.Position.Z)
                                    game.ReplicatedStorage.MainEvent:FireServer("Grabbing",false)
                                end
                            end)
                            wait(.5)
                        until Target.Character:FindFirstChild("GRABBING_CONSTRAINT")
                        if theplace == "Admin" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(string.split(TPAREAS['Admin'],",")[1],string.split(TPAREAS['Admin'],",")[2],string.split(TPAREAS['Admin'],",")[3])
                        elseif theplace == "Train" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(string.split(TPAREAS['Train'],",")[1],string.split(TPAREAS['Train'],",")[2],string.split(TPAREAS['Train'],",")[3])
                        elseif theplace == "Club" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(string.split(TPAREAS['Club'],",")[1],string.split(TPAREAS['Club'],",")[2],string.split(TPAREAS['Club'],",")[3])
                        elseif theplace == "Bank" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(string.split(TPAREAS['Bank'],",")[1],string.split(TPAREAS['Bank'],",")[2],string.split(TPAREAS['Bank'],",")[3])
                        elseif theplace == "Void" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(string.split(TPAREAS['Void'],",")[1],string.split(TPAREAS['Void'],",")[2],string.split(TPAREAS['Void'],",")[3])
                        elseif theplace == "HOST" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = op.Character.HumanoidRootPart.CFrame+op.Character.HumanoidRootPart.CFrame.lookVector*3.5
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.Angles(0, math.rad(180), 0)
                        end
                        wait(3)
                        repeat
                            if not Target.Character:FindFirstChild("GRABBING_CONSTRAINT") then
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
                                return
                            end
                            pcall(function()
                                game.ReplicatedStorage.MainEvent:FireServer("Grabbing",false)
                            end)
                            wait(0.01) 
                        until not Target.Character:FindFirstChild("GRABBING_CONSTRAINT")
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
                    end
                end
            end
        end
    end
end

game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Data) 
    if Players[Data.FromSpeaker].UserId == tonumber(getgenv().Settings.host) then
        CMD(Data.Message)
    end
end)
