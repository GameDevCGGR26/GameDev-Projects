Cutscene2State = Class{__includes = BaseState}

require 'src/cutscenes/cutscene2'


function Cutscene2State:init()
    Map:clean()
    Map:init() -- load first

    self:loadAssets()
	dialog_finished3 = false
	gSounds['level1']:stop()
  gSounds['level2']:stop()
end

function Cutscene2State:loadAssets()
    self.animation = {state}

    self.animation = Animation {
        frames = {1,2,3,4,5},
        interval = 1.5,
    }

    self.currentAnimation = self.animation
end

function Cutscene2State:enter()
    next_text = 1
    x = 1
    gSounds['level2']:stop()

    gSounds['bgm2']:setLooping(true)
	gSounds['bgm2']:setVolume(0.25)
	gSounds['bgm2']:play()

end

function Cutscene2State:update(dt)


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
			next_text = 16
			x = 16

        end
    end

    if next_text == 17 then
    gSounds['bgm2']:stop()
		gStateMachine:change('play2')

	Map:next()


    gSounds['level3']:setLooping(true)
    gSounds['level3']:setVolume(0.5)
    gSounds['level3']:play()
    end

    self.currentAnimation:update(dt)

    if self.currentAnimation.currentFrame == 5 then
      	dialog_finished3 = true
    end

end

function Cutscene2State:render()

	love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)

	if next_text == 1 or next_text == 3 or next_text == 4 then
		love.graphics.draw(gTextures.crowd, 0, 0, 0, 5, 5)
		love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)
	end

	if next_text == 13 then
		love.graphics.draw(gTextures.road, -100, -100, 0, 5.5, 4.8)
		love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)
	end

	if next_text == 14 or next_text == 15 then
		if dialog_finished3 == false then
			if self.currentAnimation.currentFrame < 5 then
				love.graphics.draw(gTextures.bigboss, gFrames.bigboss[self.currentAnimation:getCurrentFrame()], 0, 0, 0, 5, 5.3)
				love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)
			end
		else
			love.graphics.draw(gTextures.bigboss5, 0, 0, 0, 5, 5.3)
			love.graphics.draw(gTextures.dialogboxcs, 0, WINDOW_HEIGHT - 200, 0, 1, 1)
		end
	end

	if dialogue_Cutscene2[next_text] ~= nil then
		if next_text == x then
			love.graphics.setFont(gFonts.xxsmall)
			love.graphics.setColor(1, 1, 1, 1)
			love.graphics.printf(dialogue_Cutscene2[next_text], 100, 475, WINDOW_WIDTH - 170, 'left')
		end
	end

	love.graphics.printf("Press s to skip", 20, 670, WINDOW_WIDTH, 'left')

	love.graphics.printf("Press x for previous", 10, 670, WINDOW_WIDTH, 'center')

	love.graphics.printf("Press Spacebar to continue", -20, 670, WINDOW_WIDTH, 'right')

end
