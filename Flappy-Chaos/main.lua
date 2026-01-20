function love.load()
    love.window.setTitle("Flappy Chaos")
    player = { x =100, y = 300, velocity = 0, size = 50 }
    playerSprite = love.graphics.newImage("assets/images/bomba.png")
    
    screenHeight = love.graphics.getHeight()
    screenWidth = love.graphics.getWidth()
    
    
    gravity = 1000
    jumpForce = -350    
    modifiers = {
        invertedGravity = false,
        flippedScreen = false,
        giantMode = false 
    }
    
    pipesSeed = 200
    spawnTimer = 0
    spawnInterval = 1.5
    pipeWidth = 50
    gapHeight = 150
    
    effectTimer = 0
    
    math.randomseed(os.time())
    
    resetGame()
end

function resetGame()
    player.y = screenHeight / 2
    player.velocity = 0
    player.size = 50
    resetModifiers()

    pipes = {}
    spawnTimer = 0
end

function spawnPipe()
    local pipe = {}
    pipe.x = screenWidth

    local minGapY = 50
    local maxGapY = screenHeight - gapHeight - 50

    pipe.gapY = math.random(minGapY, maxGapY)

    table.insert(pipes, pipe)
    
end

function checkCollision(pipe)
    local bx = 100
    local by = player.y
    local bw = player.size
    local bh = player.size

    if bx < pipe.x + pipeWidth and
        bx + bw > pipe.x and
        by < pipe.gapY and
        by + bh > 0 then
        return true
    end

    if bx < pipe.x + pipeWidth and
        bx + bw > pipe.x and
        by < screenHeight and
        by + bh > pipe.gapY + gapHeight then
        return true
    end
    return false
end

function love.update(dt)
    if effectTimer > 0 then
        effectTimer = effectTimer - dt
    else
        if modifiers.invertedGravity or modifiers.flippedScreen or modifiers.giantMode then
            resetModifiers()
        end
    end

    local currentGravity = gravity
    
    if modifiers.invertedGravity then
        currentGravity = -gravity
    end
    
    player.velocity = player.velocity + currentGravity * dt
    player.y = player.y + player.velocity * dt

    if player.y < 0 then
        player.y = 0
        player.velocity = 0
    end

    if (player.y + player.size) > screenHeight then
        resetGame()
    end 

    spawnTimer = spawnTimer - dt
    if spawnTimer <= 0 then
        spawnPipe()
        spawnTimer = spawnInterval
    end

    for i = #pipes, 1, -1 do
        local p = pipes[i]
        p.x = p.x - pipesSeed * dt

        if p.x + pipeWidth < 0 then
            table.remove(pipes, i)
        end

        if checkCollision(p) then
            resetGame()
        end
    end
end

function love.draw()
    love.graphics.push()

    if modifiers.flippedScreen then
        love.graphics.translate(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
        love.graphics.rotate(math.pi)
        love.graphics.translate(-love.graphics.getWidth()/2, -love.graphics.getHeight()/2)
    end
    
    love.graphics.setColor(0, 1, 0)

    for _, p in pairs(pipes) do
        love.graphics.rectangle("fill", p.x, 0, pipeWidth, p.gapY)
        love.graphics.rectangle("fill", p.x, p.gapY + gapHeight, pipeWidth, screenHeight - (p.gapY + gapHeight))
    end

    
    if modifiers.giantMode then
        love.graphics.setColor(1, 0, 0)
    else
        love.graphics.setColor(1, 1, 1)
    end
    local scaleX = player.size / playerSprite:getWidth()
    local scaleY = player.size / playerSprite:getHeight()

    love.graphics.draw(playerSprite, player.x, player.y, 0, scaleX, scaleY)
    love.graphics.pop()
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Tempo do Efeito: " .. string.format("%.1f", effectTimer), 10, 10)
end

function love.keypressed(key)
    if key == "space" then
        local force = jumpForce
        if modifiers.invertedGravity then
            force = -jumpForce
        end
        player.velocity = force
    end

    if key == "1" then triggerEffect("invertedGravity") end
    if key == "2" then triggerEffect("flippedScreen") end
    if key == "3" then triggerEffect("giantMode") end
end

function triggerEffect(name)
    resetModifiers()
    modifiers[name] = true
    effectTimer = 5

    if name == "giantMode" then
        player.size = 80
    end
end

function resetModifiers()
    for k, v in pairs(modifiers) do
        modifiers[k] = false
    end
    player.size = 50
end