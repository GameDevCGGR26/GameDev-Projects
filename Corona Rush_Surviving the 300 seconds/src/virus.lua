local Virus = {}
Virus.__index = Virus

local ActiveVirus = {}

function Virus:load(x, y)
   local instance = setmetatable({}, Virus)
   instance.x = x
   instance.y = y

   instance.startX = instance.x
   instance.startY = instance.y

   instance.width = 32
   instance.height = 32
   instance.speed = 100
   instance.speedMod = 1
   instance.xVel = instance.speed

   instance.rageCounter = 0
   instance.rageTrigger = 3

   instance.damage = 1

   instance.state = 'walk'

   instance:loadAssets()

   instance.physics = {}
   instance.physics.body = love.physics.newBody(World, instance.x, instance.y, 'dynamic')
   instance.physics.body:setFixedRotation(true)
   instance.physics.body:setMass(25)
   instance.physics.shape = love.physics.newRectangleShape(instance.width * 0.4, instance.height * 0.75)
   instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)

   table.insert(ActiveVirus, instance)
end

function Virus:loadAssets()
   self.animation = {state}

   self.animation.walk = Animation {
      frames = {1, 2, 3, 4},
      interval = 0.3,
      width = self.width,
      height = self.height
   }

   self.animation.run = Animation {
      frames = {1, 2, 3, 4},
      interval = 0.3,
      width = self.width,
      height = self.height
   }

   self.currentAnimation = self.animation[self.state]
end

function Virus.removeAll()
   for i,v in ipairs(ActiveVirus) do
      v.physics.body:destroy()
   end

   ActiveVirus = {}
end

function Virus:resetPosition()
   if self.y > MapHeight then
      self.physics.body:setPosition(self.startX, self.startY)
   end
end

function Virus:update(dt)
    self:syncPhysics()
    self.currentAnimation:update(dt)
   self:resetPosition()
end

function Virus:flipDirection()
   self.xVel = -self.xVel
end

function Virus:syncPhysics()
   self.x, self.y = self.physics.body:getPosition()
   self.physics.body:setLinearVelocity(self.xVel * self.speedMod, 100)
end

function Virus:draw()
   local scaleX = 1
   if self.xVel < 0 then
      scaleX = -1
   end
   love.graphics.draw(
      gTextures.virus, gFrames.virus[self.currentAnimation:getCurrentFrame()],
      self.x, self.y, 0, scaleX, 1, self.currentAnimation.width/2, self.currentAnimation.height/2
   )
end

function Virus.updateAll(dt)
   for i,instance in ipairs(ActiveVirus) do
      instance:update(dt)
   end
end

function Virus.drawAll()
   for i,instance in ipairs(ActiveVirus) do
      instance:draw()
   end
end

function Virus.beginContact(a, b, collision)
   for i,instance in ipairs(ActiveVirus) do
      if a == instance.physics.fixture or b == instance.physics.fixture then
         if a == Player.character.fixture or b == Player.character.fixture then
            Player:takeDamage(instance.damage)
            gSounds['player-hurt']:play()
         end
         -- instance:incrementRage()
         instance:flipDirection()
      end
   end
end

return Virus
