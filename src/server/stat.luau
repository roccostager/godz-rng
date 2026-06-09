--!strict

--[[
This modules handles server-side logic for stats.
]]--


-- Types
local Types = require(game:GetService("ReplicatedStorage").Shared.Types)


-- Referencing Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")


-- Modules
local Math = require(ReplicatedStorage.Shared.utils.math)
local Random = require(ReplicatedStorage.Shared.utils.random)


-- Config
local criticalConfig = require(ReplicatedStorage.Shared.configuration.critical)


-- Remote Events
local RemoteEvents = ReplicatedStorage:WaitForChild("RemoteEvents")


-- Module Start
local reps = {}

function reps.init(data)

    -- Train Remote Event
    RemoteEvents.statRE.OnServerEvent:Connect(function(player, stat: Types.Stat)
        
        -- Handle Stat Incrementation
        local amount = Math.calculateMultiplier(data.profiles[player].getStatMultiplier(stat))
        local criticalFactor = Random.rollOddsTable(criticalConfig); amount *= criticalFactor
        data.profiles[player].incrementStat(stat, amount)
        RemoteEvents.statRE:FireClient(player, stat, data.profiles[player].getStatValue(stat), amount, criticalFactor)

        -- Handle lucky rolls mechanic

    end)

end

return reps