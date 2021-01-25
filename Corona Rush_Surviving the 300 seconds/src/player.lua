
local Player = {}

function Player:load(x, y)
  self.x = 100
  self.y = 0

  -- starting position when player falls
self.startX = self.x
self.startY = self.y

self.width = 25
self.height = 45

self.dx = 0
self.dy = 0

self.maxSpeed = 200
self.acceleration = 4000
self.friction = 3500
self.gravity = 1700

self.jumpAmount = -540
self.coins = 0
self.powerups = 0
self.health = {current = 3, max = 3}

self.direction = 'right'
self.state = 'idle'

self.color = { red = 1, green = 1, blue = 1, speed = 3}

self.alive = true
self.grounded = false

self:loadAssets() --using .physics to load the character

self.character = {}
self.character.body = love.physics.newBody(World, self.x, self.y, "dynamic")
self.character.body:setFixedRotation(true)
self.character.shape = love.physics.newRectangleShape(self.width * 0.5, self.height * 0.85)
self.character.fixture = love.physics.newFixture(self.character.body, self.character.shape)
self.character.body:setGravityScale(0)

self.powerup = {}
self.maskCollected = false
self.faceshieldCollected = false
self.alcoholCollected = false
self.ppeCollected = false
end

function Player:loadAssets()   ---just like in colton's code using Dependencies
self.animation = {state}

self.animation.idle = Animation {
   frames = {1},
   interval = 0.1,
   width = self.width,
   height = self.height
}

self.animation.run = Animation {
   frames = {2, 3, 4, 5},
   interval = 0.1,
   width = self.width,
   height = self.height
}

self.animation.jump = Animation {
   frames = {6},
   interval = 0.1,
   width = self.width,
   height = self.height
}

self.currentAnimation = self.animation[self.state]
end

function Player:takeDamage(amount)
   self:tintRed()
   if self.health.current - amount > 0 then
      self.health.current = self.health.current - amount
   else
      self.health.current = 0
      self:die()
   end
end

function Player:die()
   self.alive = false
   GUI.isDisplay = false
end

function Player:lose()
   gStateMachine:change('game-over')
   self:resetPosition()
end

function Player:respawn()
   if not self.alive then
      self:resetPosition()
      self.health.current = self.health.max
      self.alive = true
   end
end

function Player:resetPosition()
   self.character.body:setPosition(self.startX, self.startY)
end

function Player:tintRed()
   self.color.green = 0
   self.color.blue = 0
end

function Player:incrementCoins()
   self.coins = self.coins + 1
end

function Player:update(dt)
  self:syncPhysics()
  self:move(dt)
  self:applyGravity(dt)
  self.currentAnimation:update(dt)
  self:setDirection()
  self:setState()
  self:jump()
  self:unTint(dt)
  self:respawn()

  if self.y > MapHeight then
  self:resetPosition()
  end
  
  if TIMERS == 0 then
   self:lose()
  end
  
end

function Player:unTint(dt)
   self.color.red = math.min(self.color.red + self.color.speed * dt, 1)
   self.color.green = math.min(self.color.green + self.color.speed * dt, 1)
   self.color.blue = math.min(self.color.blue + self.color.speed * dt, 1)
end


function Player:setState()
   if not self.grounded then
      self.state = "jump"
      self.currentAnimation = self.animation[self.state]
   elseif self.dx == 0 then
      self.state = "idle"
      self.currentAnimation = self.animation[self.state]
   else
      self.state = "run"
      self.currentAnimation = self.animation[self.state]
   end
end


function Player:setDirection()
   if self.dx < 0 then
      self.direction = "left"
   elseif self.dx > 0 then
      self.direction = "right"
   end
end


function Player:applyGravity(dt)   --gravity applied
  if not self.grounded then
     self.dy = self.dy + self.gravity * dt
  end
end


