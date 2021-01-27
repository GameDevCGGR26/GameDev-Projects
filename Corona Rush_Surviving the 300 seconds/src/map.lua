
local Map = {}
-- local STI = require("sti")
-- local Coin = require("coin")
-- local Spike = require("spike")
-- local Stone = require("stone")
-- local Enemy = require("enemy")
-- local Player = require("player")


function Map:load()
  self.currentLevel = 1
  World = love.physics.newWorld(0,2000)
  World:setCallbacks(beginContact, endContact)

  self:init()
end

function Map:init()
   self.level = STI("map/"..self.currentLevel..".lua", {"box2d"})

   self.level:box2d_init(World)
   self.entityLayer = self.level.layers.entity
   self.objLayer = self.level.layers.obj
   MapWidth = self.level.width * self.level.tilewidth
   MapHeight = self.level.height * self.level.tileheight






   self:spawnEntities()
  -- self:spawBreakables()
   self:spawnObjects()
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

   --self.currentLevel = self.currentLevel + 1
  -- if self.testingcenters == 1 then
    self:clean()
    gStateMachine:change('next-level')
   --self:init()
  -- Player:resetPosition()
--end
end

function Map:clean()
   self.level:box2d_removeLayer("solid")
  -- Coin.removeAll()


end

function Map:update(dt)
   if Player.x > MapWidth - 16 then
      self:next()
   end
   if Player.testingc == true then
     self:next()
   end
end



function Map:spawnEntities()
  for i,v in ipairs(self.entityLayer.objects) do
    if v.type == "enemy" then
      print('spawn')
      Virus:load(v.x + v.width / 2, v.y + v.height)
    end
  end
end

function Map:spawnObjects()
   for i,v in ipairs(self.objLayer.objects) do
     if v.type == "coin" then
       Coin:new(v.x, v.y)
     end
     if v.type == "mask" then
       Mask:new(v.x, v.y)
     end
     if v.type == "faceshield" then
       Faceshield:new(v.x, v.y)
     end
     if v.type == "ppe" then
       Ppe:new(v.x, v.y)
     end
     if v.type == "alcohol" then
       Alcohol:new(v.x, v.y)
     end
     if v.type == "testingcenter" then
       print('spawn')
      TestingCenter:new(v.x + v.width / 2, v.y + v.height)
     end
	end
end


return Map
