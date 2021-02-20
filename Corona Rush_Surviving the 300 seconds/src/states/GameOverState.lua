GameOverState = Class{__includes = BaseState}

function GameOverState:init()
  self.color = { red = 1, green = 1, blue = 1}

  self:loadAssets()
end

function GameOverState:enter()

end

function GameOverState:loadAssets()
	self.animation = Animation {
		frames = {1,2,3,2},
		interval = 0.6,
	}
	self.currentAnimation = self.animation
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
        gSounds['level1']:stop()
        gSounds['death']:stop()
        gSounds['mainmenu']:setLooping(true)
        gSounds['mainmenu']:setVolume(0.5)
        gSounds['mainmenu']:play()
    end

    if love.keyboard.wasPressed('space') then
        gStateMachine:change('play')
    end
      self.currentAnimation:update(dt)
end

function GameOverState:render()
  love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
  love.graphics.draw(
  gTextures.gameoverbg, gFrames.gameoverbg[self.currentAnimation:getCurrentFrame()],
  0, 0, 0, 5, 5)

    love.graphics.setFont(gFonts.small)
    love.graphics.printf('You have failed to save the humanity!', 290, 450, 1000)
    love.graphics.printf('Press ENTER to Go to MAIN MENU', 150, 550, 1000, 'center')
    love.graphics.printf('Press SPACE to RESTART', 150, 600, 1000, 'center')
end

function GameOverState:beginContact(a, b, collision)

end

function GameOverState:endContact(a, b, collision)

end
