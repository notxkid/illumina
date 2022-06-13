local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local UI = Material.Load({
     Title = "illumina hub - Cart Ride",
     Style = 2,
     SizeX = 400,
     SizeY = 300,
     Theme = "Jester"
})

local Section = UI.New({
    Title = "Main"
})

Section.Toggle({
    Text = "Scan Cart ClickDetectors",
    Callback = function(value)
        getgenv().cartscan = value
    end,
    Enabled = false
})

Section.Toggle({
    Text = "Spam Cart ClickDetectors",
    Callback = function(value)
        getgenv().cartspam = value
    end,
    Enabled = false
})

Section.Toggle({
    Text = "Spam Cart Regen",
    Callback = function(value)
        getgenv().regenspam = value
        if value == true then
            scan()
        end
    end,
    Enabled = false
})

local FirstScan = false
local ClickDetectors = {}
local RegenClickDetectors = {}

function scan()
    print("Scanning")
    for i,v in pairs(workspace:GetDescendants()) do
        if v:IsA("ClickDetector") then
            if v.Parent.Name == "Up" and getgenv().cartscan == true and not ClickDetectors[v] then
                table.insert(ClickDetectors,v)
            elseif v.Parent.Name:find("Regen") and getgenv().regenspam == true and not RegenClickDetectors[v] then
                table.insert(RegenClickDetectors,v)
            end
        end
    end
end

spawn(function()
    scan()
    while wait(10) do
        scan()
    end
end)

workspace.DescendantAdded:Connect(function(v)
    if v:IsA("ClickDetector") and v.Parent.Name == "Up" and not ClickDetectors[v] then
        table.insert(ClickDetectors,v)
    end
end)

spawn(function()
    game:GetService("RunService").Heartbeat:Connect(function()
        wait()
        if getgenv().cartspam == true then
            for i,v in pairs(ClickDetectors) do
                if v then
                    wait()
                    if getgenv().cartspam == true then
                        fireclickdetector(v) 
                    end
                else
                    table.remove(ClickDetectors,i)  
                end
            end
        end
        if getgenv().regenspam == true then
            for i,v in pairs(RegenClickDetectors) do
                if v then
                    wait()
                    if getgenv().regenspam == true then
                        fireclickdetector(v) 
                    end
                else
                    table.remove(ClickDetectors,i)  
                end
            end
        end
    end)
end)

UI.Banner({
    Text = "Illumina Hub - Cart Ride Loaded"
})
