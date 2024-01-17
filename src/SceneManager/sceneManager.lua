import "../Snake/snake"

class('SceneManager').extends()

-- LuaFormatter off
local pd <const> = playdate
local gfx <const> = playdate.graphics

local games = {
    { name = "*Snake*", x = 180, y = 160, activeY = 158, game = Snake },
    { name = "*Breakout*", x = 170, y = 185, activeY = 183, game = nil },
    { name = "*Tetris*", x = 180, y = 210, activeY = 208, game = nil }
}
-- LuaFormatter on

-- TODO:
-- currentObject always points to Snake need to implement other
-- games before changing this, also will then be able to remove
-- currentGame variable and just use currentObject

local currentGame, currentObject = games[1].name, games[1].game
local play = false

local function menuUi()
    local backgroundImage = gfx.image.new("images/retrodateMenu.png")
    assert(backgroundImage)
    gfx.sprite.setBackgroundDrawingCallback(function()
        backgroundImage:draw(0, 0)
    end)
    gfx.sprite.update()
end

local function displayGames()
    for i = 1, #games do
        if games[i].name == currentGame then
            gfx.setColor(gfx.kColorWhite)
            gfx.fillRoundRect(160.5, games[i].activeY, 85, 20, 10)
            gfx.setColor(gfx.kColorBlack)
            gfx.drawText(games[i].name, games[i].x, games[i].y)
        else
            local original_draw_mode = gfx.getImageDrawMode()
            gfx.setImageDrawMode(gfx.kDrawModeInverted)
            gfx.drawText(games[i].name, games[i].x, games[i].y)
            gfx.setImageDrawMode(original_draw_mode)
        end
    end
end

local function switchGame()
    if pd.buttonJustPressed(pd.kButtonUp) and currentGame == games[2].name then
        currentGame = games[1].name
    elseif pd.buttonJustPressed(pd.kButtonDown) and currentGame == games[1].name then
        currentGame = games[2].name
    elseif pd.buttonJustPressed(pd.kButtonUp) and currentGame == games[3].name then
        currentGame = games[2].name
    elseif pd.buttonJustPressed(pd.kButtonDown) and currentGame == games[2].name then
        currentGame = games[3].name
    end
end

local function selectGame()
    if pd.buttonJustPressed(pd.kButtonA) then play = true end
end

function SceneManager:update()
    if play ~= true then
        menuUi()
        displayGames()
        switchGame()
        selectGame()
    else
        local gameOver = currentObject:update()
        if gameOver == true then play = false end
    end
end
