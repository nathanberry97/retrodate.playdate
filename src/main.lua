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

-- Apple variables
local appleX, appleY = math.random(5, 395), math.random(35, 235)
-- local score = "0000"
local score = 0

local function playerMovement()
    -- Player velocity
    if pd.buttonIsPressed(pd.kButtonUp) then
        velocityY, velocityX = -playerSpeed, 0
    elseif pd.buttonIsPressed(pd.kButtonDown) then
        velocityY, velocityX = playerSpeed, 0
    elseif pd.buttonIsPressed(pd.kButtonLeft) then
        velocityX, velocityY = -playerSpeed, 0
    elseif pd.buttonIsPressed(pd.kButtonRight) then
        velocityX, velocityY = playerSpeed, 0
    end

    -- Update player position
    playerX = playerX + velocityX
    playerY = playerY + velocityY
end

local function playerCollision()
    -- Player collision
    if playerX < 0 then
        playerX = 400
    elseif playerX > 400 then
        playerX = 0
    end

    if playerY < 30 then
        playerY = 240
    elseif playerY > 240 then
        playerY = 30
    end
end

local function socreBorder()
    -- Draw top border
    gfx.fillRect(0, 0, 400, 30)

    -- Draw score border
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRect(20, 5, 90, 20)
    gfx.fillCircleAtPoint(20, 15, 10)
    gfx.fillCircleAtPoint(110, 15, 10)
    gfx.setColor(gfx.kColorBlack)

    -- Display score
    gfx.drawText("*Score:* " .. score, 20, 7)
end

local function playerCollisionApple()
    -- Player collision with apple
    if playerX + 10 >= appleX and playerX - 10 <= appleX then
        if playerY + 10 >= appleY and playerY - 10 <= appleY then
            appleX, appleY = math.random(5, 395), math.random(35, 235)
            score = score + 1
        end
    end
end

local function drawPlayer()

    -- LuaFormatter off
    playerLength[#playerLength + 1] = { playerX, playerY }
    -- LuaFormatter on

    -- remove the first element if table is greater than score
    if #playerLength > score + 1 then table.remove(playerLength, 1) end

    -- draw player body
    for i = 1, #playerLength do
        gfx.fillRect(playerLength[i][1], playerLength[i][2], 10, 10)
    end
end

function pd.update()
    -- Update the game state here
    gfx.clear()

    -- Draw score border
    socreBorder()

    -- Draw the game state here
    drawPlayer()
    gfx.fillCircleAtPoint(appleX, appleY, 5)

    -- Update player position
    playerMovement()
    playerCollision()
    playerCollisionApple()
end
