Camera = {xview = 0, yview = 0}

function Camera:setFocus(x,y,w,h,difMax,speed)
    if (x - self.xview > w - difMax) then self.xview = self.xview + speed end
    if (x - self.xview < difMax) then self.xview = self.xview - speed end
    if (y - self.yview > h - difMax) then self.yview = self.yview + speed end
    if (y - self.yview < difMax) then self.yview = self.yview - speed end
    Camera:setPosition(self.xview, self.yview)
end

function Camera:setPosition(x, y)
    love.graphics.push()
    love.graphics.translate(-x, -y)
end

function Camera:reset()
    love.graphics.pop()
end
