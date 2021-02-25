local Virus = {}
Virus.__index = Virus

local ActiveVirus = {}

function Virus:load(x, y)
	local instance = setmetatable({}, Virus)
	instance.x = x
	instance.y = y

	instance.startX = instance.x
	instance.startY = instance.y

	if Map.currentLevel == 3 then
		instance.width = 94
		instance.height = 94
	else
		instance.width = 32
		instance.height = 32
	end
	
	instance.speed = 100
	instance.speedMod = 1
	instance.xVel = instance.speed

	instance.rageCounter = 0
	instance.rageTrigger = 3

	instance.damage = 1

	instance.state = 'walk'

	instance:loadAssets()

	instance.physics = {}
	instance.physics.body = love.physics.newBody(World, instance.x, instance.y, 'dynamic')
	instance.physics.body:setFixedRotation(true)
	instance.physics.body:setMass(25)
	instance.physics.shape = love.physics.newRectangleShape(instance.width, instance.height )
	instance.physics.fixture = love.physics.newFixture(instance.physics.body, instance.physics.shape)

	table.insert(ActiveVirus, instance)
end

function Virus:loadAssets()
	self.animation = {state}

	self.animation.walk = Animation {
		frames = {1, 2, 3, 4},
		interval = 0.3,
		width = self.width,
		height = self.height
	}

	self.animation.run = Animation {
		frames = {1, 2, 3, 4},
		interval = 0.3,
		width = self.width,
		height = self.height
	}

	self.currentAnimation = self.animation[self.state]
end

function Virus.removeAll()
	for i,v in ipairs(ActiveVirus) do
		v.physics.body:destroy()
	end

   ActiveVirus = {}
end

function Virus:resetPosition()
	if self.y > MapHeight then
		self.physics.body:setPosition(self.startX, self.startY)
	end
end

function Virus:update(dt)
    self:syncPhysics()
    self.currentAnimation:update(dt)
   	self:resetPosition()
end

function Virus:flipDirection()
   	self.xVel = -self.xVel
end

function Virus:syncPhysics()
	self.x, self.y = self.physics.body:getPosition()
	self.physics.body:setLinearVelocity(self.xVel * self.speedMod, 100)
end

function Virus:draw()
	local scaleX = 1
	if self.xVel < 0 then
		scaleX = -1
	end
	
	if Map.currentLevel == 3 then
		love.graphics.draw(
		gTextures.bigvirus, gFrames.bigvirus[self.currentAnimation:getCurrentFrame()],
		self.x, self.y, 0, scaleX, 1, self.currentAnimation.width/2, self.currentAnimation.height/2
		)
	else 
		love.graphics.draw(
			gTextures.virus, gFrames.virus[self.currentAnimation:getCurrentFrame()],
			self.x, self.y, 0, scaleX, 1, self.currentAnimation.width/2, self.currentAnimation.height/2
		)
	end
end

function Virus.updateAll(dt)
	for i,instance in ipairs(ActiveVirus) do
		instance:update(dt)
	end
end

function Virus.drawAll()
	for i,instance in ipairs(ActiveVirus) do
		instance:draw()
	end
end

function Virus.beginContact(a, b, collision)
	for i,instance in ipairs(ActiveVirus) do
		if a == instance.physics.fixture or b == instance.physics.fixture then
			if a == Player.character.fixture or b == Player.character.fixture then
				Player:takeDamage(instance.damage)
				gSounds['player-hurt']:play()
				if Player.maskCollected == true then
					GUI.mBarDisplay = GUI.mBarDisplay + 1
					if charNum == 1 then
						if GUI.mBarDisplay > 2 then
							GUI.isDisplayMask = false
							Player.exposed = true
							Player.maskCollected = false
						end
					elseif charNum > 1 then
						if GUI.mBarDisplay > 1 then
							GUI.isDisplayMask = false
							Player.exposed = true
							Player.maskCollected = false
						end
					end
				end
				if Player.faceshieldCollected == true then
					GUI.fBarDisplay = GUI.fBarDisplay + 1
					if charNum == 1 then
						if GUI.fBarDisplay > 3 then
							GUI.isDisplayFaceshield = false
							Player.exposed = true
							Player.faceshieldCollected = false
						end
					elseif charNum > 1 then
						if GUI.fBarDisplay > 2 then
							GUI.isDisplayFaceshield = false
							Player.exposed = true
							Player.faceshieldCollected = false
						end
					end
				end
				if Player.ppeCollected == true then
					GUI.pBarDisplay = GUI.pBarDisplay + 1
					if charNum == 1 then
						if GUI.pBarDisplay > 5 then
							GUI.isDisplayPPE = false
							Player.exposed = true
							Player.ppeCollected = false
						end
					elseif charNum > 1 then
						if GUI.pBarDisplay > 4 then
							GUI.isDisplayPPE = false
							Player.exposed = true
							Player.ppeCollected = false
						end
					end
				end
				if Player.alcoholCollected == true then
					GUI.aBarDisplay = GUI.aBarDisplay + 1
					if charNum == 1 then
						if GUI.aBarDisplay > 3 then
							GUI.isDisplayAlcohol = false
							Player.exposed = true
							Player.alcoholCollected = false
						end
					elseif charNum > 1 then
						if GUI.aBarDisplay > 2 then
							GUI.isDisplayAlcohol = false
							Player.exposed = true
							Player.alcoholCollected = false
						end
					end
				end
			end
		instance:flipDirection()
		end
	end
end

return Virus
