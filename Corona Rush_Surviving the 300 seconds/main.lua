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
      ['start2'] = function() return StartState2() end,
  		['play'] = function() return PlayState() end,
      ['play2'] = function() return PlayState2() end,
      ['play3'] = function() return PlayState3() end,
  		['game-over'] = function() return GameOverState() end,
  		['next-level'] = function() return NextLevelState() end,
  		['how2play'] = function() return HowToPlayState() end,
  		['cutscene1'] = function() return Cutscene1State() end,
      ['cutscene12'] = function() return Cutscene1State2() end,
  		['cutscene2'] = function() return Cutscene2State() end,
  		['cutscene3'] = function() return Cutscene3State() end,
  --		['highscore'] = function() return HighScoreState() end,
  		['end-credit'] = function() return EndCreditState() end,
      ['char-select2'] = function() return CharacterSelectState2() end,
  		['char-select'] = function() return CharacterSelectState() end
  	}
    	gStateMachine:change('start')

  	love.keyboard.keysPressed = {}
end

function love.resize(w, h)
	push:resize(w, h)
	print(w, h)
end

function love.draw()

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
