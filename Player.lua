local Player = {
    x = game_width / 2,
    y = game_height / 2,
    xv = 50,
    yv = 50,
    v = 200,
    images = {lg.newImage("player1.png"),lg.newImage("player2.png"),lg.newImage("player3.png"),lg.newImage("player4.png")},
    direction = 1,
}

function Player:Draw()
    lg.draw(self.images[self.direction], self.x, self.y)
end

function Player:Update(dt)
    self.xv = 0
    self.yv = 0

    if input.right() then
        self.xv = self.v
    end
    if input.up() then
        self.yv = - self.v
    end
    if input.left() then
        self.xv = - self.v
    end
    if input.down() then
        self.yv = self.v
    end

    if self.xv ~= 50 and self.yv ~= 50 then
        self.xv = self.xv / ROOT2
        self.yv = self.yv / ROOT2
    end


    self.x = self.x + self.xv * dt
    self.y = self.y + self.yv * dt


    if self.x < 0 then self.x = 0 end
    if self.y < 0 then self.y = 0 end
    if self.x + self.images[1]:getHeight() > game_width then self.x = game_width - self.images[1]:getHeight() end
    if self.y + self.images[1]:getHeight() > game_height then self.y = game_height - self.images[1]:getHeight() end
end

function Player:NewDirection()
    self.direction = self.direction % 4 + 1
end


return Player