import "CoreLibs/graphics"

-- LuaFormatter off
local pd <const> = playdate
local gfx <const> = playdate.graphics
-- LuaFormatter on

-- Player variables
local playerX, playerY = 200, 120
local playerSpeed = 3
local velocityX, velocityY = 0, 0

-- Apple variables
local appleX, appleY = math.random(0, 400), math.random(0, 240)
local score = "0000"

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

    if playerY < 0 then
        playerY = 240
    elseif playerY > 240 then
        playerY = 0
    end
end

function pd.update()
    -- Update the game state here
    gfx.clear()

    -- Draw the game state here
    gfx.fillRect(playerX, playerY, 10, 10)
    gfx.fillCircleAtPoint(appleX, appleY, 5)

    -- Draw score border
    gfx.fillRect(20, 5, 90, 20)
    gfx.fillCircleAtPoint(20, 15, 10)
    gfx.fillCircleAtPoint(110, 15, 10)

    -- Draw score
    gfx.setImageDrawMode(gfx.kDrawModeFillWhite)
    gfx.drawText("*Score:* " .. score, 20, 7)

    -- Update player position
    playerMovement()
    playerCollision()
end
