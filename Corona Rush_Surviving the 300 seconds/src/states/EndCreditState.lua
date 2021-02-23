EndCreditState = Class{__includes = BaseState}


function EndCreditState:init()
    credits = 70

    Timer.every(1, function()
        credits = credits - 1
    end)
end

function EndCreditState:enter()

end

function EndCreditState:update(dt)
    Timer.update(dt)



end

function EndCreditState:render()
    if credits == 70 or credits == 69 or credits == 68 or credits == 67 or credits == 66 or credits == 65 or credits == 64 or credits == 63
        or credits == 62 or credits == 61 or credits == 60 or credits == 59 or credits == 58 or credits == 57 or credits == 56 then

        love.graphics.setFont(gFonts.large)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('END?', 150, 300, 1000, 'center')
    elseif credits == 55 or credits == 54 or credits == 53 or credits == 52 or credits == 51 or credits == 50 or credits == 49
        or credits == 48 or credits == 47 or credits == 46 then

        love.graphics.setFont(gFonts.large)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('Made by CGGR from BSCOE 2-6\nA.Y. 2020-2021', 150, 190, 1000, 'center')
    elseif credits == 45 or credits == 44 or credits == 43 or credits == 42 or credits == 41 then
        love.graphics.setFont(gFonts.medium)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('PROJECT LEADER\n\nCruz, Francesca L.', 150, 250, 1000, 'center')
    elseif credits == 40 or credits == 39 or credits == 38 or credits == 37 or credits == 36 then
        love.graphics.setFont(gFonts.medium)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('GRAPHIC DESIGNER\n\nGarcia, Chelsea L.', 150, 250, 1000, 'center')
    elseif credits == 35 or credits == 34 or credits == 33 or credits == 32 or credits == 31 then
        love.graphics.setFont(gFonts.medium)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('PROJECT CODING MANAGER\n\nRanay, Daniel C.', 150, 250, 1000, 'center')
    elseif credits == 30 or credits == 29 or credits == 28 or credits == 27 or credits == 26 then
        love.graphics.setFont(gFonts.medium)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('SCRIPTWRITER\n\nGutierrez, Jorel C.', 150, 250, 1000, 'center')
    elseif credits == 25 or credits == 24 or credits == 23 then
        love.graphics.setFont(gFonts.large)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('Special Thanks to:', 150, 250, 1000, 'center')
    elseif credits == 22 or credits == 21 or credits == 20 or credits == 19 or credits == 18 then
        love.graphics.setFont(gFonts.medium)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('Babilonia, Alejandro B.', 150, 300, 1000, 'center')
    elseif credits == 17 or credits == 16 or credits == 15 or credits == 14 or credits == 13 then
        love.graphics.setFont(gFonts.medium)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('Youtuber\n\nDevJeeper', 150, 250, 1000, 'center')
    elseif credits == 12 or credits == 11 or credits == 10 or credits == 9 or credits == 8 then
        love.graphics.setFont(gFonts.large)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('Thank You for Playing our Game', 150, 250, 1000, 'center')
    elseif credits == 7 or credits == 6 or credits == 5 or credits == 4 or credits == 3 or credits == 2 or credits == 1  then
        love.graphics.setFont(gFonts.large)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('To God Be The Glory', 150, 250, 1000, 'center')
    else
        Map:clean()
        gStateMachine:change('start2')
    end





end
