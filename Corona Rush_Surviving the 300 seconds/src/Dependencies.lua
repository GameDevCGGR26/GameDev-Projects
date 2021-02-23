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
require 'src/states/HowToPlayState'
require 'src/states/GameOverState'
require 'src/states/NextLevelState'
require 'src/states/PlayState'
require 'src/states/PlayState2'
require 'src/states/PlayState3'
require 'src/states/StartState'
require 'src/states/StartState2'
require 'src/states/CharacterSelectState'
require 'src/states/CharacterSelectState2'
require 'src/states/EndCreditState'


-- game cutscenes
require 'src/cutscenes/cutscene1'
require 'src/cutscenes/cutscene2'
require 'src/cutscenes/cutscene3'

-- game cutscene states
require 'src/states/Cutscene1State'
require 'src/states/Cutscene1State2'
require 'src/states/Cutscene2State'
require 'src/states/Cutscene3State'

require 'src/Animation'

require 'src/Util'




gFonts = {
    xxsmall = love.graphics.newFont('assets/font/bit.ttf', 30),
    xsmall = love.graphics.newFont('assets/font/bit.ttf', 40),
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
    ['congrats'] = love.audio.newSource('sounds/congrats.mp3', 'static'),
    ['news'] = love.audio.newSource('sounds/breaking-news.mp3', 'static'),
    ['bgm1'] = love.audio.newSource('sounds/mysteriousbg.mp3', 'static'),
    ['end-credit'] = love.audio.newSource('sounds/end-credits.mp3', 'static'),
    ['level2'] = love.audio.newSource('sounds/level2.mp3', 'static'),
    ['level3'] = love.audio.newSource('sounds/level3.mp3', 'static')
}

gTextures = {
    background = love.graphics.newImage('assets/citybig.png'),
    background2= love.graphics.newImage('assets/city2_2x.png'),
    bgcharselect = love.graphics.newImage('assets/bgcharselect.png'),
    dialogboxcs = love.graphics.newImage('assets/dialogboxcs.png'),
    selecttool = love.graphics.newImage('assets/selecttool.png'),
    mainmenutitle = love.graphics.newImage('assets/mainmenu.png'),
    mainmenubg = love.graphics.newImage('assets/main menu bg sprite.png'),
    nextlvlbg = love.graphics.newImage('assets/nextlevelbg.png'),
    h2play1 = love.graphics.newImage('assets/1h2play.png'),
    h2play2 = love.graphics.newImage('assets/2h2play.png'),
    h2play3 = love.graphics.newImage('assets/3h2play.png'),
    gameoverbg = love.graphics.newImage('assets/gameoverbg.png'),
    toxic2 = love.graphics.newImage('assets/toxic2.png'),

    news = love.graphics.newImage('assets/cutscene/news reporter.png'),
    news1 = love.graphics.newImage('assets/cutscene/news reporter1.png'),
    news4 = love.graphics.newImage('assets/cutscene/news reporter4.png'),
    eyeopen = love.graphics.newImage('assets/cutscene/eye open.png'),
    curtain = love.graphics.newImage('assets/cutscene/curtain.png'),
    hospital = love.graphics.newImage('assets/cutscene/hospital.png'),
    oxygen = love.graphics.newImage('assets/cutscene/oxygen mask.png'),
    meet = love.graphics.newImage('assets/cutscene/meeting.png'),
    window = love.graphics.newImage('assets/cutscene/looking at window.png'),
    chaos = love.graphics.newImage('assets/cutscene/chaos.png'),
    chaos4 = love.graphics.newImage('assets/cutscene/chaos4.png'),
    friends = love.graphics.newImage('assets/cutscene/che and ces.png'),



    hero1 = love.graphics.newImage('assets/cesca run animation.png'),
    hero1F = love.graphics.newImage('assets/cesca run with face shield.png'),
    hero1M = love.graphics.newImage('assets/cesca run with mask.png'),
    hero1A = love.graphics.newImage('assets/cesca with alcohol.png'),
    hero1I = love.graphics.newImage('assets/cesca idle.png'),
    hero1Inw = love.graphics.newImage('assets/cesca idle nw.png'),

    hero2 = love.graphics.newImage('assets/che run animation.png'),
    hero2F = love.graphics.newImage('assets/che run with fs animation.png'),
    hero2M = love.graphics.newImage('assets/che run with mask animation.png'),
    hero2A = love.graphics.newImage('assets/che with alcohol.png'),
    hero2I = love.graphics.newImage('assets/che idle.png'),
    hero2Inw = love.graphics.newImage('assets/che idle nw.png'),

    hero3 = love.graphics.newImage('assets/jorel run animation.png'),
    hero3F = love.graphics.newImage('assets/jorel run with fs animation.png'),
    hero3M = love.graphics.newImage('assets/jorel run with mask animation.png'),
    hero3A = love.graphics.newImage('assets/jorel with alcohol.png'),
    hero3I = love.graphics.newImage('assets/jorel idle.png'),
    hero3Inw = love.graphics.newImage('assets/jorel idle nw.png'),

    hero4 = love.graphics.newImage('assets/ranay run animation.png'),
    hero4F = love.graphics.newImage('assets/ranay run with fs animation.png'),
    hero4M = love.graphics.newImage('assets/ranay run with mask animation.png'),
    hero4A = love.graphics.newImage('assets/ranay with alcohol.png'),
    hero4I = love.graphics.newImage('assets/ranay idle.png'),
    hero4Inw = love.graphics.newImage('assets/ranay idle nw.png'),

    heroP = love.graphics.newImage('assets/ppe run animation.png'),

    virus = love.graphics.newImage('assets/virus.png'),
    coins = love.graphics.newImage('assets/coin7f.png'),
    heartBar = love.graphics.newImage('assets/heart bar2.png'),
    testingcenter = love.graphics.newImage('assets/testing centerbigt.png'),

    mask = love.graphics.newImage('assets/mask.png'),
    faceshield = love.graphics.newImage('assets/faceshield.png'),
    ppe = love.graphics.newImage('assets/ppe.png'),
    alcohol = love.graphics.newImage('assets/alcohol.png'),

    faceshieldBar = love.graphics.newImage('assets/faceshield bar.png'),
    alcoholBar = love.graphics.newImage('assets/alcohol bar.png'),
    ppeBar = love.graphics.newImage('assets/ppe bar.png'),
    maskBar = love.graphics.newImage('assets/mask bar.png'),

    nfaceshieldBar = love.graphics.newImage('assets/faceshieldnormalbar.png'),
    nalcoholBar = love.graphics.newImage('assets/alcoholnormalbar.png'),
    nppeBar = love.graphics.newImage('assets/ppenormalbar.png'),
    nmaskBar = love.graphics.newImage('assets/masknormalbar.png')
}

