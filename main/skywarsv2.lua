--[[ xkid#5002 ]]--
--[[ Credits to infinite yield for the Discord button and the Serverhop button]]--

-- Wait for game loaded

if not game:IsLoaded() then
	game.Loaded:Wait()
end

-- Set Values

getgenv().AntiVoid = 'reset'
getgenv().TriggerBot = 'reset'
getgenv().stop = false
getgenv()["IrisAd"] = true

-- Load UI

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua",true))()
local UI = Material.Load({
     Title = "illumina hub - Skywars V2 Fixed",
     Style = 2,
     SizeX = 400,
     SizeY = 300,
     Theme = "Light"
})

-- Load hot notification script

local Notification = loadstring(game:HttpGet("https://api.irisapp.ca/Scripts/IrisBetterNotifications.lua"))()

-- Variables
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local FolderName = tostring(math.random(1,1000000))
local AntiVoidName = tostring(math.random(1,1000000))
local Mouse = LocalPlayer:GetMouse()
local plrsLeft = workspace.plrsLeft
local LastPosition = nil
local Noclip = nil

-- Universal Anti-Cheat Bypasser
if getgenv().BypassedAntiCheat ~= false then
    getgenv().BypassedAntiCheat = true
    loadstring(game:HttpGet('https://raw.githubusercontent.com/notxkid/illumina/main/main/bypasses.lua',true))()
end
-- SkyWars Anti-Cheat Bypasser
for i,v in pairs(LocalPlayer.PlayerGui.Extra:GetChildren()) do
    if v.Name == "Local" or v.Name:find("AntiSploitClient") then
        v:Destroy()
    end
end
LocalPlayer.PlayerGui.DescendantAdded:Connect(function(v)
    if v.Name == "Local" or v.Name:find("AntiSploitClient") and v.Parent == LocalPlayer.PlayerGui.Extra then
        v:Destroy()
    end
end)
for i,v in pairs(getnilinstances()) do
    if v:IsA("HopperBin") or v.Name == "Local" then 
        v:Destroy()
    end
end
-- Remove Spawn Anti-Cheat
if workspace:FindFirstChild("Lobby") and workspace["Lobby"]:FindFirstChild("KillPlates") ~= nil then
    workspace["Lobby"]:FindFirstChild("KillPlates"):Destroy()
end

-- Functions

function mineall() -- Mine all ores
    Notification.Notify("Mine all ores", "The better the pickaxe, the faster this will take!", {
        Duration = 2,       
        Main = {
            Rounding = true,
        }
    });
    -- Equip Pickaxe
    if LocalPlayer.Backpack:FindFirstChild("Axe") then
        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild("Axe"))
    end
    
    -- Get Pickaxe
    repeat
        wait()
    until LocalPlayer.Character:FindFirstChild("Axe") ~= nil

    local axe = LocalPlayer.Character:WaitForChild("Axe")

    if not workspace:FindFirstChild(FolderName) then
        local folder = Instance.new("Folder", workspace)
        folder.Name = FolderName
    end
    local afolder = workspace:WaitForChild(FolderName)

    for i, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("Map") and v.Name:find("Map") then
            local oresfolder = v.Map:FindFirstChild("Ores")
            
            local orig = CFrame.new(LocalPlayer.Character.HumanoidRootPart.Position)
            for _, child in pairs(LocalPlayer.Character:GetDescendants()) do
                if child:IsA("BasePart") and child.CanCollide == true then
                    child.CanCollide = false
                end
            end
            for i, v in ipairs(oresfolder:GetChildren()) do
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
                local position = LocalPlayer.Character.HumanoidRootPart.Position
                
                local part = Instance.new("Part", afolder)
                part.Anchored = true
                part.Size = Vector3.new(99, 1, 99)
                part.Position = position - Vector3.new(0, 5, 0)
                part.Transparency = 1
                
                repeat
                    wait()
                    if axe:FindFirstChild("RemoteEvent") then 
                        axe.RemoteEvent:FireServer(v)
                    end
                until v.Name == "Broken" or axe:FindFirstChild("RemoteEvent") == nil
                
                -- Reset
                LocalPlayer.Character.HumanoidRootPart.CFrame = orig
                for i, v in pairs(afolder:GetChildren()) do
                    v:Destroy()
                end
                for _, child in pairs(LocalPlayer.Character:GetDescendants()) do
                    if child:IsA("BasePart") and child.CanCollide == true then
                        child.CanCollide = true
                    end
                end
            end
        end
    end
    Notification.Notify("Mine all ores", "Done", {
        Duration = 2,       
            Main = {
                Rounding = true,
            }
    });
end

function collectallcoins() -- Collect all coins
    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local pos = hrp.Position
        for i,v in pairs(game:GetService("Workspace").GameStorage.Coins:GetChildren()) do
            if v.Name == "Coin" then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
                wait(0.5)
            end
        end
        wait()
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
    end
end

function killall() -- kill all Players
    if LocalPlayer.Backpack:FindFirstChild("Sword") then
        LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild("Sword"))
    end
    local sword = LocalPlayer.Character:WaitForChild("Sword", 10)
    print("Got sword")
    -- Sword Reach
    sword.Handle.Massless = true
    sword.Handle.Size = Vector3.new(30, 30, 30)
    sword.GripPos = Vector3.new(0, 0, 0)

    -- Loop through players
    for i, v in pairs(Players:GetPlayers()) do
        if v and v.Character and LocalPlayer.Character and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= LocalPlayer then
            if v and v.Character.Humanoid.Health > 0 and v.Backpack:FindFirstChildWhichIsA("Tool") then
                local KillPart = Instance.new("Part", workspace)
                KillPart.Anchored = true
                KillPart.Transparency = 1
                KillPart.Size = Vector3.new(5, 1, 5)
                KillPart.Position = v.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0)
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(KillPart.Position) + Vector3.new(0,5,0)
                -- kill them
                repeat
                    wait()
                    if v and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("HumanoidRootPart") then
                        KillPart.Position = v.Character.HumanoidRootPart.Position + Vector3.new(math.random(5,20), 5, math.random(5,20))
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(KillPart.Position) + Vector3.new(0,0,0)
                        sword:Activate()
                    end
                until v.Character.HumanoidRootPart.Position.Y < 135 or v.Character.Humanoid.Health == 0 or LocalPlayer.Character:FindFirstChild("HumanoidRootPart") == nil or v.Character:FindFirstChild("HumanoidRootPart") == nil

                -- reset
                KillPart:Destroy()
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7.9967288970947, 165.31405639648, -7.4000864028931)
                wait(0.5)
            end
        end
    end
    collectallcoins()
