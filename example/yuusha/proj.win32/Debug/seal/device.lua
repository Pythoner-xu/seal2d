local platform = require("platform_core")
local device = {}

function device.is_pc()
    local p = platform.get_platform()
    return p == 'win32' or p == 'mac'
end

return device