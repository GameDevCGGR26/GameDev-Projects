local Faceshield = {}
Faceshield.__index = Faceshield
ActiveFaceshields = {}

function Faceshield:new (x,y)
	local  instance = setmetatable ({}, Faceshield)
	instance.x = x
	instance.y = y
	instance.width = 32
	instance.height = 32
	instance.scaleX = 1
	instance.randomTimeOffset = math.random(0, 100)
	instance.toBeRemoved = false

	instance:loadAssets()
	instance.physics = {}
	instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "static")
	instance.physics.shape = love.physics.newRectangleShape(instance.width, instance.height)
	instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
	instance.physics.fixture:setSensor(true)
	table.insert(ActiveFaceshields, instance)
end

function Faceshield:loadAssets()
	self.animation = Animation {
		frames = {1,2},
		interval = 0.5,
	}
	self.currentAnimation = self.animation
end

function Faceshield:remove ()
	for i,instance in ipairs(ActiveFaceshields) do
		if instance == self then
			self.physics.body:destroy()
			table.remove(ActiveFaceshields, i)
		end
	end
end

function Faceshield.removeAll()
	for i, v in ipairs(ActiveFaceshields) do
		v.physics.body:destroy()
	end

  	ActiveFaceshields = {}
end

function Faceshield:update (dt)
	self.currentAnimation:update(dt)
	self:checkRemove()
end

function Faceshield:checkRemove ()
	if self.toBeRemoved then
		self:remove()
	end
end

function Faceshield.removeAll()
	for i,j in ipairs(ActiveFaceshields) do
		j.physics.body:setActive(false)
	end

  	ActiveFaceshields = {}
end

function Faceshield:draw ()
	love.graphics.draw(
	gTextures.faceshield, gFrames.faceshield[self.currentAnimation:getCurrentFrame()],
		self.x, self.y, 0, scaleX, 1, self.width/2, self.height/2
	)
end

function Faceshield.updateAll (dt)
	for i,instance in ipairs(ActiveFaceshields) do
		instance:update(dt)
	end
end

function Faceshield.drawAll ()
	for i,instance in ipairs(ActiveFaceshields) do
		instance:draw()
	end
end

function Faceshield.beginContact (a, b, collision)
	for i,instance in ipairs(ActiveFaceshields) do
		if a == instance.physics.fixture or b == instance.physics.fixture then
			if a == Player.character.fixture or b == Player.character.fixture then
				if GUI.faceshieldBar == 0 then
					instance.toBeRemoved = true
					GUI.isDisplayFaceshield = true
					GUI.isDisplayAlcohol =false
					GUI.isDisplayMask = false
					GUI.isDisplayPPE = false
					GUI.faceshieldBar = 1
					GUI.alcoholBar = 0
					GUI.maskBar = 0
					GUI.ppeBar = 0
					GUI.fBarDisplay = 1
					Player.alcoholCollected = false
					Player.faceshieldCollected = true
					Player.maskCollected = false
					Player.ppeCollected = false
					gSounds['powerup1']:play()
					return true
				else
					instance.toBeRemoved = false
					Player.faceshieldCollected = false
					GUI.isDisplayFaceshield = false
					GUI.faceshieldBar = 0
					instance.physics.fixture:setMask(1)
					return false
				end
			end
		end
	end
end

return Faceshield
