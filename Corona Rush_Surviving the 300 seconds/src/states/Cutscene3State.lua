Cutscene3State = Class{__includes = BaseState}

require 'src/cutscenes/cutscene3'


function Cutscene3State:init()

end

function Cutscene3State:enter()
    next_text = 1
    x = 1
    gSounds['level3']:stop()
    gSounds['level1']:stop()

    gSounds['end-credit']:setLooping(true)
    gSounds['end-credit']:setVolume(0.5)
    gSounds['end-credit']:play()
end

function Cutscene3State:update(dt)


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
              next_text = 4
              x = 4
        end
    end


    if next_text == 5 then
        gStateMachine:change('end-credit')
    end

end

function Cutscene3State:render()

  if next_text == 1 then
         love.graphics.draw(gTextures.road1, 0, 0, 0, 5, 5)
         love.graphics.draw(gTextures.dialogboxcs, 0, 515, 0, 1, 1)
     end

    if dialogue_Cutscene3[next_text] ~= nil then
        if next_text == x then
            love.graphics.draw(gTextures.dialogboxcs, 0, 515, 0, 1, 1)
            love.graphics.setFont(gFonts.xxsmall)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.print(dialogue_Cutscene3[next_text], 150, 475)
            --love.graphics.print(next_text, 0, 0)
        end
    end

    love.graphics.printf("Press s to skip", 20, 670,
        WINDOW_WIDTH, 'left')

        love.graphics.printf("Press x for previous", 10, 670,
            WINDOW_WIDTH, 'center')

    love.graphics.printf("Press Spacebar to continue", -20, 670,
        WINDOW_WIDTH, 'right')

end
