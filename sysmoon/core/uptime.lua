local Uptime = {}
local system = require("sysmoon.system")
local parse_uptime = require("sysmoon.parser").parse_uptime

function Uptime.get()
    local result = system.get_uptime()
    return parse_uptime(result)
end

return Uptime