end

-- INF JUMP AND FLY

InfJump = true
_G.JumpHeight = 50

function infjump()
    InfJump = false
    if InfJump == false then
        function Action(Object, Function)
            if Object ~= nil then
                Function(Object)
            end
        end
        local UIS = game:GetService "UserInputService"
        UIS.InputBegan:connect(
            function(UserInput)
                if
                    UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space and
                        InfJump == false
                 then
                    repeat wait() until LocalPlayer.Character
                    Action(
                        LocalPlayer.Character.Humanoid,
                        function(self)
                            if
                                self:GetState() == Enum.HumanoidStateType.Jumping or
                                    self:GetState() == Enum.HumanoidStateType.Freefall and InfJump == false
                             then
                                Action(
                                    self.Parent.HumanoidRootPart,
                                    function(self)
                                        self.Velocity = Vector3.new(0, _G.JumpHeight, 0)
                                    end
                                )
                            end
                        end
                    )
                end
            end
        )
    end
end

local plr = LocalPlayer
local mouse = Mouse
local torso = plr.Character.Head
local flying = false
local deb = true
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local lastctrl = {f = 0, b = 0, l = 0, r = 0}
local maxspeed = 400
local speed = 0

function Fly()
    local bg = Instance.new("BodyGyro", torso)
    bg.P = 9e4
    bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.cframe = torso.CFrame
    local bv = Instance.new("BodyVelocity", torso)
    bv.velocity = Vector3.new(0, 0.1, 0)
    bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
    repeat
        wait()
        if plr.Character:FindFirstChild("Humanoid") then
        plr.Character.Humanoid.PlatformStand = true
        if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
            speed = speed + .5 + (speed / maxspeed)
            if speed > maxspeed then
                speed = maxspeed
            end
        elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
            speed = speed - 1
            if speed < 0 then
                speed = 0
            end
        end
        if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
            bv.velocity =
                ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f + ctrl.b)) +
                ((game.Workspace.CurrentCamera.CoordinateFrame *
                    CFrame.new(ctrl.l + ctrl.r, (ctrl.f + ctrl.b) * .2, 0).p) -
                    game.Workspace.CurrentCamera.CoordinateFrame.p)) *
                speed
            lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
        elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
            bv.velocity =
                ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f + lastctrl.b)) +
                ((game.Workspace.CurrentCamera.CoordinateFrame *
                    CFrame.new(lastctrl.l + lastctrl.r, (lastctrl.f + lastctrl.b) * .2, 0).p) -
                    game.Workspace.CurrentCamera.CoordinateFrame.p)) *
                speed
        else
            bv.velocity = Vector3.new(0, 0.1, 0)
        end
        bg.cframe =
            game.Workspace.CurrentCamera.CoordinateFrame *
            CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 50 * speed / maxspeed), 0, 0)
    end
    until not flying
    ctrl = {f = 0, b = 0, l = 0, r = 0}
    lastctrl = {f = 0, b = 0, l = 0, r = 0}
    speed = 0
    bg:Destroy()
    bv:Destroy()
    plr.Character.Humanoid.PlatformStand = false
