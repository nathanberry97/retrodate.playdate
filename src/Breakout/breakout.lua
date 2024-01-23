class('Breakout').extends()

-- LuaFormatter off
local pd <const> = playdate
local gfx <const> = playdate.graphics
-- LuaFormatter on

-- Game variables
local score = 0

-- Game over
local gameOver = false

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

function Breakout:update()
    -- Check if game over if so reset game
    if gameOver then gameOver = false end

    -- Draw score border
    scoreBorder()

    return gameOver
end
