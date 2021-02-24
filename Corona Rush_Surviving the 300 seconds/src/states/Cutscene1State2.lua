Cutscene1State2 = Class{__includes = BaseState}

require 'src/cutscenes/cutscene1'


function Cutscene1State2:init()
    gSounds['mainmenu']:stop()
    gSounds['news']:setLooping(true)
    gSounds['news']:setVolume(0.3)
    gSounds['news']:play()
    self:loadAssets()
    dialog_finished = false
    dialog_finished1 = false
end

function Cutscene1State2:enter()
    next_text = 1
 x = 1
end

function Cutscene1State2:loadAssets()
    self.animation = {state}

    self.animation.news = Animation {
        frames = {1,2,3,4},
        interval = 1.5,
    }

    self.animation.chaos = Animation {
        frames = {1,2,3,4},
        interval = 2,
    }

    self.animation.eyeopen = Animation {
        frames = {1,2,3,4,5,6,7,8,9,10,11,12,13,14},
        interval = 0.4,
    }

    self.animation.oxygen = Animation {
        frames = {1,2,3},
        interval = 0.1,
    }

    self.currentAnimation = self.animation[state]
end

function Cutscene1State2:update(dt)



    if next_text == 4 then
        gSounds['news']:stop()
    end

    if next_text == 5 then
        gSounds['bgm1']:setLooping(true)
        gSounds['bgm1']:setVolume(0.25)
        gSounds['bgm1']:play()
    end


    if next_text ~= nil then
        --if variable next_text exists
        if love.keyboard.wasPressed('space') then
        --controls user input to go to forward
            next_text = next_text + 1
         x = x + 1


        elseif love.keyboard.wasPressed('x') then
        --controls user input to go to back
            next_text = next_text - 1
         x = x - 1
      elseif love.keyboard.wasPressed('s') then
            next_text = 71
          x = 71
              gSounds['news']:stop()
        end

    end





    if next_text == 72 then
        gStateMachine:change('char-select2')
    end

    if self.animation.news.currentFrame == 4 then
        dialog_finished = true
    end

    if self.animation.eyeopen.currentFrame == 14 then
        dialog_finished1 = true
    end


    self:setState()

    self.currentAnimation:update(dt)
end

function Cutscene1State2:render()

    love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)

    if next_text == 1 or next_text == 2  then
        love.graphics.draw(gTextures.news1, 0, 0, 0, 5, 5)
    end

    if next_text == 3  then
        if dialog_finished == false then
          if self.animation.news.currentFrame < 4 then
            love.graphics.draw(gTextures.news, gFrames.news[self.currentAnimation:getCurrentFrame()], 0, 0, 0, 5, 5)
          end
        else
          love.graphics.draw(gTextures.news4, 0, 0, 0, 5, 5)
        end
    end

    if next_text == 6  then
        if dialog_finished1 == false then
          if self.animation.eyeopen.currentFrame < 14 then
            love.graphics.draw(gTextures.eyeopen, gFrames.eyeopen[self.currentAnimation:getCurrentFrame()], 0, 0, 0, 5, 5)
            love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)
          end
        else
          love.graphics.draw(gTextures.curtain, 0, 0, 0, 5, 5)
          love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)
        end
    end

    if next_text == 7 or next_text == 8 or next_text == 9 or next_text == 10 or next_text == 11 or
    next_text == 12 or next_text == 13 or next_text == 14 then
        love.graphics.draw(gTextures.curtain, 0, 0, 0, 5, 5)
        love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)
    end

    if next_text == 15 or next_text == 16 or next_text == 17 or next_text == 18 or
    next_text == 19 or next_text == 20 or next_text == 21 or next_text == 22 or next_text == 23 or
    next_text == 24 or next_text == 25 or next_text == 26 then

        love.graphics.draw(gTextures.oxygen, gFrames.oxygen[self.currentAnimation:getCurrentFrame()], 0, 0, 0, 5, 5)
        love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)
    end

    if next_text == 29 or next_text == 30 or next_text == 31  then
        love.graphics.draw(gTextures.friends, 0, 0, 0, 5, 5)
        love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)
    end

    if next_text == 37 or next_text == 38 or next_text == 39 or next_text == 40 or
    next_text == 41 or next_text == 42 or next_text == 43 or next_text == 44 or next_text == 45 or next_text == 46 then

        love.graphics.draw(gTextures.meet, 0, 0, 0, 5, 5)
        love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)
    end

    if next_text == 47 or next_text == 48 or next_text == 49 then
        love.graphics.draw(gTextures.window, 0, 0, 0, 5, 5)
        love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)
    end

    if next_text == 50 or next_text == 51 or next_text == 52 then
        love.graphics.draw(gTextures.chaos, gFrames.chaos[self.currentAnimation:getCurrentFrame()], 0, 0, 0, 5, 5)
        love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)
    end

    if next_text == 54 or next_text == 55 or next_text == 56 or next_text == 57 or next_text == 58 or next_text == 59
    or next_text == 60 or next_text == 61 or next_text == 62 or next_text == 63 or next_text == 64 or next_text ==
    65 or next_text == 66 or next_text == 67 or next_text == 68 or next_text == 69 or next_text == 70 or next_text == 71 then

        love.graphics.draw(gTextures.meet, 0, 0, 0, 5, 5)
        love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)
    end

    if dialogue_Cutscene1[next_text] ~= nil then
        if next_text == 1 or next_text == 2 or next_text == 3 then
            love.graphics.setFont(gFonts.xxsmall)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.print(dialogue_Cutscene1[next_text], 150, 500)
        elseif next_text == x then
            love.graphics.setFont(gFonts.xxsmall)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.printf(dialogue_Cutscene1[next_text], 100, 475, WINDOW_WIDTH - 170, 'left')
        end

    end

    love.graphics.printf("Press s to skip", 20, 680, WINDOW_WIDTH, 'left')

    love.graphics.printf("Press x for previous", 10, 680, WINDOW_WIDTH, 'center')

    love.graphics.printf("Press Spacebar to continue", -20, 680, WINDOW_WIDTH, 'right')
end

function Cutscene1State2:setState()
    if next_text == 1 then
	    self.state = "news"
	    self.currentAnimation = self.animation[self.state]
    elseif next_text == 6 then
        self.state = "eyeopen"
	    self.currentAnimation = self.animation[self.state]
    elseif next_text == 15 then
        self.state = "oxygen"
	    self.currentAnimation = self.animation[self.state]
    elseif next_text == 50 then
        self.state = "chaos"
	    self.currentAnimation = self.animation[self.state]
    end
end