end
mouse.KeyDown:connect(
    function(key)
        if key:lower() == "e" then
            if flying then
                flying = false
            else
                flying = true
                Fly()
            end
        elseif key:lower() == "w" then
            ctrl.f = 1
        elseif key:lower() == "s" then
            ctrl.b = -1
        elseif key:lower() == "a" then
            ctrl.l = -1
        elseif key:lower() == "d" then
            ctrl.r = 1
        end
    end
)
mouse.KeyUp:connect(
    function(key)
        if key:lower() == "w" then
            ctrl.f = 0
        elseif key:lower() == "s" then
            ctrl.b = 0
        elseif key:lower() == "a" then
            ctrl.l = 0
        elseif key:lower() == "d" then
            ctrl.r = 0
        end
    end
)

function GetOrSetAntiVoidPart() -- antivoid
    local PossiblePart = workspace:FindFirstChild(AntiVoidName)
    if PossiblePart == nil then
        PossiblePart = Instance.new("Part",workspace)
        PossiblePart.Name = AntiVoidName
        PossiblePart.Anchored = true
        PossiblePart.CanCollide = true
        PossiblePart.Size = Vector3.new(5,1,5)
        PossiblePart.Transparency = 1
    end
    return PossiblePart
end

local debounce = false

--Antivoid main
local AntiVoidPart = GetOrSetAntiVoidPart()
AntiVoidPart.Touched:Connect(function(hit)
    local Character = LocalPlayer.Character
    if Character == hit.Parent and debounce == false and LastPosition ~= nil and getgenv().AntiVoid == true then
        debounce = true
        wait()
        Character:FindFirstChild("HumanoidRootPart").CFrame = LastPosition
        -- Freeze Character
        Character.Humanoid.WalkSpeed = 0
        for i, v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") and not v.Anchored then
				v.Anchored = true
			end
		end

        -- Notify
        Notification.Notify("Anti-Void", "Anti void has attempted to save you", {
            Duration = 2,       
            Main = {
                Rounding = true,
            }
        });
    
        wait(1)
        -- Unfreeze character
        for i, v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") and v.Anchored then
				v.Anchored = false
			end
        end
	    wait(0.5)
	    Character.Humanoid.WalkSpeed = Speed
        debounce = false
    end
end)

