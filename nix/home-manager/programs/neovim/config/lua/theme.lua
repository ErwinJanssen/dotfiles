local filepath = os.getenv "XDG_CONFIG_HOME" .. "/theme.json"

local file = io.open(filepath, "r")
if not file then
    return nil
end

local contents = file:read "*all"
return vim.fn.json_decode(contents)
