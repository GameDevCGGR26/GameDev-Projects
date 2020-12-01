--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score

    self.medals = {
        ['gold'] = love.graphics.newImage('gold.png'),
        ['silver'] = love.graphics.newImage('silver.png'),
        ['bronze'] = love.graphics.newImage('bronze.png')
    }
end

function ScoreState:update(dt)
    scrolling = true
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 160, VIRTUAL_WIDTH, 'center')

      -- GOLD MEDAL -> 30 OR higher
    if self.score >= 30 then
        love.graphics.draw(self.medals['gold'], 206, 25)
        love.graphics.setFont(flappyFont)
        love.graphics.printf('Congratulations Birdie!', 0, 64, VIRTUAL_WIDTH, 'center')
    --SILVER MEDAL -> 20 OR More than 20 Points
  elseif self.score >= 20 then
        love.graphics.draw(self.medals['silver'], 206, 25)
        love.graphics.setFont(flappyFont)
        love.graphics.printf('Too close to Gold, Birdie!', 0, 64, VIRTUAL_WIDTH, 'center')
      --BRONZE MEDAL -> 10 OR More than 10 Points
  elseif self.score >= 10 then
        love.graphics.draw(self.medals['bronze'], 206, 25)love.graphics.setFont(flappyFont)
        love.graphics.printf('Keep up!', 0, 120, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.setFont(hugeFont)
        love.graphics.printf('Oops! You lose!', 0, 100, VIRTUAL_WIDTH, 'center')
    end
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Press Enter to Play Again!', 0, 230, VIRTUAL_WIDTH, 'center')
end
