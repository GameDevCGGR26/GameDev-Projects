PlayState = Class{__includes = BaseState}

local highlighted = 1

function PlayState:init()
    titleState = false
    playing = true

    Map:load()
    GUI:load()

    TIMERS = 300
    
    Timer.every(1, function()
        TIMERS = TIMERS - 1
    end)
    
    gSounds['mainmenu']:stop()
    gSounds['level1']:setLooping(true)
    gSounds['level1']:setVolume(0.5)
    gSounds['level1']:play()

end


function PlayState:update(dt)
    Timer.update(dt)
    World:update(dt)
    Player:update(dt)
    Coin.updateAll(dt)
    Mask.updateAll(dt)
    Faceshield.updateAll(dt)
    Ppe.updateAll(dt)
    Alcohol.updateAll(dt)
    GUI:update(dt)
    TestingCenter.updateAll(dt)
    Virus.updateAll(dt)
    Map:update(dt)

    if TIMERS <= 0 then
		-- clear timers from prior PlayStates
		Timer.clear()
		Coin.updateAll(dt)
		Mask.updateAll(dt)
		Faceshield.updateAll(dt)
		Ppe.updateAll(dt)
		Alcohol.updateAll(dt)

		gSounds['death']:play()

		gStateMachine:change('game-over', {
			timer = TIMERS
		})
    end

    local halfScreen =  WINDOW_WIDTH / 2

    if Player.x < (MapWidth - halfScreen) then
        boundX = math.max(0, Player.x - halfScreen)
    else
        boundX = math.min(Player.x - halfScreen, MapWidth - WINDOW_WIDTH)
    end

    Camera:setPosition(Player.x, 0)

    BACKGROUND_SCROLL = (boundX/3) % 524 * 4

    if love.keyboard.wasPressed('escape') then
        if playing then
            playing = false
        else
            playing = true
        end
    end
end

function PlayState:render()
    if Map.currentLevel == 1 then
        love.graphics.draw(gTextures.background, -BACKGROUND_SCROLL, 0, 0, 4, 3.5)
    elseif Map.currentLevel == 2 then
        love.graphics.draw(gTextures.background2, -BACKGROUND_SCROLL, 0, 0, 4, 3.5)
    end
	Map.level:draw(-Camera.x, -Camera.y, Camera.scale, Camera.scale)


  	Camera:apply()
    TestingCenter.drawAll()
        Player:draw()
		Coin.drawAll()
		Mask.drawAll()
		Faceshield.drawAll()
		Ppe.drawAll()
		Alcohol.drawAll()
    Virus.drawAll()
	Camera:clear()

		GUI:draw()
end

function PlayState:beginContact(a, b, collision)
	if Coin:beginContact(a,b, collision) then return end
	if Mask.beginContact(a,b, collision) then return end
	if Faceshield.beginContact(a,b, collision) then return end
	if Ppe.beginContact(a,b, collision) then return end
	if Alcohol.beginContact(a,b, collision) then return end
	if TestingCenter.beginContact(a, b, collision) then return end
	Virus.beginContact(a, b, collision)
    Player:beginContact (a, b, collision)
end

function PlayState:endContact(a, b, collision)
    Player:endContact (a, b, collision)
end
