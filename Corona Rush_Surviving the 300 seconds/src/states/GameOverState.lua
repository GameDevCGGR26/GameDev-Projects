
GameOverState = Class{__includes = BaseState}



function GameOverState:init()
    
end

function GameOverState:enter()
    
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start')
    end
end

function GameOverState:render()
   
        love.graphics.setFont(gFonts['medium'])
        love.graphics.setColor(99, 155, 255, 255)
        love.graphics.printf('GAME OVER', 1, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(gFonts['small'])
        love.graphics.printf('You have died', 1, VIRTUAL_HEIGHT / 2 - 40 + 20, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to Go to MAIN MENU', 1, VIRTUAL_HEIGHT / 2 + 15, VIRTUAL_WIDTH, 'center')
   

end

