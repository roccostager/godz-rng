--!strict

--[[ ui
This module handles updating the client-side UI when stat values change.
]]


-- Types
local Types = require(game:GetService("ReplicatedStorage").Shared.Types)


-- Config
local statsConfig = require(game:GetService("ReplicatedStorage").Shared.configuration.stats).stats


local ui = {}


ui.init = function(player: Player)
    local gui = player:WaitForChild("PlayerGui"):WaitForChild("Overlay")
    local statsFrame = gui:WaitForChild("Stats")

    local function updateStat(stat: Types.Stat, value: number)
        (statsFrame:FindFirstChild(stat) :: TextLabel).Text = `{statsConfig[stat].name}: {value}`
    end

    return updateStat
end

return ui