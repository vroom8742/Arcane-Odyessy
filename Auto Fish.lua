-- to do checks for bait then autobuy bait 

local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character

local Rod
for i,v in pairs(Character:GetChildren()) do
    if v:IsA("Tool") and string.match(v.Name, "Rod") then
        Rod = v
    end
end

local FishState = game:GetService("ReplicatedStorage").RS.Remotes.Misc.FishState
local ToolAction = game:GetService("ReplicatedStorage").RS.Remotes.Misc.ToolAction

getgenv().AUTOFISH = true

pcall(function()
    while getgenv().AUTOFISH do wait()
        if Character:FindFirstChild("FishBiteGoal") ~= nil then
            FishState:FireServer("Reel")
            ToolAction:FireServer(Rod)
        elseif Character:FindFirstChild("FishClock") == nil then
            ToolAction:FireServer(Rod)
            wait(5)
        end
    end
end)
