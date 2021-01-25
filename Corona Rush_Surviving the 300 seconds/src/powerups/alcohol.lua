local Alcohol = {}
Alcohol.__index = Alcohol
ActiveAlcohols = {}

function Alcohol:new (x,y)
local  instance = setmetatable ({}, Alcohol)
instance.x = x
instance.y = y
--instance.img = love.graphics.newImage("assets/mask.png")
instance.width = 35
instance.height = 35
instance.scaleX = 1
instance.randomTimeOffset = math.random(0, 100)
instance.toBeRemoved = false

instance:loadAssets()
instance.physics = {}
instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "static")
instance.physics.shape = love.physics.newRectangleShape(instance.width, instance.height)
instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
instance.physics.fixture:setSensor(true)
table.insert(ActiveAlcohols, instance)
end

function Alcohol:loadAssets()
 self.animation = Animation {
   frames = {1,2},
   interval = 0.5,
  }
 self.currentAnimation = self.animation
end

function Alcohol:remove ()
  for i,instance in ipairs(ActiveAlcohols) do
    if instance == self then
      --Player:incrementPowerups()
      self.physics.body:destroy()
      table.remove(ActiveAlcohols, i)
    end
  end
end

function Alcohol:update (dt)
--self:spin(dt)
self.currentAnimation:update(dt)
self:checkRemove()
end

function Alcohol:checkRemove ()
  if self.toBeRemoved then
   self:remove()
  end
end

--function Mask:spin (dt)
--self.scaleX = math.sin(love.timer.getTime() * 2 + self.randomTimeOffset)
--end

function Alcohol:draw ()
  -- love.graphics.draw(self.img, self.x, self.y, 0, self.scaleX, 1, self.width/2, self.height/2)
  love.graphics.draw(
  gTextures.alcohol, gFrames.alcohol[self.currentAnimation:getCurrentFrame()],
      self.x, self.y, 0, scaleX, 1, self.width/2, self.height/2
   )
end

function Alcohol.updateAll (dt)
  for i,instance in ipairs(ActiveAlcohols) do
      instance:update(dt)
  end
end

function Alcohol.drawAll ()
  for i,instance in ipairs(ActiveAlcohols) do
      instance:draw()
  end
end

function Alcohol.beginContact (a, b, collision)
  for i,instance in ipairs(ActiveAlcohols) do
    if a == instance.physics.fixture or b == instance.physics.fixture then
      if a == Player.character.fixture or b == Player.character.fixture then
        if GUI.alcoholBar == 0 then
          instance.toBeRemoved = true
          GUI.isDisplayAlcohol = true
          GUI.isDisplayMask = false
          GUI.isDisplayFaceshield = false
          GUI.isDisplayPPE = false
          GUI.alcoholBar = 1
          GUI.maskBar = 0
          GUI.faceshieldBar = 0
          GUI.ppeBar = 0
          Player.alcoholCollected = true
          Player.faceshieldCollected = false
          Player.maskCollected = false
          Player.ppeCollected = false
          return true
        else
          instance.toBeRemoved = false
          Player.alcoholCollected = false
          GUI.isDisplayAlcohol = false
          GUI.alcoholBar = 0
          instance.physics.fixture:setMask(1)
          return false
        end
      end
    end
  end
end

return Alcohol
