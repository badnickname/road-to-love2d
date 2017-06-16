require("animation")
require("entity.player")
require("camera")

local objects = {}
local numObj = 0
local curTime, prevTime = love.timer.getTime()
local objPlayer = {}

function love.load()
    objPlayer = Player.new(120,120)
    table.insert(objects, objPlayer)
end

function love.update()
    -- Step
    curTime = love.timer.getTime()
    for i,v in pairs(objects) do
        objects[i]:update(curTime)
    end

    -- Input
    --[[if love.mouse.isDown(1) then
        table.insert(objects, Player.new(love.mouse.getX(),love.mouse.getY()))
        numObj = numObj + 1
    end]]--
end

function love.draw()
    love.graphics.print("FPS: "..love.timer.getFPS(), 0, 0)

    Camera:setFocus(objPlayer.x,objPlayer.y,320,320,100,objPlayer.speed)

    love.graphics.print("start positon\nobjects: "..numObj, 0, 32)
    for i,v in pairs(objects) do
        objects[i]:draw()
    end

    Camera:reset()
end
