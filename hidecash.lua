repeat task.wait() until game:IsLoaded() and game:GetService("Players").LocalPlayer 
task.wait(1)

local plr = game:GetService("Players").LocalPlayer
local drops = workspace.Ignored.Drop
local hidden = false

function hide(part)
    part.Transparency = 1
    part:FindFirstChildWhichIsA("BillboardGui").Enabled = false
    for i,v in pairs(part:GetChildren()) do 
        if v:IsA("Decal") then 
            v.Transparency = 1
        end
    end
end

game:GetService("Players").LocalPlayer.Chatted:Connect(function(str)
    if str == "/e hide" then 
        if hidden == false then 
            for i,v in next, drops:GetChildren() do 
                if v:IsA("Part") and v.Name == "MoneyDrop" then    
                    hide(v)
                end
                task.wait(.02)
            end
            hidden = true
            game.StarterGui:SetCore("SendNotification",{Title ="Hide Cash",Text ="Enabled",Duration =3}) 
        else 
            for i,v in next, drops:GetChildren() do 
                if v:IsA("Part") and v.Name == "MoneyDrop" then    
                    v.Transparency = 0
                    v:FindFirstChildWhichIsA("BillboardGui").Enabled = true
                    for i,v in pairs(v:GetChildren()) do 
                        if v:IsA("Decal") then 
                            v.Transparency = 0
                        end
                    end
                end
                task.wait(.02)
            end
            hidden = false
            game.StarterGui:SetCore("SendNotification",{Title ="Hide Cash",Text ="Disabled",Duration =3}) 
        end
    end
end)

drops.ChildAdded:Connect(function(n)
    if hidden == true then 
        task.wait(.5)
        if n:IsA("Part") and n.Name == "MoneyDrop" then 
            hide(n)
        end
    end
end)
