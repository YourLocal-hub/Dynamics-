--// SERVICES local Players = game:GetService("Players") local TeleportService = game:GetService("TeleportService") local HttpService = game:GetService("HttpService") local LocalPlayer = Players.LocalPlayer

--// RAYFIELD local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--// KEY SYSTEM local function createKeyWindow() local Window = Rayfield:CreateWindow({ Name = "Dynamics", LoadingTitle = "Dynamics", LoadingSubtitle = "by YourLocal-hub", ConfigurationSaving = { Enabled = true, FolderName = "DynamicsCFG", FileName = "UserSettings" }, Discord = { Enabled = true, Invite = "z2qGsFREwG", RememberJoins = true }, KeySystem = true, KeySettings = { Title = "Dynamics Key System", Subtitle = "Enter the key to unlock", Note = "Join the Discord server to get the key: discord.gg/z2qGsFREwG", FileName = "DynamicsKey", SaveKey = false, GrabKeyFromSite = false, Key = { "MD82671" } } })

Rayfield:Notify({
    Title = "Key Accepted!",
    Content = "Loading Dynamics GUI...",
    Duration = 4,
    Image = 4483362458
})

task.wait(2)
loadstring(game:HttpGet("https://raw.githubusercontent.com/YourLocal-hub/Dynamics-/refs/heads/main/Source.lua"))()

end

createKeyWindow()

