-- https://github.com/Ulydev/push
push = require 'lib/push'

-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib/class'

-- https://github.com/karai17/Simple-Tiled-Implementation
STI  = require 'lib/sti'

-- https://github.com/airstruck/knife
Timer = require 'lib/knife.timer'

-- game entities
Player = require 'src/player'
Coin  = require 'src/coin'
Mask  = require 'src/mask'
Faceshield  = require 'src/faceshield'
Ppe  = require 'src/ppe'
Alcohol  = require 'src/alcohol'
GUI = require 'src/gui/gui'
Camera = require 'src/camera'


-- game objects



require 'src/Animation'

require 'src/Util'

--small = love.graphics.newFont('font/font.ttf', 8)
--medium = love.graphics.newFont('font/font.ttf', 16)
--large = love.graphics.newFont('font/font.ttf', 32)

--gSounds = {
    --tbgm = love.audio.newSource('sounds/music/Aspire.mp3', 'static'),
    -- forest = love.audio.newSource('sounds/music/forest.mp3', 'static'),
    --jump = love.audio.newSource('sounds/SFX/jump.wav', 'static')
--}

gTextures = {
    --background = love.graphics.newImage('graphics/background/Title.png'),
    --forest = love.graphics.newImage('graphics/background/Forest.png'),
    --cave = love.graphics.newImage('graphics/background/Cave.png'),
    --arrow = love.graphics.newImage('graphics/arrow.png'),
    --panel = love.graphics.newImage('graphics/holder.png'),
    --logo = love.graphics.newImage('graphics/logo.png'),
    background = love.graphics.newImage("assets/citybig.png"),
    hero = love.graphics.newImage('assets/cesca run animation.png'),
    heroF = love.graphics.newImage('assets/cesca run with face shield.png'),
    heroP = love.graphics.newImage('assets/ppe run animation.png'),
    heroM = love.graphics.newImage('assets/cesca run with mask.png'),
    heroA = love.graphics.newImage('assets/cesca with alcohol.png'),
    coins = love.graphics.newImage('assets/coin7f.png'),
    mask = love.graphics.newImage('assets/mask.png'),
    faceshield = love.graphics.newImage('assets/faceshield.png'),
    ppe = love.graphics.newImage('assets/ppe.png'),
    alcohol = love.graphics.newImage('assets/alcohol.png'),
    faceshieldBar = love.graphics.newImage('assets/faceshield bar.png'),
    alcoholBar = love.graphics.newImage('assets/alcohol bar.png'),
    ppeBar = love.graphics.newImage('assets/ppe bar.png'),
    maskBar = love.graphics.newImage('assets/mask bar.png')
    --slime = love.graphics.newImage('graphics/slime.png'),
    --keyLock = love.graphics.newImage('graphics/key_lock.png')
}

gFrames = {
    --arrow = GenerateQuads(gTextures.arrow, 4, 5),
    --logo = GenerateQuads(gTextures.logo, 272, 160),
    hero = GenerateQuads(gTextures.hero, 25, 45),
    heroF = GenerateQuads(gTextures.heroF, 25, 45),
    heroP = GenerateQuads(gTextures.heroP, 25, 45),
    heroM = GenerateQuads(gTextures.heroM, 25, 45),
    coins = GenerateQuads(gTextures.coins, 16, 16),
    mask = GenerateQuads(gTextures.mask, 40, 40),
    faceshield = GenerateQuads(gTextures.faceshield, 32, 32),
    ppe = GenerateQuads(gTextures.ppe, 39, 35),
    alcohol = GenerateQuads(gTextures.alcohol, 35, 35),
    faceshieldBar = GenerateQuads(gTextures.faceshieldBar, 37, 6),
    alcoholBar = GenerateQuads(gTextures.alcoholBar, 37, 6),
    ppeBar = GenerateQuads(gTextures.ppeBar, 55,6),
    maskBar = GenerateQuads(gTextures.maskBar, 28,6)
    --slime = GenerateQuads(gTextures.slime, 16, 13),
    --key = GenerateQuadsKey(gTextures.keyLock),
    --lock = GenerateQuadsLock(gTextures.keyLock)
}
