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
Mask  = require 'src/powerups/mask'
Faceshield  = require 'src/powerups/faceshield'
Ppe  = require 'src/powerups/ppe'
Alcohol  = require 'src/powerups/alcohol'
GUI = require 'src/gui/gui'
Camera = require 'src/camera'
Map = require 'src/map'
Virus = require 'src/virus'
TestingCenter = require 'src/testingcenter'


-- game objects

require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/ControlState'
require 'src/states/GameOverState'
require 'src/states/NextLevelState'
require 'src/states/PlayState'
require 'src/states/StartState'



require 'src/Animation'

require 'src/Util'




gFonts = {
	small = love.graphics.newFont('assets/font/bit.ttf', 50),
	medium = love.graphics.newFont('assets/font/bit.ttf', 64),
	large = love.graphics.newFont('assets/font/bit.ttf', 128)
}

gSounds = {
    ['level1'] = love.audio.newSource('sounds/level1.mp3', 'static'),
    ['select1'] = love.audio.newSource('sounds/select1.wav', 'static'),
    ['select2'] = love.audio.newSource('sounds/select2.wav', 'static'),
    ['death'] = love.audio.newSource('sounds/death.wav', 'static'),
    ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
    ['coin'] = love.audio.newSource('sounds/coin.wav', 'static'),
    ['powerup1'] = love.audio.newSource('sounds/powerup1.wav', 'static'),
    ['player-hurt'] = love.audio.newSource('sounds/player-hurt.wav', 'static'),
    ['mainmenu'] = love.audio.newSource('sounds/mainmenu.mp3', 'static'),
    ['congrats'] = love.audio.newSource('sounds/congrats.mp3', 'static')
}

gTextures = {
    background = love.graphics.newImage("assets/citybig.png"),
    background2= love.graphics.newImage("assets/city2_2x.png"),
    hero = love.graphics.newImage('assets/cesca run animation.png'),
    heroF = love.graphics.newImage('assets/cesca run with face shield.png'),
    heroP = love.graphics.newImage('assets/ppe run animation.png'),
    heroM = love.graphics.newImage('assets/cesca run with mask.png'),
    heroA = love.graphics.newImage('assets/cesca with alcohol.png'),
    virus = love.graphics.newImage('assets/virus.png'),
    coins = love.graphics.newImage('assets/coin7f.png'),
    mask = love.graphics.newImage('assets/mask.png'),
    faceshield = love.graphics.newImage('assets/faceshield.png'),
    ppe = love.graphics.newImage('assets/ppe.png'),
    alcohol = love.graphics.newImage('assets/alcohol.png'),
    faceshieldBar = love.graphics.newImage('assets/faceshield bar.png'),
    alcoholBar = love.graphics.newImage('assets/alcohol bar.png'),
    ppeBar = love.graphics.newImage('assets/ppe bar.png'),
    maskBar = love.graphics.newImage('assets/mask bar.png'),
    heartBar = love.graphics.newImage('assets/heart bar2.png'),
    toxic2 = love.graphics.newImage('assets/toxic2.png'),
    testingcenter = love.graphics.newImage('assets/testing centerbigt.png')
}

gFrames = {
    hero = GenerateQuads(gTextures.hero, 25, 45),
    heroF = GenerateQuads(gTextures.heroF, 25, 45),
    heroP = GenerateQuads(gTextures.heroP, 25, 45),
    heroM = GenerateQuads(gTextures.heroM, 25, 45),
    virus = GenerateQuads(gTextures.virus, 32, 32),
    coins = GenerateQuads(gTextures.coins, 16, 16),
    mask = GenerateQuads(gTextures.mask, 40, 40),
    faceshield = GenerateQuads(gTextures.faceshield, 32, 32),
    ppe = GenerateQuads(gTextures.ppe, 39, 35),
    alcohol = GenerateQuads(gTextures.alcohol, 35, 35),
    faceshieldBar = GenerateQuads(gTextures.faceshieldBar, 37, 6),
    alcoholBar = GenerateQuads(gTextures.alcoholBar, 37, 6),
    ppeBar = GenerateQuads(gTextures.ppeBar, 55,6),
    maskBar = GenerateQuads(gTextures.maskBar, 28,6),
    heartBar = GenerateQuads(gTextures.heartBar, 36,6),
    toxic2 = GenerateQuads(gTextures.toxic2, 256, 128),
    testingcenter = GenerateQuads(gTextures.testingcenter, 100, 110)
}
