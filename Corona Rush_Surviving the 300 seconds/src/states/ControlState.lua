--[[
    GD50
    Match-3 Remake

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    -Control State-

    State that simply shows us our score when we finally lose.
]]

ControlState = Class{__includes = BaseState}

function ControlState:init()

end

function ControlState:enter()
   
end

function ControlState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end
end

function ControlState:render()
    love.graphics.draw(gTextures['toxic2'])

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print('Press Escape to go Back')

    love.graphics.setColor(56/255, 56/255, 56/255, 234/255)
    love.graphics.rectangle('fill', 37, 20, 180, 94)

    love.graphics.setColor(99/255, 155/255, 255/255, 255/255)
    love.graphics.printf('Controls', 60, 23, 128, 'center')

    love.graphics.printf('W or UP arrow key to jump', 60, 33, 128, 'center')
    love.graphics.printf('S or DOWN arrow key to go down', 60, 53, 128, 'center')
    love.graphics.printf('A or LEFT arrow key to go left', 60, 73, 128, 'center')
    love.graphics.printf('D or RIGHT arrow key to go right', 60, 93, 128, 'center')
end