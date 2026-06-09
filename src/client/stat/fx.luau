--!strict

--[[ fx
This module handles screen effects when stats are trained
]]


-- Types
local Types = require(game:GetService("ReplicatedStorage").Shared.Types)


-- Config
local statsConfig = require(game:GetService("ReplicatedStorage").Shared.configuration.stats).stats


-- Referencing Services
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")


local fx = {}


fx.init = function(player: Player)
    local gui = player:WaitForChild("PlayerGui"):WaitForChild("Overlay")
    local rollBar = gui:WaitForChild("Roll")

    local function rollbarFx(stat: Types.Stat, value: number)

        local shineEffect
        local ratio = 1

        if ratio < 0.25 then
            shineEffect = ReplicatedStorage.UI.Shines.s:Clone()
        elseif ratio < 0.5 then
            shineEffect = ReplicatedStorage.UI.Shines.m:Clone()
        else
            shineEffect = ReplicatedStorage.UI.Shines.l:Clone()
        end

        shineEffect.Parent = rollBar
        TweenService:Create(shineEffect.UIGradient, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Offset = Vector2.new(1, 0) }):Play()
        Debris:AddItem(shineEffect, 1)
    end

    return rollbarFx
end

return fx