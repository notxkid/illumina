-- Loader.lua
-- // * Some scripts may be obfuscated to prevent game owners from patching them! * \\ --

getgenv()["IrisAd"] = true
local Notification = loadstring(game:HttpGet("https://api.irisapp.ca/Scripts/IrisBetterNotifications.lua"))()

if game.PlaceId == 855499080 then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/notxkid/illumina/main/main/skywarsv2.lua',true))()
elseif game.PlaceId == 4913581664 then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/notxkid/illumina/main/main/cartride.lua',true))()
elseif game.PlaceId == 7584496019 then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/notxkid/illumina/main/main/99failimpossible.lua',true))()
else
    Notification.Notify("Illumina Hub", "Game is not supported", {Duration = 2,Main={Rounding = true}})
end
