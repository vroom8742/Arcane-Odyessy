local player = game:GetService("Players").LocalPlayer
local character = player.character

local Rod
for i,v in pairs(character:GetChildren()) do
    if v:IsA("Tool") and string.match(v.Name, "Rod") then
        Rod = v
    end
end

local FishState = game:GetService("ReplicatedStorage").RS.Remotes.Misc.FishState
local ToolAction = game:GetService("ReplicatedStorage").RS.Remotes.Misc.ToolAction

_G.loop = true
pcall(function()
    while _G.loop do
        wait()
        if character:FindFirstChild("FishBiteGoal") ~= nil then
            FishState:FireServer("Reel")
            ToolAction:FireServer(Rod)
        elseif character:FindFirstChild("FishClock") == nil then
            ToolAction:FireServer(Rod)
            wait(5)
        end
    end
end)
