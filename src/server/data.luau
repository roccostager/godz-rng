--!strict

-- Types
local Types = require(game:GetService("ReplicatedStorage").Shared.Types)


-- Referencing Services
local Players = game:GetService("Players")


-- Module Start
local data = {}
data.profiles = {}


data.init = function()
    Players.PlayerAdded:Connect(function(player)
        
        -- PlayerProfile Object

        local PlayerProfile = {
            stats = {
                strength = { value = 0, multiplier = 0 },
                agility  = { value = 0, multiplier = 0 },
                vitality = { value = 0, multiplier = 0 },
                magic    = { value = 0, multiplier = 0 },
            },
            auras = {}
        }


        -- PlayerProfile Methods

        PlayerProfile.getStatMultiplier = function(stat: Types.Stat)  -- Get Stat Multiplier
            return PlayerProfile.stats[stat].multiplier
        end
        PlayerProfile.getStatValue = function(stat: Types.Stat)  -- Get Stat Value
            return PlayerProfile.stats[stat].value
        end
        PlayerProfile.incrementStat = function(stat: Types.Stat, amount: number)  -- Increment Stat
            PlayerProfile.stats[stat].value += amount
        end


        -- Add PlayerProfile to data.profiles
        data.profiles[player] = PlayerProfile
    end)

    Players.PlayerRemoving:Connect(function(player)
        -- Save Data

        data.profiles[player] = nil
    end)
end


return data