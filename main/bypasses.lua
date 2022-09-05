local lp = game:GetService("Players").LocalPlayer

local old
old = hookmetamethod(game, "__index", function(...) 
    local a,b = ...
    if not checkcaller() and b == "WalkSpeed" or b == "JumpPower" then
        if a.ClassName == "Humanoid" and a.Parent == lp.Character then
            return 16
        end
    end
    return old(...)
end)

local OldNameCall = nil
OldNameCall = hookmetamethod(game, "__namecall", function(Self, ...)
    local NameCallMethod = getnamecallmethod()

    if tostring(string.lower(NameCallMethod)) == "kick" then
        return nil
    end
    
    return OldNameCall(Self, ...)
end)

for _, con in ipairs(getconnections(lp.Character.Humanoid.Changed)) do
    con:Disable()
end
for _, con in ipairs(getconnections(lp.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"))) do
    con:Disable()
end
for _, con in ipairs(getconnections(lp.Character.Humanoid:GetPropertyChangedSignal("JumpPower"))) do
    con:Disable()
end
