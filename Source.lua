local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Dynamics",
    LoadingTitle = "Dynamics",
    LoadingSubtitle = "by YourLocal-hub",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "DynamicsCFG",
        FileName = "UserSettings"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

local mainTab = Window:CreateTab("Player Settings", 4483362458)

mainTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Callback = function(Value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end
    end,
})

mainTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 300},
    Increment = 5,
    Suffix = "Power",
    CurrentValue = 50,
    Callback = function(Value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end
    end,
})

mainTab:CreateToggle({
    Name = "Reset Speed & Jump to Default",
    CurrentValue = false,
    Callback = function(Value)
        if Value and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16
            LocalPlayer.Character.Humanoid.JumpPower = 50
        end
    end,
})

mainTab:CreateButton({
    Name = "Rejoin",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end,
})

local serverTab = Window:CreateTab("Serverhop", 4483362074)

serverTab:CreateButton({
    Name = "Join Smallest Server",
    Callback = function()
        local servers = {}
        local cursor = ""
        repeat
            local response = HttpService:JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100&cursor="..cursor)
            )
            for _, server in pairs(response.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    table.insert(servers, server)
                end
            end
            cursor = response.nextPageCursor or ""
        until not cursor or #servers >= 1

        if #servers > 0 then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[1].id, LocalPlayer)
        end
    end,
})

serverTab:CreateButton({
    Name = "Join Random Server",
    Callback = function()
        local servers = {}
        local cursor = ""
        repeat
            local response = HttpService:JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100&cursor="..cursor)
            )
            for _, server in pairs(response.data) do
                if server.playing < server.maxPlayers and server.id ~= game.JobId then
                    table.insert(servers, server)
                end
            end
            cursor = response.nextPageCursor or ""
        until not cursor or #servers >= 1

        if #servers > 0 then
            local selected = servers[math.random(1, #servers)]
            TeleportService:TeleportToPlaceInstance(game.PlaceId, selected.id, LocalPlayer)
        end
    end,
})

local teleportTab = Window:CreateTab("Teleport", 4483362324)

teleportTab:CreateButton({
    Name = "Rejoin",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end,
})

teleportTab:CreateInput({
    Name = "Teleport to Friend",
    PlaceholderText = "Enter friend's username",
    RemoveTextAfterFocusLost = true,
    Callback = function(username)
        local friend = Players:FindFirstChild(username)
        if friend and friend.Character and friend.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:MoveTo(friend.Character.HumanoidRootPart.Position + Vector3.new(3,0,0))
        end
    end,
})

teleportTab:CreateInput({
    Name = "Teleport to UserId (in-server)",
    PlaceholderText = "Enter UserId",
    RemoveTextAfterFocusLost = true,
    Callback = function(userId)
        for _, p in ipairs(Players:GetPlayers()) do
            if tostring(p.UserId) == userId and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character:MoveTo(p.Character.HumanoidRootPart.Position + Vector3.new(3,0,0))
            end
        end
    end,
})

local morphsTab = Window:CreateTab("Morphs", 4483362263)

morphsTab:CreateButton({
    Name = "Morph to R6 Blocky",
    Callback = function()
        if LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") then
                    v:Destroy()
                end
            end
            LocalPlayer.Character.Humanoid.BodyTypeScale.Value = 0
        end
    end,
})

morphsTab:CreateButton({
    Name = "Morph to R15 Slim",
    Callback = function()
        if LocalPlayer.Character then
            LocalPlayer.Character.Humanoid.BodyTypeScale.Value = 1
        end
    end,
})

local miscTab = Window:CreateTab("Misc", 4483362224)

miscTab:CreateToggle({
    Name = "FPS Unlocker (Visual)",
    CurrentValue = false,
    Callback = function(Value)
        if setfpscap then
            setfpscap(Value and 999 or 60)
        end
    end,
})

miscTab:CreateToggle({
    Name = "Toggle GUI",
    CurrentValue = true,
    Callback = function(Value)
        for _, gui in pairs(game:GetService("CoreGui"):GetChildren()) do
            if gui:FindFirstChild("Topbar") and gui.Name:find("Rayfield") then
                gui.Enabled = Value
            end
        end
    end,
})

local scriptsTab = Window:CreateTab("Other Scripts", 4483362387)

scriptsTab:CreateButton({
    Name = "Infinite Yield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end,
})

scriptsTab:CreateButton({
    Name = "CMD-X",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source"))()
    end,
})

scriptsTab:CreateButton({
    Name = "Dark Dex",
    Callback = function()
        loadstring(game:HttpGet("https://gist.githubusercontent.com/Defaultio/f09b0e7e42504ff4d052a8f2a263e8f8/raw/"))()
    end,
})

local creditsTab = Window:CreateTab("Credits", 4483362316)

creditsTab:CreateParagraph({
    Title = "Credits",
    Content = "Dynamics GUI\nCreated by YourLocal-hub\nBuilt with Rayfield UI Library\nContributors: OpenAI Tools\nVersion: 1.0"
})
