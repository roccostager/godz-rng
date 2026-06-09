--!strict

--[[ Critical
Configuration for Critical Rep Rates by weight
]]


-- Types
local Types = require(game:GetService("ReplicatedStorage").Shared.Types)


local critical: Types.OddsTable = {  -- Expected value: ~1.285
    { weight = "fill", value =   1   },
    { weight = 0.2,    value =   1.5 },
    { weight = 0.05,   value =   3   },
    { weight = 0.01,   value =   5   },
    { weight = 0.005,  value =   10  },
}
return critical