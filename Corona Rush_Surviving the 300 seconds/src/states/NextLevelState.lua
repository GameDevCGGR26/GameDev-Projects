
NextLevelState = Class{__includes = BaseState}

function NextLevelState:init()
    Map:clean() --cleans the map
    Map:init() -- load first
end

function NextLevelState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

    if Map.currentLevel == 1 then  --level1 to level2
      GUI.testingcenterDisplay = 0
      TIMERS = 300
      GUI.isDisplayFaceshield = false
      GUI.isDisplayAlcohol = false
      GUI.isDisplayPPE = false

      if charNum == 4 then
      	GUI.isDisplayMask = true
      	GUI.maskBar = 1
      	GUI.mBarDisplay = 1
      elseif charNum < 4 then
      	GUI.isDisplayMask = false
      	GUI.maskBar = 0
      	GUI.mBarDisplay = 1
      end

      if charNum == 3 then
      	GUI.health = {current = 4, max = 4}
      else
      	GUI.health = {current = 3, max = 3}
      end
      gStateMachine:change('play2')
      Map:next()


    elseif Map.currentLevel == 2 then --level2 to cutscene2 to level3
      GUI.testingcenterDisplay = 0
      TIMERS = 300
      GUI.isDisplayFaceshield = false
      GUI.isDisplayAlcohol = false
      GUI.isDisplayPPE = false

      if charNum == 4 then
        GUI.isDisplayMask = true
        GUI.maskBar = 1
        GUI.mBarDisplay = 1
      elseif charNum < 4 then
        GUI.isDisplayMask = false
        GUI.maskBar = 0
        GUI.mBarDisplay = 1
      end

      if charNum == 3 then
        GUI.health = {current = 4, max = 4}
      else
        GUI.health = {current = 3, max = 3}
      end
        gStateMachine:change('cutscene2')



      elseif Map.currentLevel == 3 then --level3 to cutscene3 to endcredits(TBA)
        GUI.testingcenterDisplay = 0
        TIMERS = 300
        GUI.isDisplayFaceshield = false
        GUI.isDisplayAlcohol = false
        GUI.isDisplayPPE = false

        if charNum == 4 then
          GUI.isDisplayMask = true
          GUI.maskBar = 1
          GUI.mBarDisplay = 1
        elseif charNum < 4 then
          GUI.isDisplayMask = false
          GUI.maskBar = 0
          GUI.mBarDisplay = 1
        end

        if charNum == 3 then
          GUI.health = {current = 4, max = 4}
        else
          GUI.health = {current = 3, max = 3}
        end
          gStateMachine:change('cutscene3')
    end
    end

    if love.keyboard.wasPressed('escape') then
        gSounds['level1']:stop()
        gSounds['level2']:stop()
        Map:clean()
        gStateMachine:change('start2')
    end
end

function NextLevelState:render()
    love.graphics.setFont(gFonts.medium)
    love.graphics.setColor(99, 155, 255, 255)
    love.graphics.printf('CONGRATULATIONS', 150, 100, 1000, 'center')
    love.graphics.setFont(gFonts.small)
    love.graphics.printf('You can collected '..Player.coinstotal..' coins! Great job!', 290, 400, 1000)
    love.graphics.printf('Press ENTER to proceed to Level '..Map.currentLevel + 1 ..'!', 150, 450, 1000, 'center')
    love.graphics.printf('Press ESCAPE to Go back to the MAIN MENU', 150, 500, 1000, 'center')
end
