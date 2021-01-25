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
    love.graphics.draw(gTextures['toxic2'], 0, 0, 0, 5, 5)

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print('Press Escape to go Back', 5, 5)

    love.graphics.setColor(56/255, 56/255, 56/255, 234/255)
    love.graphics.rectangle('fill', 250, 120, 800, 500)

    love.graphics.setColor(59/255, 200/255, 255/255, 255/255)
    love.graphics.printf('Controls', 0, 170, WINDOW_WIDTH, 'center')

    love.graphics.setColor(99/255, 155/255, 255/255, 255/255)
    love.graphics.printf('W or UP arrow key to jump', 0, 280, WINDOW_WIDTH, 'center')
    love.graphics.printf('S or DOWN arrow key to go down', 0, 350, WINDOW_WIDTH, 'center')
    love.graphics.printf('A or LEFT arrow key to go left', 0, 420, WINDOW_WIDTH, 'center')
    love.graphics.printf('D or RIGHT arrow key to go right', 0, 500, WINDOW_WIDTH, 'center')
end
