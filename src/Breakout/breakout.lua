class('Breakout').extends()

-- LuaFormatter off
local pd <const> = playdate
local gfx <const> = playdate.graphics
-- LuaFormatter on

-- Game variables
local score = 0

-- Paddle variables
local paddleX = 250

-- Ball variables
local ballX, ballY = 272, 205

-- Game over
local gameOver = false

local function gameBorder()
    gfx.setBackgroundColor(gfx.kColorBlack)
    gfx.setColor(gfx.kColorWhite)
    gfx.fillRoundRect(150, 15, 235, 210, 3)
    gfx.drawLine(5, 15, 135, 15)
    gfx.drawLine(5, 80, 135, 80)
    gfx.setColor(gfx.kColorBlack)
end

local function displayScore()
    local original_draw_mode = gfx.getImageDrawMode()
    gfx.setImageDrawMode(gfx.kDrawModeInverted)
    gfx.drawText("*Score:* ", 15, 30)
    gfx.drawText(score, 15, 50)
    gfx.setImageDrawMode(original_draw_mode)
end

local function drawPaddle()
    gfx.setColor(gfx.kColorBlack)
    gfx.fillRoundRect(paddleX, 210, 45, 5, 3)
    gfx.setColor(gfx.kColorWhite)
end

local function movePaddle()
    local paddleSpeed = 2.5

    if pd.buttonIsPressed(pd.kButtonLeft) and paddleX > 150 then
        paddleX = paddleX - paddleSpeed
    elseif pd.buttonIsPressed(pd.kButtonRight) and paddleX < 340 then
        paddleX = paddleX + paddleSpeed
    end
end

local function drawBall()
    gfx.setColor(gfx.kColorBlack)
    gfx.fillCircleAtPoint(ballX, ballY, 5)
    gfx.setColor(gfx.kColorWhite)
end

function Breakout:update()
    -- Check if game over if so reset game
    if gameOver then gameOver = false end

    -- Draw score border
    gameBorder()
    displayScore()
    drawPaddle()
    movePaddle()
    drawBall()

    return gameOver
end
