--[[
    GD50
    Super Mario Bros. Remake

    -- StartState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

StartState = Class{__includes = BaseState}

local highlighted = 2

function StartState:init()
self.transitionAlpha = 0
end



function StartState:update(dt)
    if love.keyboard.wasPressed('d' or 'right') then
        highlighted = highlighted + 1
        if highlighted > 3 then
            highlighted = 1
        end
        gSounds['select1']:play()
    elseif love.keyboard.wasPressed('a' or 'left') then
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
        if highlighted == 2 then
            gStateMachine:change('play')
        elseif highlighted == 1 then
            gStateMachine:change('controls')
        elseif highlighted == 3 then
            love.event.quit()
        end
    end
  end


function StartState:render()

    love.graphics.draw(gTextures.toxic2)

    love.graphics.setFont(gFonts.large)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Corona Rush', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Corona Rush', 0, VIRTUAL_HEIGHT / 2 - 40, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts.small)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Controls', 50, VIRTUAL_HEIGHT / 2 + 38, VIRTUAL_WIDTH)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Controls', 49, VIRTUAL_HEIGHT / 2 + 37, VIRTUAL_WIDTH)

    love.graphics.setFont(gFonts.medium)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Start', 1, VIRTUAL_HEIGHT / 2 + 34, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Start', 0, VIRTUAL_HEIGHT / 2 + 33, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts.small)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Exit', 175, VIRTUAL_HEIGHT / 2 + 38, VIRTUAL_WIDTH)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Exit', 174, VIRTUAL_HEIGHT / 2 + 37, VIRTUAL_WIDTH)

    if highlighted == 1 then
        love.graphics.setColor(255/255, 255/255, 0, 255/255)
        love.graphics.printf('Controls', 49, VIRTUAL_HEIGHT / 2 + 37, VIRTUAL_WIDTH)
    elseif highlighted == 2 then
        love.graphics.setFont(gFonts.medium)
        love.graphics.setColor(255/255, 255/255, 0, 255/255)
        love.graphics.printf('Start', 0, VIRTUAL_HEIGHT / 2 + 33, VIRTUAL_WIDTH, 'center')
    elseif highlighted == 3 then
        love.graphics.setColor(255/255, 255/255, 0, 255/255)
        love.graphics.printf('Exit', 174, VIRTUAL_HEIGHT / 2 + 37, VIRTUAL_WIDTH)
    else
    end


end
