
CharacterSelectState = Class{__includes = BaseState}

charNum = 1
function CharacterSelectState:init()
    self.currentChar = 1
    gSounds['bgm1']:setLooping(true)
    gSounds['bgm1']:setVolume(0.25)
    gSounds['bgm1']:play()

    if self.currentChar == 1 then
      self.charName = 'Cesca'

    elseif self.currentChar == 2 then
      self.charName = 'Chelsea'

    elseif self.currentChar == 3 then
      self.charName = 'Lois'

    elseif self.currentChar == 4 then
      self.charName = 'Daniel'
    end
end

function CharacterSelectState:update(dt)
    if self.currentChar == 1 then
        charNum = 1
    elseif self.currentChar == 2 then
        charNum = 2
    elseif self.currentChar == 3 then
        charNum = 3
    elseif self.currentChar == 4 then
        charNum = 4
    end
    if love.keyboard.wasPressed("left" or "a") then
        if self.currentChar == 1 then
            charNum = 1
            gSounds['select1']:play()
        else
            self.currentChar = self.currentChar - 1
            gSounds['select1']:play()
        end
    elseif love.keyboard.wasPressed("right" or "d") then
        if self.currentChar == 4 then
            charNum = 4
            gSounds['select2']:play()
        else
            self.currentChar = self.currentChar + 1
            gSounds['select2']:play()
        end
    end

    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        gStateMachine:change('play')
        gSounds['bgm1']:stop()
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end
end

function CharacterSelectState:render()
    love.graphics.draw(gTextures.bgcharselect, 0, 0, 0, 5, 5)

    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Select your Character with left and right!", 0, 30,
        WINDOW_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf("(Press Enter to continue!)", 0, 80,
        WINDOW_WIDTH, 'center')
    love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200)
    love.graphics.setColor(1, 1, 1, 1)
    if charNum == 1 then
        love.graphics.draw(gTextures.selecttool, 184, 160)

        love.graphics.draw(gTextures.hero1Inw, 210, 170, 0, 7, 7)
        love.graphics.draw(gTextures.hero2I, 460, 210, 0, 5, 5)
        love.graphics.draw(gTextures.hero3I, 710, 210, 0, 5, 5)
        love.graphics.draw(gTextures.hero4I, 960, 210, 0, 5, 5)
        love.graphics.printf("\t\tFrancesca,", 0, 548, WINDOW_WIDTH, 'left')
        love.graphics.printf("Has the most advantage powerup HP \nwhen collecting powerups.", 0, 598, WINDOW_WIDTH, 'center')
    elseif charNum == 2 then
        love.graphics.draw(gTextures.selecttool, 433, 160)

        love.graphics.draw(gTextures.hero1I, 210, 210, 0, 5, 5)
        love.graphics.draw(gTextures.hero2Inw, 450, 170, 0, 7, 7)
        love.graphics.draw(gTextures.hero3I, 710, 210, 0, 5, 5)
        love.graphics.draw(gTextures.hero4I, 960, 210, 0, 5, 5)
        love.graphics.printf("\t\tChelsea,", 0, 548, WINDOW_WIDTH, 'left')
        love.graphics.printf("The timer increases by 10 seconds \nin every powerup collected.", 0, 598, WINDOW_WIDTH, 'center')
    elseif charNum == 3 then
        love.graphics.draw(gTextures.selecttool, 680, 160)

        love.graphics.draw(gTextures.hero1I, 210, 210, 0, 5, 5)
        love.graphics.draw(gTextures.hero2I, 460, 210, 0, 5, 5)
        love.graphics.draw(gTextures.hero3Inw, 700, 170, 0, 7, 7)
        love.graphics.draw(gTextures.hero4I, 960, 210, 0, 5, 5)
        love.graphics.printf("\t\tLois,", 0, 560, WINDOW_WIDTH, 'left')
        love.graphics.printf("Has the most advantage number of health.", 0, 610, WINDOW_WIDTH, 'center')
    elseif charNum == 4 then
        love.graphics.draw(gTextures.selecttool, 930, 160)

        love.graphics.draw(gTextures.hero1I, 210, 210, 0, 5, 5)
        love.graphics.draw(gTextures.hero2I, 460, 210, 0, 5, 5)
        love.graphics.draw(gTextures.hero3I, 710, 210, 0, 5, 5)
        love.graphics.draw(gTextures.hero4Inw, 940, 170, 0, 7, 7)
        love.graphics.printf("\t\tDaniel,", 0, 560, WINDOW_WIDTH, 'left')
        love.graphics.printf("Always have a stock of masks.", 0, 610, WINDOW_WIDTH, 'center')
    end
end
