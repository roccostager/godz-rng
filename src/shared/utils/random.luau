--!strict

--[[ Random
This module provides utilities for randomization, such as rolling weighted odds tables.
]]--


-- Types
local Types = require(game:GetService("ReplicatedStorage").Shared.Types)


local Random = {}


--[[ Rolls an OddsTable.
Considers a numeric and "fill" weights.
Returns the value of the rolled entry.
]]--
Random.rollOddsTable = function(oddsTable: Types.OddsTable)

    -- Sum all numeric weights
    local numericSum = 0
    local fillEntry = nil

    for _, entry in ipairs(oddsTable) do
        if entry.weight == "fill" then
            fillEntry = entry
        else
            numericSum += entry.weight
        end
    end

    -- Build a normalised total and resolve the fill weight
    local fillWeight = 0
    if fillEntry then
        fillWeight = math.max(0, 1 - numericSum)
    end

    local total = numericSum + fillWeight

    -- Pick a random point in [0, total)
    local roll = math.random() * total

    local cursor = 0
    for _, entry in ipairs(oddsTable) do
        local weight = if entry.weight == "fill" then fillWeight else entry.weight
        cursor += weight
        if roll < cursor then
            return entry.value
        end
    end

    -- Fallback: return the last entry (handles floating-point edge cases)
    return oddsTable[#oddsTable].value

end


--[[ Random Interval
For continuous values
]]
Random.randomInterval = function(min: number, max: number)
    return min + (max - min) * math.random()
end

return Random