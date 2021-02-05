
NextLevelState = Class{__includes = BaseState}

function NextLevelState:init()
    Map:load() -- load first
end

function NextLevelState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
        Map:next() -- to change from next level if enter was pressed
    end

    if love.keyboard.wasPressed('escape') then
        gStateMachine:change('start')
    end
end

function NextLevelState:render()
    love.graphics.setFont(gFonts.medium)
    love.graphics.setColor(99, 155, 255, 255)
    love.graphics.printf('CONGRATULATIONS', 150, 100, 1000, 'center')
    love.graphics.setFont(gFonts.small)
    love.graphics.printf('You can now proceed to the next level', 230, 400, 1000)
    love.graphics.printf('Press ENTER to proceed to Level 2!', 150, 450, 1000, 'center')
    love.graphics.printf('Press ESCAPE to Go back to the MAIN MENU', 150, 500, 1000, 'center')
end
