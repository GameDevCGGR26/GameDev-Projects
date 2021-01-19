Powerup = Class{}

function Powerup:init(skin)

    self.width = 16
    self.height = 16

    self.dy = 20
    self.dx = 0

    self.skin = skin
    self.inPlay = true
end

function Powerup:collides(target)
    if self.x > target.x + target.width or target.x >self.x + self.width then
        return false
    end

    if self.y > target.y + target.height or target.y >self.y + self.height then
        return false
    end

    return true
end

function Powerup:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Powerup:render()
    love.graphics.draw(gTextures['main'],gFrames['powerups'][self.skin], self.x, self.y)
end