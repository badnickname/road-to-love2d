require("animation")
require("entity.player")

local objects = {}
local numObj = 0
local curTime, prevTime = love.timer.getTime()

function love.load()

end

function love.update()
    -- Step
    curTime = love.timer.getTime()
    for i,v in pairs(objects) do
        objects[i]:update(curTime)
    end

    -- Input
    if love.mouse.isDown(1) then
        table.insert(objects, Player.new(love.mouse.getX(),love.mouse.getY()))
        numObj = numObj + 1
    end
end

function love.draw()
    love.graphics.print("FPS: "..love.timer.getFPS(), 0, 0)
    love.graphics.print("objects: "..numObj, 0, 32)
    for i,v in pairs(objects) do
        objects[i]:draw()
    end
end
