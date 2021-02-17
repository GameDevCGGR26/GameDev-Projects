--size of the actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

--size trying to emulate with push
VIRTUAL_HEIGHT = 144
VIRTUAL_WIDTH = 256

BACKGROUND_SCROLL = 0

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

	gStateMachine = StateMachine {
		['start'] = function() return StartState() end,
		['play'] = function() return PlayState() end,
		['game-over'] = function() return GameOverState() end,
		['next-level'] = function() return NextLevelState() end,
		['controls'] = function() return ControlState() end
	}
  	gStateMachine:change('start')

	gSounds['level1']:setLooping(true)
	gSounds['level1']:setVolume(0.5)
	gSounds['level1']:play()

  	love.keyboard.keysPressed = {}
end

function love.resize(w, h)
	push:resize(w, h)
	print(w, h)
end

function love.draw()    --map insert and bg

  gStateMachine:render()

end

function love.keypressed (key)
	love.keyboard.keysPressed[key] = true
	Player:jump(key)
	Player:fire(key)
end

function love.keyboard.wasPressed(key)
	return love.keyboard.keysPressed[key]
end

function love.update(dt)
  	gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function beginContact (a, b, collision)
  	gStateMachine:beginContact(a, b, collision)

end

function endContact (a, b, collision)
 	gStateMachine:endContact(a, b, collision)
end
