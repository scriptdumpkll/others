local a=game:GetService("ReplicatedStorage").MainEvent;local b={"CHECKER_1","TeleportDetect","OneMoreTime"}local c;c=hookmetamethod(game,"__namecall",function(...)local d={...}local self=d[1]local e=getnamecallmethod()local f=getcallingscript()if e=="FireServer"and self==a and table.find(b,d[2])then return end return c(...)end)

local CP = Instance.new("Part", workspace)
CP.Anchored = true 
CP.CanCollide = false 
CP.Position = Vector3.new(9e8, 9e5, 9e8)
CP.Size = Vector3.new(5, 5, 5)
CP.Transparency = 0.7
CP.Name = "CAM_PART"
workspace.Camera.CameraSubject = workspace.CAM_PART

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
local Event = game:GetService("ReplicatedStorage").MainEvent
local Player = Players.LocalPlayer
local Aura = false
local CurrAnim
local Owner = getgenv().Settings.host
local MainOwner = game.Players:GetPlayerByUserId(Settings['host'])

local Chat = function(Str)
	game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(tostring(Str), "All")
end

local CheckTable = function(Id)
    Found = false 
    for i,v in pairs(getgenv().Alts) do 
        if (v == Id) then 
           Found = true 
        end
    end
    
    return Found
end

local AltsInGame = function()
	local Am = 0
	for i,v in pairs(Players:GetChildren()) do 
		if (CheckTable(v.UserId) == true) then 
			Am += 1
		end
	end
	return Am
end

local GetAltNumber = function()
	local Number = nil
	for i,v in pairs((getgenv().Alts)) do 
		if (v == Player.UserId) then
			Number = i
		end
	end
	return tonumber(string.sub(Number, 4, string.len(Number)))
end

local LOCATIONS_CHACHE = {
    OLD_HIDESPOT = nil,
    SWARM_POS = nil,
    CRASH_POS = nil
}

local I = {
	duping = false,
	hostPlayer = nil,
	isGrabber = false,
	grabberPlayer = nil,
	cashAura = false,
}

local PresentSetups = {
    SurroundSetup = {"4.5,0,0","0,0,4.5","-4.5,0,0","0,0,-4.5","3,0,3","-3,0,3","-3,0,-3","3,0,-3","6.5,0,0","5,0,3","3.5,0,5","0,0,6.5","-5,0,3","-3.5,0,5","-6.5,0,0","-5,0,-3","-3.5,0,-5","0,0,-6.5","5,0,-3","3.5,0,-5","4.5,7,0","0,7,4.5","-4.5,7,0","0,7,-4.5","3,7,3","-3,7,3","-3,7,-3","3,7,-3","6.5,7,0","5,7,3","3.5,7,5","0,7,6.5","-5,7,3","-3.5,7,5","-6.5,7,0","-5,7,-3","-3.5,7,-5","0,7,-6.5","5,7,-3","3.5,7,-5"},
}

local TPAREAS = {
    Admin = "-870.7142944335938, -32.64921188354492, -654.3141479492188",
    Bank = "-375.7147216796875, 21.24999237060547, -364.8031311035156",
    Club = "-265.0559387207031, 0.02806040644645691, -429.0494384765625",
    Train = "608.0512084960938, 47.9999885559082, -104.57772064208984",
    Hidden = "-768.5383911132812, 44.35078811645508, -859.6719970703125",
    Void = "62.828392028808594, 22362.8828125, 7235.142578125"
}

function CheckPlayer(userid)
    for i,v in pairs(Players:GetChildren()) do
        if v.UserId == userid then
            return true
        end
    end
    return false
end

local function CheckPlr(userId)
    for i,v in pairs(game.Players:GetChildren()) do
        if v.UserId == tonumber(userId) then
            return true
        end
    end
    return false
end

local function FormatAlts()
    local new = {}
    for i,v in pairs(Alts) do
        if CheckPlr(v) == true then
            table.insert(new,tonumber(v))
        end
    end
    return new
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

