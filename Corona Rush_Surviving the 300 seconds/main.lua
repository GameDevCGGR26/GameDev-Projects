--size of the actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
--size trying to emulate with push
VIRTUAL_HEIGHT = 144
VIRTUAL_WIDTH = 256

love.graphics.setDefaultFilter('nearest', 'nearest')

require 'src/Dependencies'

playing = true
titleState = true

function love.load()

  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = false,
    vsync = true
  })

  Map = STI("map/level1.lua", {"box2d"}) --loads the map from tiled software
  World = love.physics.newWorld(0, 0)  --creates the world
 World:setCallbacks(beginContact, endContact) --callbacks for character collision
  Map:box2d_init(World)
 Map.layers.solid.visible = false
  MapWidth = Map.width * Map.tilewidth
  MapHeight = Map.height * Map.tileheight

  gStateMachine = StateMachine {
    ['start'] = function() return StartState() end,
    ['play'] = function() return PlayState() end,
    ['game-over'] = function() return GameOverState() end,
    ['controls'] = function() return ControlState() end
  }
  gStateMachine:change('start')

  gSounds['level1']:setLooping(true)
  gSounds['level1']:setVolume(0.5)
  gSounds['level1']:play()


  love.keyboard.keysPressed = {}

  --background = love.graphics.newImage("assets/citybig.png")   --bg insert
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

function love.resize(w, h)
	push:resize(w, h)
	print(w, h)
end




function love.draw()    --map insert and bg
--push:start()
  gStateMachine:render()
 --push:finish()
end

function love.keypressed (key)
  love.keyboard.keysPressed[key] = true
  Player:jump(key)
  Player:fire(key)


end

function love.keyboard.wasPressed(key)
	return love.keyboard.keysPressed[key]
end

function  love.update(dt)
  	gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
  --backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt)
end

function beginContact (a, b, collision)
  gStateMachine:beginContact(a, b, collision)

end

function endContact (a, b, collision)
    	gStateMachine:endContact(a, b, collision)
end
