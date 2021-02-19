--[[
    GD50
    Super Mario Bros. Remake

    -- StartState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

StartState = Class{__includes = BaseState}

local highlighted = 1



function StartState:init()
self.transitionAlpha = 0
self.color = { red = 1, green = 1, blue = 1}

self:loadAssets()
end

function StartState:loadAssets()
	self.animation = Animation {
		frames = {1,2,3},
		interval = 0.4,
	}
	self.currentAnimation = self.animation
end

function StartState:update(dt)
    if love.keyboard.wasPressed('s' or 'down') then
        highlighted = highlighted + 1
        if highlighted > 3 then
            highlighted = 1
        end
        gSounds['select1']:play()
    elseif love.keyboard.wasPressed('w' or 'up') then
        highlighted = highlighted - 1
        if highlighted < 1 then
            highlighted = 3
        end
        gSounds['select2']:play()
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if highlighted == 1 then
            gStateMachine:change('play')
        elseif highlighted == 2 then
            gStateMachine:change('controls')
        elseif highlighted == 3 then
            love.event.quit()
        end
    end

    self.currentAnimation:update(dt)
  end


function StartState:render()

    --love.graphics.draw(gTextures.toxic2, 0, 0, 0, 5, 5)
    love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
    --love.graphics.draw(gTextures.mainmenubg, 0, 0, 0, 5, 5)
    love.graphics.draw(
  	gTextures.mainmenubg, gFrames.mainmenubg[self.currentAnimation:getCurrentFrame()],
  	0, 0, 0, 5, 5)

    love.graphics.draw(gTextures.mainmenutitle, 0, 0, 0, 5, 5)


    --[[love.graphics.setFont(gFonts.large)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Corona Rush', 3, WINDOW_HEIGHT / 4 + 5, WINDOW_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Corona Rush', 0, WINDOW_HEIGHT / 4, WINDOW_WIDTH, 'center') ]]--

    love.graphics.setFont(gFonts.medium)
    love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
    --love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Start', 295, WINDOW_HEIGHT / 2 -5, WINDOW_WIDTH)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Start', 292, WINDOW_HEIGHT / 2 - 5, WINDOW_WIDTH)

    love.graphics.setFont(gFonts.medium)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Controls', 260, WINDOW_HEIGHT / 2 + 100, WINDOW_WIDTH)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Controls', 257, WINDOW_HEIGHT / 2 + 100, WINDOW_WIDTH)

    love.graphics.setFont(gFonts.medium)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Exit', 320, WINDOW_HEIGHT / 2 + 215, WINDOW_WIDTH)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Exit', 317, WINDOW_HEIGHT / 2 + 215, WINDOW_WIDTH)

    if highlighted == 1 then
        love.graphics.setColor(255/255, 255/255, 0, 255/255)
        love.graphics.printf('Start', 295, WINDOW_HEIGHT / 2 -5, WINDOW_WIDTH)
    elseif highlighted == 2 then
        love.graphics.setFont(gFonts.medium)
        love.graphics.setColor(255/255, 255/255, 0, 255/255)
        love.graphics.printf('Controls', 260, WINDOW_HEIGHT / 2 + 100, WINDOW_WIDTH)
    elseif highlighted == 3 then
        love.graphics.setColor(255/255, 255/255, 0, 255/255)
        love.graphics.printf('Exit', 320, WINDOW_HEIGHT / 2 + 215, WINDOW_WIDTH)
    else
    end


end
