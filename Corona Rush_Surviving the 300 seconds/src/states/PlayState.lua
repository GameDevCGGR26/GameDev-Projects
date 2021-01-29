PlayState = Class{__includes = BaseState}

local highlighted = 1

function PlayState:init()
    -- self.playing = true
    titleState = false
    playing = true

    Map:load()
    -- Player:load()
    GUI:load()
    Player:load()
    --Coin:new(400,100)
  --  Coin:new(2895,170)
  --  Coin:new(5000,230)

  --  Mask:new(3300,160)
  --  Mask:new(830,130)

--    Faceshield:new(4450,150)

  --  Ppe:new(1380,150)

  --  Alcohol:new(2260,170)
  --  GUI:load()


    TIMERS = 300
    Timer.every(1, function()
            TIMERS = TIMERS - 1
          end)
        -- Timer.every(intervals[i], function()
      --     counters[i] = counters[i] + 1
  --      end)
	
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
    --  Map:update(dt)
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
  love.graphics.draw(gTextures.background, -BACKGROUND_SCROLL, 0, 0, 4, 3.5)
  --Map:draw(-Camera.x, -Camera.y, Camera.scale, Camera.scale)
	Map.level:draw(-Camera.x, -Camera.y, Camera.scale, Camera.scale)

	Camera:apply()
		Player:draw()
		Coin.drawAll()
		Mask.drawAll()
		Faceshield.drawAll()
		Ppe.drawAll()
		Alcohol.drawAll()
    Virus.drawAll()
    TestingCenter.drawAll()
	Camera:clear()

		GUI:draw()
  --  Map:draw(-backgroundScrol,0,2,2)
end




function PlayState:beginContact(a, b, collision)
  if Coin:beginContact(a,b, collision) then return end
  if Mask.beginContact(a,b, collision) then return end
  if Faceshield.beginContact(a,b, collision) then return end
  if Ppe.beginContact(a,b, collision) then return end
  if Alcohol.beginContact(a,b, collision) then return end
  Player:beginContact (a, b, collision)
  Virus.beginContact(a, b, collision)
end

function PlayState:endContact(a, b, collision)
    Player:endContact(a, b, collision)
end
