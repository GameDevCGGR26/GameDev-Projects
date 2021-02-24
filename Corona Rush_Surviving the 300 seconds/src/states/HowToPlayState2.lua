
HowToPlayState2 = Class{__includes = BaseState}

--charNum = 1
function HowToPlayState2:init()
    self.currentChar = 1
    self.color = { red = 1, green = 1, blue = 1}

    self:loadAssets()
end

function HowToPlayState2:loadAssets()
  self.animation = {state}
	self.animation = Animation {
		frames = {1,2,3,2},
		interval = 0.4,
	}
	self.currentAnimation = self.animation
end

function HowToPlayState2:update(dt)
    if self.currentChar == 1 then
        charNum = 1
    elseif self.currentChar == 2 then
        charNum = 2
    elseif self.currentChar == 3 then
        charNum = 3
    end
    if love.keyboard.wasPressed("left") then
        if self.currentChar == 1 then
            charNum = 1
            gSounds['select1']:play()
        else
            self.currentChar = self.currentChar - 1
            gSounds['select1']:play()
        end

    elseif love.keyboard.wasPressed("a") then
        if self.currentChar == 1 then
            charNum = 1
            gSounds['select1']:play()
        else
            self.currentChar = self.currentChar - 1
            gSounds['select1']:play()
        end

    elseif love.keyboard.wasPressed("right") then
        if self.currentChar == 3 then
            charNum = 3
            gSounds['select2']:play()
        else
            self.currentChar = self.currentChar + 1
            gSounds['select2']:play()
        end

    elseif love.keyboard.wasPressed("d") then
        if self.currentChar == 3 then
            charNum = 3
            gSounds['select2']:play()
        else
            self.currentChar = self.currentChar + 1
            gSounds['select2']:play()
        end

    end

    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        gStateMachine:change('start2')
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start2')
    end

    self.currentAnimation:update(dt)
end

function HowToPlayState2:render()
  love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
  love.graphics.draw(
  gTextures.mainmenubg, gFrames.mainmenubg[self.currentAnimation:getCurrentFrame()],
  0, 0, 0, 5, 5)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Press left and right!", 0, 610,
        WINDOW_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf("(Press Escape to go back to the main menu!)", 0, 660,
        WINDOW_WIDTH, 'center')
  --  love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200)
    love.graphics.setColor(1, 1, 1, 1)
    if charNum == 1 then
      love.graphics.draw(gTextures.h2play1,  0, 0, 0, 5, 5)
    elseif charNum == 2 then
        love.graphics.draw(gTextures.h2play2,  0, 0, 0, 5, 5)
        love.graphics.setFont(gFonts['small'])
        love.graphics.printf("x1 Enemy \n Immunity", 150, 470,
            WINDOW_WIDTH, 'left')
        love.graphics.printf("x2 Enemy \n Immunity", 400, 500,
        WINDOW_WIDTH, 'left')
        love.graphics.printf("x4 Enemy \n Immunity", 660, 470,
        WINDOW_WIDTH, 'left')
        love.graphics.printf("+1 Health \nx2 sprays", 910, 470,
        WINDOW_WIDTH, 'left')
    elseif charNum == 3 then
        love.graphics.draw(gTextures.h2play3,  0, 0, 0, 5, 5)
        love.graphics.setFont(gFonts['small'])
        love.graphics.printf("   Acts as a \nScore Multiplier", 130, 470,
            WINDOW_WIDTH, 'left')
        love.graphics.printf("Avoid these! \n  -1 Health", 520, 470,
            WINDOW_WIDTH, 'left')
        love.graphics.setFont(gFonts['xsmall'])
        love.graphics.printf("     Reach this! \n to finish the level", 850, 520,
            WINDOW_WIDTH, 'left')
    end
end
