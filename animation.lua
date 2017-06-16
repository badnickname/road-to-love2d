Animation = {}
Animation.__index = Animation

function Animation.new(sprite)
    local entity = {
        curAnim = 0,
        curFrame = 0,
        w = 32,
        h = 32,
        type = {},
        texture = sprite,
        frame = love.graphics.newQuad(0,0,0,0,sprite:getDimensions())
    }
    setmetatable(entity, Animation)
    return entity
end

function Animation:addType(name, vPos, maxFrames)
    self.type[name] = {pos = vPos, rBorder = maxFrames}
end

function Animation:setType(name)
    self.curAnim = name
end

function Animation:getType()
    return self.curAnim
end

function Animation:setSize(w, h)
    self.w = w
    self.h = h
end

function Animation:isLastFrame()
    if (self.curFrame == self.type[self.curAnim].rBorder) then
        return true
    end
    return false
end

function Animation:update()
    local isAnimationEnd = false

    if (self.curFrame < self.type[self.curAnim].rBorder) then
        self.curFrame = self.curFrame + 1
    else
        self.curFrame = 0
    end
    self.frame:setViewport(self.curFrame * self.w,
                           self.type[self.curAnim].pos * self.h,
                           self.w, self.h)
    return isAnimationEnd
end

function Animation:draw(x, y, r, sx, sy, ox, oy)
    love.graphics.draw(self.texture, self.frame, x, y, r, sx, sy, ox, oy)
end
