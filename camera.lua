Camera = {xview = 0, yview = 0, rcur = 0, rnext = 0, shaked = false,
          prevTime = love.timer.getTime(), limshake = 0.01}

function Camera:setFocus(x,y,w,h,difMax,speed,curTime)
    love.graphics.push()

    if (self.shaked) then
        love.graphics.translate(w/2, h/2)
        love.graphics.rotate(self.rcur)
        love.graphics.translate(-w/2, -h/2)

        -- Timer begin
        if (curTime - self.prevTime > 0.001) then
            self.prevTime = curTime

            if (self.speed>0) then
                if (self.rcur > self.rnext) then
                    self.rnext = -self.rcur+self.limshake
                    self.speed = -self.speed
                else
                    self.rcur = self.rcur + self.speed
                end
            else
                if (self.rcur < self.rnext) then
                    self.rnext = -self.rcur-self.limshake
                    self.speed = -self.speed
                else
                    self.rcur = self.rcur + self.speed
                end
            end

            if (math.abs(self.rnext) < self.limshake) then
                self.shaked = false
            end

        end
        -- Timer end

    end

    if (x - self.xview > w - difMax) then self.xview = self.xview + speed end
    if (x - self.xview < difMax) then self.xview = self.xview - speed end
    if (y - self.yview > h - difMax) then self.yview = self.yview + speed end
    if (y - self.yview < difMax) then self.yview = self.yview - speed end
    Camera:setPosition(self.xview, self.yview)
end

function Camera:shake(amount)
    self.shaked = true
    self.rcur = amount
    self.rnext = -amount + 0.005
    self.speed = -0.005
end

function Camera:setPosition(x, y)
    love.graphics.translate(-x, -y)
end

function Camera:reset()
    love.graphics.pop()
end
