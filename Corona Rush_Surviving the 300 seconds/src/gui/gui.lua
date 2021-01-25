local GUI = {}

function GUI:load()
  self.coins = {} --coins images and constants
  self.coins.img = love.graphics.newImage("assets/coinsingle.png")
  self.coins.width = self.coins.img:getWidth()
  self.coins.height = self.coins.img:getHeight()
  self.coins.scale = 4
  self.coins.x = love.graphics.getWidth() - 200 --upper leftmost corner
  self.coins.y = 30

  self.hearts = {} --hearts images and constants
  self.hearts.img = love.graphics.newImage("assets/heart bar single.png")
  self.hearts.width = self.hearts.img:getWidth()
  self.hearts.height = self.hearts.img:getHeight()
  self.hearts.scale = 8
  self.hearts.x = 10
  self.hearts.y = 30
  self.hearts.spacing = self.hearts.width * self.hearts.scale + 10

  self.powerupBar = {}
  self.isDisplayFaceshield = false
  self.isDisplayAlcohol = false
  self.isDisplayPPE = false
  self.isDisplayMask = false
  self.faceshieldBar = 0
  self.alcoholBar = 0
  self.ppeBar = 0
  self.maskBar = 0
  self.powerupBar.x = 10
  self.powerupBar.y = 85
  self.powerupBar.scale = 8

  self.font = love.graphics.newFont("assets/bit.ttf", 36) --coin count font
end

function GUI:update(dt)

end

function GUI:draw()
  self:displayCoins()
  self:displayCoinText()
  self:displayHearts ()
  self:displayPowerupBar()
end

function GUI:displayPowerupBar()
  if self.isDisplayFaceshield == true then
    love.graphics.draw(gTextures.faceshieldBar, gFrames.faceshieldBar[1], self.powerupBar.x, self.powerupBar.y, 0, self.powerupBar.scale, self.powerupBar.scale)
  elseif self.isDisplayAlcohol == true then
    love.graphics.draw(gTextures.alcoholBar, gFrames.alcoholBar[1], self.powerupBar.x, self.powerupBar.y, 0, self.powerupBar.scale, self.powerupBar.scale)
  elseif self.isDisplayPPE == true then
    love.graphics.draw(gTextures.ppeBar, gFrames.ppeBar[1], self.powerupBar.x, self.powerupBar.y, 0, self.powerupBar.scale, self.powerupBar.scale)
  elseif self.isDisplayMask == true then
    love.graphics.draw(gTextures.maskBar, gFrames.maskBar[1], self.powerupBar.x, self.powerupBar.y, 0, self.powerupBar.scale, self.powerupBar.scale)
  end
end

function GUI:displayHearts ()
 love.graphics.setColor(0,0,0,0.5) --shadow
 love.graphics.draw(self.hearts.img, self.hearts.x + 2, self.hearts.y + 2, 0, self.hearts.scale, self.hearts.scale)
 love.graphics.setColor(1,1,1,1)
 love.graphics.draw(self.hearts.img, self.hearts.x, self.hearts.y, 0, self.hearts.scale, self.hearts.scale)
end

function GUI:displayCoins()
  love.graphics.setColor(0,0,0,0.5) --shadow
  love.graphics.draw(self.coins.img, self.coins.x + 2, self.coins.y + 2, 0, self.coins.scale, self.coins.scale)
  love.graphics.setColor(1,1,1,1)
  love.graphics.draw(self.coins.img, self.coins.x, self.coins.y, 0, self.coins.scale, self.coins.scale)
end

function GUI:displayCoinText()
  love.graphics.setFont(self.font)
  local x = self.coins.x + self.coins.width * self.coins.scale
  local y = self.coins.y + self.coins.height / 2 * self.coins.scale - self.font:getHeight() / 2
  love.graphics.setColor(0,0,0,0.5) --shadow
  love.graphics.print(" : "..Player.coins, x + 2, y + 2)
  love.graphics.setColor(1,1,1,1)
  love.graphics.print(" : "..Player.coins, x, y)
end
return GUI
