local Mask = {}
Mask.__index = Mask
ActiveMasks = {}

function Mask:new (x,y)
	local  instance = setmetatable ({}, Mask)
	instance.x = x
	instance.y = y
	instance.width = 80
	instance.height = 40
	instance.scaleX = 1
	instance.randomTimeOffset = math.random(0, 100)
	instance.toBeRemoved = false

	instance:loadAssets()
	instance.physics = {}
	instance.physics.body = love.physics.newBody(World, instance.x, instance.y, "static")
	instance.physics.shape = love.physics.newRectangleShape(instance.width, instance.height)
	instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)
	instance.physics.fixture:setSensor(true)
	table.insert(ActiveMasks, instance)
end

function Mask:loadAssets()
	self.animation = Animation {
		frames = {1,2},
		interval = 0.5,
	}
	self.currentAnimation = self.animation
end

function Mask:remove ()
	for i,instance in ipairs(ActiveMasks) do
		if instance == self then
			self.physics.body:destroy()
			table.remove(ActiveMasks, i)
		end
	end
end

function Mask.removeAll()
	for i, v in ipairs(ActiveMasks) do
		v.physics.body:destroy()
	end

  	ActiveMasks = {}
end

function Mask:update (dt)
	self.currentAnimation:update(dt)
	self:checkRemove()
end

function Mask:checkRemove ()
	if self.toBeRemoved then
		self:remove()
	end
end

function Mask.removeAll()
	for i,j in ipairs(ActiveMasks) do
		j.physics.body:setActive(false)
	end

  	ActiveMasks = {}
end

function Mask:spin (dt)
	self.scaleX = math.sin(love.timer.getTime() * 2 + self.randomTimeOffset)
end

function Mask:draw ()
	love.graphics.draw(
	gTextures.mask, gFrames.mask[self.currentAnimation:getCurrentFrame()],
		self.x, self.y, 0, scaleX, 1, self.width/2, self.height/2
	)
end

function Mask.updateAll (dt)
	for i,instance in ipairs(ActiveMasks) do
		instance:update(dt)
	end
end

function Mask.drawAll ()
	for i,instance in ipairs(ActiveMasks) do
		instance:draw()
	end
end

function Mask.beginContact (a, b, collision)
	for i,instance in ipairs(ActiveMasks) do
		if a == instance.physics.fixture or b == instance.physics.fixture then
			if a == Player.character.fixture or b == Player.character.fixture then
				if GUI.maskBar == 0 then
					instance.toBeRemoved = true
					GUI.isDisplayMask = true
					GUI.isDisplayAlcohol = false
					GUI.isDisplayFaceshield = false
					GUI.isDisplayPPE = false
					GUI.maskBar = 1
					GUI.alcoholBar = 0
					GUI.faceshieldBar = 0
					GUI.ppeBar = 0
					GUI.mBarDisplay = 1
					Player.alcoholCollected = false
					Player.faceshieldCollected = false
					Player.maskCollected = true
					Player.ppeCollected = false
					gSounds['powerup1']:play()
					return true
				else
					instance.toBeRemoved = false
					Player.maskCollected = false
					GUI.isDisplayMask = false
					GUI.maskBar = 0
					instance.physics.fixture:setMask(2)
					return false
				end
			end
		end
	end
end

return Mask
