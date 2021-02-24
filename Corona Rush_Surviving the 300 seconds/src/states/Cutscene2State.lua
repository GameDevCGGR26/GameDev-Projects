Cutscene2State = Class{__includes = BaseState}

require 'src/cutscenes/cutscene2'


function Cutscene2State:init()
    Map:clean()
    Map:init() -- load first
    self:loadAssets()
    dialog_finished3 = false
    gSounds['level1']:stop()
end

function Cutscene2State:enter()
    next_text = 1
    x = 1
    gSounds['level2']:stop()
    
    gSounds['bgm2']:setLooping(true)
    gSounds['bgm2']:setVolume(0.25)
    gSounds['bgm2']:play()
  
end

function Cutscene2State:loadAssets()
    self.animation = {state}

    self.animation = Animation {
        frames = {1,2,3,4,5},
        interval = 1.5,
    }


    self.currentAnimation = self.animation
end

function Cutscene2State:update(dt)

    self.currentAnimation:update(dt)

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

    if self.currentAnimation.currentFrame == 5 then
        dialog_finished3 = true
    end


    

end

function Cutscene2State:render()
    love.graphics.draw(gTextures.dialogboxcs, 0, 515, 0, 1, 1)
    
    if next_text == 1 or next_text == 3 or next_text == 4 then
        love.graphics.draw(gTextures.crowd, 0, 0, 0, 5, 5)
        love.graphics.draw(gTextures.dialogboxcs, 0, 515, 0, 1, 1)
    end

    if next_text == 13 then
        love.graphics.draw(gTextures.road, 0, 0, 0, 5, 5)
        love.graphics.draw(gTextures.dialogboxcs, 0, 515, 0, 1, 1)
    end

    if next_text == 14 or next_text == 15 then
        if dialog_finished3 == false then
          if self.currentAnimation.currentFrame < 5 then
            love.graphics.draw(gTextures.bigboss, gFrames.bigboss[self.currentAnimation:getCurrentFrame()], 0, 0, 0, 5, 5)
          end
        else
          love.graphics.draw(gTextures.bigboss5, 0, 0, 0, 5, 5)
        end
    end

    if dialogue_Cutscene2[next_text] ~= nil then
        if next_text == x then
            love.graphics.setFont(gFonts.xxsmall)
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.print(dialogue_Cutscene2[next_text], 150, 475)
            love.graphics.print(next_text, 0, 0)
        end
    end
end


