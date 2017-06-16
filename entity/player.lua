Player = {}
Player.__index = Player

local sprite = love.graphics.newImage("graphics/player.png")

function Player.new(x,y)
    local entity = {
        animation = Animation.new(sprite),
        prevTime = love.timer.getTime(),
        animTime = love.timer.getTime(),
        pKey = nil,
        rKey = nil,
        w = 32,
        h = 32,
        speed = 5,
        angle = 0,
        xscale = 1,
        yscale = 1,
        xpos = 16,
        ypos = 16,
        dx = 0,
        dy = 0,
        x = x,
        y = y
    }
    entity.animation:setSize(entity.w, entity.h)
    entity.animation:addType("green",0,2)
    entity.animation:addType("yellow",1,2)
    entity.animation:addType("blue",2,2)
    entity.animation:setType("yellow")
    entity.animation:update()
    setmetatable(entity, Player)
    return entity
end

function Player:update(curTime)
    local keyA, keyD, keyW, keyS =
    love.keyboard.isDown("a"), love.keyboard.isDown("d"),
    love.keyboard.isDown("w"), love.keyboard.isDown("s")

    if (keyA==false and keyD==false) then self.dx = 0 end
    if (keyW==false and keyS==false) then self.dy = 0 end

    if (keyA) then self.dx = -self.speed end
    if (keyD) then self.dx = self.speed end
    if (keyW) then self.dy = -self.speed end
    if (keyS) then self.dy = self.speed end

    -- Move
    if (curTime - self.prevTime > 0.016) then
        self.prevTime = curTime
        self.x = self.x + self.dx
        self.y = self.y + self.dy
    end

    -- Animation
    if (curTime - self.animTime > 0.3) then
        self.animTime = curTime
        if (self.animation:isLastFrame()) then
            local type = self.animation:getType()
            if (type=="green") then self.animation:setType("yellow")
            elseif (type=="yellow") then self.animation:setType("blue")
            elseif (type=="blue") then self.animation:setType("green")
            end
        end
        self.animation:update()
    end
end

function Player:onKeyPressed(key)
    -- Shake
    if (key == "space") then
        Camera:shake(-0.1)
    end
end

function Player:draw()
    if (Camera.shaked) then
        love.graphics.print("SHAKED!", self.x - 24, self.y - 32)
    end
    self.animation:draw(self.x, self.y, self.angle,
                        self.xscale, self.yscale, self.xpos, self.ypos)
end