function Player:move(dt)  --character controls
   if love.keyboard.isDown("d", "right") then
      self.dx = math.min(self.dx + self.acceleration * dt, self.maxSpeed)
   elseif love.keyboard.isDown("a", "left") then
      self.dx = math.max(self.dx - self.acceleration * dt, -self.maxSpeed)
   else
      self:applyFriction(dt)
   end
end


function Player:applyFriction(dt)  --friction/movemnt of character above ground
   if self.dx > 0 then
      self.dx = math.max(self.dx - self.friction * dt, 0)
   elseif self.dx < 0 then
      self.dx = math.min(self.dx + self.friction * dt, 0)
   end
end


function Player:syncPhysics ()   --knows the positon of the character at the map
  self.x, self.y = self.character.body:getPosition()
  self.character.body:setLinearVelocity(self.dx, self.dy)
end


function Player:beginContact(a, b, collision)   --collision of character
   if self.grounded == true then return end
   local nx, ny = collision:getNormal()
   if a == self.character.fixture then
      if ny > 0 then
         self:land(collision)
      elseif ny < 0 then
         self.dy = 0
      end
   elseif b == self.character.fixture then
      if ny < 0 then
         self:land(collision)
      elseif ny > 0 then
         self.dy = 0
      end
   end
end


function Player:land(collision)  --land collision of character
   self.currentGroundCollision = collision
   self.dy = 0
   self.grounded = true
end


function Player:jump(key)
   if (key == "w" or key == "up") and self.grounded then
      self.dy = self.jumpAmount
      self.grounded = false
      gSounds['jump']:play()
   end
end


function Player:fire(key)
      if self.alcoholCollected == true then
         key = "space"
      end
end
function Player:endContact(a, b, collision)   --characternot colliding with anything rather than the ground
   if a == self.character.fixture or b == self.character.fixture then
      if self.currentGroundCollision == collision then
         self.grounded = false
      end
   end
end


function Player:draw()   --1.5 bcoz 1 makes the character too small
   local scaleX = 1.5
   if self.direction == "left" then
      scaleX = -1.5
   end

   love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
      if self.faceshieldCollected == true then
         love.graphics.draw(
         gTextures.heroF, gFrames.heroF[self.currentAnimation:getCurrentFrame()],
         self.x, self.y, 0, scaleX, 1.5, self.currentAnimation.width/1.5, self.currentAnimation.height/1.5
         )
      elseif self.ppeCollected == true then
         love.graphics.draw(
         gTextures.heroP, gFrames.heroP[self.currentAnimation:getCurrentFrame()],
         self.x, self.y, 0, scaleX, 1.5, self.currentAnimation.width/1.5, self.currentAnimation.height/1.5
         )
      elseif self.maskCollected == true then
         love.graphics.draw(
         gTextures.heroM, gFrames.heroM[self.currentAnimation:getCurrentFrame()],
         self.x, self.y, 0, scaleX, 1.5, self.currentAnimation.width/1.5, self.currentAnimation.height/1.5
         )
      else
         if self.alcoholCollected == true and love.keyboard.isDown('space') then
            love.graphics.draw(gTextures.heroA, self.x, self.y, 0, scaleX, 1.5, self.currentAnimation.width/1.5, self.currentAnimation.height/1.5
            )
         elseif self.alcoholCollected == true then
            love.graphics.draw(
            gTextures.hero, gFrames.hero[self.currentAnimation:getCurrentFrame()],
            self.x, self.y, 0, scaleX, 1.5, self.currentAnimation.width/1.5, self.currentAnimation.height/1.5
            )  --1.7 is the divisor to offset the 1.5 scale of the character
         else
            love.graphics.draw(
            gTextures.hero, gFrames.hero[self.currentAnimation:getCurrentFrame()],
            self.x, self.y, 0, scaleX, 1.5, self.currentAnimation.width/1.5, self.currentAnimation.height/1.5
            ) --1.7 is the divisor to offset the 1.5 scale of the character
         end
      end
   love.graphics.setColor(1,1,1,1)
end

return Player
