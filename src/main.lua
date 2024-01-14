import "CoreLibs/object"
import "CoreLibs/graphics"
import "Snake/snake"

-- LuaFormatter off
local pd <const> = playdate
local gfx <const> = playdate.graphics
-- LuaFormatter on

-- Initialise Snake object
Snake()

function pd.update()
    -- Update the game state here
    gfx.clear()

    -- Start snake game
    Snake:update()
end
