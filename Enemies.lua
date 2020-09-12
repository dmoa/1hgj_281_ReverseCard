local Enemies = {
    -- no SOA today I'm too tired
    ball_img = lg.newImage("ball.png"),
    enemy_img = lg.newImage("enemy.png"),
    enemies = {},
    bullets =   {},
    tick = 1,
    max_v = 300,
    max_v_2 = 50
}

function Enemies:Draw()
    for _, v in ipairs(self.enemies) do
        lg.setColor(v.color)
        lg.draw(self.enemy_img, v.pos.x, v.pos.y)
    end
    for _, v in ipairs(self.bullets) do
        lg.setColor(v.color)
        lg.draw(self.ball_img, v.pos.x, v.pos.y)
    end
    lg.setColor(1, 1, 1, 1)
end

function Enemies:Update(dt)
    self.tick = self.tick - dt
    if self.tick < 0 then
        self.tick = 1
        self:NewEnemy()
    end

    for _, v in ipairs(self.enemies) do
        local xv = v.destination.x - v.pos.x
        local yv = v.destination.y - v.pos.y
        if math.abs(xv) > self.max_v then
            if xv < 0 then
                xv = - self.max_v
            else
                xv = self.max_v
            end
        end
        if math.abs(yv) > self.max_v then
            if yv < 0 then
                yv = - self.max_v
            else
                yv = self.max_v
            end
        end

        v.pos.x = v.pos.x + xv * dt
        v.pos.y = v.pos.y + yv * dt

        v.tick = v.tick - dt
        if v.tick < 0 then
            v.tick = 3
            self:NewBullet(v.pos.x, v.pos.y)
        end
    end

    for _, v in ipairs(self.bullets) do

        v.destination.x = player.x
        v.destination.y = player.y

        local xd = v.destination.x - v.pos.x
        local yd = v.destination.y - v.pos.y

        local new_xv = xd / (xd + yd) * self.max_v_2
        local new_yv = yd / (xd + yd) * self.max_v_2

        if xd < 0 then new_xv = new_xv * -1 end
        if yd < 0 then new_yv = new_yv * -1 end

        v.pos.x = v.pos.x + new_xv * dt
        v.pos.y = v.pos.y + new_yv * dt
    end

end

function Enemies:NewEnemy()
    local new = {
        pos = {x = - game_width - lm.random(300), y = - game_height - lm.random(300)},
        destination = {x = player.x, y = player.y},
        color = {lm.random(), lm.random(), lm.random()},
        tick = 3
    }

    if lm.random() < 0 then
        new.pos.x = new.pos.x * -1
    end
    if lm.random() < 0 then
        new.pos.y = new.pos.y * -1
    end

    table.insert(self.enemies, new)
end

function Enemies:NewBullet(_x, _y)
    local new = {
        pos = {x = _x, y = _y},
        oldpos = {x = -1, y = -1},
        color = {lm.random(), lm.random(), lm.random()},
        destination = {x = player.x, y = player.y},
        tick = 3
    }

    table.insert(self.bullets, new)
end

Enemies:NewEnemy()


return Enemies