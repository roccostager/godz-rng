--!strict

--[[ Math
This module contains various math-related utility functions.
]]--


local Math = {}


Math.calculateMultiplier = function(multiplier: number)
    return 2^multiplier
end


return Math