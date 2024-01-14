import "CoreLibs/graphics"

-- LuaFormatter off
local pd <const> = playdate
local gfx <const> = playdate.graphics
-- LuaFormatter on

-- Player variables
local playerX, playerY = 200, 120
local playerSpeed = 3
local velocityX, velocityY = 0, 0
local playerLength = {}
local playerAngle = 0

-- Apple variables
local appleX, appleY = math.random(5, 395), math.random(35, 235)

-- Score variables
local score = 0

local function resetPlayer()
    playerX, playerY = 200, 120
    velocityX, velocityY = 0, 0
    score, playerAngle = 0, 0
    playerSpeed = 3
    playerLength = {}
    collectgarbage()
end

local function resetApple()
    appleX, appleY = math.random(5, 395), math.random(35, 235)
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
    if playerX < 0 or playerX > 400 or playerY < 30 or playerY > 240 then
        resetPlayer()
        resetApple()
    end
end

local function socreBorder()
    -- Draw top border
    gfx.fillRect(0, 0, 400, 30)

    -- Draw score border
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(10, 5, 95, 20, 10)
    gfx.setColor(gfx.kColorBlack)

    -- Display score
    gfx.drawText("*Score:* " .. score, 20, 7)
end

local function playerCollisionApple()
    if playerX + 10 >= appleX and playerX - 10 <= appleX then
        if playerY + 10 >= appleY and playerY - 10 <= appleY then
            resetApple()
            score = score + 1

            if score % 20 == 0 and playerSpeed < 6 then
                playerSpeed = playerSpeed + 1
            end
        end
    end
end

local function drawPlayer()

    -- LuaFormatter off
    playerLength[#playerLength + 1] = { playerX, playerY }
    -- LuaFormatter on

    if #playerLength > score + 1 then table.remove(playerLength, 1) end

    -- draw player body
    for i = 1, #playerLength do
        gfx.fillRect(playerLength[i][1], playerLength[i][2], 10, 10)

        -- Apple collision with player body
        if appleX == playerLength[i][1] and appleY == playerLength[i][2] then
            resetApple()
        end

        -- Player collision with player body
        if #playerLength == i then break end
        if playerX == playerLength[i][1] and playerY == playerLength[i][2] then
            resetPlayer()
            resetApple()
            break
        end
    end
end

local function drawApple() gfx.fillCircleAtPoint(appleX, appleY, 5) end

function pd.update()
    -- Update the game state here
    gfx.clear()

    -- Draw score border
    socreBorder()

    -- Draw the game state here
    drawPlayer()
    drawApple()

    -- Update player position
    playerMovement()
    playerCollision()
    playerCollisionApple()

end
