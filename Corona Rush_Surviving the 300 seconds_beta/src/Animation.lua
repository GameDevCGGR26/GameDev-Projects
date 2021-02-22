--[[
    GD50
    Super Mario Bros. Remake

    -- Animation Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Animation = Class{}

function Animation:init(def)
    self.frames = def.frames
    self.interval = def.interval
    self.width = def.width
    self.height = def.height
    self.timer = 0
    self.currentFrame = 1
end

function Animation:update(dt)
    if #self.frames > 1 then
        self.timer = self.timer + dt

        if self.timer > self.interval then
            self.timer = self.timer % self.interval

            self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))
        end
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end
