PlayState = Class{__includes = BaseState}

local highlighted = 1

function PlayState:init()
    -- self.playing = true
    titleState = false
    playing = true

    -- Slime.loadAssets()
--    Map:load()
    -- Player:load()
    GUI:load()
end


function PlayState:update(dt)

    World:update(dt)
    Player:update(dt)
    Coin.updateAll(dt)
    Mask.updateAll(dt)
    Faceshield.updateAll(dt)
    Ppe.updateAll(dt)
    Alcohol.updateAll(dt)
    GUI:update(dt)
  --  Map:update(dt)

    Camera:setPosition(Player.x, 0)

      if love.keyboard.wasPressed('escape') then
          if playing then
              playing = false
          else
              playing = true
          end
      end
  end




function PlayState:render()
  love.graphics.draw(gTextures.background, 0, 0, 0, 4, 3.5)
	Map:draw(-Camera.x, -Camera.y, Camera.scale, Camera.scale)

	Camera:apply()
		Player:draw()
		Coin.drawAll()
		Mask.drawAll()
		Faceshield.drawAll()
		Ppe.drawAll()
		Alcohol.drawAll()
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
end

function PlayState:endContact(a, b, collision)
    Player:endContact(a, b, collision)
end
