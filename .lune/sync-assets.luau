local fs = require("@lune/fs")
local roblox = require("@lune/roblox")

print("Parsing game.rbxl...")

-- Read and deserialize Roblox place file
local fileContents = fs.readFile("game.rbxl")
local game = roblox.deserializePlace(fileContents)

-- Extract ReplicatedStorage/Assets
local replicatedStorage = game:GetService("ReplicatedStorage")
local assetsFolder = replicatedStorage:FindFirstChild("Assets")

if assetsFolder then
    local assetsXml = roblox.serializeModel({ assetsFolder }, true)
    fs.writeFile("src/assets/Assets.rbxmx", assetsXml)
    print("✅ Synced ReplicatedStorage/Assets")
else
    print("❌ No 'Assets' folder found in ReplicatedStorage.")
end

print("Sync complete!")