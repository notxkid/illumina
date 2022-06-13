local Notification = loadstring(game:HttpGet("https://api.irisapp.ca/Scripts/IrisBetterNotifications.lua"))()

if game.PlaceId == 855499080 then
    loadstring(game:HttpGet('https://raw.githubusercontent.com/notxkid/illumina/main/main/skywarsv2.lua',true))()
else
    Notification.Notify("Illumina Hub", "Game is not supported", {Duration = 2,Main={Rounding = true}})
end
