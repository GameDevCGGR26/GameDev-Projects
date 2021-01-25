
local Map = {}
-- local STI = require("sti")
-- local Coin = require("coin")
-- local Spike = require("spike")
-- local Stone = require("stone")
-- local Enemy = require("enemy")
-- local Player = require("player")


function Map:load()
   self.currentLevel = 1
   World = love.physics.newWorld(0, 0)
   World:setCallbacks(beginContact, endContact)

   self:init()
end

function Map:init()
   self.level = STI("map/level1.lua", {"box2d"})

   self.level:box2d_init(World)
   self.entityLayer = self.level.layers.entity

   MapWidth = self.level.width * self.level.tilewidth
   MapHeight = self.level.height * self.level.tileheight

   --self:spawnEntities()
  -- self:spawBreakables()
   self:spawObjects()
end

function Map:backGround()
   if self.currentLevel == 1  then
      return gTextures.background
   end
end

function Map:positionCamera(player, camera)
   local halfScreen =  VIRTUAL_WIDTH / 2

   if Player.x < (MapWidth - halfScreen) then
      boundX = math.max(0, Player.x - halfScreen) -- lock camera at the left side of the screen.
   else
      boundX = math.min(Player.x - halfScreen, MapWidth - VIRTUAL_WIDTH) -- lock camera at the right side of the screen
   end

   Camera:setPosition(boundX, 0)
end

function Map:next()
   self:clean()
   self.currentLevel = self.currentLevel + 1
   self:init()
   Player:resetPosition()
end

function Map:clean()
   self.level:box2d_removeLayer("solid")
  -- Coin.removeAll()


end

function Map:update(dt)
   if Player.x > MapWidth - 16 then
      self:next()
   end

   if Player.y > MapHeight then
      Player:die()
      self:spawObjects()
   end
end

function Map:spawnEntities()
	for i,v in ipairs(self.entityLayer.objects) do
		if v.type == "slime" then
         Slime:load(v.x + v.width / 2, v.y + v.height / 2)
      elseif v.type == 'player' then
         Player:load(v.x, v.y)
		end
	end
end

function Map:spawObjects()
   for i,v in ipairs(self.entityLayer.objects) do
      if v.type == "key" then
         Key:load(v.x, v.y)
		end
	end
end

function Map:spawBreakables()
   for i,v in ipairs(self.entityLayer.objects) do
		if v.type == "breakable" then
         Breakable.new(v.x , v.y)
		end
	end
end

return Map