local function Surronund(PLRNAME)
    local data = CheckPlr2(PLRNAME)
    if data then
        local newalts = FormatAlts()
        local index = 0
        local Target = game.Players[data]
        local player = game.Players.LocalPlayer
        for i,v in pairs(newalts) do
            if v == player.UserId then
                index = index + 1
                local cords = PresentSetups['SurroundSetup'][index]
                local x,y,z = string.split(cords,",")[1],string.split(cords,",")[2],string.split(cords,",")[3]
                player.Character.HumanoidRootPart.CFrame = CFrame.new(Target.Character.HumanoidRootPart.CFrame.X+tonumber(x),Target.Character.HumanoidRootPart.CFrame.Y+tonumber(y),Target.Character.HumanoidRootPart.CFrame.Z+tonumber(z))
            else
                index = index + 1
            end
        end
    else
        return false
    end
end

local function KnockPlr(plr_name)
    local data = CheckPlr2(plr_name)
    if data == nil then
        return false
    end
    local Target = game.Players[data]
    if Target.Character and Player.Character then
        local oldpos = Player.Character.HumanoidRootPart.CFrame
        repeat
            pcall(function()
                setfpscap(20)
                local combat = Player.Character:FindFirstChild("Combat") or Player.Backpack:FindFirstChild("Combat")
                if combat then
                    if KNOCKING == false then
                        Player.Character.HumanoidRootPart.CFrame = oldpos
                        return false
                    end
                    if Player.Backpack:FindFirstChild("Combat") then
                        Player.Backpack:FindFirstChild("Combat").Parent = Player.Character
                    end
                    Player.Character.HumanoidRootPart.Anchored = false
                    local random = (-2, 2)
                    Player.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame + Vector3.new(0, random, random)
                    if Target.Character.BodyEffects:FindFirstChild("Dead").Value == false and Target.Character.BodyEffects:FindFirstChild("K.O").Value == false then
                        Player.Character:FindFirstChild("Combat"):Activate()
                    end
                    task.wait()
                end
            end)
            task.wait()
        until Target.Character.BodyEffects:FindFirstChild("K.O").Value == true
        Player.Character.HumanoidRootPart.CFrame = oldpos
        setfpscap(Settings.fps)
        return Target.Name
    end
    return false
end

for d, e in pairs(game.Workspace:GetDescendants()) do
	if e:IsA("Seat") then
		e:Destroy()
	end
end

spawn(function()
    repeat task.wait(0.2) until Player.Character and Player.Character:FindFirstChildWhichIsA("Humanoid") and Player.Character:FindFirstChild("FULLY_LOADED_CHAR")
    task.wait(0.1)
    Chat("loaded")
    task.wait(0.5)
end)

