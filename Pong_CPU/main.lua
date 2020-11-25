push = require 'push'

Class = require 'class'

require 'Paddle'

require 'Ball'


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200
PADDLE_SPEED_AI = 200

aimode = false

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Pong')

    math.randomseed(os.time())

    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    titleFont = love.graphics.newFont('font.ttf', 25)
    scoreFont = love.graphics.newFont('font.ttf', 40)
    readyFont = love.graphics.newFont('font.ttf', 50)
    

    love.graphics.setFont(smallFont)

    sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['victory'] = love.audio.newSource('sounds/victory.mp3', 'static')
    }

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    player1Score = 0
    player2Score = 0
    
    player1 = Paddle(10, 30, 5, 20)
    player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5 , 20)

    ball = Ball(VIRTUAL_WIDTH/ 2 - 2, VIRTUAL_HEIGHT/ 2 - 2, 4, 4)

    gameState = 'start'

    servingPlayer = math.random(2)

    difficulty = {}

end

function love.resiz(w,h)
    push:resize(w,h)
end

function love.update(dt)

    if gameState == 'serve' then

        ball.dy = math.random(-50, 50)

        if servingPlayer == 1 then

            ball.dx = math.random(140, 200)
        else

            ball.dx = -math.random(140, 200)
        end
    end

    if gameMode == 'pvc' then
     
        up_button = 'w'     
        down_button = 's'
        
        if controls == 'ws' then            
            up_button = 'w'
            down_button = 's'
        end

        check_width = 0

        if difficulty == 'easy' then
            check_width = VIRTUAL_WIDTH/4
        elseif difficulty == 'med' then
            check_width = VIRTUAL_WIDTH/2
        elseif difficulty == 'hard' then
            check_width = VIRTUAL_WIDTH
        end

        plr = player1          
        plr_n = player2

        if ((ball.x - plr_n.x)^2)^(0.5)  < check_width then 
            if (plr_n.y > (ball.y + ball.height/2))  then                    
                plr_n.dy = -PADDLE_SPEED
            elseif (plr_n.y + plr_n.height < (ball.y + ball.height/2))  then
                plr_n.dy = PADDLE_SPEED
            else
                plr_n.dy = 0
            end
        end
    end

    if gameState == 'play' then
    
        if ball:collides(player1) then
            ball.dx = -ball.dx * 1.03
            ball.x = player1.x + 5

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end

            sounds['paddle_hit']:play()
        end

        if ball:collides(player2) then
            ball.dx = -ball.dx * 1.03
            ball.x = player2.x - 4

            if ball.dy < 0 then
                ball.dy = -math.random(10, 150)
            else
                ball.dy = math.random(10, 150)
            end
            
            sounds['paddle_hit']:play()
        end

        if ball.y <= 0 then
            ball.y = 0
            ball.dy = -ball.dy

            sounds['wall_hit']:play()
        end

        if ball.y >= VIRTUAL_HEIGHT - 4 then
            ball.y = VIRTUAL_HEIGHT - 4
            ball.dy = -ball.dy

            sounds['wall_hit']:play()
        end
    

        if ball.x < 0 then
            servingPlayer = 1
            player2Score = player2Score + 1
            sounds['score']:play()
        
            if player2Score == 10 then
                winningPlayer = 2
                gameState = 'done'
                sounds['victory']:play()
            else 
                gameState = 'serve'
                ball:reset()
            end
        end

        if ball.x > VIRTUAL_WIDTH then
            servingPlayer = 2
            player1Score = player1Score + 1
            sounds['score']:play()

            if player1Score == 10 then
                winningPlayer = 1
                gameState = 'done'
                sounds['victory']:play()
            else
                gameState = 'serve'
                ball:reset()
            end
        end 
    end

    
    if gameMode == 'pvp' then 
        if love.keyboard.isDown('w') then
            player1.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('s') then
            player1.dy = PADDLE_SPEED
        else
            player1.dy = 0
        end

        if love.keyboard.isDown('up') then
            player2.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('down') then
            player2.dy = PADDLE_SPEED
        else
            player2.dy = 0
        end
    end

    if gameMode == 'pvc' then 
        if love.keyboard.isDown('w') then
            player1.dy = -PADDLE_SPEED
        elseif love.keyboard.isDown('s') then
            player1.dy = PADDLE_SPEED
        else
            player1.dy = 0
        end
    end
    

    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)


end

