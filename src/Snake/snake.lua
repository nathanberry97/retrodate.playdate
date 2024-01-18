class('Snake').extends()

-- LuaFormatter off
local pd <const> = playdate
local gfx <const> = playdate.graphics
-- LuaFormatter on

-- Player variables
local playerX, playerY = 265, 110
local playerSpeed = 3
local velocityX, velocityY = 0, 0
local playerLength = {}
local playerAngle = 0

-- Apple variables
local appleX, appleY = math.random(155, 380), math.random(20, 220)

-- Score variables
local score = 0

-- Game over
local gameOver = false

local function gameOverScreen()
    gameOver = true
    gfx.fillRect(0, 0, 400, 240)
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    gfx.drawText("*Game Over*", 150, 100)
    gfx.drawText("*Score:* " .. score, 150, 120)
    gfx.setImageDrawMode(gfx.kDrawModeCopy)
    pd.wait(1000)
end

local function resetPlayer()
    playerX, playerY = 265, 110
    velocityX, velocityY = 0, 0
    score, playerAngle = 0, 0
    playerSpeed = 3
    playerLength = {}
    collectgarbage()
end

local function resetApple()
    appleX, appleY = math.random(155, 380), math.random(20, 220)
end

local function playerMovement()
    if pd.buttonIsPressed(pd.kButtonUp) and playerAngle ~= 2 then
        velocityY, velocityX = -playerSpeed, 0
        if score > 0 then playerAngle = 1 end
    elseif pd.buttonIsPressed(pd.kButtonDown) and playerAngle ~= 1 then
        velocityY, velocityX = playerSpeed, 0
        if score > 0 then playerAngle = 2 end
    elseif pd.buttonIsPressed(pd.kButtonLeft) and playerAngle ~= 4 then
        velocityX, velocityY = -playerSpeed, 0
        if score > 0 then playerAngle = 3 end
    elseif pd.buttonIsPressed(pd.kButtonRight) and playerAngle ~= 3 then
        velocityX, velocityY = playerSpeed, 0
        if score > 0 then playerAngle = 4 end
    end

    -- Update player position
    playerX = playerX + velocityX
    playerY = playerY + velocityY
end

local function playerCollision()
    if playerX < 145 or playerX > 390 or playerY < 10 or playerY > 230 then
        gameOverScreen()
        resetPlayer()
        resetApple()
    end
end

local function scoreBorder()
    -- Set background scene
    gfx.setBackgroundColor(gfx.kColorBlack)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(150, 15, 235, 210, 3)
    gfx.drawLine(5, 15, 135, 15)
    gfx.drawLine(5, 80, 135, 80)
    gfx.setColor(gfx.kColorBlack)

    -- Display score
    local original_draw_mode = gfx.getImageDrawMode()
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    gfx.drawText("*Score:* ", 15, 30)
    gfx.drawText(score, 15, 50)
    gfx.setImageDrawMode(original_draw_mode)
end

local function drawApple() gfx.fillCircleAtPoint(appleX, appleY, 5) end

local function drawPlayer()
    -- LuaFormatter off
    playerLength[#playerLength + 1] = { playerX, playerY }
    -- LuaFormatter on

    if #playerLength > score + 1 then table.remove(playerLength, 1) end

    -- draw player body
    for i = 1, #playerLength do
        local x = playerLength[i][1]
        local y = playerLength[i][2]

        gfx.fillRect(x, y, 10, 10)

        -- Apple collision with player body
        if x + 5 >= appleX - 10 and x + 5 <= appleX + 10 then
            if y + 5 >= appleY - 10 and y + 5 <= appleY + 10 then
                resetApple()
            end
        end

        -- Player collision with player body
        if #playerLength == i then break end

        local rangeX = playerX <= x + 1 and playerX >= x - 1
        local rangeY = playerY <= y + 1 and playerY >= y - 1

        if rangeX and rangeY then
            gameOverScreen()
            resetPlayer()
            resetApple()
            break
        end
    end
end

local function playerCollisionApple()
    -- draw hit box around apple
    gfx.setColor(gfx.kColorBlack)

    -- Apple collision with player head
    local lowetLeftX, lowetLeftY = appleX - 10, appleY - 10
    local upperRightX, upperRightY = appleX + 10, appleY + 10

    -- Player head center
    local playerCenterX, playerCenterY = playerX + 5, playerY + 5

    if playerCenterX >= lowetLeftX and playerCenterX <= upperRightX then
        if playerCenterY >= lowetLeftY and playerCenterY <= upperRightY then
            resetApple()
            score = score + 1

            if score % 50 == 0 and playerSpeed < 5 then
                playerSpeed = playerSpeed + 1
            end
        end
    end

    -- Apple hit box
    -- local diffX, diffY = upperRightX - lowetLeftX, upperRightY - lowetLeftY
    -- gfx.drawRect(lowetLeftX, lowetLeftY, diffX, diffY)
end

function Snake:update()
    -- Check if game over if so reset game
    if gameOver then gameOver = false end

    -- Draw score border
    scoreBorder()

    -- Draw the game state here
    drawPlayer()
    drawApple()

    -- Update player position
    playerMovement()
    playerCollision()

    -- Apple collision with player head
    playerCollisionApple()

    return gameOver
end