function Commands(Str)
    local op = game.Players:GetPlayerByUserId(getgenv().Settings.host)
    local msg = (Str:lower():split(" "))
    local OLDMSG = msg
    if msg[1] == ((getgenv().Settings.prefix).."dupe") then 
        Aura = false
        if (I.duping == true) then 
            Chat("dupe already started")
            task.wait(0.1)
            Chat("chat "..(getgenv().Settings.prefix).."stopdupe to stop")
            return
        end
        
        for i,v in pairs(Players:GetChildren()) do 
            if (string.sub(string.lower(v.Name),1,string.len(msg[2]))) == string.lower(msg[2]) then
                I.grabberPlayer = v
            end
        end
        
        if (I.grabberPlayer == nil) then 
            Chat("player not found")
            return
        end
        
        
        if (Player.UserId == I.grabberPlayer.UserId) then 
            I.isGrabber = true
        end

        I.duping = true
        
        if (I.isGrabber == true) then
            task.spawn(function()
                Chat("starting collecting cash")
                I.cashAura = true 
                
                repeat 
                    Player.Character.HumanoidRootPart.Anchored = false
                    for i,v in pairs(workspace.Ignored.Drop:GetChildren()) do
                        if v:IsA("Part") and (v.Position-player.Character.HumanoidRootPart.Position).Magnitude <= 15 then
                            fireclickdetector(v:FindFirstChild("ClickDetector"))
                        end
                    end
                    task.wait(0.13)
                until (I.cashAura == false) or (I.isGrabber == false)
                
                Chat("stopped collecting cash")
            end)
        else 
            task.spawn(function()
                Chat("starting dropping cash")
            
                repeat 
                    local AltNr,AltsInGame = GetAltNumber(), AltsInGame()	

                    local Pos = (I.grabberPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(math.cos((AltNr * ((2*math.pi)/(AltsInGame-1)))) * 6.5, 0, math.sin((AltNr * ((2*math.pi)/(AltsInGame-1)))) * 6.5)).p

                    Player.Character.HumanoidRootPart.Anchored = false
                    Player.Character.HumanoidRootPart.CFrame = CFrame.new(Pos, I.grabberPlayer.Character.HumanoidRootPart.Position)
                    
                    Event:FireServer("DropMoney", "10000")
                    task.wait(0.5)
                until (I.duping == false)
                
                Chat("stopped dropping cash")
            end)	
        end   
    elseif msg[1] == ((getgenv().Settings.prefix).."stopdupe") then
        I.cashAura = false 
        I.isGrabber = false 
        I.duping = false
    elseif msg[1] == ((getgenv().Settings.prefix).."line") then
        Player.Character.HumanoidRootPart.Anchored = false
        Aura = false
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
        local BaseAnchor = Players:GetPlayerByUserId(Settings['host'])
        local Set = CreateSet()
        for i=1,40 do
            if Alts_[i] == player.UserId then
                player.Character.HumanoidRootPart.CFrame = BaseAnchor.Character.HumanoidRootPart.CFrame * CFrame.new(Set[i],0,0)
                break
            end
        end
        Player.Character.HumanoidRootPart.Anchored = true
    elseif msg[1] == ((getgenv().Settings.prefix).."swarm") then
	    Player.Character.HumanoidRootPart.Anchored = false
        Aura = true
        LOCATIONS_CHACHE['SWARM_POS'] = Player.Character.HumanoidRootPart.CFrame
        repeat task.wait()
            local RanX = math.random(-12,12)
            local RanZ = math.random(-12,12)
            local RanY = math.random(-5,5)
            Player.Character.HumanoidRootPart.CFrame = CFrame.new(MainOwner.Character.UpperTorso.Position.X + RanX, MainOwner.Character.UpperTorso.Position.Y + RanY + 10, MainOwner.Character.UpperTorso.Position.Z + RanZ)
        until Aura == false
    elseif msg[1] == ((getgenv().Settings.prefix).."noswarm") then
        Aura = false
        wait(0.5)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = LOCATIONS_CHACHE['SWARM_POS']
        wait(2)
        Player.Character.HumanoidRootPart.Anchored = true
    elseif msg[1] == ((getgenv().Settings.prefix).."dance") then
        if CurrAnim and CurrAnim.IsPlaying then
            CurrAnim:Stop()
        end
        local Anim = Instance.new("Animation")
        Anim.AnimationId = "http://www.roblox.com/asset/?id=15392759696"
        CurrAnim = Player.Character.Humanoid.Animator:LoadAnimation(Anim)
        CurrAnim:Play()
        CurrAnim:AdjustSpeed()
    elseif msg[1] == ((getgenv().Settings.prefix).."stopdance") then
        if CurrAnim and CurrAnim.IsPlaying then
            CurrAnim:Stop()
        end
    elseif msg[1] == ((getgenv().Settings.prefix).."who") then
        local plr = game:service"Players".LocalPlayer
        for _, v in pairs(getgenv().Alts) do
            if tonumber(v) == plr.UserId then
                Chat("[ "..tostring(_).." ] "..Player.Name)
            end
        end
    elseif msg[1] == ((getgenv().Settings.prefix).."hlock") then
        Player.Character.HumanoidRootPart.Anchored = false
        Player.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 300, 0)
        wait(0.25)
        Player.Character.HumanoidRootPart.Anchored = true
    elseif msg[1] == ((getgenv().Settings.prefix).."unhlock") then
        Player.Character.HumanoidRootPart.Anchored = false
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, -300, 0)
        wait(0.25)
        Player.Character.HumanoidRootPart.Anchored = true
    elseif msg[1] == ((getgenv().Settings.prefix).."say") then
        Chat(msg[2])
    elseif msg[1] == ((getgenv().Settings.prefix).."to") then
        Player.Character.HumanoidRootPart.Anchored = false
        Surround(msg[2])
        Chat("hi")
        wait(2)
        Player.Character.HumanoidRootPart.Anchored = true
    elseif msg[1] == ((getgenv().Settings.prefix).."hide") then
        Player.Character.HumanoidRootPart.Anchored = true
        Player.Character.HumanoidRootPart.Anchored = false
        LOCATIONS_CHACHE['OLD_HIDESPOT'] = Player.Character.HumanoidRootPart.CFrame
        Player.Character.HumanoidRootPart.CFrame = CFrame.new(-163,54,216)
        wait(2)
        Player.Character.HumanoidRootPart.Anchored = true
    elseif msg[1] == ((getgenv().Settings.prefix).."unhide") then
        Player.Character.HumanoidRootPart.Anchored = false
        Player.Character.HumanoidRootPart.CFrame = LOCATIONS_CHACHE['OLD_HIDESPOT']
        wait(2)
        Player.Character.HumanoidRootPart.Anchored = true
    elseif msg[1] == ((getgenv().Settings.prefix).."claim") then
        game:GetService("ReplicatedStorage").MainEvent:FireServer("EnterPromoCode",msg[2])
        
    elseif msg[1] == ((getgenv().Settings.prefix).."re") then
        Player.Character.HumanoidRootPart.Anchored = true
        LOCATIONS_CHACHE['OLD_HIDESPOT'] = Player.Character.HumanoidRootPart.CFrame
    	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-498,0)
    	repeat wait() until game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame == game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,-498,0)
    	for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
             if v:IsA("MeshPart") or v:IsA("BasePart") or v:IsA("Accessory") then
                  v:Destroy()
             end
    	end
        repeat wait() until Player.Character
        Player.Character.HumanoidRootPart.CFrame = LOCATIONS_CHACHE['OLD_HIDESPOT']
        wait(2)
        Player.Character.HumanoidRootPart.Anchored = true
    elseif msg[1] == ((getgenv().Settings.prefix).."tp") then
        if Player.UserId == getgenv().Alts.Alt1 then
            Player.Character.HumanoidRootPart.Anchored = false
            local theplace = ""
            if msg[3] == nil or string.lower(msg[3]) == "host" and not table.find(TPAREAS, Admin) and not table.find(TPAREAS, Hidden) and not table.find(TPAREAS, Bank) and not table.find(TPAREAS, Club) and not table.find(TPAREAS, Train) and not table.find(TPAREAS, Void) then
                theplace = "HOST"
            elseif string.lower(msg[3]) == "admin" then
                theplace = "Admin"
            elseif string.lower(msg[3]) == "train" then
                theplace = "Train"
            elseif string.lower(msg[3]) == "club" then
                theplace = "Club"
            elseif string.lower(msg[3]) == "bank" then
                theplace = "Bank"
	        elseif string.lower(msg[3]) == "hidden" then
		        theplace = "Hidden"
            elseif string.lower(msg[3]) == "void" then
                theplace = "Void"
            end
            if theplace then
                local ko_data = KnockPlr(msg[2])
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
                            wait(1)
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
                        elseif theplace == "Hidden" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(string.split(TPAREAS['Hidden'],",")[1],string.split(TPAREAS['Hidden'],",")[2],string.split(TPAREAS['Hidden'],",")[3])
			            elseif theplace == "HOST" then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = op.Character.HumanoidRootPart.CFrame+op.Character.HumanoidRootPart.CFrame.lookVector*3.5
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame*CFrame.Angles(0, math.rad(180), 0)
                        end
                        wait(1)
                        repeat
                            if not Target.Character:FindFirstChild("GRABBING_CONSTRAINT") then
                                wait(1)
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
                                return
                            end
                            pcall(function()
                                game.ReplicatedStorage.MainEvent:FireServer("Grabbing",false)
                            end)
                            wait(1) 
                        until not Target.Character:FindFirstChild("GRABBING_CONSTRAINT")
                        wait(1)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldpos
                        setfpscap(Settings['fps'])
                    end
                end
            end
        end
    end
end

game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Data) 
    if Players[Data.FromSpeaker].UserId == tonumber(getgenv().Settings.host) then
        Commands(Data.Message)
    end
end)
