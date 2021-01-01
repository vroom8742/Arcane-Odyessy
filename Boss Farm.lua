-- WARNING! USE THIS ONLY ON A ALT! --

-- Variables --
local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character

local RunService = game:GetService("RunService")

local Remotes = game:GetService("ReplicatedStorage").RS.Remotes
local DealWeaponDamage = Remotes.Combat.DealWeaponDamage;

getgenv().afkcount = 0
local SAFEPOSITION = CFrame.new(-20288, 250, -6731)

-- Tables --
local Enable = {}
local Exclusions = {TheExiled = false, Minotaur = false}

-- Functions --
local function ANTIAFK()
    if getgenv().afkcount == 0 then
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
           vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
           wait(1)
           vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
        getgenv().afkcount = getgenv().afkcount + 1
    end
end

local function HideIdentity()
    pcall(function() 
        for i,v in pairs(Character.Head.Overhead:GetChildren()) do 
            v:Destroy() 
            Character.Data.FullName:Destroy() 
        end 
    end)

    Character.HumanoidRootPart.CFrame = CFrame.new(-20288, 250, -6731)

    wait(3)
    local Mouse    = LocalPlayer:GetMouse()
                
    local AutoRun  = false
    local AirTP    = false
    
    local function CheckRig()
        if LocalPlayer.Character then
            local Humanoid = LocalPlayer.Character:WaitForChild('Humanoid')
            if Humanoid.RigType == Enum.HumanoidRigType.R15 then
                return 'R15'
            else
                return 'R6'
            end
        end
    end


    local StoredCF = Character.PrimaryPart.CFrame
    if AirTP then
        local Part = Instance.new('Part',workspace)
        Part.Size = Vector3.new(5,0,5)
        Part.Anchored = true
        Part.CFrame = CFrame.new(Vector3.new(9999,9999,9999))
        Character.PrimaryPart.CFrame = Part.CFrame*CFrame.new(0,3,0)
        spawn(function()
            wait(3)
            Part:Destroy()
        end)
    end
    if CheckRig() == 'R6' then
        local Clone = Character.HumanoidRootPart:Clone()
        Character.HumanoidRootPart:Destroy()
        Clone.Parent = Character
    else
        local Clone = Character.LowerTorso.Root:Clone()
        Character.LowerTorso.Root:Destroy()
        Clone.Parent = Character.LowerTorso
    end
    if AirTP then
        wait(1)
        Character.PrimaryPart.CFrame = StoredCF
    end
end

function Enable:BossFarm(boolean)
    local function BossKill()
        local function Magnitude()
            for i,v in pairs(workspace.NPCs:GetChildren()) do 
                if v:FindFirstChild("HumanoidRootPart") then
                    if (Character.HumanoidRootPart.Position - v:FindFirstChild('HumanoidRootPart').Position).magnitude <= 25 then
                        return v
                    end
                end
            end
        end

        for i,v in pairs(workspace.NPCs:GetChildren()) do
            if not Exclusions.TheExiled and string.match(v.Name, "The Exiled") or not Exclusions.Minotaur and string.match(v.Name, "Minotaur") then
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    Character.HumanoidRootPart.CFrame = v:FindFirstChild("HumanoidRootPart").CFrame
                    DealWeaponDamage:FireServer(Character, Magnitude(), '{"Level":75000,"Name":"Old Dagger"}', "Slash")
                else
                    Character.HumanoidRootPart.CFrame = SAFEPOSITION
                    break
                end
            end
        end
    end

    wait(5)

    pcall(function()
        if boolean then
            RunService:UnbindFromRenderStep("BossFarm")
            RunService:BindToRenderStep("BossFarm", 100, BossKill)     
        else
            RunService:UnbindFromRenderStep("BossFarm")
        end
    end)
end

ANTIAFK()
HideIdentity()
Enable:BossFarm(true)


-- if you want to loop when your dead still --
LocalPlayer.CharacterAdded:Connect(function(char)
    repeat wait() until char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Head")
    wait(3)
    Character = char
    HideIdentity()
    Enable:BossFarm(true)
end)

