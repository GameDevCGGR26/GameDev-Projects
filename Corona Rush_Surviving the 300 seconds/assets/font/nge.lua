local Virus = {}
Virus.__index = Virus

local ActiveVirus = {}

function Virus:load(x, y)
   local self = setmetatable({}, Virus)
   self.x = x
   self.y = y

   self.width = 32
   self.height = 32

   self.speed = 100
   self.speedMod = 1
   self.dx = self.speed

   self.speedCounter = 0
   self.speedTrigger = 2

   self.damage = 1

   self.color = {
      blue = 1,
      red = 1,
      green = 1,
      speed = 3
   }

   self.state = 'walk'

   self:loadAssets()

   self.Virus = {}
   self.Virus.body = love.physics.newBody(World, self.x, self.y, 'dynamic')
   self.Virus.body:setFixedRotation(true)
   self.Virus.body:setMass(25)
   self.Virus.shape = love.physics.newRectangleShape(self.width * 0.4, self.height * 0.75)
   self.Virus.fixture = love.physics.newFixture(self.Virus.body, self.Virus.shape)

   table.insert(ActiveVirus, self)
end

function Virus:loadAssets()
   self.animation = {state}

   self.animation.walk = Animation {
      frames = {1,2,3,4},
      interval = 0.1,
      width = self.width,
      height = self.width
   }

   self.animation.run = Animation {
      frames = {1,2,3,4},
      interval = 0.1,
      width = self.width,
      height = self.width
   }

   self.currentAnimation = self.animation[self.state]
end

function Virus.removeAll()
   for i,v in ipairs(ActiveVirus) do
      v.Virus.body:destroy()
   end

   ActiveVirus = {}
end

--[[function Virus:changeColor()
    self.color.blue = 0
    self.color.green = 0
end]]--

function Virus:increaseSpeed()
   self.speedCounter = self.speedCounter + 1
   if self.speedCounter > self.speedTrigger then
      self.state = 'run'
      self.currentAnimation = self.animation[self.state]
      self.speedMod = 2
      self.speedCounter = 0
   else
      self.currentAnimation = self.animation[self.state]
      self.speedMod = 1
   end
end

--[[function Virus:normalColor(dt)
   self.color.red = math.min(self.color.red + self.color.speed * dt, 1)
   self.color.green = math.min(self.color.green + self.color.speed * dt, 1)
   self.color.blue = math.min(self.color.blue + self.color.speed * dt, 1)
end]]--

function Virus:update(dt)
    self:syncPhysics()
    self.currentAnimation:update(dt)
    --self:normalColor(dt)
 end

function Virus:flipDirection()
   self.dx = -self.dx
end

function Virus:syncPhysics()
   self.x, self.y = self.Virus.body:getPosition()
   self.Virus.body:setLinearVelocity(self.dx * self.speedMod, 100)
end

function Virus:draw()
   local scaleX = 1
   if self.dx < 0 then
      scaleX = -1
   end
   love.graphics.setColor(self.color.blue, self.color.red, self.color.green)
   love.graphics.draw(
      gTextures.virus, gFrames.virus[self.currentAnimation:getCurrentFrame()],
      self.x, self.y, 0, scaleX, 1, self.currentAnimation.width/2, self.currentAnimation.height/2
   )
   love.graphics.setColor(1,1,1,1)
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
      if a == instance.Virus.fixture or b == instance.Virus.fixture then
         if a == Player.character.fixture or b == Player.character.fixture then
            Player:takeDamage(instance.damage)
         end
        instance:increaseSpeed()
         instance:flipDirection()
      end
   end
end

return Virus
