local TestingCenter = {}
TestingCenter.__index = TestingCenter
ActiveTestingCenters = {}

function TestingCenter:new (x,y)
local  instance = setmetatable ({}, TestingCenter)
  instance.x = x
  instance.y = y
  --instance.img = love.graphics.newImage("assets/TestingCenter.png")
  instance.width = 80
  instance.height = 40
  instance.scaleX = 1
  instance.randomTimeOffset = math.random(0, 100)
  instance.toBeRemoved = false

  instance:loadAssets()
  instance.physics = {}
  instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "static")
  instance.physics.shape = love.physics.newRectangleShape(instance.width, instance.height)
  instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
  instance.physics.fixture:setSensor(true)
  table.insert(ActiveTestingCenters, instance)
  end

function TestingCenter:loadAssets()
 self.animation = Animation {
   frames = {1},
   interval = 0.5,
  }
 self.currentAnimation = self.animation
end

function TestingCenter:remove ()
  for i,instance in ipairs(ActiveTestingCenters) do
    if instance == self then
      self.physics.body:destroy()
      table.remove(ActiveTestingCenters, i)
    end
  end
end

function TestingCenter:update (dt)
  self.currentAnimation:update(dt)
  self:checkRemove()
  self:checkNumber()
end

function TestingCenter:checkNumber()
  if #ActiveTestingCenters > 1 then
     self:remove()
  end
end

function TestingCenter:checkRemove ()
  if self.toBeRemoved then
   self:remove()
  end
end

function TestingCenter:spin (dt)
self.scaleX = math.sin(love.timer.getTime() * 2 + self.randomTimeOffset)
end

function TestingCenter:draw ()
  love.graphics.draw(
  gTextures.testingcenter, gFrames.testingcenter[self.currentAnimation:getCurrentFrame()],
      self.x, self.y, 0, scaleX, 1, self.width/2, self.height/2
   )
end

function TestingCenter.updateAll (dt)
  for i,instance in ipairs(ActiveTestingCenters) do
      instance:update(dt)
  end
end

function TestingCenter.drawAll ()
  for i,instance in ipairs(ActiveTestingCenters) do
      instance:draw()
  end
end

function TestingCenter.beginContact (a, b, collision)
  for i,instance in ipairs(ActiveTestingCenters) do
    if a == instance.physics.fixture or b == instance.physics.fixture then
      if a == Player.character.fixture or b == Player.character.fixture then
        Player.testingc = true
        gSounds['congrats']:play()
          return true
      end
    end
  end
end

return TestingCenter
