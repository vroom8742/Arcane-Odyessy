local Arcane = {}

--// Gets Remotes in RS
function Arcane:GetRemote(Name)
    local Remotes = game:GetService("ReplicatedStorage").RS.Remotes

    for i,v in pairs(Remotes:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            if string.match(v.Name, tostring(Name)) then
                return v
            end
        end
    end
end


--// Gets Modules in RS
function Arcane:GetModule(Name)
    local Modules = game:GetService("ReplicatedStorage").RS.Modules

    for i,v in pairs(Modules:GetDescendants()) do
        if v:IsA("ModuleScript") then
            if string.match(v.Name, tostring(Name)) then
                return require(v)
            end
        end
    end
end


--// Gets NPCs in workspace
function Arcane:GetNPC(Name)
    for i,v in pairs(workspace.NPCs:GetChildren()) do
        if string.match(v.Name, tostring(Name)) then
            return v
        end
    end
end


--// Bind/Unbind functions to/from RenderStep
function Arcane:BindLoop(name, func, boolean)
    local RunService = game:GetService("RunService")

    if boolean then
        RunService:BindToRenderStep(tostring(name), 100, func)
    else
        RunService:UnbindFromRenderStep(tostring(name))
    end
end


return Arcane
