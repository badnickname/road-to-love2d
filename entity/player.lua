Player = {}
Player.__index = Player

local sprite = love.graphics.newImage("graphics/player.png")

function Player.new(x,y)
    local entity = {
        animation = Animation.new(sprite),
        prevTime = love.timer.getTime(),
        w = 32,
        h = 32,
        angle = 0,
        xscale = 1,
        yscale = 1,
        xpos = 16,
        ypos = 16,
        x = x,
        y = y
    }
    entity.animation:setSize(entity.w, entity.h)
    entity.animation:addType("green",0,2)
    entity.animation:addType("yellow",1,2)
    entity.animation:setType("yellow")
    entity.animation:update()
    setmetatable(entity, Player)
    return entity
end

function Player:update(curTime)
    self.angle = self.angle + 0.01
    if (curTime - self.prevTime > 0.3) then
        self.prevTime = curTime
        self.animation:update()
    end
end

function Player:draw()
    self.animation:draw(self.x, self.y, self.angle,
                        self.xscale, self.yscale, self.xpos, self.ypos)
end
