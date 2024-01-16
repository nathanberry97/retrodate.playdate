import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"

import "Menu/menu"

-- LuaFormatter off
local pd <const> = playdate
local gfx <const> = playdate.graphics
-- LuaFormatter on

function pd.update()
    -- Update the game state here
    gfx.clear()
    Menu:update()
end
