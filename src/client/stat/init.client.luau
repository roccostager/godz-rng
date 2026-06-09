--[[ Stat
This script handles client-side stats:
1. Player Input for Stat Training: fires event to server.
2. Stat Changes from Server: listens to server event + invokes effects.
]]--


-- Types
local Types = require(game:GetService("ReplicatedStorage").Shared.Types)


-- Referencing Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")


-- Remote Events
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")


-- Player, Character
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()


-- Initialise Modules
local ui = require(script.ui).init(player)
local fx = require(script.fx).init(player)


-- Global Variables
local trainingInterval = 1


-- Training State
local trainingDebounce = { strength = false, agility = false, vitality = false, magic = false }


-- Training Function
function rep(stat: Types.Stat)
    if trainingDebounce[stat] or not character then return end
    trainingDebounce[stat] = true

    RemoteEvents.statRE:FireServer(stat)
    
    task.wait(trainingInterval)
    trainingDebounce[stat] = false
end


-- Rep Detection
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)  -- Strength on click
    if gameProcessedEvent then return end

    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        rep("strength")
    end
end)


-- Client Event Listener
RemoteEvents.statRE.OnClientEvent:Connect(function(stat: Types.Stat, value: number, change: number, critical: number)
    ui(stat, value)
    fx(stat, value)
end)