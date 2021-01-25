local Ppe = {}
Ppe.__index = Ppe
ActivePpes = {}

function Ppe:new (x,y)
local  instance = setmetatable ({}, Ppe)
instance.x = x
instance.y = y
--instance.img = love.graphics.newImage("assets/mask.png")
instance.width = 32
instance.height = 32
instance.scaleX = 1
instance.randomTimeOffset = math.random(0, 100)
instance.toBeRemoved = false

instance:loadAssets()
instance.physics = {}
instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "static")
instance.physics.shape = love.physics.newRectangleShape(instance.width, instance.height)
instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
instance.physics.fixture:setSensor(true)
table.insert(ActivePpes, instance)
end

function Ppe:loadAssets()
 self.animation = Animation {
   frames = {1,2},
   interval = 0.5,
  }
 self.currentAnimation = self.animation
end

function Ppe:remove ()
  for i,instance in ipairs(ActivePpes) do
    if instance == self then
      --Player:incrementPowerups()
      self.physics.body:destroy()
      table.remove(ActivePpes, i)
    end
  end
end

function Ppe:update (dt)
--self:spin(dt)
self.currentAnimation:update(dt)
self:checkRemove()
end

function Ppe:checkRemove ()
  if self.toBeRemoved then
   self:remove()
  end
end

--function Mask:spin (dt)
--self.scaleX = math.sin(love.timer.getTime() * 2 + self.randomTimeOffset)
--end

function Ppe:draw ()
  -- love.graphics.draw(self.img, self.x, self.y, 0, self.scaleX, 1, self.width/2, self.height/2)
  love.graphics.draw(
  gTextures.ppe, gFrames.ppe[self.currentAnimation:getCurrentFrame()],
      self.x, self.y, 0, scaleX, 1, self.width/2, self.height/2
   )
end

function Ppe.updateAll (dt)
  for i,instance in ipairs(ActivePpes) do
      instance:update(dt)
  end
end

function Ppe.drawAll ()
  for i,instance in ipairs(ActivePpes) do
      instance:draw()
  end
end

function Ppe.beginContact (a, b, collision)
  for i,instance in ipairs(ActivePpes) do
    if a == instance.physics.fixture or b == instance.physics.fixture then
      if a == Player.character.fixture or b == Player.character.fixture then
        if GUI.ppeBar == 0 then
          instance.toBeRemoved = true
          GUI.isDisplayPPE = true
          GUI.isDisplayAlcohol = false
          GUI.isDisplayFaceshield = false
          GUI.isDisplayMask = false
          GUI.ppeBar = 1
          GUI.maskBar = 0
          GUI.faceshieldBar = 0
          GUI.alcoholBar = 0
          Player.alcoholCollected = false
          Player.faceshieldCollected = false
          Player.maskCollected = false
          Player.ppeCollected = true
          return true
        else
          instance.toBeRemoved = false
          Player.ppeCollected = false
          GUI.isDisplayPPE = false
          GUI.ppeBar = 0
          instance.physics.fixture:setMask(1)
          return false
        end
      end
    end
  end
end

return Ppe
