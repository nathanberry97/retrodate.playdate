import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "SceneManager/sceneManager"

-- LuaFormatter off
local pd <const> = playdate
local gfx <const> = playdate.graphics
-- LuaFormatter on

function pd.update()
    -- Update the game state here
    gfx.clear()
    SceneManager:update()
end
