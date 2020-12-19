--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

Tile = Class{}

function Tile:init(x, y, color, variety, shinyTiles)
    
    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32
    
    self.shiny = false
    -- tile appearance/points
    self.color = color
    self.variety = variety
    self.shinyTiles = shinyTiles
    
    -- time for color change or shine tiles
    self.colorTimer = Timer.every(0.75, function()
        self.shiny = not self.shiny
    end)
end

function Tile:render(x, y)
    
    -- draw shadow
    love.graphics.setColor(34/255, 32/255, 52/255, 1)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x + 2, self.y + y + 2)

    -- draw tile itself
    if self.shinyTiles == true and self.shiny then
        love.graphics.setColor(1, 1, 1, 40/255)
    else
        love.graphics.setColor(1, 1, 1, 1)
    end
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x, self.y + y)
end
