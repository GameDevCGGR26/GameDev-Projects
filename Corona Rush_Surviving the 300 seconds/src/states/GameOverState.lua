
GameOverState = Class{__includes = BaseState}



function GameOverState:init()
    
end

function GameOverState:enter()
    
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end
    
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('play')
    end
end

function GameOverState:render()
    love.graphics.setFont(gFonts.medium)
    love.graphics.setColor(99, 155, 255, 255)
    love.graphics.printf('GAME OVER', 150, 100, 1000, 'center')
    love.graphics.setFont(gFonts.small)
    love.graphics.printf('You have died', 530, 400, 1000)
    love.graphics.printf('Press ENTER to Go to MAIN MENU', 150, 450, 1000, 'center')
    love.graphics.printf('Press SPACE to RESTART', 150, 500, 1000, 'center')
end

