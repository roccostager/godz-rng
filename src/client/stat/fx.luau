--!strict

--[[ fx
This module handles screen effects when stats are trained
]]


-- Types
local Types = require(game:GetService("ReplicatedStorage").Shared.Types)


-- Referencing Services
local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")


-- Config
local statsConfig = require(ReplicatedStorage.Shared.configuration.stats).stats


-- Modules
local Random = require(ReplicatedStorage.Shared.utils.random)


local fx = {}


fx.init = function(player: Player)
    local gui = player:WaitForChild("PlayerGui"):WaitForChild("Overlay")
    local rollBar = gui:WaitForChild("Roll")

    local function rollbarFx(stat: Types.Stat, statData: number)

        -- Reproll Effect
        local reproll = ReplicatedStorage.UI.Effects.RepRoll:Clone()
        reproll.Position = UDim2.new(Random.randomInterval(0.12, 0.88), 0, Random.randomInterval(0.1, 0.9), 0)
        Debris:AddItem(reproll, 2)
        reproll.Parent = gui

        TweenService:Create(reproll, TweenInfo.new(0.3, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), { Size = UDim2.new(0.25, 0, 0.15, 0) }):Play()

        TweenService:Create(reproll.Value, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Value = math.random(1, 100) }):Play()
        reproll.Value:GetPropertyChangedSignal("Value"):Connect(function()
            reproll.Text = math.floor(reproll.Value.Value + 0.99)
        end)

        task.delay(0.5, function()
            local dir = -1 + 2*math.random(0, 1)

            local multi = ReplicatedStorage.UI.Effects.Multi:Clone()
            multi.Position = UDim2.new(reproll.Position.X.Scale + Random.randomInterval(-0.05, 0.05), 0, reproll.Position.Y.Scale + Random.randomInterval(-0.05, 0.05), 0)
            multi.Rotation = dir * Random.randomInterval(7, 10)

            Debris:AddItem(multi, 1)
            multi.Parent = gui

            TweenService:Create(multi, TweenInfo.new(0.3, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), { Rotation = 0.5 * multi.Rotation, TextTransparency = 0, TextStrokeTransparency = 0 }):Play()
            TweenService:Create(multi.UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), { Scale = 3 }):Play()
            task.wait(0.1)
            reproll.Value.Value = reproll.Value.Value * 2
            TweenService:Create(reproll, TweenInfo.new(0.3, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), { Size = UDim2.new(0.4, 0, 0.225, 0) }):Play()
        end)

        -- Roll Bar Effect
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