gFrames = {
    mainmenutitle = GenerateQuads(gTextures.mainmenutitle, 256,144),
    mainmenubg = GenerateQuads(gTextures.mainmenubg, 256,144),
    gameoverbg = GenerateQuads(gTextures.gameoverbg, 256, 144),
    h2play1 = GenerateQuads(gTextures.h2play1, 256, 144),
    h2play2 = GenerateQuads(gTextures.h2play2, 256, 144),
    h2play2 = GenerateQuads(gTextures.h2play3, 256, 144),
    toxic2 = GenerateQuads(gTextures.toxic2, 256, 128),

    news = GenerateQuads(gTextures.news, 256, 144),
    chaos = GenerateQuads(gTextures.chaos, 256, 144),
    eyeopen = GenerateQuads(gTextures.eyeopen, 256, 144),
    oxygen = GenerateQuads(gTextures.oxygen, 256, 144),

    hero1 = GenerateQuads(gTextures.hero1, 25, 45),
    hero1F = GenerateQuads(gTextures.hero1F, 25, 45),
    hero1M = GenerateQuads(gTextures.hero1M, 25, 45),

    hero2 = GenerateQuads(gTextures.hero2, 27, 45),
    hero2F = GenerateQuads(gTextures.hero2F, 27, 45),
    hero2M = GenerateQuads(gTextures.hero2M, 27, 45),

    hero3 = GenerateQuads(gTextures.hero3, 25, 45),
    hero3F = GenerateQuads(gTextures.hero3F, 25, 45),
    hero3M = GenerateQuads(gTextures.hero3M, 25, 45),

    hero4 = GenerateQuads(gTextures.hero4, 27, 45),
    hero4F = GenerateQuads(gTextures.hero4F, 27, 45),
    hero4M = GenerateQuads(gTextures.hero4M, 27, 45),

    heroP = GenerateQuads(gTextures.heroP, 25, 45),

    virus = GenerateQuads(gTextures.virus, 32, 32),
    coins = GenerateQuads(gTextures.coins, 16, 16),
    heartBar = GenerateQuads(gTextures.heartBar, 36,6),
    testingcenter = GenerateQuads(gTextures.testingcenter, 100, 110),

    mask = GenerateQuads(gTextures.mask, 40, 40),
    faceshield = GenerateQuads(gTextures.faceshield, 32, 32),
    ppe = GenerateQuads(gTextures.ppe, 39, 35),
    alcohol = GenerateQuads(gTextures.alcohol, 35, 35),

    faceshieldBar = GenerateQuads(gTextures.faceshieldBar, 37, 6),
    alcoholBar = GenerateQuads(gTextures.alcoholBar, 37, 6),
    ppeBar = GenerateQuads(gTextures.ppeBar, 55,6),
    maskBar = GenerateQuads(gTextures.maskBar, 28,6),

    nfaceshieldBar = GenerateQuads(gTextures.nfaceshieldBar, 27, 6),
    nalcoholBar = GenerateQuads(gTextures.nalcoholBar, 27, 6),
    nppeBar = GenerateQuads(gTextures.nppeBar, 45,6),
    nmaskBar = GenerateQuads(gTextures.nmaskBar, 18,6)
}
