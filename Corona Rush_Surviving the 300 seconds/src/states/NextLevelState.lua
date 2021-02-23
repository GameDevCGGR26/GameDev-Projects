
NextLevelState = Class{__includes = BaseState}

function NextLevelState:init()
    Map:clean() --cleans the map
    Map:init() -- load first

    self.color = { red = 1, green = 1, blue = 1}
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

  love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
  love.graphics.draw(gTextures.nextlvlbg, 0, 0, 0, 5, 5)

    love.graphics.setFont(gFonts.small)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf('You collected '..Player.coinstotal..' coins! Great job!', 340, 400, 1000)
    love.graphics.setColor(1, 1, 0, 1)
    love.graphics.printf('You collected '..Player.coinstotal..' coins! Great job!', 337, 400, 1000)
    if Map.currentLevel < 3 then
      love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
    love.graphics.printf('Press ENTER to proceed to Level '..Map.currentLevel + 1 ..'!', 150, 450, 1000, 'center')

  else
      love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
    love.graphics.printf('Press ENTER to proceed', 150, 450, 1000, 'center')
  end
      love.graphics.setColor(self.color.red, self.color.green, self.color.blue)
    love.graphics.printf('Press ESCAPE to Go back to the MAIN MENU', 150, 500, 1000, 'center')
end
