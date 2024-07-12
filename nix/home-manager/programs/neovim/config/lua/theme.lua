-- This module reads and returns the theme colors from `theme.json`.
--
-- The theme colors are auto-generated, and the resulting colors are stored as
-- JSON data in the config directory. By reading these in a separate module,
-- other Neovim configuration code can simply `require("theme")` to access
-- these colors definitions.
local filepath = os.getenv "XDG_CONFIG_HOME" .. "/theme.json"

local file = io.open(filepath, "r")
if not file then
    return nil
end

local contents = file:read "*all"
return vim.fn.json_decode(contents)
