LoadingState = Class{__includes = BaseState}


function LoadingState:init()
    self:loadAssets()
    gSounds['loadingbgm']:setLooping(true)
    gSounds['loadingbgm']:setVolume(0.25)
    gSounds['loadingbgm']:play()
end

function LoadingState:enter()

end

function LoadingState:loadAssets()
    self.animation = {state}

    self.animation = Animation {
        frames = {1,2,3,4,5,6,7,6,5,4,3,2,1,8,8,8,8,8,1,1},
        interval = 0.5,
    }

    self.currentAnimation = self.animation
end

function LoadingState:update(dt)
  if self.animation.currentFrame == 20 then
  gSounds['loadingbgm']:stop()
  gStateMachine:change('start')
end
    self.currentAnimation:update(dt)
end

function LoadingState:render()
          if self.animation.currentFrame <= 20 then
            love.graphics.draw(gTextures.logo, gFrames.logo[self.currentAnimation:getCurrentFrame()], 0, 0, 0, 5, 5)
          end

end

function LoadingState:exit()
end
