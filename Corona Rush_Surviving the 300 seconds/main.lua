--size of the actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
--size trying to emulate with push
VIRTUAL_HEIGHT = 144
VIRTUAL_WIDTH = 256

love.graphics.setDefaultFilter('nearest', 'nearest')

require 'src/Dependencies'


function love.load()
  Map = STI("map/level1.lua", {"box2d"}) --loads the map from tiled software
  World = love.physics.newWorld(0, 0)  --creates the world
  World:setCallbacks(beginContact, endContact) --callbacks for character collision
  Map:box2d_init(World)
  Map.layers.solid.visible = false
  MapWidth = Map.width * Map.tilewidth
  MapHeight = Map.height * Map.tileheight

  background = love.graphics.newImage("assets/citybig.png")   --bg insert
  GUI:load()
  Player:load()
  Coin:new(400,100)
  Coin:new(2895,170)
  Coin:new(5000,230)

  Mask:new(3300,160)
  Mask:new(830,130)

  Faceshield:new(4450,150)

  Ppe:new(1380,150)

  Alcohol:new(2260,170)

end

function  love.update(dt)
    World:update(dt)
    Player:update(dt)
    Coin.updateAll(dt)
    Mask.updateAll(dt)
    Faceshield.updateAll(dt)
    Ppe.updateAll(dt)
    Alcohol.updateAll(dt)
    GUI:update(dt)

    Camera:setPosition(Player.x, 0)
  --backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
end

function love.draw()    --map insert and bg
  love.graphics.draw(gTextures.background, 0, 0, 0, 4, 3.5)
  Map:draw(-Camera.x, -Camera.y, Camera.scale, Camera.scale)

  Camera:apply()
    Player:draw()
    Coin.drawAll()
    Mask.drawAll()
    Faceshield.drawAll()
    Ppe.drawAll()
    Alcohol.drawAll()
  Camera:clear()

    GUI:draw()
end

function love.keypressed (key)
  Player:jump(key)
  Player:fire(key)
  if key == 'escape' then
    love.event.quit()
  end
end

function beginContact (a, b, collision)
  if Coin:beginContact(a,b, collision) then return end
  if Mask.beginContact(a,b, collision) then return end
  if Faceshield.beginContact(a,b, collision) then return end
  if Ppe.beginContact(a,b, collision) then return end
  if Alcohol.beginContact(a,b, collision) then return end
  Player:beginContact (a, b, collision)
end

function endContact (a, b, collision)
    Player:endContact (a, b, collision)
end
