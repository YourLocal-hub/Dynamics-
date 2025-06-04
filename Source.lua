--// SERVICES local Players = game:GetService("Players") local TeleportService = game:GetService("TeleportService") local HttpService = game:GetService("HttpService") local LocalPlayer = Players.LocalPlayer

--// RAYFIELD local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--// WINDOW SETUP local Window = Rayfield:CreateWindow({ Name = "Dynamics", LoadingTitle = "Dynamics", LoadingSubtitle = "by YourLocal-hub", ConfigurationSaving = { Enabled = true, FolderName = "DynamicsCFG", FileName = "UserSettings" }, Discord = { Enabled = true, Invite = "z2qGsFREwG", RememberJoins = true }, KeySystem = true, KeySettings = { Title = "Dynamics Key System", Subtitle = "Enter the key to unlock", Note = "Join the Discord server to get the key: discord.gg/z2qGsFREwG", FileName = "DynamicsKey", SaveKey = false, GrabKeyFromSite = false, Key = { "MD82671" } } })

Rayfield:Notify({ Title = "Key Accepted!", Content = "Loading Dynamics GUI...", Duration = 4, Image = 4483362458 })

task.wait(2)

--// PLAYER SETTINGS TAB local mainTab = Window:CreateTab("Player Settings", 4483362458)

mainTab:CreateSlider({ Name = "WalkSpeed", Range = {16, 200}, Increment = 1, Suffix = "Speed", CurrentValue = 16, Callback = function(Value) if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = Value end end, })

mainTab:CreateSlider({ Name = "JumpPower", Range = {50, 300}, Increment = 5, Suffix = "Power", CurrentValue = 50, Callback = function(Value) if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then LocalPlayer.Character.Humanoid.JumpPower = Value end end, })

mainTab:CreateToggle({ Name = "Reset Speed & Jump to Default", CurrentValue = false, Callback = function(Value) if Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = 16 LocalPlayer.Character.Humanoid.JumpPower = 50 end end, })

mainTab:CreateButton({ Name = "Rejoin", Callback = function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end, })

--// SERVERHOP TAB local serverTab = Window:CreateTab("Serverhop", 71766545473909)

serverTab:CreateButton({ Name = "Join Smallest Server", Callback = function() local servers = {} local cursor = "" repeat local response = HttpService:JSONDecode( game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100&cursor="..cursor) ) for _, server in pairs(response.data) do if server.playing < server.maxPlayers and server.id ~= game.JobId then table.insert(servers, server) end end cursor = response.nextPageCursor or "" until not cursor or #servers >= 1

if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[1].id, LocalPlayer)
    else
        Rayfield:Notify({Title = "Error", Content = "No available servers found.", Duration = 5})
    end
end,

})

serverTab:CreateButton({ Name = "Join Random Server", Callback = function() local servers = {} local cursor = "" repeat local response = HttpService:JSONDecode( game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100&cursor="..cursor) ) for _, server in pairs(response.data) do if server.playing < server.maxPlayers and server.id ~= game.JobId then table.insert(servers, server) end end cursor = response.nextPageCursor or "" until not cursor or #servers >= 1

if #servers > 0 then
        local selected = servers[math.random(1, #servers)]
        TeleportService:TeleportToPlaceInstance(game.PlaceId, selected.id, LocalPlayer)
    else
        Rayfield:Notify({Title = "Error", Content = "No available servers found.", Duration = 5})
    end
end,

})

--// TELEPORT TAB local teleportTab = Window:CreateTab("Teleport", 6723742959)

teleportTab:CreateButton({ Name = "Rejoin", Callback = function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end, })

--// MORPHS TAB local morphsTab = Window:CreateTab("Morphs", 17321510343)

morphsTab:CreateButton({ Name = "Morph to R6 Blocky", Callback = function() if LocalPlayer.Character then for _, v in pairs(LocalPlayer.Character:GetDescendants()) do if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then v:Destroy() end end LocalPlayer.Character.Humanoid.BodyTypeScale.Value = 0 end end, })

morphsTab:CreateButton({ Name = "Morph to R15 Slim", Callback = function() if LocalPlayer.Character then LocalPlayer.Character.Humanoid.BodyTypeScale.Value = 1 end end, })

--// MISC TAB local miscTab = Window:CreateTab("Misc", 4483362224)

miscTab:CreateToggle({ Name = "FPS Unlocker (Visual)", CurrentValue = false, Callback = function(Value) if setfpscap then setfpscap(Value and 999 or 60) end end, })

miscTab:CreateToggle({ Name = "Toggle GUI", CurrentValue = true, Callback = function(Value) for _, gui in pairs(game:GetService("CoreGui"):GetChildren()) do if gui:FindFirstChild("Topbar") and gui.Name:find("Rayfield") then gui.Enabled = Value end end end, })

--// OTHER SCRIPTS TAB local scriptsTab = Window:CreateTab("Other Scripts", 13436029957)

scriptsTab:CreateButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end, })

scriptsTab:CreateButton({ Name = "CMD-X", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source"))() end, })

scriptsTab:CreateButton({ Name = "Dark Dex", Callback = function() loadstring(game:HttpGet("https://gist.githubusercontent.com/Defaultio/f09b0e7e42504ff4d052a8f2a263e8f8/raw/"))() end, })

--// CREDITS TAB local creditsTab = Window:CreateTab("Credits", 16933943605)

creditsTab:CreateParagraph({ Title = "Credits", Content = "Dynamics GUI\nCreated by YourLocal-hub\nBuilt with Rayfield UI Library\nVersion: 1.0" })

