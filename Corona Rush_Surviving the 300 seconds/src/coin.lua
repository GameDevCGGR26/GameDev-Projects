local Coin = {}
Coin.__index = Coin
ActiveCoins = {}

function Coin:new (x,y)
  local  instance = setmetatable ({}, Coin)
  instance.x = x
  instance.y = y
  -- instance.img = love.graphics.newImage("assets/coinsingle.png")
  instance.width = 16
  instance.height = 16
  instance.scaleX = 1
  instance.randomTimeOffset = math.random(0, 100)
  instance.toBeRemoved = false

  instance:loadAssets()
  instance.physics = {}
  instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "static")
  instance.physics.shape = love.physics.newRectangleShape(instance.width, instance.height)
  instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
  instance.physics.fixture:setSensor(true)
  table.insert(ActiveCoins, instance)
end

function Coin:loadAssets()
  self.animation = Animation {
    frames = {1,2,3,4,5,6,7},
    interval = 0.1,
  }
  self.currentAnimation = self.animation
end

function Coin:remove()
  for i,instance in ipairs(ActiveCoins) do
    if instance == self then
      Player:incrementCoins()
      self.physics.body:destroy()
      table.remove(ActiveCoins, i)
    end
  end
end

function Coin:update(dt)
  self.currentAnimation:update(dt)
  self:checkRemove()
end

function Coin:checkRemove()
  if self.toBeRemoved then
   self:remove()
  end
end

function Coin:spin(dt)
  self.scaleX = math.sin(love.timer.getTime() * 2 + self.randomTimeOffset)
end

function Coin:draw()
  love.graphics.draw(
      gTextures.coins, gFrames.coins[self.currentAnimation:getCurrentFrame()],
      self.x, self.y, 0, scaleX, 1, self.width/2, self.height/2
   )
end

function Coin.updateAll(dt)
  for i,instance in ipairs(ActiveCoins) do
      instance:update(dt)
  end
end

function Coin.drawAll()
  for i,instance in ipairs(ActiveCoins) do
      instance:draw()
  end
end

function Coin:beginContact(a, b, collision)
  for i,instance in ipairs(ActiveCoins) do
    if a == instance.physics.fixture or b == instance.physics.fixture then
      if a == Player.character.fixture or b == Player.character.fixture then
        instance.toBeRemoved = true
        print('a')
        gSounds['coin']:play()
        return true
      end
    end
  end
end

return Coin