-- Heartbeat loop
local Jump = 50
local Speed = 16
RunService.Heartbeat:Connect(function()
    local Character = LocalPlayer.Character
    local Humanoid = Character:FindFirstChild("Humanoid")
    if Humanoid then
        local RootPart = Humanoid.RootPart
        if RootPart == nil then
            return
        end
        if debounce == false and getgenv().stop == false then
            Humanoid.WalkSpeed = Speed
            Humanoid.JumpPower = Jump
        elseif getgenv().stop == true then
            Humanoid.WalkSpeed = 0
        end
        
        -- Last position
        local Ray = Ray.new(RootPart.Position, Vector3.new(0, -3, 0))
        local FloorPart = workspace:FindPartOnRay(Ray, Character)
        if FloorPart and FloorPart ~= AntiVoidPart then
            LastPosition = CFrame.new(RootPart.Position)
        end

        -- antivoid stuff
        local Position = RootPart.Position
        AntiVoidPart.Position = Vector3.new(Position.X,135,Position.Z)
        
        if plrsLeft.Value == 0 and getgenv().AntiVoid == true then
            getgenv().AntiVoid = false
            repeat wait() until plrsLeft.Value > 0
            if getgenv().AntiVoid == false then
               getgenv().AntiVoid = true
            end
        end
        
        if getgenv().AntiVoid == true then
            AntiVoidPart.CanCollide = true
        elseif getgenv().AntiVoid == false then
            AntiVoidPart.CanCollide = false
        elseif getgenv().AntiVoid == "reset" then
            AntiVoidPart:Destroy()
        end
        
        -- Trigger bot pretty simple
        local Bow = Character:FindFirstChild("Bow")
        if Mouse.Target ~= nil and Mouse.Target.Parent:FindFirstChild("Humanoid") and Mouse.Target.Parent ~= Character and Bow and getgenv().TriggerBot == true then
            mouse1press() wait() mouse1release()
        end
        
        -- Autoheal
        if getgenv().AutoHeal == true and Humanoid.Health <= 25 and Humanoid.Health ~= 0 then
            getgenv().AutoHeal = false
            if LocalPlayer.Backpack:FindFirstChild("Heal") then
                LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild("Heal"))
            end
            local heal = LocalPlayer.Character:WaitForChild("Heal",10)
            if heal then
                heal:Activate()
                wait(0.5)
                Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild("Sword"))
                Notification.Notify("Auto-heal", "Attempted to heal you back to 100% health", {
                    Duration = 2,       
                    Main = {
                        Rounding = true,
                    }
                });
            end
            getgenv().AutoHeal = true
        end
    end
end)

game:GetService("ReplicatedStorage").Events.HideMenu.OnClientEvent:Connect(function()
    getgenv().stop = true
    wait(3)
    getgenv().stop = false
end)

local Section = UI.New({
    Title = "Main"
})

local Section2 = UI.New({
    Title = "Teleports"
})

local Section3 = UI.New({
    Title = "Character"
})

local Section4 = UI.New({
    Title = "Other"
})

Section.Button({
    Text = "Mine All Ores",
    Callback = function()
        if not LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool") then return end
        mineall()
    end,
    	Menu = {
		Information = function(self)
			UI.Banner({
				Text = "Mines all ores in the current game."
			})
		end
	}
})

Section.Button({
    Text = "Kill All",
    Callback = function()
       if not LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool") then return end
       killall()
    end,
        	Menu = {
		Information = function(self)
			UI.Banner({
				Text = "Kills all players in the current game except you."
			})
		end
	}
})

Section.Button({
    Text = "Collect all coins",
    Callback = function()
        if not LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool") then return end
        collectallcoins()
    end
})

Section.Button({
    Text = "Sword Reach",
    Callback = function()
        if not LocalPlayer.Backpack:FindFirstChildWhichIsA("Tool") then return end
        
        if LocalPlayer.Backpack:FindFirstChild("Sword") then
            LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild("Sword"))
        end
        local sword = LocalPlayer.Character:WaitForChild("Sword",10)
        
        sword.Handle.Massless = true
        sword.Handle.Size = Vector3.new(25,25,25)
        --sword.GripPos = Vector3.new(0,0,0)
    end
})

Section.Toggle({
    Text = "Anti-Void",
    Callback = function(value)
        if value == true then
            getgenv().AntiVoid = true
        elseif value == false then
            getgenv().AntiVoid = false
        end
    end,
    Enabled = false
})

Section.Toggle({
    Text = "Bow Trigger-Bot",
    Callback = function(value)
        getgenv().TriggerBot = value
    end,
    Enabled = false
})

Section.Toggle({
    Text = "Auto-heal (Needs heal potion)",
    Callback = function(value)
        getgenv().AutoHeal = value
    end,
    Enabled = false
})

