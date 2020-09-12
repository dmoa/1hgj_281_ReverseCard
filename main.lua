la = love.audio
ld = love.data
le = love.event
lfile = love.filesystem
lf = love.font
lg = love.graphics
li = love.image
lj = love.joystick
lk = love.keyboard
lm = love.math
lmouse = love.mouse
lp = love.physics
lsound = love.sound
lsys = love.system
lth = love.thread
lt = love.timer
ltouch = love.touch
lv = love.video
lw = love.window
ROOT2 = 1.41421356237

lg.setDefaultFilter("nearest", "nearest", 1)
lg.setLineStyle('rough')

splash = require "libs/splash"

function love.draw() splash:update() end
splash:startSplashScreen("start_screen.png", "", 1500, 500, 0, {}, function()

input = require "libs/input"
push = require "libs/push"
require "libs/AABB"
require "libs/minmaxabs"
game_width, game_height = 512, 512
windowL = 1024
lw.setMode(windowL, windowL, {borderless = false})
push:setupScreen(game_width, game_height, windowL, windowL, {fullscreen = false, resizable = true, borderless = false})

screen = require "libs/shack"
screen:setDimensions(push:getDimensions())



player = require "Player"
enemies = require "Enemies"

function love.draw()
    screen:apply()
    push:start()

    player:Draw()
    enemies:Draw()

    push:finish()
end

function love.update(dt)
    screen:update(dt)
    player:Update(dt)
    enemies:Update(dt)
end

function love.keypressed(key)
    if key == "escape" then le.quit() end
    if key == "return" and lk.isDown("lalt") then push:switchFullscreen() end
    if key == "space" then player:NewDirection() end
end

function love.resize(w, h)
  push:resize(w, h)
  loadingScreen.angle = 0
  lg.clear()
end

end)