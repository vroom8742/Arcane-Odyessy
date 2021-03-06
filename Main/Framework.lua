local Module = {}


--// Gets LocalPlayer's Character
function Module:GetLPCharacter()
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    return Character
end


--// Gets Remotes in RS
function Module:GetRemote(name)
    local Remotes = game:GetService("ReplicatedStorage").RS.Remotes

    for i,v in pairs(Remotes:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            if string.match(v.Name, tostring(name)) then
                return v
            end
        end
    end
end


--// Gets Modules in RS
function Module:GetModule(name)
    local Modules = game:GetService("ReplicatedStorage").RS.Modules

    for i,v in pairs(Modules:GetDescendants()) do
        if v:IsA("ModuleScript") then
            if string.match(v.Name, tostring(name)) then
                return require(v)
            end
        end
    end
end


--// Gets NPCs in workspace
function Module:GetNPC(name)
    for i,v in pairs(workspace.NPCs:GetChildren()) do
        if string.match(v.Name, tostring(name)) then
            return v
        end
    end
end


--// Gets Closest NPC near you
function Module:GetClosestNPC(range)
    for i,v in pairs(workspace.NPCs:GetChildren()) do 
        if v:FindFirstChild("HumanoidRootPart") then
            if (Module:GetLPCharacter():FindFirstChild('HumanoidRootPart').Position - v:FindFirstChild('HumanoidRootPart').Position).magnitude <= tonumber(range) then
                return v
            end
        end
    end
end


--// Bind/Unbind functions to/from RenderStep
function Module:BindLoop(name, func, boolean)
    local RunService = game:GetService("RunService")

    if boolean then
        RunService:BindToRenderStep(tostring(name), 100, func)
    else
        RunService:UnbindFromRenderStep(tostring(name))
    end
end


return Module
