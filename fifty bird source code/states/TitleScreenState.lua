--[[
    TitleScreenState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The TitleScreenState is the starting screen of the game, shown on startup. It should
    display "Press Enter" and also our highest score.
]]

TitleScreenState = Class{__includes = BaseState}

-- to highlight, whether 'day mode' or 'night mode' of the game
local highlight = 1

function TitleScreenState:update(dt)
    -- transition to countdown when enter/return are pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        sounds['select']:play()
        gStateMachine:change('countdown')
    end
    
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        highlight = highlight == 1 and 2 or 1
    end

    -- to change background
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        if highlight == 1 then
            background = true
            sounds['select']:play()
        else
            background = false
            sounds['select']:play()
        end
    end
end
 
function TitleScreenState:render()
    -- simple UI code
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Fifty Bird', 0, 80, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter to Play', 0, 250, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(smallFont)
    love.graphics.setColor(97/255, 107/255, 97/255, 1)
    -- to display highlight of mode
    if highlight == 1 then 
        love.graphics.rectangle('line', 227, 130, 57, 15)
    else
        love.graphics.rectangle('line', 227, 148, 57, 15)
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf('Day Mode', 0, 133, VIRTUAL_WIDTH, 'center')
    love.graphics.printf('Night Mode', 0, 151, VIRTUAL_WIDTH, 'center')
end