function love.keypressed(key)
    
    if gameState == 'start' then
        if key == 'c' then
            gameState = 'menuDifficulty'
            gameMode = 'pvc'
        end
    end

    if gameMode == 'pvc' then
        if key == '1' then 
            difficulty = 'easy'
            gameState = 'serve'
        elseif key == '2' then 
            difficulty = 'med'
            gameState = 'serve'
        elseif key == '3' then 
            difficulty = 'hard'
            gameState = 'serve'
        end
    end

    if key == 'space' then 
        gameMode = 'pvp'
        gameState = 'ready'
    end

    if key == 'escape' then
        if gameState ~= 'start' then
            gameState = 'start'
            ball:reset()
            player1Score = 0
            player2Score = 0
            player1:reset1()
            player2:reset2()
        else
            love.event.quit()
        end

    elseif key ==  'enter' or key == 'return' then
        if gameState == 'ready' then
            gameState = 'serve'
        elseif gameState == 'serve' then
            gameState = 'play'
        elseif gameState == 'done' then
            gameState = 'serve'
            ball:reset()

            player1Score = 0
            player2Score = 0
            
            if winningPlayer == 1 then
                servingPlayer = 2
            else
                servingPlayer = 1
            end
        end
    end
end

function love.draw()
    push:apply('start')

    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    
    
    love.graphics.setFont(smallFont)


    if gameState == 'ready' then
        love.graphics.setFont(readyFont)
        love.graphics.printf('READY?', 0, 100,  VIRTUAL_WIDTH,'center') 
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to START', 0, 200,  VIRTUAL_WIDTH,'center') 
    end

    if gameState == 'start' then    
        love.graphics.setFont(titleFont)
        love.graphics.printf('WELCOME TO PONG', 0, 100,  VIRTUAL_WIDTH,'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Space to play against a player!', 0, 180,  VIRTUAL_WIDTH,'center')
        love.graphics.printf('Press C to play against a CPU!', 0, 190,  VIRTUAL_WIDTH,'center') 
        love.graphics.printf('Press Escape to Quit', 0, VIRTUAL_HEIGHT - 20, VIRTUAL_WIDTH - 5, 'right')

    elseif gameState == 'menuDifficulty' then
        love.graphics.setFont(largeFont) 
        love.graphics.printf('CHOOSE YOUR DIFFICULTY!', 0, 40, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('1. NOOBIE (for chickens) ', 0, 90,  VIRTUAL_WIDTH,'center')
        love.graphics.printf('2. MODERATE PLAYER (for people who wants some challenge )', 0, 100,  VIRTUAL_WIDTH,'center') 
        love.graphics.printf('3. PRO GAMER (for people who wants to never win )', 0, 110,  VIRTUAL_WIDTH,'center') 
    elseif gameState == 'serve' then
        player1:render()
        player2:render()
        ball:render()
        displayScore()
        love.graphics.setFont(smallFont)
        love.graphics.printf('Player ' .. tostring(servingPlayer) .. "'s serve", 0, 10,  VIRTUAL_WIDTH,'center')
        love.graphics.printf('Press Enter to Serve!', 0, 20,  VIRTUAL_WIDTH,'center')
    elseif gameState == 'play' then
        player1:render()
        player2:render()
        ball:render()
        displayScore()
        love.graphics.setFont(smallFont)
    elseif gameState == 'done' then
        player1:render()
        player2:render()
        ball:render()
        if gameMode == 'pvc' then
            if player1Score == 10 then 
                love.graphics.setFont(titleFont)
                love.graphics.printf('Player 1 Wins!', 0, 100,  VIRTUAL_WIDTH,'center')
                love.graphics.setFont(smallFont)
                love.graphics.printf('Press Enter to Restart!', 0, 180,  VIRTUAL_WIDTH,'center')
                love.graphics.printf('Press Escape to Go back to Menu', 0, 190,  VIRTUAL_WIDTH,'center')
            end
            if player2Score == 10 then 
                gameState = 'done'
                love.graphics.setFont(titleFont)
                love.graphics.printf('Computer Wins!', 0, 100,  VIRTUAL_WIDTH,'center')
                love.graphics.setFont(smallFont)
                love.graphics.printf('Press Enter to Restart!', 0, 180,  VIRTUAL_WIDTH,'center')
                love.graphics.printf('Press Escape to Go back to Menu', 0, 190,  VIRTUAL_WIDTH,'center')
            end
        else
            love.graphics.setFont(titleFont)
            love.graphics.printf('Player ' .. tostring(winningPlayer) .. ' wins!', 0, 100, VIRTUAL_WIDTH,'center')
            love.graphics.setFont(smallFont)
            love.graphics.printf('Press Enter to Restart!', 0, 180,  VIRTUAL_WIDTH,'center')
            love.graphics.printf('Press Escape to Go back to Menu', 0, 190,  VIRTUAL_WIDTH,'center')
        end
    end

    

    displayFPS()

    push:apply('end')
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

function displayScore()
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50,  VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)
end