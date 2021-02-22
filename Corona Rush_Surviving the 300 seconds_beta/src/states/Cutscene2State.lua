Cutscene2State = Class{__includes = BaseState}

require 'src/cutscenes/cutscene2'


function Cutscene2State:init()
    Map:clean()
    Map:init() -- load first

end

function Cutscene2State:enter()
    next_text = 1
    x = 1
    gSounds['level2']:stop()
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
        end
    end


    if next_text == 17 then
      gStateMachine:change('play2')
      Map:next()

    end

end

function Cutscene2State:render()
    if dialogue_Cutscene2[next_text] ~= nil then
        if next_text == x then
            love.graphics.draw(gTextures.dialogboxcs, 0, 515, 0, 1, 1)
            love.graphics.setFont(gFonts.xxsmall)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.print(dialogue_Cutscene2[next_text], 150, 475)
            love.graphics.print(next_text, 0, 0)
        end
    end
end