Section.Toggle({
    Text = "Disable Spawn-Borders",
    Callback = function(value)
        if value == true then
            for i,v in pairs(workspace['Borders']:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        elseif value == false then
            for i,v in pairs(workspace['Borders']:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end,
    Enabled = false
})

-- Teleports

Section2.Button({
    Text = "Mega VIP",
    Callback = function()
       LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1.8973470926285, 264.01287841797, 70.017677307129)
    end
})

Section2.Button({
    Text = "VIP",
    Callback = function()
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0.09401910007, 265.19183349609, -70.074653625488)
    end
})

Section2.Button({
    Text = "Shop",
    Callback = function()
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(95.559829711914, 264.47235107422, -0.30938053131104)
    end
})

Section2.Button({
    Text = "Middle Island",
    Callback = function()
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7.9967288970947, 165.31405639648, -7.4000864028931)
    end
})

Section2.Button({
    Text = "Lobby",
    Callback = function()
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-0.26797923445702, 272.33557128906, -1.7032647132874)
    end
})

Section2.Button({
    Text = "Game Store",
    Callback = function()
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-67.510246276855, 265.09762573242, -0.32639706134796)
    end
})

Section2.Button({
    Text = "Group Section",
    Callback = function()
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(125.34710693359, 266.02334594727, 0.62211513519287)
    end
})

-- Character

Section3.Slider({
    Text = "Walkspeed",
    Callback = function(value)
        Speed = value
    end,
    Min = 16,
    Max = 100,
    Def = 16
})

Section3.Slider({
    Text = "JumpPower",
    Callback = function(value)
        Jump = value
    end,
    Min = 50,
    Max = 125,
    Def = 50
})

Section3.Slider({
    Text = "Inf-Jump Height",
    Callback = function(value)
        _G.JumpHeight = value
    end,
    Min = 50,
    Max = 125,
    Def = 50
})

Section3.Toggle({
    Text = "Flight (e to toggle on/off)",
    Callback = function(value)
        if value == true then
           flying = value
           Fly()
        else
           flying = value
        end
    end,
    Enabled = false
})

Section3.Toggle({
    Text = "Inf-Jump",
    Callback = function(value)
        if value == true then
        infjump()
        elseif value == false then
        InfJump = true
        end
    end,
    Enabled = false
})

Section4.Button({
    Text = "Equip mega vip armor",
    Callback = function()
        local origpos = LocalPlayer.Character.HumanoidRootPart.Position
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-10.522195816040039, 264.9999084472656, 61.2391471862793)
        wait(0.3)
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(11.011512756347656, 264.9999084472656, 79.23206329345703)
        wait(0.3)
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(origpos)
    end
})

Section4.Button({
    Text = "Execute Infinite-Yield",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

Section4.Button({
    Text = "Serverhop",
    Callback = function() -- credits to infinite yield, i did not make any of this
        local x = {}
	    for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
		    if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
			    x[#x + 1] = v.id
		    end
    	end
	    if #x > 0 then
		    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, x[math.random(1, #x)])
	    else
		    Notification.Notify("Serverhop", "Could not find a server", {
                Duration = 2,       
                Main = {
                    Rounding = true,
                }
            });
    	end
    end
})

Section4.Button({
	Text = "Join Discord",
	Callback = function() -- credits to infinite yield, i did not make any of this
	    
	    local req = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or getgenv().request or request
	    if req then
		    req({
			    Url = 'http://127.0.0.1:6463/rpc?v=1',
			    Method = 'POST',
			    Headers = {
				    ['Content-Type'] = 'application/json',
				    Origin = 'https://discord.com'
			    },
			    Body = game:GetService("HttpService"):JSONEncode({
				    cmd = 'INVITE_BROWSER',
				    nonce = game:GetService("HttpService"):GenerateGUID(false),
				    args = {code = 'W8PNnb4uH3'}
			    })
		    })
	    end
	end,
})

-- autoload
local tp = syn and syn.queue_on_teleport or queue_on_teleport
if tp then
    tp("loadstring(game:HttpGet('https://raw.githubusercontent.com/notxkid/illumina/main/main/skywarsv2.lua'))()")
end

UI.Banner({
    Text = "Skywars V2 Loaded & Anticheat bypassed | by xkid#5002"
})
